# Market log

Newest first. Format and rules: `README.md`.

---

### 2026-10-02 — Gap claims re-checked: two need narrower wording
- **What:** A second pass tried to falsify the "not shipped by anyone" list in `landscape.md`. Still unshipped as products: rulings with rejected readings, external benchmarks with limits, the fact/meaning split, tripwires that change the answer, a rules version stamped on stored results, goldens verified a second way. Two claims were too broad. Graded verdicts exist in Anthropic's internal data agent (a confidence tier on every answer). Runtime review exists in two forms: Anthropic's internal review before delivery, and Lightdash scanning every agent turn after delivery for admins. A judge that reviews the answer before the user sees it, without seeing the agent's reasoning, was not found.
- **Source:** https://claude.com/blog/how-anthropic-enables-self-service-data-analytics-with-claude (2026-06-03); https://docs.lightdash.com/agents/issues (date not shown).
- **Means:** Opinion: "no product ships it" still holds for verdicts and a blind runtime judge, but "nobody does it" does not. That the vendor of the model had to build these for its own data team supports the gap rather than closing it. `landscape.md` rows 18 and 20 corrected.
- **Tags:** research · write

### 2026-09-30 — Landscape review: offline referee has shipped; per-answer referee has not
- **What:** A review of 14 products against the kit's 24 parts. Snowflake, Hex, Cube, Wren (Enterprise), Omni, and Looker ship eval suites that re-run test questions when context changes and report regressions; Databricks ships a partial version. Most also suggest context edits from usage for a human to approve. None ships tripwires that change an answer, graded verdicts, expected-refusal tests, or goldens verified by a second method.
- **Source:** `landscape.md` (this repo).
- **Means:** My July 2026 viewpoint called Learn and Referee whitespace. The offline half is now standard. The open space is the per-answer referee and the governance of meaning (rulings with owners, the fact/meaning split in learning). The kit is built around those.
- **Tags:** research · write

### 2026-09-16 — Fivetran announces a Context Layer (limited preview)
- **What:** Context stored as warehouse tables under an open "Agents Schema" (e.g. `AGENTS.OSI_DATASET`). Agent traces are written back to the warehouse, including the answer, the SQL, and the assumptions the agent made.
- **Source:** https://www.fivetran.com/blog/announcing-fivetran-context-layer
- **Means:** Recording "assumptions made" with each answer is a good idea; the kit now requires it in provenance (CONVENTIONS §4). Context as warehouse tables is the opposite choice from files in git; worth watching which one teams prefer.
- **Tags:** new-player · watch

### 2026-09-16 — WrenAI CLI v0.15.0
- **What:** Wren's CLI-first rewrite continues: MDL semantic model, context as YAML and Markdown, memory of question→SQL pairs in a local index, skills for agents, and a strict mode that blocks DuckDB file and remote readers. Evaluation and the AI Advisor remain Enterprise-only.
- **Source:** https://github.com/Canner/WrenAI
- **Means:** The closest open-source design to this kit. Its strict mode caught a gap in mine: a SELECT-only guard does not stop `read_csv('/etc/passwd')` in DuckDB. Now in CONVENTIONS §2.
- **Tags:** release · try

### 2026-09-15 — Coginiti joins the Claude and OpenAI partner networks
- **What:** Coginiti, which positions itself as a "semantic intelligence" platform and joined OSI in April 2026, announced both partnerships.
- **Source:** https://www.einpresswire.com/article/942430134/coginiti-joins-openai-and-claude-partner-networks-to-advance-governed-enterprise-ai
- **Means:** Semantic-layer vendors are positioning as the grounding layer for general-purpose assistants, not only for their own agent.
- **Tags:** release · watch

### 2026-09-15 — Hex: published and scheduled eval suites
- **What:** Hex eval suites can now be published, versioned, and scheduled, extending the August launch.
- **Source:** https://learn.hex.tech/changelog/2026-09-15
- **Means:** Drift detection on a schedule is now a product feature. The kit's drift loop should run on a schedule too, not only on change.
- **Tags:** release · watch

