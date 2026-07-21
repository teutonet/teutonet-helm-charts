# CLAUDE.md

## helm-unittest gotchas

- Once a test sets `kubernetesProvider:`, ALL `lookup` calls in the rendered template chain go through the fake client — not just the ones under test. Every GVR touched by any lookup in that render path needs a `scheme:` entry, or it panics: `coding error: you must register resource to list kind...`.
- A scheme-registered GVR with a LIST-style `lookup` (empty name arg) and zero matching objects panics with the same error, even though the scheme entry exists. Fix: register at least one (even non-matching) dummy object of that kind, or skip the lookup entirely with an explicit override value.
- GET-style `lookup` (name given) has no such restriction.
- `kubernetesProvider.scheme` keys and `gvr.group/version/resource` values are unquoted by convention in this repo (e.g. `apps/v1/DaemonSet`, `group: apps`) — no quotes needed even for CRD groups with dots/slashes.

## Go template gotchas

- Sprig `ternary`'s test argument must be a strict `bool`. Piping `and`/`or` output straight into it fails (`wrong type for value; expected bool; got string`) because `and`/`or` return one of their operands verbatim, not a coerced bool. Convert first, e.g. `eq (include "...") "true" | ternary ...`.
- `if`/`and`/`or` themselves accept any value via Go's generic truthiness (zero-value check) — no `eq`/`ne` needed when just branching on an `include` result inside a plain `if`.
