# Scope

Where context lives: one operator core plus one pack per data domain, connected by a registry.

## The layers

```
core/                      one per person (private repo)
  CORE.md                  entry: conventions, operator, how to route
  operator.md              who I am, defaults, preferences
  reporting.md             how my deliverables look and read
  registry.yaml            every domain: where it lives, owner, freshness
  shared-entities.yaml     people, dates and time zones, money, organizations
  glossary.yaml            words I use the same way everywhere

<domain repo>/context/     one per body of data (lives with the data's code)
  CONTEXT.md               entry and router for this domain
  VERSION
  meaning/  memory/  referee/  proposals/
```

**A domain** is a body of data where one owner rules on meaning: my health records, my books, a
client's support tickets. A project usually holds one domain and may read others.

**The core** holds everything about the operator. Shared entities live there so every domain maps
people, dates, and money to the same definitions. Data-warehouse practice calls these *conformed
dimensions*: defined once, reused by every fact table.

## Why not one engine per project

- The operator's preferences get re-learned in every repo.
- Shared entities are defined twice and drift apart.
- A question that crosses domains has nowhere to go.

## Why not one engine for everything

- Loading everything gets ignored. The router exists because of this.
- Different domains have different owners of meaning.
- A single `VERSION` would mark unrelated history as changed.
- Some domains sit behind a wall (see below).

The same layering already runs in Claude Code: a user-level `~/.claude/CLAUDE.md`, a
`CLAUDE.md` per project, and `@` imports between them.

## Not covered: governance

The kit does not govern the context layer. This is a known gap, and it is out of scope for now.

- **Assumed from the data source:** access control, row-level security, and audit of who read
  what. The kit's access guards (CONVENTIONS §2) keep the agent read-only; they do not decide who
  may see which rows.
- **Not enforced for the context layer itself:** metrics, rulings, outcomes, and how data is
  delivered carry owner fields and git history, but nothing enforces who may change them, who may
  read them, or that a change was reviewed. For one person that is acceptable. For a team it is
  not; see "Personal first, team later".
- **Actions** (add-on `actions`) have their own approval and limits, but no audit beyond the
  outcome record.

## Walls

Client domains stay in client repos and register only in that client's workspace. The core may
carry the operator's preferences into client work. It never carries client meaning out of it,
and never across to another client.

## Cross-domain questions

1. The core reads `registry.yaml` to find the domains involved.
2. Each domain's `CONTEXT.md` is loaded for its side of the question.
3. The join goes through `shared-entities.yaml`. If an entity has no shared definition, the
   question stops and asks.
4. The answer carries each domain's provenance and the lowest of their verdicts.

## Personal first, team later

Build for one person. These choices keep the team path open:

| Layer | Personal | Team |
|---|---|---|
| Sources | Local caches, my credentials | Shared sources, service accounts, row-level security per user |
| Meaning | I rule | A named owner per domain; rulings reviewed like code |
| Operator | One profile | A profile per user plus team defaults |
| Memory | Mine | Session → user → shared tiers; promotion through the referee |
| Learn | I merge proposals | Proposals are pull requests; the domain owner reviews |
| Referee | Goldens run locally; I am often the judge | Goldens in CI; the judge pass is required |
| Control | Guards plus my discipline | Audit log of every question and query; permissions in the harness |

What to do now so the team version is possible later:

- plain files in git, so proposals become pull requests with no new tooling
- an owner field on every ruling, even when the owner is you
- `asks_like` on refusals and goldens, so a shared agent can match them
- a question log from the first day
