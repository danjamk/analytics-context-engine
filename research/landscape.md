# Landscape

Which products cover which of the kit's 24 parts (`kit/PARTS.md`), as of **2026-09-30**, with
rows 18 and 20 corrected on 2026-10-02. Sources for each product are in `log.md` and in the source
list below. Vendor features change monthly; check the log for anything newer. All of it is
read-about: no product here has been tried in `lab/` yet.

## Coverage matrix

● ships · ◐ partial, prose-only, or offline-only · — not found · ? not checked.
All 24 parts are defined in this kit; the matrix shows the market, not the kit.

| # | Part | Snowflake | Databricks | Hex | Cube | WrenAI | ktx | Catalogs¹ |
|---|---|---|---|---|---|---|---|---|
| 1 | Source registry with coverage limits | — | — | — | — | — | ◐ | ◐ |
| 2 | Entities and grain | ● | ● | ? | ● | ● | ● (fan/chasm traps) | ◐ |
| 3 | Metrics | ● | ● | ? | ● | ● | ● | ◐ |
| 4 | Glossary / synonyms | ● | ● | ? | ◐ | ◐ | ● | ● |
| 5 | Rulings (owner, rejected reading, supersedes) | — | — | — | — | — | — | — |
| 6 | Caveats (structured) | ◐ prose | ◐ prose | ? | ◐ rules | ◐ prose | ◐ wiki | — |
| 7 | Refusals (`asks_like`, `instead`) | ◐ free-text instruction | — | — | — | — | — | — |
| 8 | External benchmarks | — | — | — | — | — | — | — |
| 9 | Business context | ● instructions | ● instructions | ● guides | ● rules | ◐ | ● wiki | ◐ |
| 10 | Operator / user profile | — | — | ● user memory | ? | — | ◐ per-user pages | ◐ OM preferences |
| 11 | Exemplars (verified question→SQL) | ● verified queries | ● trusted assets | ? | ● certified queries | ● memory | — | ◐ |
| 12 | Recipes | — | — | — | — | — | — | ◐ OM runbooks |
| 13 | Session log | — | — | ? | ◐ memories | — | — | — |
| 14 | Question / usage log | ● query history | ◐ monitoring | ● | ◐ | — | ◐ warehouse history | ◐ |
| 15 | Learn with human gate | ● suggestions | ● usage analysis | ● review agent | — | ◐ auto-stores, no gate (OSS) | ● PR-gated, typed conflicts | ● DataHub, Atlan |
| 15b | Fact/meaning split | — | — | — | — | — | — | — |
| 16 | Goldens, human-verified by second method | ◐ verified_by/at | ◐ can be AI-generated | ◐ from past threads | ◐ | ◐ Ent | — | ◐ DataHub (paid) |
| 17 | Tripwires that change the output | — | — | — | — | — | — | — |
| 18 | Checklist + graded verdicts | — | ◐ Good/Bad/Manual (offline) | ◐ pass/warn (offline) | — | ◐ Ent pass/fail | — | — |
| 19a | Drift loop (re-run on change, regressions) | ● | ◐ | ● | ● (CI gate) | ● Ent AI Advisor | — | ◐ |
| 19b | Version stamped on stored results | — | — | — | — | — | — | — |
| 20 | Judge pass | ◐ offline | ◐ offline | ◐ offline | — | ? | — | — |
| 21 | Conventions | ◐ | ◐ | ◐ | ◐ | ● skills | ● skills | — |
| 22 | Router / summary-first / loading policy | ◐ | ◐ | ? | ● always vs agent_requested | ● | ● | ◐ |
| 23 | Access guards | ◐ private fields | ◐ | ? | ● accessible_views | ● strict mode | ● | ◐ |
| 24 | Provenance on each number | — | — | ◐ cites sources | — | ◐ dry-plan SQL | ◐ context provenance | — |

Rows 18 and 20, outside the products above (2026-10-02): Anthropic's internal data agent puts a
confidence tier on every answer and runs a review before delivery; Lightdash scans every agent turn
after delivery, for admins. See `log.md`.

¹ OpenMetadata 2.0, DataHub, Atlan. Also checked: dbt (parts 2, 3, 12 via saved queries; out-of-scope questions return errors), Looker (glossary, golden queries GA 2026-08-28, Prism evals), Omni (branch eval vs. main), MotherDuck Guides (versioned markdown context, no learn loop), Fivetran Context Layer (writes agent traces, including assumptions made, back to the warehouse). Vanna's open-source repo was archived 2026-03-29.
## What is commodity and what is not

**Commodity: use it, don't build differentiation on it.** Entities, metrics, glossary (2–4);
business context as prose (9); verified question→SQL exemplars (11); router and loading policy (22);
access guards (23); the offline drift loop (19a); learn-from-use with a human approval gate (15).

**Not shipped by anyone reviewed:** rulings with owner, rejected reading, and supersedes (5);
structured refusals with an alternative (7); external benchmarks with stated limits (8); the
fact/meaning split in learning (15b); goldens verified by a second method (16); tripwires that
change the answer (17); graded verdicts (18), though Anthropic runs them internally; a rules
version stamped on stored results (19b); a judge that reviews the answer before delivery without
seeing the agent's reasoning (20); a referee that works across platforms.

## Sources

- Snowflake: semantic view YAML, custom instructions, Cortex Analyst evaluations, verified query suggestions — docs.snowflake.com (fetched 2026-09-30)
- Databricks: metric views YAML (2026-09-17), Genie benchmarks, Genie monitor — docs.databricks.com
- Hex: changelog 2026-04-14, 04-23, 08-04, 09-15 — learn.hex.tech
- Cube: AI context, certified queries, evals — docs.cube.dev
- WrenAI: github.com/Canner/WrenAI; docs.getwren.ai (AI Advisor); getwren.ai/pricing
- ktx: github.com/Kaelio/ktx
- OpenMetadata Context Center: docs.open-metadata.org/v2.0.x; DataHub: datahub.com/blog, github.com/datahub-project/analytics-agent; Atlan: atlan.com, github.com/atlanhq/agent-toolkit
- dbt: docs.getdbt.com (latest metrics spec, dbt-mcp tools); Looker: docs.cloud.google.com; Omni: omni.co/blog; MotherDuck: motherduck.com/blog; Fivetran: fivetran.com/blog
