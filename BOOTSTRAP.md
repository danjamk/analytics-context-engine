# Bootstrap

Instructions for an agent (Claude Code or similar) setting up a context engine for its operator.
Follow the phases in order. Ask one question at a time and confirm each answer before writing it.

Read first: `kit/CONVENTIONS.md`, `kit/PARTS.md`, `kit/SCOPE.md`, `kit/PRIVACY.md`.

---

## Phase 0 — Place the instance

1. **Never create an instance inside this kit repo.** Instances are private.
2. Ask where the operator's **core** should live. Recommend a new private git repo
   (e.g. `~/<workspace>/data-core/`). If it already exists, read `core/CORE.md` and skip to Phase 2.
3. Ask which **domain** to start with. Recommend the one with the most existing material:
   a database the operator already queries, a repo with SQL in it, or exported files.
   The domain's pack lives at `<domain repo>/context/`.
4. If the domain is a client's, confirm it belongs in that client's workspace and register it there,
   not in the personal core.

## Phase 1 — Core: interview the operator

Copy `templates/core/` to the core location. Then interview, one question at a time:

1. Name, role, and what decisions the data feeds.
2. Time zone, week start, fiscal year, currency, units.
3. Default deliverable format. Offer the kit default: a self-contained HTML file with data embedded.
4. Three things they always want in an answer.
5. Anything that must never appear in a deliverable (sensitivity).
6. Phrases they use with a specific meaning ("lately", "this quarter").

Write `core/operator.md` and `core/glossary.yaml`. Leave "What I push back on" empty; it fills
from corrections over time. Write `core/CORE.md` with the real path to `kit/CONVENTIONS.md`.

## Phase 2 — Register the domain and its sources

Copy `templates/domain/` to `<domain repo>/context/`.

For each source, fill `meaning/sources.yaml`: access method, read-only credential scope, cache
location, refresh, last loaded, covered range. Then set up the **access guards** (CONVENTIONS §2)
before running any query, and write the connection block in `CONTEXT.md`.

Add the domain to `core/registry.yaml`.

## Phase 3 — Discovery: find the grains and the traps

Profile before asking. Run read-only queries to find:

- row counts, keys, and the grain of each table (does the key actually unique-identify a row?)
- join coverage between tables (share of rows that match)
- null rates on keys and measures, and whether nulls mean "unknown" or "zero"
- date ranges per table, the time zone of timestamps, and whether the last period is partial
- the database's own query history, if available: frequent joins and filters are evidence

Then walk the **trap catalog** and check each against the data:

| # | Trap | Look for |
|---|---|---|
| 1 | Grain collision | Parent and child rows counted together |
| 2 | Partial period | Last month or week incomplete |
| 3 | Missing looks like zero | Nulls or absent rows read as 0 |
| 4 | Sentinel values | -1, 9999, "N/A", system user ids |
| 5 | Soft deletes and cancellations | Rows that net out or should be excluded |
| 6 | Non-entity rows | Fees, adjustments, test records mixed with real ones |
| 7 | Time zone | UTC timestamps bucketed as local dates |
| 8 | Units and currency | Mixed units, multiple currencies |
| 9 | Enums and codes | Codes with meanings not in the schema |
| 10 | Synonyms | Several names for one thing; one name for several things |
| 11 | Cross-system ids | The same entity keyed differently in two sources |
| 12 | Competing measures | Two columns that both claim to be "the" number |
| 13 | Canonical table | Several tables or views with overlapping content |
| 14 | Stale or partial source | An endpoint that returns only part of the history |
| 15 | Semi-additive measures | Balances or inventory summed across time |

Write what you find as **draft** entries in `meaning/entities.yaml` (with measured coverage and
dates) and `meaning/caveats.yaml` (with a measured consequence for each).

**If a `*-data-analyst` skill from Anthropic's `data-context-extractor` exists**, import it:
entities, metrics, terminology, and gotchas become draft entries. Convert its "standard filters"
into caveats that report, not filters that apply silently. Replace any `DIV0`-style handling with
explicit nulls (CONVENTIONS §6).

## Phase 4 — Rulings interview

Meaning cannot be inferred. Ask the operator these, one at a time, showing the numeric effect of
each reading from your discovery queries:

1. When you say "<customer / user / order>", what counts? What is excluded?
2. What is the main id, and are there several?
3. Which 2–3 numbers do you ask about most? How should each be calculated?
4. What should always be excluded, and should the output say it was?
5. What mistakes does someone new to this data make?
6. For each trap found in Phase 3 with two defensible readings: which reading wins?

For every two-reading choice, offer a recommended default. Write answers as rulings in
`meaning/rulings.yaml` (with the rejected reading and its effect), definitions in
`meaning/metrics.yaml` with `status: ruled`, and terms in `meaning/glossary.yaml`.

Ask also: which questions should this data refuse? Write them to `meaning/refusals.yaml`, each
with an `instead`.

Write `meaning/business.md` from what the operator says about who asks and why. Keep it to a page.

## Phase 5 — Goldens

Ask the operator for 5 numbers they already know from another source: a report, a statement,
a vendor dashboard, a hand count. Those become goldens with `verified: true` and the source as the
verification method. Include at least one question the data should refuse, as an expected REFUSE.

Where the operator cannot supply a check, write the golden with `verified: false`. It does not
gate anything until a human confirms it.

Do not copy any golden question into `memory/exemplars.yaml`.

## Phase 6 — Referee

1. Fill `referee/tripwires.sql` with checks for freshness, unmapped share, the weakest join, and
   each high-severity caveat that can be measured.
2. Add domain checks to `referee/checklist.md`.
3. Run the `check` skill: context references resolve, goldens reproduce, tripwires run.

## Phase 7 — First analysis

Ask the operator for a real question. Answer it with the `analyze` skill end to end, including the
verdict and provenance. Write the session log. Write a proposal for anything you had to decide that
the context did not cover.

## Phase 8 — Hand-off

Tell the operator, in five lines or fewer:

- where the core and the domain pack live
- what is ruled, what is draft, and what is stubbed
- how many goldens are verified
- the open proposals waiting for them
- how to ask the next question (`analyze`) and how to add a domain (`new-domain`)

Commit the core and the domain pack to their own private repos. Never commit them here.
