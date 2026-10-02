---
name: recipe
description: Run, refine, or capture a recipe — a remembered analysis for a recurring report, with its objective, audience, sources, rules, steps, watch-for list, output spec, and golden check. Use when the user says "run the monthly report", "run recipe <name>", "make this repeatable", "capture this as a recipe", or gives feedback on a recurring report.
---

# Recipe

Template: `<base>/../../templates/domain/memory/recipes/recipe.md`. Background:
`<base>/../../kit/PARTS.md` parts 12 and 25, and "Refining a recurring analysis".

## Run
1. Read `context/memory/recipes/<name>.md`, `<core>/reporting.md`, and the domain's audience
   differences in `CONTEXT.md`.
2. Read the latest entry for this recipe in `memory/outcomes.yaml`. Note open
   recommendations, questions raised, and feedback.
3. Check every precondition. A failed gate stops the run and is reported as the finding.
4. Execute the steps with the given parameters; validate each step's output.
5. Apply the watch-for list. Flag what it catches; recommend where it says to.
6. Run the golden check. Mismatch → mark the recipe **needs re-validation** and do not ship.
7. Build the deliverable to the output spec and the reporting standards. Open with what changed
   since the last run, including the status of its recommendations.
8. Publish by the recipe's publish mode:
   - `manual`: hand the artifact to the operator.
   - `live`: publish only if every tripwire and the golden check passed. Otherwise hold, leave the
     last good version up, and say which check failed.
   - `action:<name>`: follow `actions/<name>.yaml`. Show the dry run, check the verdict gate
     (PASS or PASS-WITH-CAVEAT only) and approval, then send.
9. Add an entry to `memory/outcomes.yaml` with its type, including held publishes and held
   actions. Update last run (and last verified, if a human confirmed the output).

## Refine
When the operator gives feedback on a run, route each part by what it changes:
- **Method** (a step, a cut, a source): edit the recipe, bump its version, add a change-log line.
- **Meaning** (a population, a definition): write a proposal (`propose` skill).
- **Presentation**: edit `<core>/reporting.md`, or the recipe's output spec if it applies to this
  report only.

Record the routing in the deliverable's `feedback` field.

## Capture
Walk the analysis once with the operator, validate the output, then write the recipe as a proposal
(`kind: recipe`). Ask for the objective and audience first: a recipe without them repeats the steps
but loses the reason. Pin definitions and order of operations; leave shell mechanics to the agent.