### 2026-09-08 — dbt's latest metrics spec moves semantic models under models
- **What:** `semantic_model` and `metrics` now sit under each `models:` entry; supported on Fusion and dbt 1.12. MetricFlow (Apache 2.0) supports DuckDB but not MySQL or SQLite.
- **Source:** https://docs.getdbt.com/docs/build/latest-metrics-spec
- **Means:** The kit borrows dbt field names (`label`, `filter`, `numerator`/`denominator`) so an exporter is simple, but does not depend on dbt.
- **Tags:** standard · watch

### 2026-09-03 — Cube describes an "agentic analytics harness"
- **What:** Cube published its architecture for agents over its semantic layer: rules files with an always/on-request loading policy, certified queries, memories, and evals that can gate a pull request.
- **Source:** https://cube.dev/blog/building-an-agentic-analytics-harness
- **Means:** Per-file loading policy is a good idea; the kit's router now marks each file `always` or on-demand.
- **Tags:** idea · watch

### 2026-08-28 — Looker golden queries GA; Snowflake steers Cortex Analyst users to Cortex Agents
- **What:** Looker's golden queries for conversational analytics reached general availability. Separately, Snowflake now recommends Cortex Agents over Cortex Analyst.
- **Source:** https://docs.cloud.google.com/looker/docs/release-notes · https://docs.snowflake.com/en/release-notes/2026/other/2026-08-28-cortex-analyst-transition-cortex-agents
- **Means:** "Verified question → SQL" is now a standard feature everywhere. It is commodity; the kit treats exemplars as table stakes.
- **Tags:** release

### 2026-08-10 — dbt semantic-layer benchmark rerun with newer models
- **What:** The dbt-llm-sl-bench repo added runs with newer models. Opus 5 and GPT-5.6 Sol reached 100% through the semantic layer; GPT-5.6 Luna scored lower with the semantic layer than without it. 11 questions; small samples.
- **Source:** https://github.com/dbt-labs/dbt-llm-sl-bench (figures computed from the committed results database; no published writeup)
- **Means:** "A semantic layer always wins" no longer holds for every model. The stronger claim is about failure mode: governed layers fail loudly more often.
- **Tags:** research · write

### 2026-08-04 — Hex launches Evals
- **What:** Fork the context and test a change before publishing; build test suites from past conversations; grade with a method judge and an answer judge.
- **Source:** https://learn.hex.tech/changelog/2026-08-04
- **Means:** Building test suites from past conversations risks circular goldens: the agent's own answers become the expected values. The kit requires a second verification method.
- **Tags:** release · write

### 2026-07-29 — MotherDuck Guides (preview)
- **What:** Versioned markdown context files served to agents over MCP, with a tool the agent calls before writing SQL. Vendor reports a large benchmark gain. An independent review found shorter guides gave more accurate answers.
- **Source:** https://motherduck.com/blog/context-belongs-in-the-warehouse/ · https://www.corrdyn.com/blog/motherduck-agent-guides/
- **Means:** Short beats complete. One wrong line in a guide enters every future question, which is the argument for goldens on context changes.
- **Tags:** release · try

### 2026-07-10 — OSI moves to Apache as Ossie (incubating)
- **What:** The Open Semantic Interchange spec, released as 0.1.1 in December 2025 and widely reported as "v1.0", is now Apache Ossie. Snowflake reads and writes Ossie YAML (preview). The repo has converters for dbt, Cube, Databricks and more. The next version drops the `semantic_model` wrapper.
- **Source:** https://ossie.apache.org/updates/ · https://github.com/apache/ossie
- **Means:** Ossie is the export target for the kit, not the authoring format: it has no governance fields (owner, status, certification) yet.
- **Tags:** standard · try

### 2026-07-07 — Omni AI Evals
- **What:** Run prompt sets on a branch against main, side by side; grading covers topic, fields, filters, query, and answer.
- **Source:** https://omni.co/blog/run-your-agent-like-a-data-product-with-ai-evals
- **Means:** Grading the path (fields, filters) as well as the answer is right. Kit goldens can name the expected path.
- **Tags:** release

### 2026-07-07 — ktx: last commit to main
- **What:** ktx (YC, Apache 2.0) keeps a semantic layer and a wiki in git, mines warehouse query history, and gates every ingest as a PR with typed conflicts. No commits since this date as of 2026-09-30.
- **Source:** https://github.com/Kaelio/ktx
- **Means:** Its typed conflict labels (`definitional_contradiction`, `re_ingest_change`) are now the kit's proposal kinds. Its terminology guide reserves "context engine" for internals and "context layer" for the product.
- **Tags:** new-player · watch

