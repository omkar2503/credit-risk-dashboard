CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  employment_status VARCHAR(50),
  monthly_income DECIMAL
);

CREATE TABLE transactions (
  txn_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  amount DECIMAL,
  txn_date DATE,
  type VARCHAR(10) CHECK (type IN ('credit', 'debit'))
);

CREATE TABLE loans (
  loan_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  amount DECIMAL,
  created_at DATE,
  status VARCHAR(20) CHECK (status IN ('approved', 'closed', 'defaulted'))
);

CREATE TABLE repayments (
  payment_id SERIAL PRIMARY KEY,
  loan_id INT REFERENCES loans(loan_id),
  due_date DATE,
  paid_date DATE,
  amount_paid DECIMAL
);
