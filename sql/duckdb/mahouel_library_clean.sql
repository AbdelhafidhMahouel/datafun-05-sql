-- ============================================
-- Library Domain - Clean / Validate (DuckDB)
-- ============================================

-- Basic checks (should return counts with no errors)

-- 1) Total rows
SELECT COUNT(*) AS branch_rows FROM branch;
SELECT COUNT(*) AS checkout_rows FROM checkout;

-- 2) Check for NULL keys (should be 0)
SELECT COUNT(*) AS null_branch_ids
FROM branch
WHERE branch_id IS NULL;

SELECT COUNT(*) AS null_checkout_ids
FROM checkout
WHERE checkout_id IS NULL;

-- 3) Check for orphan child rows (should be 0)
SELECT COUNT(*) AS orphan_checkouts
FROM checkout c
LEFT JOIN branch b ON c.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

-- 4) Quick preview join
SELECT
  c.checkout_id,
  c.branch_id,
  b.branch_name,
  c.material_type,
  c.duration_days,
  c.fine_amount,
  c.checkout_date
FROM checkout c
JOIN branch b ON c.branch_id = b.branch_id
ORDER BY c.checkout_id;