### 2026-06-30 — Snowflake Cortex Sense
- **What:** Builds context from query usage patterns. Snowflake reported that semantic views covered under 5% of its own internal tables.
- **Source:** https://www.snowflake.com/en/blog/enterprise-ai-agents-grounded-context/
- **Means:** Hand-curated semantic layers don't scale to all tables; mining usage is how vendors fill the gap. Usage is evidence, not a ruling.
- **Tags:** release · watch

### 2026-06-26 — Cube Evals
- **What:** Evals run on branches; the CLI exits non-zero to gate a pull request; failures carry one of nine tags.
- **Source:** https://cube.dev/changelog/2026-06-26-changelog-cube-evals
- **Means:** A failure taxonomy is worth borrowing for the kit's verdict log.
- **Tags:** release

### 2026-06-16 — Databricks: Genie One, Genie Ontology, Genie Agents
- **What:** Genie spaces became Genie Agents. Genie Ontology mines definitions and ranks them by source, usage, freshness, and proximity to certified assets. Benchmarks are never placed in the agent's context.
- **Source:** https://www.databricks.com/blog/introducing-genie-one-genie-ontology-and-genie-agents
- **Means:** Automated authority ranking replaces a ruling with a score. The kit keeps rulings explicit. The holdout rule (benchmarks out of context) is now in REFEREE.md.
- **Tags:** release · write

### 2026-06-03 — Anthropic describes its internal self-service data agent
- **What:** Anthropic's data team routes every data question through a semantic layer by default, adds skills and business context, and runs an adversarial review skill before delivery. Every answer ends with a footer: source tier, confidence tier, review round, freshness (max date in the data), and owning team. Corrections become pull requests tagged to the domain owner. Reported accuracy: 21% without skills, over 95% with them (vendor-reported). The review added 6% accuracy at 72% higher latency (vendor-reported).
- **Source:** https://claude.com/blog/how-anthropic-enables-self-service-data-analytics-with-claude
- **Means:** Opinion: the closest published practice to the kit's per-answer referee, and internal, not a product. It treats the semantic layer as required but not sufficient. The freshness line discloses but does not block, and the reviewer appears to see the working (not verified), so tripwires and a blind judge remain open.
- **Tags:** research · watch · write

### 2026-05-28 — DataHub Context Platform (private beta)
- **What:** Mines query logs for proven joins and filters. Context Hub lets experts approve context and simulate its effect on text-to-SQL before publishing. An open-source analytics agent drafts context proposals and waits for the user's approval.
- **Source:** https://datahub.com/blog/announcing-datahub-context-platform/
- **Means:** "Test the proposal before merging" is converging across vendors. In the open-source agent, the approver is whoever is asking, not the owner of the data's meaning.
- **Tags:** new-player · watch

### 2026-04-30 — Wren AI Advisor (Enterprise)
- **What:** Diagnoses failing benchmark questions, stages schema and instruction fixes, verifies them on the failures, regression-tests the full benchmark, then applies.
- **Source:** https://docs.getwren.ai/cp/guide/evaluation/ai-advisor
- **Means:** The closest shipped match to the kit's drift loop. Ground-truth SQL may be AI-generated and previewed by a human, which is weaker than verification by a second method.
- **Tags:** release · watch

### 2026-04-07 — dbt: semantic layer vs. text-to-SQL, 2026 edition
- **What:** Claude Sonnet 4.6 went from 90.0% to 98.2% and GPT-5.3-Codex from 84.1% to 100% through the semantic layer. Raw text-to-SQL on the unmodeled schema scored 64.5%, up from GPT-4's 32.7% in 2023.
- **Source:** https://docs.getdbt.com/blog/semantic-layer-vs-text-to-sql-2026
- **Means:** Newer models explain about half the gain once attributed to modeling. The order of effect is still: model the data, then govern it.
- **Tags:** research · write

### 2026-03-29 — Vanna archives its open-source repo
- **What:** Vanna's open-source project (question→SQL memory, no semantic layer) was archived; the hosted product continues.
- **Source:** https://github.com/vanna-ai/vanna
- **Means:** Memory of past queries alone wasn't enough to keep an open-source project going. The surviving designs pair memory with a semantic model.
- **Tags:** new-player
