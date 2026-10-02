---
name: propose
description: Stage a change to a data domain's meaning (definition, reading choice, refusal, caveat, recipe) as a reviewable proposal with blast radius and golden impact; or apply a measured fact directly with its date. Use after an analysis that needed a decision the context did not cover, or when the user says "propose", "write that down as a rule", "that should be a definition".
---

# Propose

Rules: `<base>/../../kit/LEARNING.md`.

1. **Route.** Would two reasonable people disagree about it?
   - **No (fact):** edit the context file directly, set `measured_on` to today, and note the change
     in the session log. Done.
   - **Yes (meaning):** continue.
2. Copy `<kit>/templates/domain/proposals/proposal.md` to
   `context/proposals/YYYY-MM-DD-<slug>.md` and fill every section. Pick the `kind`.
3. **Golden impact.** Apply the change on a branch (or a copy), run the `check` skill, and record
   which goldens moved. Revert the branch.
4. Do not edit `meaning/` for a meaning change. The owner merges.
5. On the owner's acceptance: add the ruling to `meaning/rulings.yaml` with the next R-id, apply the
   change, delete the proposal, re-run goldens, and bump `VERSION` if a number or meaning changed.
