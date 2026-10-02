# Parts

The 24 parts of a context engine. Each one exists because an answer was wrong without it.

**Scope:** *core* = about the operator, shared across all data. *domain* = about one body of
data. See `SCOPE.md`.
**File:** where the part lives in an instance. Templates are in `templates/`.

| # | Part | Function | Prevents | Scope | File |
|---|---|---|---|---|---|
| 1 | Source registry | Curate | Stale or partial data read as complete | domain (+ core index) | `meaning/sources.yaml` |
| 2 | Entities and grain | Curate | Double counting; joins that drop rows | domain (+ core shared) | `meaning/entities.yaml` |
| 3 | Metrics | Curate | Same name, different WHERE clause | domain | `meaning/metrics.yaml` |
| 4 | Glossary and value index | Curate | Question words mapped to the wrong thing | domain (+ core) | `meaning/glossary.yaml` |
| 5 | Rulings | Curate | Definitions changing silently; history restated | domain | `meaning/rulings.yaml` |
| 6 | Caveats | Curate | A clean query returning a wrong number | domain | `meaning/caveats.yaml` |
| 7 | Refusals | Referee | The plausible nearest number shipped as the answer | domain | `meaning/refusals.yaml` |
| 8 | Benchmarks | Curate | Comparing to an outside number measured differently | domain | `meaning/benchmarks.yaml` |
| 9 | Business context | Curate | Technically right, analytically wrong | domain + core | `meaning/business.md` |
| 10 | Operator profile | Remember | Every deliverable different; preferences re-asked | core | `core/operator.md` |
| 11 | Exemplars | Remember | Rewriting tricky SQL and repeating its traps | domain | `memory/exemplars.yaml` |
| 12 | Recipes | Remember | Recurring numbers computed differently each time | domain | `memory/recipes/` |
| 13 | Session log | Remember | Losing why the last analysis went the way it did | domain | `memory/sessions/` |
| 14 | Question log | Remember | Never learning which questions deserve a definition | domain | `memory/questions.jsonl` |
| 15 | Proposals | Learn | Nothing learned, or definitions rewritten mid-analysis | domain | `proposals/` |
| 16 | Goldens | Referee | A definition edit silently restating history | domain | `referee/goldens.yaml` |
| 17 | Tripwires | Referee | Trusting an answer built on broken data | domain | `referee/tripwires.sql` |
| 18 | Checklist and verdicts | Referee | A number shipped without its conditions | core template + domain | `referee/checklist.md` |
| 19 | Version and drift loop | Referee | Results made under different rules looking identical | domain | `VERSION` |
| 20 | Judge pass | Referee | Right number, wrong grain or unfair comparison | core | skill `judge` |
| 21 | Conventions | Control | Behavior varying by session | core | `kit/CONVENTIONS.md` |
| 22 | Entry point and router | Control | Context not loaded, or loaded whole and ignored | core + domain | `core/CORE.md`, `context/CONTEXT.md` |
| 23 | Access guards | Control | An agent writing to production; truncation read as complete | domain | connection config |
| 24 | Provenance on output | Control | A number reused later without its meaning | core rule | every answer |

---

## Curate: what the data means

### 1. Source registry
- **Contents:** per source: access method, credential scope, cache location, refresh method, last successful load, known coverage limits, owner.
- **Prevents:** answering from stale or partial data as if it were current and complete. Example: an API endpoint that returns only recent records while an export returns full history.
- **Minimum:** source, access, as-of, known gaps.

### 2. Entities and grain
- **Contents:** per entity: grain ("one row per order line"), key, source, joins with measured coverage and the date measured, derived entities with their filter. Semi-additive measures (balances, inventory) declare the dimension they cannot be summed over.
- **Prevents:** double counting across parent and child grain; joins that silently drop rows.
- **Minimum:** grain and key per table; coverage of the weakest join.

### 3. Metrics
- **Contents:** name, label, definition including exclusions, `is_not` (what it does not measure), SQL, grain, unit, population (`filter`), source and rejected source, period bucketing and time zone, denominator for ratios, caveats, reconciles_to, golden, used_by, status (draft / ruled / deprecated), ruled_by, ruled_on.
- **Prevents:** two people or systems answering the same question with different WHERE clauses.
- **Minimum:** definition, grain, population, SQL, status.

### 4. Glossary and value index
- **Contents:** term, meaning here, synonyms, ruling reference, UNRULED flag. A value index maps what people type to stored values ("NY" → `New York`; "UK" → `United Kingdom`).
- **Prevents:** a word in the question resolving to the wrong population.
- **Minimum:** the five words people use most.

### 5. Rulings
- **Contents:** id, kind (threshold, classification, exclusion, source precedence, unit conversion, weights…), what was decided, who ruled, date, rejected reading and its numeric effect, supersedes. Rulings that change over time carry effective-dated windows.
- **Prevents:** a definition changing without anyone knowing; old results restated under new rules; the same ambiguity argued every month.
- **Rule:** never edited, only superseded.
- **Minimum:** a dated log of who decided what.

