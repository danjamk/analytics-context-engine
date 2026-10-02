# Example domain: UCI Online Retail II

A public demo domain pack, built with `BOOTSTRAP.md`, showing an agent caveat or refuse where
plain text-to-SQL returns a confident wrong number. **Status: planned.**

## Data

- UCI Online Retail II — https://archive.ics.uci.edu/dataset/502/online+retail+ii
- License: CC BY 4.0. About 1.07M invoice lines, Dec 2009 – Dec 2011, a UK online retailer.
- Not committed to this repo. `fetch.sh` (planned) downloads it and loads DuckDB.

## Traps to demonstrate (to be confirmed by profiling)

| Trap | What naive SQL does |
|---|---|
| Last month is partial (data ends 2011-12-09) | Reports a sales collapse in December 2011 |
| Cancellations (invoices starting with "C") carry negative quantities | Nets them out silently, or double counts depending on the filter |
| A large share of lines have no customer id | Drops them from "revenue per customer" without saying so |
| Non-product stock codes (postage, fees, adjustments) | Counts them as product sales |
| Country names stored in a specific form | A filter on "UK" returns nothing and reads as zero sales |

## Planned contents

`context/` — a complete domain pack: sources, entities, metrics, rulings, caveats, refusals,
goldens (verified against published summaries of the dataset or hand counts), tripwires, and two
recipes. Plus a side-by-side: the same five questions answered with and without the pack.
