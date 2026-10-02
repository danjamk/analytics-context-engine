---
name: check
description: Validate a data domain's context pack — references resolve, measured facts are not stale, no golden leaks into exemplars, tripwires run, and goldens reproduce. Use before merging a context change, after a data refresh, or when the user says "check the context", "run the goldens", "did anything drift".
---

# Check

Spec: `<base>/../../kit/REFEREE.md` §2 and §6.

## Context lint
1. Every id referenced in `meaning/`, `memory/`, and `referee/` exists (caveats, rulings, metrics,
   goldens, exemplars).
2. Every `applies_to` names a real entity or metric.
3. Facts with `stale_after` in the past, or `measured_on` older than the source's last load, are
   listed as stale.
4. No golden `question` or `asks_like` phrasing appears in `memory/exemplars.yaml`.
5. Every refusal has an `instead`. Every ruled metric has `ruled_by` and `sql`.
6. Files whose `last_verified` (or "Last verified" line) is older than the review interval in
   `CONTEXT.md` (default 90 days) are listed for review.
7. Proposals past their `review_by` date are listed, oldest first. A stalled ruling stops learning.
8. Expected values in check scripts that are not read from `goldens.yaml` are flagged as copies.
9. Rulings superseded since the newest verified golden that depends on them are flagged: the
   goldens may not cover the current rule.
10. If `memory/questions.jsonl` exists: questions asked twice or more with no metric or exemplar
    are listed as candidate definitions.

## Goldens
For each golden with `verified: true`: run its SQL, compare to `expect` within tolerance, and record
the result in its drift history. Expected-REFUSE goldens: run the `analyze` procedure on each
phrasing and confirm it refuses. A golden that moved is a stop-and-review, not an automatic failure.

## Report
One table: check · result · action. List moved goldens first.
