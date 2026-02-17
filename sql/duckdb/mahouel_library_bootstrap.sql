-- ============================================
-- Library Domain - Bootstrap Tables (DuckDB)
-- ============================================

DROP TABLE IF EXISTS checkout;
DROP TABLE IF EXISTS branch;

-- Parent table
CREATE TABLE branch (
    branch_id TEXT PRIMARY KEY,
    branch_name TEXT,
    city TEXT,
    system_name TEXT
);

-- Child table
CREATE TABLE checkout (
    checkout_id TEXT PRIMARY KEY,
    branch_id TEXT,
    material_type TEXT,
    duration_days INTEGER,
    fine_amount DOUBLE,
    checkout_date DATE,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Load data
COPY branch
FROM 'data/library/branch.csv'
(HEADER, AUTO_DETECT TRUE);

COPY checkout
FROM 'data/library/checkout.csv'
(HEADER, AUTO_DETECT TRUE);
