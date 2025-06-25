-- Load CSVs in pgAdmin using COPY
-- Adjust the path if needed for your local system

-- Load users
COPY users(user_id, name, age, employment_status, monthly_income)
FROM 'G:\Resume Projects\credit_risk_system\data\users.csv'
DELIMITER ',' CSV HEADER;

-- Load transactions
COPY transactions(txn_id, user_id, amount, txn_date, type)
FROM 'G:\Resume Projects\credit_risk_system\data\transactions.csv'
DELIMITER ',' CSV HEADER;

-- Load loans
COPY loans(loan_id, user_id, amount, created_at, status)
FROM 'G:\Resume Projects\credit_risk_system\data\loans.csv'
DELIMITER ',' CSV HEADER;

-- Load repayments
COPY repayments(payment_id, loan_id, due_date, paid_date, amount_paid)
FROM 'G:\Resume Projects\credit_risk_system\data\repayments.csv'
DELIMITER ',' CSV HEADER;
