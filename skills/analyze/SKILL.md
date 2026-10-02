---
name: analyze
description: Answer a data question through a governed context pack — load context, resolve terms, declare the frame, run tripwires, query read-only, reconcile, referee, and report with verdict and provenance. Use for any numeric or analytical question over a domain that has a context/CONTEXT.md, e.g. "how many…", "what was revenue…", "compare…", "why did … change".
---

# Analyze

Never query first and interpret later. The kit lives at `<base>/../../`.

1. **Load.** Read the domain's `context/CONTEXT.md` and follow its router. Read
   `<kit>/kit/CONVENTIONS.md` if not already loaded. Do not read `referee/goldens.yaml`.
2. **Check refusals.** If the question matches an entry in `meaning/refusals.yaml`, refuse, say
   why, and offer its `instead`. Stop.
3. **Resolve terms.** Map every noun to `meaning/glossary.yaml` or a metric. A term that does not
   resolve, or resolves two ways with different numbers: stop and ask, showing both readings and
   their numeric effect.
4. **Declare the frame** before running anything: grain · population · source · period ·
   denominator (ratios).
5. **Tripwires.** Run `referee/tripwires.sql`. Record every value.
6. **Query.** Read-only. Prefer, in order: a recipe, a metric's `sql`, an exemplar, new SQL.
   If the `question-log` add-on is installed, log the question to `memory/questions.jsonl`.
7. **Reconcile** the reported total to a raw sum of the source.
8. **Referee.** Walk `referee/checklist.md`. Assign a verdict: PASS · PASS-WITH-CAVEAT ·
   PROVISIONAL · REFUSE.
9. **Report.** Answer first. Then the number with grain, population, source, freshness,
   assumptions, triggered caveats, and the verdict. Follow `core/operator.md` for format.
10. **Learn.** Apply measured facts directly (with the date). Write a proposal for every reading
    you chose that no ruling covers (`propose` skill). Append a session log for non-trivial work.

For high-stakes answers, run the `referee` skill's judge pass before step 9.
