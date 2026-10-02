# Recipe: <name>

> **Objective:** <the decision this analysis feeds, in the owner's words>
> **Audience:** <who reads it, and what they do with it>
> **Cadence:** <monthly | quarterly | on demand>
> **Owner:** <name> · **Version:** <n> · **Created:** YYYY-MM-DD
> **Last run:** YYYY-MM-DD · **Last verified:** YYYY-MM-DD

## Parameters
| Param | Type | Default | Invalidates goldens |
|---|---|---|---|

## Depends on
- Sources: <ids from meaning/sources.yaml>
- Metrics: <names>
- Rulings: <ids>
- Exemplars: <ids>

## Preconditions (stop conditions, not warnings)
| Gate | Check | Stop if |
|---|---|---|

A failed gate stops the run. It is reported as the finding; it is not waived because the report is due.

## Before running
Read the latest entry for this recipe in `memory/deliverables.yaml`: what it recommended, the
questions it raised, and the operator's feedback. Say what changed since then.

## Steps
### 1. <step>
- **Do:** <command or SQL file>
- **Expect:** <output shape>
- **Validate:** <what makes this step correct>

## Watch for
| Signal | Threshold or pattern | Then |
|---|---|---|
| <e.g. backlog older than 30 days grows> | <e.g. > 10% month over month> | <flag it in the summary / recommend …> |

## Output spec
Follows `core/reporting.md`. Only what is specific to this report:
- **Sections:** <in order>
- **Charts:** <which, and what each must show>
- **Conclusions:** <what the summary must answer>

## Caveats that must appear in the deliverable
-

## Golden check
| Check | Expected | Tolerance | Last verified |
|---|---|---|---|

Mismatch → the recipe is marked **needs re-validation** and does not ship.

## After running
Add an entry to `memory/deliverables.yaml`: recipe version, data as-of, `VERSION`, verdict,
location, recommendations, questions raised. Route feedback by what it changes (PARTS.md,
"Refining a recurring analysis").

## Change log
| Date | Version | Change | Why |
|---|---|---|---|
