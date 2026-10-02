# Parts

The 25 parts of a context engine. Each one exists because an answer was wrong without it.

**Kind** is what a part holds: Sources, Meaning, Business, Operator, Memory, or Checks. Parts that
are mechanisms rather than documents have no kind. Controls apply to every part.
**Function** is what the engine does with it: Curate (state what the data means), Remember (keep
past work), Learn (change the context from use), Referee (decide whether an answer may ship).
A part has one kind and may be used by several functions. See "Functions" below.
**Scope:** *core* = about the operator, shared across all data. *domain* = about one body of
data. See `SCOPE.md`.
**Install:** *base* parts are set up by `BOOTSTRAP.md`. *Add-on* parts are installed later from
`addons/` when they are worth the effort (see the Add-ons table in `README.md`).
**File:** where the part lives in an instance. Templates are in `templates/`. Kinds are a
classification, not a folder layout; file paths are unchanged from v0.2.

| # | Part | Kind | Function | Prevents | Scope | Install | File |
|---|---|---|---|---|---|---|---|
| 1 | Source registry | Sources | Curate | Stale or partial data read as complete | domain (+ core index) | base | `meaning/sources.yaml` |
| 2 | Entities and grain | Meaning | Curate | Double counting; joins that drop rows | domain (+ core shared) | base | `meaning/entities.yaml` |
| 3 | Metrics | Meaning | Curate | Same name, different WHERE clause | domain | base | `meaning/metrics.yaml` |
| 4 | Glossary and value index | Meaning | Curate | Question words mapped to the wrong thing | domain (+ core) | base | `meaning/glossary.yaml` |
| 5 | Rulings | Meaning | Curate | Definitions changing silently; history restated | domain | base | `meaning/rulings.yaml` |
| 6 | Caveats | Meaning | Curate, Referee | A clean query returning a wrong number | domain | base | `meaning/caveats.yaml` |
| 7 | Refusals | Meaning | Referee | The plausible nearest number shipped as the answer | domain | base | `meaning/refusals.yaml` |
| 8 | Benchmarks | Meaning | Curate | Comparing to an outside number measured differently | domain | add-on `benchmarks` | `meaning/benchmarks.yaml` |
| 9 | Business context | Business | Curate, Referee | Technically right, analytically wrong | domain + core | base | `meaning/business.md` |
| 10 | Operator profile and reporting standards | Operator | read by all | Every deliverable different; preferences re-asked | core | base | `core/operator.md`, `core/reporting.md` |
| 11 | Exemplars | Memory | Remember | Rewriting tricky SQL and repeating its traps | domain | base | `memory/exemplars.yaml` |
| 12 | Recipes | Memory | Remember | Recurring analysis computed differently each time; its method lost | domain | base | `memory/recipes/` |
| 13 | Session log | Memory | Remember | Losing why the last analysis went the way it did | domain | base | `memory/sessions/` |
| 14 | Question log | Memory | Remember, Learn | Never learning which questions deserve a definition | domain | add-on `question-log` | `memory/questions.jsonl` |
| 15 | Proposals | Meaning (proposed) | Learn | Nothing learned, or definitions rewritten mid-analysis | domain | base | `proposals/` |
| 16 | Goldens | Checks | Referee | A definition edit silently restating history | domain | base | `referee/goldens.yaml` |
| 17 | Tripwires | Checks | Referee | Trusting an answer built on broken or partial data | domain | base | `referee/tripwires.sql` |
| 18 | Checklist and verdicts | Checks | Referee | A number shipped without its conditions | core template + domain | base | `referee/checklist.md` |
| 19 | Version and drift loop | mechanism | Referee, Learn | Results made under different rules looking identical | domain | base (scheduled runs: add-on `drift-ci`) | `VERSION` |
| 20 | Judge pass | mechanism | Referee | Right number, wrong grain or unfair comparison | core | add-on `judge` | `referee` skill, judge pass |
| 21 | Conventions | Control | all | Behavior varying by session | core | base | `kit/CONVENTIONS.md` |
| 22 | Entry point, router and delivery | Control | all | Context not loaded, loaded whole and ignored, or absent at the moment of choice | core + domain | base | `core/CORE.md`, `context/CONTEXT.md` |
| 23 | Access guards | Control | all | An agent writing to production; truncation read as complete | domain | base | connection config |
| 24 | Provenance on output | Control | all | A number reused later without its meaning | core rule | base | every answer |
| 25 | Deliverables | Memory | Remember, Learn | Last month's recommendation forgotten or contradicted; a published report nobody can trace | domain | base | `memory/deliverables.yaml` |

