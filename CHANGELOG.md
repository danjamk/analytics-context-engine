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
