SELECT * FROM loan_detils.loan_applications;
SELECT 
    STRFTIME('%Y-%m', application_date) AS application_month,
    COUNT(loan_id) AS loan_volume,
    AVG(credit_score) AS avg_monthly_credit_score,
    -- Comparing this month's avg score to last month
    AVG(credit_score) - LAG(AVG(credit_score)) OVER (ORDER BY STRFTIME('%Y-%m', application_date)) AS score_delta
FROM loan_applications l
JOIN borrower_profiles b ON l.borrower_id = b.borrower_id
GROUP BY 1
ORDER BY 1;SELECT * FROM loan_detils.borrower_profiles;