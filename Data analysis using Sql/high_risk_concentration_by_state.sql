SELECT * FROM loan_detils.loan_applications;
SELECT 
    b.state,
    b.borrower_id,
    b.credit_score,
    l.dti_ratio,
    l.loan_amount,
    -- Ranking borrowers by risk (highest DTI and lowest Credit Score)
    RANK() OVER(PARTITION BY b.state ORDER BY l.dti_ratio DESC, b.credit_score ASC) as risk_rank_in_state
FROM borrower_profiles b
JOIN loan_applications l ON b.borrower_id = l.borrower_id
WHERE l.loan_status NOT IN ('Paid Off')
limit 5;