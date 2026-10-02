# Learning

How a context engine improves from use without drifting.

## The routing rule

Two kinds of things get learned, and they go through different doors.

| | Meaning | Fact |
|---|---|---|
| Test | Would two reasonable people disagree about it? **Yes.** | **No.** It is what the data says today. |
| Examples | What a metric counts; which population is in scope; what a word means; which of two readings wins | A coverage rate that moved; a newly found data gap; a row count; a load failure |
| Path | Proposal → owner rules → merge | Apply directly → stamp the date measured → note it in the session log |
| Why | Meaning needs an owner, or it drifts | A fact held behind a gate leaves a known-wrong number in a trusted file |

Every platform that learns from use today either gates everything (and the queue fills with
bookkeeping nobody reads) or writes everything automatically (and meaning drifts). This rule is
the difference.

## Proposals — `proposals/YYYY-MM-DD-<slug>.md`

One file per proposed change to meaning. Template: `templates/domain/proposals/proposal.md`.

Required fields:

- **Kind:** one of
  - `new_definition` — a metric, term, or population invented to answer a question
  - `definitional_contradiction` — two sources or files disagree about what something means
  - `reading_choice` — a term has two defensible readings with different numbers
  - `refusal` — a question the data should decline
  - `caveat_promotion` — a trap found in use, worth writing down
  - `recipe` — a validated process to pin
- **Target file** and the exact diff.
- **Evidence:** the query and result, or the owner's statement.
- **Blast radius:** which metrics, recipes, exemplars, and goldens depend on the current text.
- **Golden impact:** run the goldens with the proposal applied (on a branch) and record which
  ones moved and by how much.

The owner merges. On merge the change gets a ruling id in `meaning/rulings.yaml`, the proposal
file is deleted, and `VERSION` is bumped if a number or meaning changed.

Unmerged proposals may be used provisionally in a deliverable if the output labels them
PROVISIONAL.

## Where learnings come from

- **The analysis itself.** End every analysis by asking: what did I have to decide that the
  context did not? Each answer is a proposal or a fact.
- **The question log.** A question asked twice is a candidate definition.
- **The database's own query history,** where available. Joins and filters people already use
  are evidence for entities and exemplars. Treat them as evidence, not rulings; existing SQL
  shows past choices, not intent.
- **Operator corrections.** When the operator pushes back on a result, the correction is
  usually a reading choice. Write it down.
- **Outcomes.** Each report, live refresh or action records the questions it raised and the operator's feedback
  (`memory/outcomes.yaml`). The next run of the same recipe starts from them.

## Refining a recurring analysis

Feedback on a recurring report changes one of three things. Route it by what it changes:

| What changed | Where it goes | Gate |
|---|---|---|
| The method (a step, a cut, a source) | The recipe: version bump and change-log line | Operator approves the new version |
| What a number means | A proposal, then a ruling | Owner rules (the routing rule above) |
| How it is presented | `core/reporting.md`, or the recipe's output spec if it is specific to this report | None: presentation is the operator's call |

One piece of feedback can touch more than one. "Split the backlog by team and drop the closed
ones" is a method change (the split) and a meaning change (which tickets count as backlog).

## Memory gradient

Knowledge moves through four stages. The referee gates the last step.

```
session (in the agent) → user (in the engine) → shared (governed) ─[referee]→ formalized (meaning/)
```

For one person, "user" and "shared" are the same place. For a team, shared memory needs an owner
per domain and a review path. See `SCOPE.md`.

## Pruning

Context that nobody cites still costs attention, and one wrong line enters every future question.
Track how often exemplars and caveats are cited. Review the never-cited ones quarterly: delete,
merge, or mark `stale_since` with a reason. Never delete a ruling; supersede it.
