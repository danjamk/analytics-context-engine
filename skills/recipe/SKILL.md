---
name: recipe
description: Run or capture a recipe — a parameterized, re-runnable procedure for a recurring data report with preconditions, validation, and a golden check. Use when the user says "run the monthly report", "run recipe <name>", "make this repeatable", or "capture this as a recipe".
---

# Recipe

Template: `<base>/../../templates/domain/memory/recipes/recipe.md`.

## Run
1. Read `context/memory/recipes/<name>.md`.
2. Check every precondition. A failed gate stops the run and is reported as the finding.
3. Execute the steps with the given parameters; validate each step's output.
4. Run the golden check. Mismatch → mark the recipe **needs re-validation** and do not ship.
5. Update last run (and last verified, if a human confirmed the output).

## Capture
Walk the process once with the operator, validate the output, then write the recipe as a proposal
(`kind: recipe`). Pin definitions and order of operations; leave shell mechanics to the agent.
