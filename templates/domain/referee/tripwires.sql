-- Tripwires — run before trusting any answer. Each row: check, value, threshold, status.
-- A red row changes the output: caveat, PROVISIONAL, or REFUSE. See REFEREE.md §2.
-- Replace the placeholders; keep one SELECT per check, UNION ALL'd.

SELECT 'freshness_days' AS check_name,
       date_diff('day', max(<loaded_at_column>), current_date) AS value,
       <max_days> AS threshold,
       CASE WHEN date_diff('day', max(<loaded_at_column>), current_date) <= <max_days>
            THEN 'green' ELSE 'red' END AS status
FROM <table>

UNION ALL

SELECT 'unmapped_share',
       avg(CASE WHEN <key> IS NULL THEN 1.0 ELSE 0.0 END),
       <max_share>,
       CASE WHEN avg(CASE WHEN <key> IS NULL THEN 1.0 ELSE 0.0 END) <= <max_share>
            THEN 'green' ELSE 'amber' END
FROM <table>

-- UNION ALL  orphan rate on the weakest join
-- UNION ALL  double-count guard (parent/child)
-- UNION ALL  agreement between two measures of the same quantity
-- UNION ALL  partial last period
;
