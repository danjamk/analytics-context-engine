# Changelog

Newest first. Written for an agent upgrading an instance that an older version of the kit made,
and for people deciding whether a new version is worth adopting.

Each entry says what changed, which instance files it affects, whether existing instances need it,
and how to apply it. Changes are written as intent, not exact text, because operators edit their
instances. Phase 0 of `BOOTSTRAP.md` and the `upgrade` skill explain how to use this.

Entry format:

```
### analytics-context-engine-vX.Y (YYYY-MM-DD)
- **<What changed>.** Affects: <instance file and section, or "kit only">.
  Existing instances: recommended | optional | not needed.
  How to apply: <one or two sentences, as intent>.
```

Versions: minor for wording and template fixes; major when the instance's structure changes.
Before v1.0, any version may change structure, and its entries say so.

---

## analytics-context-engine-v0.5 (2026-10-02) — preview

Outcomes beyond reports. Adds part 26; the kit now has 26 parts. Renames one file added in v0.4.

- **Part 25 is now Outcomes, in `memory/outcomes.yaml`.** Affects: `memory/deliverables.yaml`
  (renamed), the router row. Types: `artifact`, `live` (a refresh of a deployed report or
  pipeline), `action`.
  Existing instances: recommended if made by v0.4.
  How to apply: rename `memory/deliverables.yaml` to `memory/outcomes.yaml`, rename the top key to
  `outcomes`, and add `type: artifact` to existing entries. Update the router row.
- **Recipes get a publish mode.** Affects: `memory/recipes/*.md`. `manual`, `live` (tripwires and
  the golden check run before every publish; a failure holds it and leaves the last good version
  up), or `action:<name>`.
  Existing instances: optional; recommended for any recipe that feeds a deployed report.
  How to apply: add a Publish line to the recipe header.
- **Part 26, Action guards, and the `actions` add-on.** Affects: kit only until installed
  (`addons/addon-actions.md`, `templates/addons/actions/action.yaml`, CONVENTIONS §2). The only
  writes the kit allows: a named action with its own write-scoped credential, a dry run, a verdict
  gate (PASS or PASS-WITH-CAVEAT only), approval per run or within limits, an idempotency key, and
  an undo path. Analysis stays read-only.
  Existing instances: not needed unless you want actions.
- **Governance is stated as not covered.** Affects: kit only (`SCOPE.md`, `PRIVACY.md`, README).
  Access control, row-level security and audit are assumed from the data source; the context layer
  has owners and git history but no enforced governance.
  Existing instances: not needed.

## analytics-context-engine-v0.4 (2026-10-02) — preview

Recurring analysis and its outputs. Adds part 25; the kit now has 25 parts. Adds two instance
files; nothing moves.

- **Recipes are base, and carry their purpose.** Affects: `memory/recipes/`, `context/CONTEXT.md`
  router. The `recipes` add-on is retired. Recipes gain objective, audience, depends-on, watch-for
  (what to flag, when to recommend), an output spec that cites the reporting standards, and
  before/after-run steps that read and write the deliverables record.
  Existing instances: recommended where a report is produced on a schedule.
  How to apply: add objective, audience and a watch-for table to each existing recipe; move any
  presentation rules out of the recipe into `core/reporting.md` unless they apply to that report
  only. Remove `recipes` from "Add-ons installed".
- **Reporting standards get their own core file.** Affects: new `core/reporting.md`;
  `core/operator.md` (Deliverables section now points to it); `context/CONTEXT.md` (new
  "Reporting differences for this domain" section); `CONVENTIONS.md` §12.
  Existing instances: recommended.
  How to apply: create `core/reporting.md` from the template; move format, structure and chart
  preferences out of `operator.md` and out of any per-project standards file into it. In each
  domain, list only how that domain differs by audience.
- **Part 25, Deliverables.** Affects: new `memory/deliverables.yaml`; router row added.
  Existing instances: recommended.
  How to apply: create the file from the template and add an entry for the most recent artifact
  of each recurring report, with its recommendations and their status. The artifact stays where
  it is; record its location and hash.
- **Refining a recurring analysis.** Affects: kit only (`PARTS.md`, `LEARNING.md`, `recipe` and
  `analyze` skills). Feedback is routed by what it changes: method to the recipe, meaning to a
  proposal, presentation to the reporting standards.
  Existing instances: not needed.

## analytics-context-engine-v0.3 (2026-10-02) — preview

From a review of three working deployments against the kit. Every new field is optional; an
instance made by v0.2 keeps working unchanged. No files move.

- **Parts are classified by kind as well as function.** Affects: kit only (`kit/PARTS.md`).
  Kinds: Sources, Meaning, Business, Operator, Memory, Checks; the drift loop and judge pass are
  mechanisms; parts 21–24 are controls. Part numbers and file paths are unchanged.
  Existing instances: not needed.
