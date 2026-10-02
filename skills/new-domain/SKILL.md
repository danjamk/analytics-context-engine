---
name: new-domain
description: Add a new data domain (database, export, API) to an existing context engine — register its sources, profile it for grains and traps, run the rulings interview, seed goldens. Use when the user says "add a domain", "set up context for <dataset>", or wants governed analysis over a new data source and already has a core.
---

# Add a domain

The kit lives at `<base>/../../`. Read `<kit>/BOOTSTRAP.md` Phases 2–8 and follow them for the new
domain. Read the operator's `core/CORE.md` and `core/registry.yaml` first; reuse
`core/shared-entities.yaml` instead of redefining people, dates, or money.

If the domain belongs to a client, its pack and registry entry go in that client's workspace,
not the personal core.