## Functions

What each function writes and reads. The answer path runs through all four: question → router →
refusal match → meaning and business context → memory → query → tripwires and checklist →
verdict with provenance → session log and question log → proposals and fact updates.

| Function | Writes | Reads | Runs |
|---|---|---|---|
| Curate | Sources, entities, metrics, glossary, caveats, refusals, benchmarks, tripwires, checklist, router | Profiling results; the operator's answers; business context | At setup, and when the owner rules |
| Remember | Exemplars, recipes, session log, question log, deliverables | Meaning and business context; earlier deliverables | After each answer, each session, and each artifact produced |
| Learn | Proposals (meaning); dated edits to sources, entities and caveats (facts); `VERSION` | Session log, question log, exemplars | After a session; the owner rules on proposals |
| Referee | A verdict and provenance on each answer | Refusals, caveats, business context, checklist, tripwires, goldens, `VERSION` | Before each answer ships, and on each change to context |

The operator profile (10) and the controls (21–24) sit beside the loop: every function reads them.

## Refining a recurring analysis

A recurring analysis (part 12) produces a deliverable (part 25), which raises new questions. Each
refinement goes one of three ways, by what it changes:

| What changed | Where it goes |
|---|---|
| The method: a new step, a new cut, a new source | The recipe: bump its version and add a change-log line |
| What a number means: a population, a definition, a reading | A proposal, then a ruling (`LEARNING.md`) |
| How it is presented: section order, a chart, where conclusions go | The reporting standards (`core/reporting.md`), or the recipe's output spec if it applies to this report only |

The next run reads the last deliverable first: what it recommended, what was asked, and what the
operator said about it.

## Rules for every part

