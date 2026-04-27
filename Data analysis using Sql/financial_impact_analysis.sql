SELECT * FROM loan_detils.borrower_profiles;
SELECT 
    loan_purpose,
    -- Total interest the bank *expected* to make
    SUM(loan_amount * (interest_rate/100)) AS expected_interest_revenue,
    -- Total principal amount lost in defaults
    SUM(CASE WHEN loan_status = 'Default' THEN loan_amount ELSE 0 END) AS principal_loss,
    -- Profitability Ratio
    ROUND(SUM(CASE WHEN loan_status = 'Default' THEN -loan_amount ELSE (loan_amount * interest_rate/100) END), 2) AS net_profit_impact
FROM loan_applications
GROUP BY loan_purpose
ORDER BY net_profit_impact ASC;