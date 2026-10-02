# Question log — format

`memory/questions.jsonl`, one JSON object per line, appended for every query run during analysis.

```json
{"ts": "2026-10-01T14:02:00Z", "question": "net revenue by month in 2011", "context": ["net_revenue", "last-month-is-partial"], "sql_file": null, "verdict": "PASS-WITH-CAVEAT", "refused": false}
```

- `question` is required. A query without a question is not run.
- `context` lists the ids of metrics, caveats, rulings, and exemplars the answer used.
- Review monthly: a question asked twice with no metric behind it is a proposal (`new_definition`).
