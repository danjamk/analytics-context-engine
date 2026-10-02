# Writing an add-on

An add-on extends what `BOOTSTRAP.md` built. It is a guide in its own right: the agent follows it
the same way it followed the bootstrap.

## Layout

```
addons/
└── addon-<name>.md
```

List every add-on, including planned ones, in the Add-ons table in the root `README.md`. The core
template (`templates/core/CORE.md`) links to that table on `main`, so instances made by older
versions still find new add-ons.

## Structure

Every add-on has these parts, in this order:

1. **Header:** `# <Add-on name>` and `**Version:** addon-<name>-vX.Y (YYYY-MM-DD)`.
2. **For the person:** what it adds, what it costs (time, tools, accounts), and when it is worth it.
3. **Preflight:** check that the core and the target domain pack exist and which kit version
   stamped them. If the kit stamp is older than the add-on requires, run the upgrade first.
   If the add-on was already installed, compare its stamp and offer the changes since then.
4. **Steps:** what to create or change, each mapped to a part in `kit/PARTS.md`. Templates come from
   `templates/`; new templates for the add-on live in `templates/addons/<name>/`.
5. **Confirm before write:** a summary under 12 lines; wait for a yes.
6. **Stamp:** record `addon-<name>-vX.Y` in the domain's `context/CONTEXT.md` under "Add-ons
   installed".
7. **Hand-off test:** one concrete check that proves the add-on works (a recipe runs and its golden
   reproduces; the judge agrees with the human goldens at a stated rate).
8. **Changelog:** at the end of the file, in the same format as the root `CHANGELOG.md`.

## Rules

- An add-on never changes what a core part means. If it needs to, the change goes into the kit and
  the root changelog.
- An add-on that needs a service, account, or cost says so in its "For the person" section.
- Same privacy rules as the kit (`kit/PRIVACY.md`).
