SELECT company.name,
    job_posting.number_job_postings,
    CASE
        WHEN job_posting.number_job_postings < 10 THEN 'Small'
        WHEN job_posting.number_job_postings > 50 THEN 'Large'
        ELSE 'Medium'
    END AS Company_size
FROM (
        SELECT company_id,
            COUNT(job_id) AS number_job_postings
        FROM job_postings_fact
        GROUP BY company_id
    ) AS job_posting
    INNER JOIN company_dim AS company ON job_posting.company_id = company.company_id