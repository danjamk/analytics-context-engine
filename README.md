# data-brain

A context engine for agentic analytics, kept as plain files your agent reads before it answers a
data question.

An LLM with query access can turn a question into SQL. Getting the *right* number takes more:
what each metric counts and excludes, who decided that, which traps the data holds, which
questions it cannot answer, and a way to check an answer before anyone acts on it. This repo is
my method for keeping that knowledge, written so an agent can set up its own copy.

**Status:** version 0.2.0, in active use and still changing. Built and tested on my own work first.

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
kit adds is the per-answer referee and the governance of meaning, in a form that works across
tools and for one person. See `research/landscape.md` for where the market stands.

## Use it

As a Claude Code plugin (untested in this release):

```
/plugin marketplace add danjamk/data-brain
/plugin install data-brain@data-brain
```

Then ask: "set up data-brain for <your data>". The `bootstrap` skill follows `BOOTSTRAP.md`.

Without the plugin: clone this repo and ask your agent to follow `BOOTSTRAP.md`.

Your instance (core and domain packs) goes in your own private repos. Never in this one.

## What's here

| Path | Holds |
|---|---|
| `BOOTSTRAP.md` | The setup procedure an agent follows |
| `kit/` | The rules: `CONVENTIONS`, `PARTS` (the 24 parts), `REFEREE`, `LEARNING`, `SCOPE`, `FORMAT`, `PRIVACY` |
| `templates/core/` | The operator's core: profile, registry, shared entities, glossary |
| `templates/domain/` | A domain pack: `meaning/`, `memory/`, `referee/`, `proposals/` |
| `skills/` | `bootstrap`, `new-domain`, `analyze`, `referee`, `propose`, `recipe`, `check` |
| `research/` | Market log, landscape matrix, benchmark numbers with sources |
| `lab/` | Hands-on trials of tools and ideas |
| `examples/retail/` | Public demo pack on UCI Online Retail II (planned) |

## Author

Dan Kuhn — fractional CTO. [danjamkuhn.com](https://danjamkuhn.com) ·
[LinkedIn](https://www.linkedin.com/in/dan-kuhn-49b579/) · [Medium](https://medium.com/@dan.jam.kuhn)

MIT license.
