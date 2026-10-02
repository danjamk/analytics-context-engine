# Recipe: <name>

> **Purpose:** <the question this answers, in the owner's words>
> **Cadence:** <monthly | quarterly | on demand>
> **Owner:** <name> · **Version:** <n> · **Created:** YYYY-MM-DD
> **Last run:** YYYY-MM-DD · **Last verified:** YYYY-MM-DD

## Parameters
| Param | Type | Default | Invalidates goldens |
|---|---|---|---|

## Preconditions (stop conditions, not warnings)
| Gate | Check | Stop if |
|---|---|---|

A failed gate stops the run. It is reported as the finding; it is not waived because the report is due.

## Steps
### 1. <step>
- **Do:** <command or SQL file>
- **Expect:** <output shape>
- **Validate:** <what makes this step correct>

## Outputs
| Artifact | Path |
|---|---|

## Caveats that must appear in the deliverable
-

## Golden check
| Check | Expected | Tolerance | Last verified |
|---|---|---|---|

Mismatch → the recipe is marked **needs re-validation** and does not ship.

## Dependencies
- Metrics: <names>
- Rulings: <ids>
- Exemplars: <ids>

## Change log
| Date | Version | Change | Why |
|---|---|---|---|