- **One source per fact; bind context to code; `last_verified` on every file.** Affects: every
  instance file; new `CONVENTIONS.md` §13 (Instances are private is now §14).
  Existing instances: recommended.
  How to apply: add `last_verified` to each YAML file and a "Last verified" line to each Markdown
  file, dated when a person last confirmed it. Where a value is copied into a second file (a
  checklist item, a check script, a tool description), generate it or cite the source id instead.
- **Business context can be pointers.** Affects: `meaning/business.md`.
  Existing instances: optional.
  How to apply: if this knowledge already lives elsewhere, add a Pointers table (read, for, when)
  and shorten the rest.
- **New optional fields.** Affects: `meaning/rulings.yaml` (`contest`, `open_question`, kind
  `partial_period`), `meaning/caveats.yaml` (`how_it_was_missed`), `meaning/benchmarks.yaml`
  (`history`), `meaning/metrics.yaml` (an `absent` list; no current values in definitions),
  `meaning/sources.yaml` (`load_health`, `hand_maintained`), `proposals/` (review-by date, version
  impact).
  Existing instances: optional; recommended for `how_it_was_missed` and proposal review dates.
  How to apply: add the fields as entries are next touched. Remove any current values pinned in
  metric definitions.
- **External tie-outs for goldens.** Affects: `referee/goldens.yaml`, `kit/REFEREE.md` §1.
  Existing instances: recommended where an outside figure exists.
  How to apply: commit the outside party's export under `referee/tieouts/` with its hash, record
  it under `tieouts`, and point the goldens it verifies at it. Make check scripts read expected
  values from `goldens.yaml`.
- **Router gains precedence and delivery.** Affects: `context/CONTEXT.md`. Part 22 is renamed
  "Entry point, router and delivery".
  Existing instances: recommended.
  How to apply: add a Precedence list (which document wins when two disagree) and a Delivery note
  listing tool descriptions or server instructions that carry context, each generated from or
  citing the files.
- **`check` reports more.** Affects: kit only (`skills/check`). Files past their review interval,
  proposals past review-by, copied expected values, goldens that predate a superseded ruling, and
  repeated questions in the question log.
  Existing instances: not needed.

## analytics-context-engine-v0.2 (2026-10-01) — preview

First public version.

- **Renamed from data-brain.** Affects: version stamps and links. Existing instances: not needed
  (none were made under the old name). The old GitHub URLs redirect.
- **Base install and add-ons.** Affects: kit only. `BOOTSTRAP.md` sets up the base parts;
  benchmarks, recipes, the question log, the judge pass, and scheduled drift checks are add-ons.
  Existing instances: not needed. Parts you already have stay; list them under "Add-ons installed"
  in `context/CONTEXT.md` once their add-on guides exist.
- **`upgrade` skill.** Affects: kit only. Existing instances: not needed.
- **Instance layout by function.** Affects: the whole domain pack.
  Existing instances: recommended, for instances built from the private v0.1 kit.
  How to apply: move `instance/context/*` into `context/meaning/` (schema → `entities.yaml`,
  `rules.md` → `rulings.yaml`), `instance/memory/` into `context/memory/`, `instance/eval/` into
  `context/referee/`, and `instance/proposals/` into `context/proposals/`. Write a
  `context/CONTEXT.md` router from the template and keep the old entry file's content in it.
- **Refusals get their own file, with an `instead` for each.** Affects: `meaning/refusals.yaml`.
  Existing instances: recommended.
  How to apply: move refusals listed in entry files or checklists into the file, and add the nearest
  answerable claim to each.
- **Goldens are held out and include expected refusals.** Affects: `referee/goldens.yaml`,
  `memory/exemplars.yaml`.
  Existing instances: recommended.
  How to apply: remove any golden question from the exemplars; add at least one golden that
  expects REFUSE; mark goldens nobody has verified by a second method as `verified: false`.
- **Version stamp on instances, and a `VERSION` per domain for meaning.** Affects: `core/CORE.md`,
  `context/CONTEXT.md`, `core/registry.yaml`, `context/VERSION`.
  Existing instances: recommended.
  How to apply: add the kit stamp lines from the templates; start the domain's meaning version at
  `0.1.0` if it has none.
- **Operator core.** Affects: new `core/` folder.
  Existing instances: optional for a single domain; recommended once there are two.
  How to apply: run Phase 1 of `BOOTSTRAP.md`, then move any reporting standards from domain packs
  into `core/operator.md`.
- **DuckDB file and remote readers blocked.** Affects: the domain's connection guards.
  Existing instances: recommended for DuckDB domains; not needed otherwise.
  How to apply: reject SQL that calls `read_csv`, `read_parquet`, `read_json`, `glob`, or
  `iceberg_scan`, or that reads a path or URL.
