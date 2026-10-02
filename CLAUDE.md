# data-brain — working on this repo

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
- Bump `VERSION`, `.claude-plugin/plugin.json`, and `CHANGELOG.md` together.

## Versioning

**data-brain is in release mode** from `0.2.0`: it is a plugin other people install. Feature PRs
add a `CHANGELOG.md` entry under `[Unreleased]` (Keep a Changelog). `/release` does the version
bump in `VERSION` and `.claude-plugin/plugin.json`, rolls up the changelog, and creates the
`vX.Y.Z` tag and GitHub Release after merge. Minor bumps for new parts, skills, or changed
conventions; patch bumps for wording and template fixes. The initial PR set `0.2.0` directly.

## Style

Plain, direct, American English. Headings name their contents. Lead with the conclusion. No
marketing verbs, no slogans, no closing summaries. State uncertainty as uncertainty.
