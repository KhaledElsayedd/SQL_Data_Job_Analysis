/*
 Question: What are the most in-demand skills for data analysts?
 - Identify the top 5 in-demand skills for data analysts.
 - Focus on all job postings.
 - This helps job seekers identify what are the most in-demand skills globally.
 */
SELECT skills,
    number_of_jobs
FROM (
        SELECT skill_id,
            COUNT(job_postings_fact.job_id) AS number_of_jobs
        FROM job_postings_fact
            LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        WHERE job_title_short LIKE '%Data%Analyst'
        GROUP BY skills_job_dim.skill_id
    ) AS skill_job_id
    INNER JOIN skills_dim ON skill_job_id.skill_id = skills_dim.skill_id
ORDER BY number_of_jobs DESC
LIMIT 5;
/*
 The following percentages represent each skill's share of the total job postings:
 - SQL: 30.9%
 - Excel: 21.1%
 - Python: 19.2%
 - Tableau: 15.9%
 - Power BI: 12.7%
 
 */