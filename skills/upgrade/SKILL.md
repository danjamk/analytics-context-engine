---
name: upgrade
description: Upgrade a context engine instance (operator core or domain pack) made by an older analytics-context-engine kit version — read the changelog entries since its stamp, explain each, apply only what the operator approves, and update the stamp. Use when the user says "upgrade analytics-context-engine", "update my context engine", "what's new in the kit", or after pulling a newer kit.
---

# Upgrade an instance

The kit lives at `<base>/../../`.

1. Read the kit version in `<kit>/VERSION`.
2. Find the instance stamps: `**Kit version:**` in `core/CORE.md` and in each domain's
   `context/CONTEXT.md` (the registry lists the domains).
3. If a stamp is newer than the kit, stop and say so.
4. Read `<kit>/CHANGELOG.md` entries newer than the oldest stamp. For each, tell the operator in one
   line what changed, which of their files it affects, and its recommendation (recommended /
   optional / not needed).
5. Apply only the entries the operator approves. Merge into their files; never replace or delete
   what they wrote. Show each change.
6. If an applied change alters a number or a meaning in a domain, run the `check` procedure and bump
   that domain's meaning `VERSION`.
7. Update each stamp you upgraded to the kit version and today's date. Note skipped entries in the
   session log so the next upgrade does not offer them again as new.
8. Check installed add-ons (the "Add-ons installed" table in each `CONTEXT.md`) against the add-on
   files in `<kit>/addons/` and offer their changelog entries the same way.
