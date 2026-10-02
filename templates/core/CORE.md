# Core — <operator name>

**Kit version:** analytics-context-engine-v0.5 (YYYY-MM-DD) — the kit version that made or last upgraded this core

Entry point for every data question I ask, in any project. Read this first, then route.

## Operating rules

@<path-to-kit>/kit/CONVENTIONS.md

## About me

Read `operator.md` before answering, and `reporting.md` before producing any deliverable.

## Where data lives

`registry.yaml` lists every domain, where its context pack lives, who owns its meaning, and how
fresh it is. To answer a question:

1. Find the domain (or domains) in the registry.
2. Read that domain's `context/CONTEXT.md` and follow its router.
3. For a question across domains, join through `shared-entities.yaml`. If an entity has no
   shared definition, stop and ask.

Client domains are not in this registry. They register in that client's workspace only.

## Words I use everywhere

`glossary.yaml`. A domain's glossary wins inside that domain.

## Ways to extend

Add-ons extend the core (a judge pass, drift checks in CI, MCP serving, and more). When
the operator asks for something this setup can't do yet, check the list at
https://github.com/danjamk/analytics-context-engine#add-ons and suggest what fits.
