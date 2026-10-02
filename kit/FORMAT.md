# Format

Context is plain YAML and Markdown in git. Authored by hand and by agents, reviewed as diffs.

## Why our own YAML

No published format carries the governance fields this kit needs: rulings with owner and
rejected reading, `is_not`, structured caveats and refusals, goldens with verification, version
stamps. So the kit authors in its own YAML and stays exportable.

## Export target: Apache Ossie

Ossie (Open Semantic Interchange, incubating at Apache since July 2026; spec 0.1.1) is the one
vendor-neutral, Apache-licensed semantic format that needs no query engine. Snowflake reads and
writes it, and the Ossie repo has converters for dbt, Cube, Databricks and others.

Rules that keep export possible:

- `meaning/entities.yaml` and `meaning/metrics.yaml` are a **strict superset** of the Ossie core:
  every Ossie required field has a direct source in our files.
- Field names follow dbt MetricFlow where Ossie has no equivalent (`label`, `filter`,
  `numerator` / `denominator`), so a dbt exporter is straightforward.
- Fields Ossie lacks export under `custom_extensions: [{vendor_name: "ANALYTICS_CONTEXT_ENGINE", data: …}]`.
- `caveats` and `is_not` also export as prose into `ai_context.instructions`, because vendor
  agents read only that field.

Ossie is pre-1.0 and its next version drops the `semantic_model` wrapper. Target 0.1.1 until a
consumer we use supports the next version.

## Metric field mapping

| Kit field | Ossie 0.1.1 | dbt | Notes |
|---|---|---|---|
| `name` | `name` | `name` | |
| `label` | — | `label` | extension |
| `definition` | `description` | `description` | |
| `sql` | `expression.dialects[{dialect: ANSI_SQL}]` | `agg` + `expr` | aggregate expression only; the full pinned query is an exemplar |
| `grain` | dataset `primary_key` | primary entity | grain statement is an extension |
| `unit` | — | `config.meta` | extension |
| `filter` (population) | — | `filter` | extension in Ossie |
| `source`, `rejected_source` | dataset `source` | model ref | rejected source is an extension |
| `period` (bucketing, time zone) | `dimension.is_time` | `agg_time_dimension` | bucketing and zone are extensions |
| `numerator`, `denominator` | — | ratio metric | extension in Ossie |
| `caveats`, `is_not` | `ai_context.instructions` (prose) | `config.meta` | also structured in extension |
| `synonyms` | `ai_context.synonyms` | — | |
| `status`, `ruled_by`, `ruled_on`, `reconciles_to`, `golden`, `used_by` | — | — | extension |

## Exporter

`tools/export_ossie.py` is planned, not built. It will read `meaning/entities.yaml` and
`meaning/metrics.yaml` and validate the output against the Ossie `core-spec/spec.yaml`.

## File conventions

- One concern per file. The file name says what it holds.
- Every entry has a stable `id`. References use ids, never prose.
- Measured facts carry `measured_on` and, where they move, `stale_after`.
- Comments explain *why* a field exists when it is not obvious. A file's header says what belongs
  in it and what belongs elsewhere.
