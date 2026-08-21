# CLAUDE.md — common chart

`common` is a library chart — no templates render on their own, no cluster to point `helm template` at. Test coverage must be comprehensive: every helper here is used by every other chart in this repo, so a broken helper breaks everything downstream silently. Any new or changed helper needs test coverage before merge.

## How to test this chart

`tests/` is an impromptu chart that exists solely to exercise `common`'s helpers via helm-unittest:

- `tests/Chart.yaml` — a throwaway chart depending on `common` (`file://../`).
- `tests/templates/*-stub.yaml` — minimal templates that `include` the helper(s) under test. One stub per helper group (e.g. `helm-stub.yaml` for `common.helm.*`).
- `tests/tests/*_test.yaml` — helm-unittest suites asserting against the corresponding stub's rendered output.

Run with `go-task chart:test CHART=common` (runs `helm dependency build tests && helm unittest tests` — do not invoke `helm unittest`/`helm dependency` by hand, the task wraps both steps).

To cover a new or changed helper:
1. Add or extend a `-stub.yaml` template that calls it (reuse an existing stub if the helper belongs to the same group).
2. Add an `it:` case to the matching `*_test.yaml`, covering the default path, edge cases, and any `fail`/error path the helper can hit.
3. Add a `matchSnapshot` case (see below) so the full output is pinned, not just the fields you thought to assert on.
4. If the helper takes more than one or two independent optional/boolean inputs, add combinatorial or generated-input coverage (see below).
5. Run `go-task chart:test CHART=common` and confirm it passes.

## Coverage bar: any change to a helper's output must fail CI

Explicit `equal`/`notExists` assertions only catch drift in the fields you thought to check. That's not enough here — a helper regression silently breaks every downstream chart. Two techniques close the gap:

### 1. `matchSnapshot` on the full rendered output

Every suite should have at least one `it:` case asserting `matchSnapshot` against the whole document (`path: ""` — the empty string is the root path, not `.`), on top of the targeted `equal` assertions. This pins the entire output, so any accidental change — a renamed key, a dropped field, reordered list, changed formatting — fails the test even if no one wrote an assertion for that specific field. For a stub that ranges over multiple documents, add `documentIndex: -1` to snapshot all of them.

```yaml
- it: matches snapshot
  set:
    convert.value: 1024Mi
    convert.to: Gi
  asserts:
    - matchSnapshot:
        path: ""
```

Snapshots live in `tests/tests/__snapshot__/<file>.snap` and **must be committed**. Review the diff to the `.snap` file on every PR that touches a helper — that diff *is* the change-detection signal. Never regenerate snapshots with `helm unittest -u` to make a red test pass without reading what changed first; that's the same as deleting the test.

### 2. Combinatorial / wide-table coverage for multi-parameter helpers

For helpers with several independent optional inputs (e.g. `common.resources`'s `resources` × `resourcesPreset` × `setCPULimits`, or `common.helm.chartSpec`'s repo-type × `prependReleaseName` × `repoNamespace`), a couple of hand-picked example cases under-covers the input space — the untested combinations are exactly where regressions hide. Enumerate the full cartesian product of boolean/enum flags as explicit `it:` cases rather than picking one or two "representative" ones.

For a helper that's a pure function over an open-ended input (numbers, strings) rather than a small enum/bool space — e.g. `common.convert`'s unit math — a couple of round-number examples aren't enough either, but the fix stays inside helm-unittest, not an external generator/fuzz script: add a wide, deliberately-awkward table of `it:` cases directly in the `*_test.yaml` — fractional values, values near unit-overflow boundaries, mixed magnitudes — picked specifically to exercise arithmetic edge cases a "nice" example would skip. This is how the `mul`/`mulf` int64-truncation regression in `common.convert` was caught: hand-picked whole-number examples (`1024Mi` → `Gi`) never exercised a fractional or huge input, so the bug was invisible until a table entry like `500.5` → `k` was added. Compute each case's expected value once (`helm template ... -s tests/templates/convert-stub.yaml --set ...`), verify it's mathematically correct, then hardcode it as a normal `equal` assertion — same as any other test, just more of them and chosen adversarially.

Do not reach for a shell script or a custom go-task target for this — it doesn't compose with `go-task chart:test`'s existing `helm unittest` invocation, adds a second test runner to reason about, and (as tried and reverted here) requires solving problems helm-unittest already solves for you (YAML round-tripping quirks, output extraction) worse than helm-unittest does.

### 3. Genuine per-run randomness via sprig, when a fixed table still isn't enough

Sprig's own `randInt`/`randNumeric` give real randomness inside a template — no external generator needed. This only works as a **round-trip/invariant** check, computed entirely inside the stub: e.g. `common.convert`'s `convert-roundtrip-stub.yaml` picks a random value and a random unit pair with `randInt`, converts A→B→A, and asserts the result matches the original within tolerance. There's no independently-computed "expected value" here — the round trip is its own oracle — which is exactly why it's limited to catching *arithmetic* bugs (e.g. the `mul`/`mulf` truncation), not a wrong unit-multiplier constant (a wrong constant round-trips with itself and passes). That's still the hand-picked table's job.

Two hard-won constraints if you write one of these:
- **Scope the randomness to realistic inputs.** Letting `randInt` pick *any* unit pair (e.g. `k`→`E`) fails the round-trip on a real but irrelevant limitation: `common.convert` formats its intermediate result with a fixed `printf "%f"` (6 decimal places), so a big enough magnitude gap collapses precision before the return trip even starts. Restrict to the same unit family and a small step gap — match how the helper is actually called in this repo, not the full input space the type system permits.
- **`randInt`/`add`/`sub`/`min`/`max` return different int types.** Sprig's arithmetic helpers return `int64`, but `randInt(min, max int) int` requires exact `int` — pipe every value crossing into a `randInt` call through `| int` or you get a template execution error, not a test failure, on every single run (this will not show up as intermittent — it's 100% reproducible, don't mistake it for a flaky random-input failure and go looking for a numerical cause).

Verify a new randomized check by literally running it in a loop (`for i in $(seq 1 300); do helm template ...; done`) before trusting it — "it passed once" tells you nothing when the input changes every run.

See root `CLAUDE.md` for general helm-unittest and Go template gotchas (kubernetesProvider scheme registration, ternary bool coercion, etc.) — those apply here too.
