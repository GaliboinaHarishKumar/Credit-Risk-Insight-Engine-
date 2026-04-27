SELECT * FROM loan_detils.borrower_profiles;
SELECT 
    CASE 
        WHEN dti_ratio > 45 AND credit_score < 600 THEN 'Critical: High Debt/Low Credit'
        WHEN dti_ratio > 45 AND credit_score >= 600 THEN 'Warning: High Debt Burden'
        WHEN dti_ratio <= 45 AND credit_score < 600 THEN 'Warning: Poor Credit History'
        ELSE 'Healthy: Low Risk'
    END AS risk_persona,
    COUNT(*) AS total_borrowers,
    SUM(loan_amount) AS total_exposure,
    ROUND(AVG(days_delinquent), 1) AS avg_days_late
FROM loan_applications l
JOIN borrower_profiles b ON l.borrower_id = b.borrower_id
GROUP BY 1
ORDER BY avg_days_late DESC;