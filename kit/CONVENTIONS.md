# Conventions

Operating rules for an agent answering questions over data through a context engine.
These rules hold in every domain. Domain packs add specifics; they never relax these.

---

## 1. Load context before answering

Read the domain entry file (`context/CONTEXT.md`) before any numeric answer, and follow its
router to the files the question needs. A question that touches a defined metric is answered
with that definition, not a fresh interpretation. If no definition exists, that is a ruling to
request, not a gap to fill by inference.

Load what the question needs, not everything. A context pack loaded whole gets skimmed and
ignored.

## 2. Read-only, enforced below the agent

`SELECT` only. No DDL, no DML, no temp tables, no writes to session state that change data.

Enforce this where the agent cannot argue past it:

- read-scoped credentials
- a client that can only issue reads (GET-only HTTP, an endpoint allowlist)
- SQL wrapped so only one statement parses (`SELECT * FROM (<sql>) LIMIT n`)
- **in DuckDB, block file and remote readers** (`read_csv`, `read_parquet`, `read_json`,
  `iceberg_scan`, `glob`, `httpfs` paths). A SELECT-only guard does not stop
  `SELECT * FROM read_csv('/etc/passwd')`.

A row cap that is exceeded returns an error, not a truncated result. A partial answer that
looks complete is a wrong answer.

If a task appears to need a write, stop and say so.

## 3. Loud fail beats silent wrong

A refused answer costs a round trip. A confident wrong number costs a decision.

| Situation | Required behavior |
|---|---|
| A term has two defensible readings that change the number | Stop and ask. Show both readings and their numeric effect. |
| The question matches a refusal | Refuse, say why, offer the refusal's `instead`. |
| A caveat is triggered | State it inline with the number. |
| The source is stale for the claim | State the as-of date and narrow the claim. |
| The join needed has weak measured coverage | State the coverage, or refuse the claim that depends on it. |
| A tripwire is red | Downgrade to PROVISIONAL or REFUSE. Never proceed quietly. |

## 4. Every number carries its provenance

Five facts travel with every figure:

- **Grain:** what one row means.
- **Population:** who is included, and who was excluded as a result.
- **Source:** which table or measure, and which competing measure was rejected.
- **Freshness:** as-of date of the data, and whether the last period is partial.
- **Assumptions:** any reading the agent chose that the context did not rule.

Return the SQL that produced the number when the consumer can use it.

## 5. Never drop what you can't map

Unmapped rows are data. Bucket them ("unattributed", "all other"), count them, and state their
share. Silently filtering them out is the most common way a report misleads.

A filter that the context says to apply is applied **and reported**. A filter applied without
saying so is a hidden assumption.

## 6. Unknown is never zero

A missing value means nobody measured it. It drops out of denominators; it never counts as zero.
Pair every sum with a count of the rows it came from. State coverage before any average.
Never write SQL that turns a division by zero into zero.

## 7. Reconcile before you report

Any aggregate that will be shown ties to a raw, unfiltered sum of the same source within a
stated tolerance. If it does not, explain the difference before the number ships.

## 8. Learning is human-gated for meaning, direct for facts

See `LEARNING.md`. The test: would two reasonable people disagree about it? If yes, it is
meaning: write a proposal and let the owner rule. If no, it is a fact: apply it, date it, log it.

Never edit a definition mid-analysis to make a number work.

## 9. Memory is not truth

A recipe or exemplar is a hypothesis that held when it was validated. Every re-run re-validates
it: freshness gates, reconciliation, goldens. A pinned procedure running stale logic is worse
than re-deriving, because it looks authoritative.

## 10. Pin the method, not the mechanics

Recipes pin definitions and order of operations. They do not pin shell quirks, retries, or
formatting. Too much pinning makes recipes brittle; too little makes them unrepeatable.

## 11. Judgments are stored, not re-derived

A score, classification, or other judgment is stored with the rules version it was made under.
Re-scoring is an explicit, logged act. Results made under different rules must be told apart.

## 12. Deliverables follow the operator's standards

Before producing a report, chart, or shareable artifact, read the operator profile
(`core/operator.md`). If it has no standards, ask once and write them down.

Standards are preferences. They never override a correctness rule: presentation is the
operator's call, accuracy is not.

Default where the operator has no preference: a self-contained artifact with the data embedded
and no runtime network dependency.

## 13. One source per fact

A fact lives in one file. A checklist item, an index, a check script's expected value, a tool
description or a report header that needs it is generated from that file or cites it by id. A
hand-copied value drifts, and drift between documents is the most common way a context pack goes
wrong.

Where you can, bind the file to the code with a test: the schema, the query code, or the goldens.
A file the agent only reads is advice; a file a test checks is enforced. Each file carries
`last_verified`, the date a person last confirmed it still matches the data.

## 14. Instances are private

Nothing from an instance (`core/`, `context/`) is published, pasted into a public repo, or
quoted across a client boundary. See `PRIVACY.md`.
