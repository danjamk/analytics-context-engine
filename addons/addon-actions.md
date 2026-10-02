# Actions

**Version:** addon-actions-v0.1 (2026-10-02)

## For the person

Lets a recurring analysis end in an action instead of a report: send an alert, or push a list to
another system (for example, a target list to a campaign tool). It is the only way the kit writes
anywhere.

The base install is read-only by construction. This add-on keeps analysis that way and adds a
separate, named path for each write, with its own credential, a dry run, a verdict gate,
approval, and an undo plan.

- **Costs:** a write-scoped credential for each target system, created by you, and a few minutes
  per action to define its limits.
- **Worth it when:** a report's recommendation is routinely turned into the same action by hand.
- **Not worth it when:** the action is rare, or nobody could tell a wrong send from a right one.

## Preflight

1. Find the core (`core/CORE.md`) and the domain pack (`context/CONTEXT.md`). Both must be stamped
   `analytics-context-engine-v0.5` or later; if older, run the `upgrade` skill first.
2. If `addon-actions` is already listed under "Add-ons installed", compare its version with this
   file's and offer the changelog entries since then.
3. Confirm the recipe that will feed the action exists and its golden check passes. An action on
   top of an unverified recipe acts on unverified numbers.

## Steps

1. **Define the action** (part 26). Copy `templates/addons/actions/action.yaml` to
   `context/actions/<name>.yaml`. Ask, one at a time: what it sends and where; which recipe feeds
   it; per-run approval or pre-approved limits; how to undo it.
2. **Credential.** The operator creates a write-scoped credential for the target system. Record
   its name, never its value. It must not be the credential any read path uses.
3. **Dry run.** Build the dry run and show its output: the exact records, their count, the target.
4. **Wire the recipe** (part 12). Set the recipe's publish mode to `action:<name>`.
5. **Outcome records** (part 25). Every run, sent or held, adds a `type: action` entry to
   `memory/outcomes.yaml`.

## Confirm before write

Summarize in under 12 lines: the action, the target, the credential name, the gate, the approval
mode and limits, the undo path. Wait for a yes.

## Stamp

Add `addon-actions-v0.1` to "Add-ons installed" in `context/CONTEXT.md`, and a router row for
`actions/`.

## Hand-off test

Run the action in dry-run mode on the latest recipe output, then run it for real with per-run
approval. Confirm: the records sent match the dry run, the outcome record exists, and a second run
with the same idempotency key is skipped.

## Changelog

### addon-actions-v0.1 (2026-10-02)
- **First version.** Affects: new `context/actions/`, `memory/outcomes.yaml` entries of type
  `action`, the feeding recipe's publish mode. Existing instances: not needed.
