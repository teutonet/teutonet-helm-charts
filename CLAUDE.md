# CLAUDE.md

Try to keep this CLAUDE file up to date with any gotchas you encounter while working on this repo. It is not a replacement for the official Helm docs, but a supplement to them.

## Style

- branches are always $type/$scope/$name
  - $type and $scope are from <https://www.conventionalcommits.org>
  - meaning a docs change for base-cluster would be docs/base-cluster/add-info-about-new-feature
- commits are always conventional commits, often without any body, but if a body is useful, a rather short one
  - big explanations can be written in the PR body
  - don't set footers like `BREAKING CHANGE:`, this is parsed automatically via the `!` in the first line

## helm-unittest gotchas

- Once a test sets `kubernetesProvider:`, ALL `lookup` calls in the rendered template chain go through the fake client — not just the ones under test. Every GVR touched by any lookup in that render path needs a `scheme:` entry, or it panics: `coding error: you must register resource to list kind...`.
- A scheme-registered GVR with a LIST-style `lookup` (empty name arg) and zero matching objects panics with the same error, even though the scheme entry exists. Fix: register at least one (even non-matching) dummy object of that kind, or skip the lookup entirely with an explicit override value.
- GET-style `lookup` (name given) has no such restriction.
- `kubernetesProvider.scheme` keys and `gvr.group/version/resource` values are unquoted by convention in this repo (e.g. `apps/v1/DaemonSet`, `group: apps`) — no quotes needed even for CRD groups with dots/slashes.

## Chart README gotchas

- `charts/*/README.md` is a generated artifact — never hand-edit it. Only edit `charts/*/README.md.gotmpl`; regeneration happens via the `release-update-metadata` CI workflow at release time (and needs `values.md`, see below).
- `go-task chart:docs CHART=<chart>` runs bare `helm-docs`, which reads `{{ .Files.Get "values.md" }}` for the Values section. `values.md` is gitignored and only produced in CI (`generate-schema-doc` from `json-schema-for-humans`, driven by `.github/workflows/release-update-metadata.yaml`). Running `chart:docs` locally without first generating `values.md` silently wipes the entire Values section from `README.md` instead of erroring.
- Any instruction to "adjust/update/fix the README" (or similar) for a chart always means `README.md.gotmpl`, never the rendered `README.md` — except the repo-root `README.md`, which is a plain hand-written file (no `.gotmpl` source) and is edited directly.

## Go template gotchas

- Sprig `ternary`'s test argument must be a strict `bool`. Piping `and`/`or` output straight into it fails (`wrong type for value; expected bool; got string`) because `and`/`or` return one of their operands verbatim, not a coerced bool. Convert first, e.g. `eq (include "...") "true" | ternary ...`.
- `if`/`and`/`or` themselves accept any value via Go's generic truthiness (zero-value check) — no `eq`/`ne` needed when just branching on an `include` result inside a plain `if`.
- Wrap context in `deepCopy` before passing it into `tpl`-based helpers like `common.tplvalues.render` inside loops, or context mutations bleed across iterations.
- `common.helm.labels` ignores its passed argument entirely (built purely from `.Release`/`.Chart`) — always call it with an empty `dict`.
