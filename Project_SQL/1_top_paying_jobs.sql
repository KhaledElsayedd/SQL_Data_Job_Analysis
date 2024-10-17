/*
 Question: What are the top paying data analyst jobs in Egypt?
 - Discover the top paying jobs for data analyst's that are available in Egypt.
 - Focusing on jobs with specified salaries (remove nulls).
 - Why? To grab insights about the top paying jobs in Egypt,
 which could help me as a data analyst find the optimal job that suits me. 
 */
SELECT job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg AS avg_yearly_salary,
    job_posted_date::DATE
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short LIKE '%Data%Analyst%'
    AND salary_year_avg IS NOT NULL
    AND job_location LIKE '%Egypt%'
ORDER BY avg_yearly_salary DESC;