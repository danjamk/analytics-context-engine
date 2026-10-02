# Analytics Context Engine

A context engine for agentic analytics, kept as plain files your agent reads before it answers a
data question.

An LLM with query access can turn a question into SQL. Getting the *right* number takes more:
what each metric counts and excludes, who decided that, which traps the data holds, which
questions it cannot answer, and a way to check an answer before anyone acts on it. This repo is
my method for keeping that knowledge, written so an agent can set up its own copy.

**Status:** `analytics-context-engine-v0.5`, **preview**. Not yet run end to end by anyone but me. Version 1.0
will be tagged after it has run on two real domains. See the [changelog](CHANGELOG.md).

Who it's for: people who analyze data with a coding agent (Claude Code) and want the agent's
numbers to hold up. For a personal notes "brain" for non-technical people, see
[agentic-guides](https://github.com/danjamk/agentic-guides).

## The idea in five points

1. **Context is three things.** What the data means (definitions, rulings, caveats, refusals),
   memory of past work (exemplars, recipes, sessions), and a referee that decides whether an answer
   may ship.
2. **Loud failure beats a confident wrong number.** Every answer carries a verdict: PASS,
   PASS-WITH-CAVEAT, PROVISIONAL, or REFUSE. A correct refusal is a good answer.
3. **Meaning has an owner.** Definitions change only through rulings that record who decided, what
   the other reading was, and what it changed. Facts about the data are updated directly.
4. **Goldens are verified by a person, another way.** A test whose expected value came from the
   agent is not a test.
5. **One core per person, one pack per body of data.** Your preferences live once; each domain's
   meaning lives with that domain.

Platforms now ship semantic layers, verified queries, and offline eval suites. Use them. What this
kit adds is the per-answer referee and the governance of meaning (rulings with owners), in a form
that works across tools and for one person. See `research/landscape.md` for where the market stands.

**Not covered: data governance.** Access control, row-level security and audit are assumed to come
from your data source. The context files themselves have owners and git history, but nothing
enforces who may change or read them. See `kit/SCOPE.md`.

## Use it

In Claude Code, paste:

```
Please read https://raw.githubusercontent.com/danjamk/analytics-context-engine/main/BOOTSTRAP.md and follow its instructions to set up a context engine for my data.
```

The agent reads the guide, fetches the kit, interviews you, and builds a **core** (your defaults
and standards) and one **domain pack** (one body of data). It takes about an hour, mostly
answering questions about what your numbers mean.

Or install it as a Claude Code plugin, which adds the skills as slash commands (not yet tested):

```
/plugin marketplace add danjamk/analytics-context-engine
/plugin install analytics-context-engine@analytics-context-engine
```

Your instance goes in your own private repos. Never in this one.

## Coming back

- **After the kit changes**, read the [changelog](CHANGELOG.md). Each entry says whether instances
  made by older versions need it. Ask your agent to run `upgrade`: it reads the entries newer than
  your instance's stamp, explains them, and applies only what you approve.
- **To go further than the base install**, pick an add-on below.

## Add-ons

The base install covers the parts every context engine needs. Add-ons take it further. Each one is
a guide the agent follows, the same way it follows `BOOTSTRAP.md`. Conventions: `addons/AUTHORING.md`.

| Add-on | What it adds | Worth it when | Status |
|---|---|---|---|
| `question-log` | Logs every question asked, and mines the database's own query history for common joins and filters | You want to learn which questions deserve a definition | Planned |
| `actions` | Turns a recipe's result into a guarded write: an alert, or a list pushed to another system. Dry run, verdict gate, approval limits, undo | A report's recommendation is routinely acted on by hand | Available (`addons/addon-actions.md`) |
| `judge` | An independent judge pass on answers, calibrated against your goldens before its verdicts count | Answers go to people who will act on them | Planned |
| `drift-ci` | Runs goldens and context checks on every change and on a schedule | The data refreshes regularly, or more than one person edits the context | Planned |
| `benchmarks` | External comparison figures with their sources and limits | People ask "is that good?" | Planned |
| `mcp` | Serves a domain pack over MCP: summary-first context and a guarded SQL tool | You want the same context in Claude Desktop or another client | Planned |
| `ossie-export` | Exports metrics and entities to Apache Ossie, for Snowflake, dbt, Cube and others | You also use a vendor semantic layer | Planned |
| `team` | Shared memory tiers, proposals as pull requests, domain owners | More than one person asks questions of the same data | Idea |

## Versions

- The kit's version is in `VERSION` and at the top of `BOOTSTRAP.md`: `analytics-context-engine-vX.Y`.
- Everything the kit creates is stamped with the version that made it.
- Minor versions change wording and templates. Major versions change the structure of an instance.
  Before 1.0, any version may change structure; the changelog says when.
- `main` is the latest version. Releases from 1.0 on are also tagged `analytics-context-engine-vX.Y`.

## What's here

| Path | Holds |
|---|---|
| `BOOTSTRAP.md` | The setup guide an agent follows (base install) |
| `CHANGELOG.md` | What changed in each version, written for upgrading an existing instance |
| `addons/` | Add-on guides and the conventions for writing them |
| `kit/` | The rules: `CONVENTIONS`, `PARTS` (the 26 parts), `REFEREE`, `LEARNING`, `SCOPE`, `FORMAT`, `PRIVACY` |
| `templates/core/` | The operator's core: profile, registry, shared entities, glossary |
| `templates/domain/` | A domain pack: `meaning/`, `memory/`, `referee/`, `proposals/` |
| `skills/` | `bootstrap`, `new-domain`, `analyze`, `referee`, `propose`, `check`, `upgrade`, `recipe` |
| `research/` | Market log, landscape matrix, benchmark numbers with sources |
| `lab/` | Hands-on trials of tools and ideas |
| `examples/retail/` | Public demo pack on UCI Online Retail II (planned) |

## Author

Dan Kuhn — fractional CTO. [danjamkuhn.com](https://danjamkuhn.com) ·
[LinkedIn](https://www.linkedin.com/in/dan-kuhn-49b579/) · [Medium](https://medium.com/@dan.jam.kuhn)

MIT license.
