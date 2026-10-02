# <Domain> — context entry

**Kit version:** analytics-context-engine-v0.2 (YYYY-MM-DD) · **Meaning version:** see `VERSION`

You are answering questions over <data description>.
**Load context before answering. Never answer a numeric question from memory or from the schema alone.**

Operating rules: `<path-to-kit>/kit/CONVENTIONS.md`. Operator profile: `<core>/operator.md`.

## Router

| Need | File | Load |
|---|---|---|
| Sources, access, freshness, known gaps | `meaning/sources.yaml` | always |
| Tables, grain, joins and their measured coverage | `meaning/entities.yaml` | always |
| Traps that make answers silently wrong | `meaning/caveats.yaml` | always |
| Questions this data cannot answer | `meaning/refusals.yaml` | always |
| Metric definitions and authoritative SQL | `meaning/metrics.yaml` | when a metric is named |
| What words mean here; value lookups | `meaning/glossary.yaml` | when a term is unclear |
| Who decided what, and why | `meaning/rulings.yaml` | when a definition is questioned |
| How this business works; who asks what | `meaning/business.md` | for "why" and "should" questions |
| External comparisons (add-on) | `meaning/benchmarks.yaml` | when asked "is that good?" |
| Validated question → SQL | `memory/exemplars.yaml` | before writing new SQL |
| Re-runnable procedures (add-on) | `memory/recipes/` | for recurring reports |
| Past sessions | `memory/sessions/` | when continuing earlier work |
| Pre-answer checks | `referee/tripwires.sql`, `referee/checklist.md` | before every number |
| Goldens | `referee/goldens.yaml` | **never during an analysis** (held out); only the `check` skill reads them |
| Proposed changes awaiting a ruling | `proposals/` | when a proposal applies |

## What is ruled, proposed, and stubbed

| Slice | Status | Notes |
|---|---|---|
| <slice> | ruled / proposed / stub | <do not answer from stubs> |

## Standing refusals

<One line each; detail in meaning/refusals.yaml.>

-

## Connection

<How to query: command, database path, credential source. Read-only guards in place.>

```zsh
duckdb -readonly <path>.duckdb
```

## Versions

- **Kit version** (top of this file): which analytics-context-engine version made or last upgraded this pack.
- **Meaning version** (`VERSION`): bump it when a number or a meaning changes. Stored judgments carry it.

## Add-ons installed

| Add-on | Version | Installed |
|---|---|---|
