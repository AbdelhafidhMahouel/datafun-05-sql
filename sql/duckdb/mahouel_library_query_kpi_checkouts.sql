-- ==========================================================
-- Library Domain KPI (DuckDB)
-- KPI: Number of checkouts by branch (and % of total)
-- ==========================================================

WITH totals AS (
  SELECT COUNT(*) AS total_checkouts
  FROM checkout
),
by_branch AS (
  SELECT
    b.branch_id,
    b.branch_name,
    b.city,
    b.system_name,
    COUNT(c.checkout_id) AS checkout_count
  FROM branch b
  LEFT JOIN checkout c
    ON c.branch_id = b.branch_id
  GROUP BY
    b.branch_id, b.branch_name, b.city, b.system_name
)
SELECT
  branch_id,
  branch_name,
  city,
  system_name,
  checkout_count,
  ROUND(100.0 * checkout_count / (SELECT total_checkouts FROM totals), 2) AS pct_of_total
FROM by_branch
ORDER BY checkout_count DESC, branch_id;
