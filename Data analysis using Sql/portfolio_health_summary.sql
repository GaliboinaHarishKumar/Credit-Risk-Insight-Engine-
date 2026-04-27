SELECT * FROM loan_detils.borrower_profiles;
WITH LoanMetrics AS (
    SELECT 
        loan_status,
        COUNT(loan_id) as loan_count,
        SUM(loan_amount) as total_value,
        AVG(interest_rate) as avg_rate
    FROM loan_applications
    GROUP BY loan_status
)
SELECT 
    loan_status,
    loan_count,
    total_value,
    -- Calculating the percentage of total portfolio value
    ROUND(total_value * 100.0 / SUM(total_value) OVER(), 2) AS pct_of_portfolio_value,
    ROUND(avg_rate, 2) AS avg_interest_rate
FROM LoanMetrics
ORDER BY total_value DESC;