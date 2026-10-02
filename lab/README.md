# Lab

Hands-on trials: tools, formats, and ideas run against real data before they shape the kit or
anything I write. A claim I have not tried is labeled as such.

## Trial format

One file per trial: `lab/YYYY-MM-DD-<tool-or-idea>.md`. Template: `TRIAL.md`.

## Queue

| Trial | Why | Log entry |
|---|---|---|
| Kit v2 on my own health data (private instance) | First real deployment of the v2 templates; finds what the templates get wrong | — |
| Demo pack on UCI Online Retail II (`examples/retail/`) | Public proof of refuse-vs-wrong; tests BOOTSTRAP.md end to end with a fresh agent | — |
| WrenAI CLI on the retail demo | Closest open-source design; compare MDL and memory to the kit | 2026-09-16 |
| Ossie export of the retail metrics, round-tripped through the dbt and Snowflake converters | Proves the format decision in `kit/FORMAT.md` | 2026-07-10 |
| Anthropic `data-context-extractor` on the retail data, then import into the kit | Tests the import path in BOOTSTRAP.md Phase 3 | — |
| MotherDuck Guides vs. a kit domain pack on the same questions | Short guide vs. structured pack: which answers better? | 2026-07-29 |
| Judge pass calibration on the retail goldens | Measure agreement before trusting verdicts | — |
| Deterministic vs. judge referee comparison | Which catches more, on which failures | — |