- **One source per fact.** A fact lives in one file. Any other file that needs it (a checklist
  item, an index, a check script's expected value, a report header) is generated from that file
  or cites it by id. A hand-copied value drifts.
- **Bind context to code where you can.** A file the agent only reads is advice. A test that checks
  the file against the schema, the query code or the goldens makes it enforced. Prefer the test.
- **Date what you verified.** Each file carries `last_verified`. The `check` skill reports files
  past their review interval. Facts are re-dated when re-measured; rulings are not re-dated, only
  superseded.

---

## Sources: where the data comes from

### 1. Source registry
- **Contents:** per source: access method, credential scope, cache location, refresh method, last successful load, known coverage limits, owner.
- **Load health:** how to tell a load is complete before analysis starts: a freshness check run at session start, how to size a catch-up load, how to repair a gap in the middle of history, known loader failure modes. A clean-looking load can still be missing a window.
- **Hand-maintained inputs:** files a person keeps (a roster, an alias map, a mapping table), each with its owner, last update, and a "goes stale" warning.
- **Prevents:** answering from stale or partial data as if it were current and complete. Example: an API endpoint that returns only recent records while an export returns full history.
- **Minimum:** source, access, as-of, known gaps.

## Meaning: what the data means

### 2. Entities and grain
- **Contents:** per entity: grain ("one row per order line"), key, source, joins with measured coverage and the date measured, derived entities with their filter. Semi-additive measures (balances, inventory) declare the dimension they cannot be summed over.
- **Prevents:** double counting across parent and child grain; joins that silently drop rows.
- **Minimum:** grain and key per table; coverage of the weakest join.
- **Rule:** a section not yet written is reported as "not written yet", never as empty. An empty file claims there are no entities.

### 3. Metrics
- **Contents:** name, label, definition including exclusions, `is_not` (what it does not measure, naming the figure it is commonly mistaken for), SQL, grain, unit, population (`filter`), source and rejected source, period bucketing and time zone, denominator for ratios, caveats, reconciles_to, golden, used_by, status (draft / ruled / deprecated), ruled_by, ruled_on.
- **Absent metrics:** metrics that were computed, found unsupportable, and removed, each with the reason. Keeps them from being rebuilt.
- **Prevents:** two people or systems answering the same question with different WHERE clauses.
- **Minimum:** definition, grain, population, SQL, status.
- **Rule:** no current values in the definition file. A value pinned at one load disagrees with the goldens at the next.

### 4. Glossary and value index
- **Contents:** term, meaning here, synonyms, ruling reference, UNRULED flag. A value index maps what people type to stored values ("NY" → `New York`; "UK" → `United Kingdom`).
- **Prevents:** a word in the question resolving to the wrong population.
- **Minimum:** the five words people use most.

### 5. Rulings
- **Contents:** id, kind (threshold, classification, exclusion, source precedence, unit conversion, weights, partial period…), what was decided, who ruled, date, rejected reading and its numeric effect, supersedes, `contest` (the condition under which the ruling should be re-opened), `open_question` (an unresolved fact the ruling depends on). Rulings that change over time carry effective-dated windows.
- **Prevents:** a definition changing without anyone knowing; old results restated under new rules; the same ambiguity argued every month.
- **Rule:** never edited, only superseded.
- **Minimum:** a dated log of who decided what.

### 6. Caveats
- **Contents:** id, applies_to, severity, caveat, consequence with a measured example, do_instead, `how_it_was_missed` (the reasoning that let the wrong figure through), see.
- **Prevents:** a query that runs cleanly and returns the wrong number.
- **Rule:** a caveat reports; it does not silently correct.
- **Minimum:** the three traps you have already fallen into.

### 7. Refusals
- **Contents:** id, `asks_like` (phrasings that trigger it), refuse, why, `instead` (the nearest claim the data supports, or the instrument that would answer it).
- **Prevents:** a plausible, arithmetically correct number that answers a different question.
- **Rule:** every refusal has an `instead`.
- **Minimum:** every question you have had to turn down once.

### 8. Benchmarks
- **Contents:** metric, external bands, sources with dates, our value, verdict, `limits` (what would make the comparison invalid), `history` (comparisons withdrawn, and why).
- **Prevents:** comparing to an industry figure measured differently (calendar time vs. business hours).
- **Minimum:** optional; add when someone asks "is that good?"

### 15. Proposals
- **Contents:** kind, target file, exact diff, evidence, blast radius, golden impact (from a run on the proposal), version impact (whether `VERSION` must bump), `review_by` date, decision.
- **Prevents:** two opposite failures: nothing learned, or definitions rewritten mid-analysis.
- **Rule:** a proposal past its `review_by` date is reported by `check`. A stalled ruling is the most common way the learn loop stops.
- See `LEARNING.md` for the fact/meaning rule and proposal kinds.

## Business: how the organization works

### 9. Business context
- **Contents:** what decides the WHERE clause but is in no column: who owns what, how processes run, priorities, usual audiences and why they ask.
- **Two forms.** Either the content itself, or pointers to where it already lives (a notes repo, a wiki, a personal knowledge base), each with what to read it for. Pointers to private locations stay in the private instance.
- **Prevents:** answers that are technically right and analytically wrong: an unfair comparison, the wrong records excluded, a data error no query can detect.
- **Minimum:** one page, or one pointer: how this business works, and who asks what.

## Operator: who is asking

### 10. Operator profile and reporting standards
- **Profile (`core/operator.md`):** defaults (time zone, fiscal calendar, units, currency), what the operator always wants, what they push back on, sensitivity rules, phrases they use with a specific meaning.
- **Reporting standards (`core/reporting.md`):** format and delivery; section order; conclusions and recommendations (placement, formatting, how a recommendation is written); charts; interactivity (tooltips, filters, collapsible notes and data tables); where provenance and caveats go; writing style; versions per audience; recorded exceptions to general advice, with the reason.
- **Prevents:** every deliverable looking different; the same preference asked in every project.
- **Minimum:** time zone, default format, three standing preferences.
- **Rules:** one profile and one set of standards in the core, read by every domain, not copied per project. A domain lists only how it differs for an audience, in its `CONTEXT.md`. Standards never override a correctness rule: presentation is the operator's call, accuracy is not.

## Memory: past work

### 11. Exemplars
- **Contents:** question, frame, pinned SQL, validated date, reconciliation result, why the SQL is shaped this way, `origin` (seed = machine-generated, user = human-confirmed), times cited.
- **Prevents:** rewriting tricky SQL and repeating its traps.
- **Rule:** a golden is never also an exemplar (see `REFEREE.md`, holdout). An exemplar whose frame predates a ruling is re-validated or removed.

### 12. Recipes
A recipe is a remembered analysis: the method for a report you produce again, with what it is for.
- **Contents:** objective (the decision it feeds), audience, cadence, parameters, sources and rules it depends on, preconditions as stop conditions, ordered steps with validation, watch-for (issues to flag, and when to make a recommendation), output spec (sections and charts for this report; cites the reporting standards rather than repeating them), required caveats, golden check, last run and last *verified*, version and change log.
- **Prevents:** a recurring analysis computed a little differently each time; the method lost when its author leaves; a report that no longer answers the decision it was built for.
- **Minimum:** objective, steps, one golden check.
- **Rule:** a run reads the previous deliverable first and records a new one (part 25). A refinement goes to the recipe, a proposal, or the reporting standards; see "Refining a recurring analysis".

### 13. Session log
- **Contents:** trigger, question as asked vs. what it needed, findings that changed context, feedback rounds, goldens re-run, lessons, open threads with ids that carry across sessions and recipes.
- **Minimum:** asked, needed, found, changed, open.

### 14. Question log
- **Contents:** every ad-hoc query with a required natural-language question, the context it cited, and whether it was refused. Where available, the database's own query history is mined as evidence of common joins and filters.
- **Rule:** anything asked twice becomes a candidate definition. The log needs a reader: `check` or a scheduled review lists repeated questions. A log nobody reads learns nothing.

### 25. Deliverables
- **Contents:** per artifact produced: id, title, date, recipe and recipe version (if any), data as-of, meaning `VERSION`, verdict, location and hash (the artifact itself stays where it was published), audience, recommendations made, issues flagged, questions it raised, operator feedback, follow-up (did a recommendation land), superseded_by.
- **Prevents:** last month's recommendation forgotten or contradicted this month; a published figure nobody can trace to the rules and data that made it; the same question re-raised because nobody recorded that it was asked.
- **Minimum:** title, date, location, `VERSION`, recommendations made.
- **Rule:** the record lives in the context pack; the artifact does not. Reports are large and often carry figures the context files must not.

## Checks: what the referee runs

### 16. Goldens
- **Contents:** question, 2–4 phrasings, frame, expected value (or expected REFUSE), tolerance, kind (structural / windowed), verified_by, verification method, SQL, expected path, depends_on, drift history.
- **External tie-out:** the strongest second method is an outside party's own figure: an export from the system of record, a statement, a published total. Commit it with its hash and source; add a new dated file rather than overwriting. It is the only check that catches an assumption shared by every internal query.
- **Prevents:** a definition change silently restating history.
- **Rules:** human-verified by a second method; held out from exemplars; include expected refusals; refreshed when the rules they cover change. A check script reads expected values from this file, never from its own copy. See `REFEREE.md`.

### 17. Tripwires
- **Contents:** pre-answer checks on the data, each with a value and a threshold: freshness, orphan rate on the weakest join, unmapped share, double-count guard, cross-source agreement, mid-load row movement, partial period (the newest period is incomplete until a stated cutoff, such as a share of the usual daily volume). Plus checks on the context itself: dangling references, stale facts, files past `last_verified`.
- **Rule:** a red tripwire changes the output. One that only logs is decoration.

### 18. Checklist and verdicts
- **Contents:** yes/no checks, each with a failure action. Verdicts: PASS, PASS-WITH-CAVEAT, PROVISIONAL, REFUSE.
- **Rule:** checklist items that restate a caveat are generated from the caveats file, so the two cannot drift.

## Mechanisms

### 19. Version and drift loop
- **Contents:** `VERSION` per domain; bump rules; stored judgments stamped with the version; goldens re-run on every change.
- **Rule:** bump when a number or a meaning changes. Writing down a rule that was already in force does not bump it. Any rule that affects a stored result lives inside the versioned files; a rule kept elsewhere can change without moving the version.

### 20. Judge pass
- **Contents:** a second pass that reads the answer against the checklist and caveats without seeing the reasoning that produced it. Calibrated against human goldens before it may issue verdicts.

## Controls

### 21. Conventions
`kit/CONVENTIONS.md`. Identical in every domain.

### 22. Entry point, router and delivery
- **Contents:** a one-page entry file per domain: need → file table, which slices are ruled vs. proposed vs. stubbed, standing refusals, connection notes, loading policy (`always` vs. `on-demand`) per file, and precedence (which document wins when two disagree). The core entry routes to domains through the registry.
- **Delivery:** where the agent works through tools (MCP or similar), the tool descriptions carry the rules a naive call breaks, and server instructions carry the conventions. Context that reaches the agent at the moment it chooses a tool is followed more often than a file it read at the start.
- **Rule:** summary first, sections on request.

### 23. Access guards
See CONVENTIONS §2. Add field exposure control: fields the agent may not read. People appear as system ids with a role; the id-to-name map stays out of the context files.

### 24. Provenance on output
See CONVENTIONS §4.
