# analytics-context-engine — working on this repo

This is the public kit. It is read by strangers and installed into their projects.

## Stack

Markdown and YAML, packaged as a Claude Code plugin (`.claude-plugin/`, `skills/`). No application
code yet; `tools/` will hold small Python utilities (Ossie exporter) when they exist. Validate the
plugin with `claude plugin validate .` before a release.

## Layout

| Path | Holds |
|---|---|
| `kit/` | The rules. Changes here change every instance's behavior. |
| `templates/` | Empty instance files. Every one maps to a part in `kit/PARTS.md`. |
| `skills/` | Plugin skills. They reference the kit as `<base>/../../`. |
| `addons/` | Add-on guides beyond the base install. Conventions in `addons/AUTHORING.md`. |
| `research/` | Market log, landscape, numbers. Public viewpoint material. |
| `lab/` | Hands-on trial write-ups. |

## Rules

- **No instance content, ever.** No client names, project keys, hostnames, people, real figures,
  or real SQL from any private dataset. Examples use `examples/retail/` or placeholders.
  Run the leakage scan in `kit/PRIVACY.md` before every commit.
- **Kit files reference instance files by role, never by content.**
- **Every template has a matching part in `kit/PARTS.md`.** Adding a part means updating PARTS,
  the template, the router in `templates/domain/CONTEXT.md`, and the skills that read it.
- **Research entries follow `research/README.md`:** facts and opinion separated; dates are when
  it happened; vendor claims labeled as vendor-reported.
- **Lab before claim.** A recommendation about a tool says whether it was tried (`lab/`) or read about.
- Bump `VERSION`, the `BOOTSTRAP.md` header, `.claude-plugin/plugin.json`, and `CHANGELOG.md` together.
- **Changing a template or a kit rule needs a changelog entry** that tells an existing instance
  how to apply it.

## Versioning

**The kit is versioned as a guide, not as software.** This is a deliberate exception to repo-wide
semver, following the pattern in agentic-guides. The shared `/release` skill does not apply.

- The kit version is `analytics-context-engine-vX.Y`, in `VERSION` and in the `BOOTSTRAP.md` header. Every
  instance file the kit creates records the version that made it.
- `CHANGELOG.md` is written for an agent upgrading an older instance: each entry names what it
  affects, whether existing instances need it, and how to apply it. The version bump and the
  changelog entry land in the PR that changes the kit.
- Minor bump for wording and template fixes. Major bump when an instance's structure changes.
  Before 1.0, any version may change structure; entries say so.
- Each add-on in `addons/` has its own `addon-<name>-vX.Y` version and changelog.
- `main` is the latest version. From 1.0, releases are tagged `analytics-context-engine-vX.Y`. Currently
  **preview** (v0.5): no tags until it has run on two real domains.
- `.claude-plugin/plugin.json` needs semver: keep it at `X.Y.0` matching the kit version.

**Protected branches:** `main`

## Style

Plain, direct, American English. Headings name their contents. Lead with the conclusion. No
marketing verbs, no slogans, no closing summaries. State uncertainty as uncertainty.
