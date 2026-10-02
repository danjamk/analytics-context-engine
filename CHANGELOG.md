# Changelog

All notable changes to this project are documented here. Format:
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning: [SemVer](https://semver.org/).

## [Unreleased]

## [0.2.0] — 2026-10-01

First public version of the kit (v2). The internal v1 kit was a set of conventions and a referee
spec inside one private project.

### Added
- 24 parts defined (`kit/PARTS.md`), each with what it prevents.
- Domain pack layout by function: `meaning/`, `memory/`, `referee/`, `proposals/`.
- Operator core and registry (`kit/SCOPE.md`): one core per person, one pack per domain.
- Referee: held-out goldens, expected-refusal goldens, path checks, two kinds of abstention,
  judge calibration (`kit/REFEREE.md`).
- Learning: fact/meaning routing rule, typed proposal kinds, goldens run on the proposal (`kit/LEARNING.md`).
- Format: own YAML as a superset of the Apache Ossie core; export planned (`kit/FORMAT.md`).
- Conventions: DuckDB file and remote readers blocked; assumptions recorded in provenance;
  reported filters; no division by zero to zero.
- Seven skills packaged as a Claude Code plugin.
- Market research log, landscape matrix, and benchmark numbers (`research/`).
- Lab trial format and queue (`lab/`).
