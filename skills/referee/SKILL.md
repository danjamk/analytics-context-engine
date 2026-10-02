---
name: referee
description: Judge a pending data answer before it ships — run tripwires and the checklist, optionally an independent judge pass, and return a verdict (PASS, PASS-WITH-CAVEAT, PROVISIONAL, REFUSE). Use when the user says "referee this", "check this answer", "is this number right", or before sharing an analysis.
---

# Referee

Spec: `<base>/../../kit/REFEREE.md`.

## Deterministic pass
1. Run `referee/tripwires.sql`; record each value against its threshold.
2. Walk `referee/checklist.md`; every "no" gets a stated consequence.
3. Assign the verdict.

## Judge pass (independent)
Launch a subagent with **only**: the final answer text, the numbers and their stated frame,
`referee/checklist.md`, `meaning/caveats.yaml`, and `meaning/refusals.yaml`. Do not give it the
reasoning, the SQL drafts, or the conversation. Ask it to return a verdict and the checklist items
it believes fail, with reasons.

If the judge has not been calibrated on this domain's goldens (see REFEREE.md §7), report its
verdict as **advisory** next to the deterministic one. Where they disagree, show both.

## Output
The verdict ships with the answer. Log it in the checklist's verdict log.