### 6. Caveats
- **Contents:** id, applies_to, severity, caveat, consequence with a measured example, do_instead, see.
- **Prevents:** a query that runs cleanly and returns the wrong number.
- **Rule:** a caveat reports; it does not silently correct.
- **Minimum:** the three traps you have already fallen into.

### 7. Refusals
- **Contents:** id, `asks_like` (phrasings that trigger it), refuse, why, `instead` (the nearest claim the data supports).
- **Prevents:** a plausible, arithmetically correct number that answers a different question.
- **Rule:** every refusal has an `instead`.
- **Minimum:** every question you have had to turn down once.

### 8. Benchmarks
- **Contents:** metric, external bands, sources with dates, our value, verdict, `limits` (what would make the comparison invalid).
- **Prevents:** comparing to an industry figure measured differently (calendar time vs. business hours).
- **Minimum:** optional; add when someone asks "is that good?"

### 9. Business context
- **Contents:** what decides the WHERE clause but is in no column: who owns what, how processes run, priorities, usual audiences and why they ask.
- **Prevents:** answers that are technically right and analytically wrong: an unfair comparison, the wrong records excluded.
- **Minimum:** one page: how this business works, and who asks what.

## Remember: memory of past work

### 10. Operator profile
- **Contents:** defaults (time zone, fiscal calendar, units, currency), deliverable format, what the operator always wants, what they push back on, sensitivity rules.
- **Prevents:** every deliverable looking different; the same preference asked in every project.
- **Minimum:** time zone, default format, three standing preferences.

### 11. Exemplars
- **Contents:** question, frame, pinned SQL, validated date, reconciliation result, why the SQL is shaped this way, `origin` (seed = machine-generated, user = human-confirmed), times cited.
- **Prevents:** rewriting tricky SQL and repeating its traps.
- **Rule:** a golden is never also an exemplar (see `REFEREE.md`, holdout).

### 12. Recipes
- **Contents:** purpose, cadence, parameters, preconditions as stop conditions, ordered steps with validation, outputs, required caveats, golden check, dependencies, last run and last *verified*, change log.
- **Prevents:** a recurring number computed a little differently each time; the method lost when its author leaves.

### 13. Session log
- **Contents:** trigger, question as asked vs. what it needed, findings that changed context, feedback rounds, goldens re-run, lessons, open threads.
- **Minimum:** asked, needed, found, changed, open.

### 14. Question log
- **Contents:** every ad-hoc query with a required natural-language question, the context it cited, and whether it was refused. Where available, the database's own query history is mined as evidence of common joins and filters.
- **Rule:** anything asked twice becomes a candidate definition.

## Learn

### 15. Proposals
- **Contents:** kind, target file, exact diff, evidence, blast radius, golden impact (from a run on the proposal), decision.
- **Prevents:** two opposite failures: nothing learned, or definitions rewritten mid-analysis.
- See `LEARNING.md` for the fact/meaning rule and proposal kinds.

## Referee

### 16. Goldens
- **Contents:** question, 2–4 phrasings, frame, expected value (or expected REFUSE), tolerance, kind (structural / windowed), verified_by, verification method, SQL, expected path, depends_on, drift history.
- **Prevents:** a definition change silently restating history.
- **Rules:** human-verified by a second method; held out from exemplars; include expected refusals. See `REFEREE.md`.

### 17. Tripwires
- **Contents:** pre-answer checks on the data, each with a value and a threshold: freshness, orphan rate on the weakest join, unmapped share, double-count guard, cross-source agreement, mid-load row movement. Plus checks on the context itself: dangling references, stale facts.
- **Rule:** a red tripwire changes the output. One that only logs is decoration.

### 18. Checklist and verdicts
- **Contents:** yes/no checks, each with a failure action. Verdicts: PASS, PASS-WITH-CAVEAT, PROVISIONAL, REFUSE.

### 19. Version and drift loop
- **Contents:** `VERSION` per domain; bump rules; stored judgments stamped with the version; goldens re-run on every change.

### 20. Judge pass
- **Contents:** a second pass that reads the answer against the checklist and caveats without seeing the reasoning that produced it. Calibrated against human goldens before it may issue verdicts.

## Control

### 21. Conventions
`kit/CONVENTIONS.md`. Identical in every domain.

### 22. Entry point and router
- **Contents:** a one-page entry file per domain: need → file table, which slices are ruled vs. proposed vs. stubbed, standing refusals, connection notes, loading policy (`always` vs. `on-demand`) per file. The core entry routes to domains through the registry.
- **Rule:** summary first, sections on request.

### 23. Access guards
See CONVENTIONS §2. Add field exposure control: fields the agent may not read.

### 24. Provenance on output
See CONVENTIONS §4.
