WITH income_cte AS (
  SELECT 
    user_id, 
    ROUND(AVG(amount), 2) AS avg_income
  FROM transactions
  WHERE type = 'credit'
    AND txn_date >= CURRENT_DATE - INTERVAL '6 MONTH'
  GROUP BY user_id
),

repayment_cte AS (
  SELECT 
    l.user_id,
    COUNT(*) FILTER (
      WHERE paid_date > due_date
    ) AS late_repayments
  FROM repayments r
  JOIN loans l ON r.loan_id = l.loan_id
  GROUP BY l.user_id
)

SELECT 
  u.user_id,
  u.name,
  COALESCE(i.avg_income, 0) AS avg_income,
  COALESCE(r.late_repayments, 0) AS late_repayments,
  
  -- Final Credit Score Calculation
  (
    CASE WHEN COALESCE(i.avg_income, 0) >= 30000 THEN 30 ELSE 0 END +
    CASE WHEN COALESCE(r.late_repayments, 0) = 0 THEN 30 ELSE -10 END +
    CASE WHEN u.employment_status IN ('Salaried', 'Business') THEN 20 ELSE 0 END +
    CASE WHEN EXISTS (
      SELECT 1 FROM loans l2 
      WHERE l2.user_id = u.user_id 
        AND l2.amount > 100000 
        AND l2.status = 'closed'
    ) THEN 10 ELSE 0 END +
    CASE WHEN EXISTS (
      SELECT 1 FROM loans l3 
      WHERE l3.user_id = u.user_id 
        AND l3.status = 'defaulted'
    ) THEN -50 ELSE 0 END
  ) AS credit_score

FROM users u
LEFT JOIN income_cte i ON u.user_id = i.user_id
LEFT JOIN repayment_cte r ON u.user_id = r.user_id
ORDER BY credit_score DESC;
