WITH jan_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 1
),
feb_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 2
),
mar_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 3
)
SELECT job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg AS avg_salary
FROM (
        SELECT *
        FROM jan_jobs
        UNION ALL
        SELECT *
        FROM feb_jobs
        UNION ALL
        SELECT *
        FROM mar_jobs
    ) AS quarter_1
WHERE salary_year_avg > 70000
    AND job_title_short LIKE '%Data%Analyst%' -- Because some the job titles aren't consistent
ORDER BY avg_salary DESC;