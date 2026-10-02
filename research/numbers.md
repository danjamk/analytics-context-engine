# Numbers

Benchmark figures worth citing, with how to cite them honestly. Checked 2026-09-30.

| Claim | Figure | Source and date | How to cite |
|---|---|---|---|
| Hard, realistic text-to-SQL is still unsolved | GPT-5: 8.67% conversational, 17.00% agentic on BIRD-Interact | ICLR 2026 — https://github.com/bird-bench/BIRD-Interact | "On agentic, multi-turn benchmarks, frontier models still score under 25%." |
| Reliability is lower than accuracy | Best reliability score 24.21% | TrustDABench, Aug 2026 — https://arxiv.org/abs/2608.24145 | Pair with BIRD-Interact. |
| Newer models improved raw text-to-SQL | 32.7% (GPT-4, 2023) → 64.5% (2026 models), same unmodeled schema | dbt, 2026-04-07 — https://docs.getdbt.com/blog/semantic-layer-vs-text-to-sql-2026 | "Newer models moved raw text-to-SQL from 32.7% to 64.5%." |
| Modeling the data is the bigger lever | 64.5% → 84–90% | same | "Modeling the data moved it to 84–90%." |
| A semantic layer closes most of the rest | Sonnet 4.6 90.0 → 98.2%; GPT-5.3-Codex 84.1 → 100% | same | Cite with the April 2026 date. |
| …but not for every model | Aug 10, 2026 rerun: GPT-5.6 Luna lower with the semantic layer than without | dbt-llm-sl-bench repo results DB (no writeup); 11 questions | "In a later rerun, one model did worse with the semantic layer." Small sample. |
| Semantic layers fail loudly more often | Aug rerun: 20 of 74 semantic-layer failures were explicit errors; out-of-scope questions returned errors (0% answered) in the Feb run | same | Don't say "always fails as a refusal." Say "fails loudly more often." |
| Leaderboard tops are noisy | Annotation errors in 66.1% of checked Spider 2.0-Snow tasks; 52.8% of BIRD Mini-Dev | CIDR 2026 — https://www.vldb.org/cidrdb/papers/2026/p5-jin.pdf | Use when someone cites a 90%+ leaderboard number. |
| LLM judges need calibration | Weak judge κ 0.04–0.42 vs. humans; three strong judges, unanimous, κ 0.79 | Liu et al., 2026-09-09 — https://arxiv.org/abs/2609.30290 | "Calibrate the judge before trusting it." |

## Retired

| Claim | Why retired |
|---|---|
| "Raw text-to-SQL scores 10–21% on enterprise workflows" | From Spider 2.0 v1 (Nov 2024), whose 632-task setting was retired 2025-05-22. The primary source says 17.0%; the 21% traces to a blog. |
| "Modeling moved accuracy from 32.7% to 84–90%" | Conflates model progress (32.7 → 64.5) with modeling (64.5 → 84–90). |

## Vendor-reported, unaudited

- Databricks Genie: "32% → 90%" against an unnamed coding-agent baseline (2026-05-08).
- Snowflake Cortex Sense: accuracy lift reported in preview materials.
- MotherDuck Guides: benchmark gain on DABStep.
