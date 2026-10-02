# Privacy boundary

This repository holds the kit: rules, templates, skills, research. It never holds an instance.

## What is never published

- Anything under an instance's `core/` or `context/`: definitions, rulings, caveats with real
  figures, goldens with verified values, exemplars with real SQL, session logs.
- Real table names, project keys, hostnames, people's names, or figures from any client or
  personal dataset.
- `.env` files, credentials, data files.

There is no scrubbed version of an instance file. If a kit file needs instance content to make
sense, the kit file is wrong: fix it at the source so the next change is clean.

## Rule that keeps the boundary simple

The kit knows an instance only by shape. Kit files may say "read `meaning/caveats.yaml`". They
never say what any caveat is. Every instance file has an empty twin in `templates/`; the
template is the shareable asset.

Examples in kit files use the public demo dataset (`examples/retail/`) or neutral placeholders
(`<metric>`, `<population_filter>`).

## Before every commit to this repo

1. `git status` shows no `core/`, `context/`, `instance/`, data, or `.env` files.
2. Run the leakage scan with your own private term list:
   ```zsh
   grep -rniEf ~/.config/data-brain/private-terms.txt . --exclude-dir=.git
   ```
   The term list (client names, project keys, hostnames, people) lives outside this repo.
   Expect zero hits. A hit is a bug in the kit, fixed in place.
3. Check examples for real names, figures, or hostnames.
