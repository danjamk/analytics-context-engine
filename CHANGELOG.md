# Changelog

Newest first. Written for an agent upgrading an instance that an older version of the kit made,
and for people deciding whether a new version is worth adopting.

Each entry says what changed, which instance files it affects, whether existing instances need it,
and how to apply it. Changes are written as intent, not exact text, because operators edit their
instances. Phase 0 of `BOOTSTRAP.md` and the `upgrade` skill explain how to use this.

Entry format:

```
### data-brain-vX.Y (YYYY-MM-DD)
- **<What changed>.** Affects: <instance file and section, or "kit only">.
  Existing instances: recommended | optional | not needed.
  How to apply: <one or two sentences, as intent>.
```

Versions: minor for wording and template fixes; major when the instance's structure changes.
Before v1.0, any version may change structure, and its entries say so.

---

## data-brain-v0.2 (2026-10-01) — preview

First public version.

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
