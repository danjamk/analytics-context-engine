# Referee

The referee decides whether an answer may ship, and in what form. It works at two times:

- **Per answer**, before a number reaches a person: tripwires, checklist, verdict, judge pass.
- **Per change**, before a context edit is trusted: goldens re-run, drift review.

Platforms now ship the per-change half as eval suites. The per-answer half is what makes loud
failure structural instead of a matter of remembering.

---

## 1. Goldens — `referee/goldens.yaml`

Questions with known answers, used to check that the engine still answers them correctly.

**Contract:**

1. **Human-verified by a second method.** A person confirmed the value some way other than
   running the golden's own SQL: a vendor report, a hand count, an export. An agent-computed
   value recorded as expected is circular and does not count. Unverified goldens are marked
   `verified: false` and do not gate anything.
2. **Held out.** A golden question never appears in `memory/exemplars.yaml`. If the agent can
   read the answer, the test measures recall, not reasoning. Vendors that run evals remove
   verified queries from context during the run for the same reason.
3. **Several phrasings.** Each golden carries 2–4 ways of asking it (`asks_like`), so the test
   covers how people ask, not one wording.
4. **Expected refusals.** Some goldens expect `REFUSE`. A correct refusal scores as a pass. A
   number returned where a refusal was expected scores worse than any refusal.
5. **Check the path, not only the number.** Where it matters, a golden names the tables,
   filters, or grain the answer must use. A right number reached the wrong way passes by luck.
6. **Two kinds.** *Structural* goldens derive only from fixed source data and must never move.
   *Windowed* goldens sit behind a rolling window and move by design; re-pin them when the
   window explains the move and investigate when it does not.
7. **External tie-outs are the strongest second method.** An outside party's own figure (a
   system-of-record export, a statement, a published total), committed with its hash and never
   overwritten, catches an assumption that every internal query shares. Record it under
   `tieouts` in `goldens.yaml`.
8. **One copy of each expected value.** Check scripts read `expect` from `goldens.yaml`. A value
   copied into a script drifts from the file.
9. **Refresh when the rules change.** A golden set built before a ruling changed does not cover
   it. When a ruling that a golden depends on is superseded, add or re-verify a golden under the
   new rule.

Start with 8–15. Five is enough to begin.

## 2. Tripwires — `referee/tripwires.sql`

Checks that run before an answer is trusted. Each returns `check, value, threshold, status`.

Typical checks on the data:

- freshness: days since last load, per source
- orphan rate on the weakest join the answer uses
- unmapped share of the population
- double-count guard (parent/child grain collision)
- agreement between two measures of the same quantity
- mid-load: row counts moving between two reads

Checks on the context itself (run by the `check` skill):

- every caveat, ruling, and golden id referenced anywhere exists
- every `applies_to` names a real entity or metric
- measured facts older than their `stale_after` date are flagged
- no golden question appears in the exemplars

**Contract:** a red tripwire changes the output: caveat, PROVISIONAL, or REFUSE.

## 3. Checklist — `referee/checklist.md`

Run before returning any number. Each item is yes/no with a defined failure action. Minimum:
grain declared · population applied and named · source chosen among competing measures ·
freshness stated · join strength adequate · unmapped rows bucketed · partial period flagged ·
denominator stated · total reconciles · triggered caveats surfaced · refusals checked ·
assumptions stated.

**Contract:** any "no" produces a stated consequence in the output.

## 4. Verdicts

| Verdict | Meaning | Output rule |
|---|---|---|
| **PASS** | Tripwires green, checklist clean | Ship with provenance |
| **PASS-WITH-CAVEAT** | A caveat triggered or a tripwire amber | Ship with the caveat at the number |
| **PROVISIONAL** | Data incomplete for the period claimed | Ship marked provisional, with what will change |
| **REFUSE** | The data cannot support the claim | Say why; offer the nearest supportable claim |

The verdict ships with the answer. A verdict computed and not shown is not a referee.

## 5. Two kinds of abstention

Report them separately; they fail differently.

- **Unanswerable question:** the data cannot answer it at any quality. Caught by `refusals`.
- **Likely-wrong answer:** the question is answerable, but this data, today, would give a wrong
  number. Caught by tripwires and caveats.

Research on text-to-SQL abstention finds that model confidence tracks the second kind and is
nearly blind to the first. That is why refusals are written down rather than inferred.

## 6. Drift loop

When anything in `meaning/` or `memory/exemplars.yaml` changes:

1. Re-run every golden that depends on the changed item. Run them on the proposal before merge.
2. A moved golden is a stop-and-review, not automatically a failure. The change may be the
   intended effect of a corrected definition.
3. The owner confirms the move was intended; the golden's drift history records it.
4. Bump `VERSION` if any number or meaning changed.

## 7. Judge pass

A second agent reads the answer, the checklist, and the triggered caveats, **without** the
reasoning that produced the answer, and returns a verdict with reasons. It catches what a
number diff cannot: right number at the wrong grain, a comparison across sources of different
freshness, prose that claims more than the numbers support.

**Calibrate before trusting.** Run the judge on the goldens and compare its verdicts to the
human ones. Published work on text-to-SQL judges found weak judge models agreeing with humans
at κ 0.04–0.42 and three strong judges requiring unanimity at κ 0.79. Until the judge agrees
with the human goldens, its verdict is advisory.

## 8. Two referee flavors

| Flavor | Catches | Cost |
|---|---|---|
| Deterministic: re-run golden SQL, diff numbers | Numeric drift, regressions | Cheap, exact |
| Judge: fresh read against checklist and caveats | Reasoning errors a number diff misses | Slower, needs calibration |

Run both. Which one catches more on a given dataset is worth measuring and writing down.
