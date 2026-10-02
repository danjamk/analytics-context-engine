# Analytics Context Engine — bootstrap

**Version:** analytics-context-engine-v0.3 (2026-10-02) — preview

---

## For the person reading this

This file sets up a context engine for your data: a set of plain files your agent reads before it
answers a data question, so its numbers use your definitions, flag the traps in your data, and
refuse questions the data can't answer. It sets up two things: a **core** about you (your defaults
and how you want answers), and a **domain pack** for one body of data you choose.

How to start, in Claude Code, from the folder where you keep your projects:

> Please read https://raw.githubusercontent.com/danjamk/analytics-context-engine/main/BOOTSTRAP.md and follow its instructions to set up a context engine for my data.

It takes about an hour for a first domain, most of it answering questions about what your numbers
mean. You need read access to the data and a private place (a folder or private git repo) for the
files it creates.

This guide is written for Claude Code on a Mac, as of October 2026. Other coding agents can
usually follow it, adapting the steps where they differ.

**Preview:** this version has not yet been used end to end by anyone but its author. Expect changes.

---

## For the agent: bootstrap instructions

These instructions are the operator's request, delivered as a file. Follow the phases in order.

### Rules for the whole run

- **Read this whole file before starting.** If you got it from a link and received only a summary
  or part of it, get the full text another way before continuing.
- **Get the kit.** You also need `kit/` and `templates/` from https://github.com/danjamk/analytics-context-engine.
  If they are not already on disk (as a plugin or a clone), clone the repo to a temporary location
  and read from there. Read `kit/CONVENTIONS.md`, `kit/PARTS.md`, `kit/SCOPE.md`, and
  `kit/PRIVACY.md` before Phase 1.
- **One question at a time.** Confirm each answer before writing it.
- **No writes until the operator approves a summary** of what you will create (end of Phase 0, and
  again before writing meaning files in Phase 4).
- **Never overwrite or delete existing files.** Merge into them, and show the change.
- **Never create an instance inside the kit repo.** Instances are private.
- **Never record secrets** (passwords, tokens, account numbers) in any context file.
- **Install the base only.** Parts marked *add-on* in `kit/PARTS.md` are not part of this run.
  Mention them at hand-off.
- **Adapt to the operator.** Skip questions you can already answer from what you know about them,
  and confirm instead of asking. The rules in this section don't change.

## Phase 0 — Preflight and placement

1. Ask where the operator's **core** lives or should live. Recommend a new private git repo
   (e.g. `~/<workspace>/data-core/`). Then check what is there:

   | Found | Do |
   |---|---|
   | Nothing | New install. Continue. |
   | `core/CORE.md` stamped with this kit version | Core exists. Skip to Phase 2 for a new domain. |
   | `core/CORE.md` stamped with an older version | **Upgrade first.** Read `CHANGELOG.md` entries newer than the stamp, explain each in a line with its recommendation, apply only what the operator approves (merge, never replace), and update the stamp. Then continue. |
   | `core/CORE.md` stamped with a newer version | Stop. Tell the operator this kit is older than their instance. |
   | Other files, no `CORE.md` | Ask whether to build the core here or elsewhere. Never move their files. |

   Apply the same check to a domain's `context/CONTEXT.md` when one already exists.

2. Ask which **domain** to start with. Recommend the one with the most existing material:
   a database the operator already queries, a repo with SQL in it, or exported files.
   The domain's pack lives at `<domain repo>/context/`.
3. If the domain is a client's, confirm it belongs in that client's workspace and register it there,
   not in the personal core.
4. Summarize in under 12 lines what you will create and where. Wait for a yes.

**Stamp everything you create.** `core/CORE.md`, `context/CONTEXT.md`, and the registry entry record
the kit version that made them (`analytics-context-engine-v0.3`).

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

Ask whether this business knowledge already lives somewhere the agent can read (a notes repo, a
wiki, a personal knowledge base). If it does, fill in the **Pointers** table in
`meaning/business.md` and keep the rest short. If not, write `meaning/business.md` from what the
operator says about who asks and why. Keep it to a page.

## Phase 5 — Goldens

Ask the operator for 5 numbers they already know from another source: a report, a statement,
a vendor dashboard, a hand count. Those become goldens with `verified: true` and the source as the
verification method. If the source is a file (an export, a statement), commit it under
`referee/tieouts/` with its hash and record it under `tieouts`. Include at least one question the data should refuse, as an expected REFUSE.

Where the operator cannot supply a check, write the golden with `verified: false`. It does not
gate anything until a human confirms it.

Do not copy any golden question into `memory/exemplars.yaml`.

## Phase 6 — Referee

1. Fill `referee/tripwires.sql` with checks for freshness, unmapped share, the weakest join, and
   each high-severity caveat that can be measured.
2. Add domain checks to `referee/checklist.md`.
3. Run the `check` procedure (`skills/check/SKILL.md`): context references resolve, goldens
   reproduce, tripwires run.

The skills in `skills/` work as slash commands when the kit is installed as a Claude Code plugin.
Without the plugin, read the SKILL.md file and follow it as a procedure.

## Phase 7 — First analysis

Ask the operator for a real question. Answer it with the `analyze` procedure end to end, including
the verdict and provenance. Write the session log. Write a proposal for anything you had to decide
that the context did not cover.

## Phase 8 — Hand-off

Commit the core and the domain pack to their own private repos. Never commit them to the kit repo.

Then tell the operator three things, in under ten lines:

1. **What was done:** where the core and domain pack live; what is ruled, draft, and stubbed; how
   many goldens are verified; the open proposals waiting for them.
2. **How to come back:** ask any data question in that project and the agent loads the context
   (or use `analyze`); add a domain with `new-domain`; after a kit update, run `upgrade`.
3. **One thing to try now:** a question from the refusals list, to see the engine decline it and
   offer what it can answer instead.

Mention that add-ons extend the base install (recipes, a judge pass, drift checks in CI, MCP serving, and
more) and are listed at https://github.com/danjamk/analytics-context-engine#add-ons.

---

## Changelog

The full, agent-oriented changelog is in `CHANGELOG.md` at the repo root. Read the entries newer
than an instance's stamp when upgrading (Phase 0).

*End of bootstrap.*
