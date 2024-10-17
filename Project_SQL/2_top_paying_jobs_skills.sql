/*
 Question: What are the top paying jobs required skills?
 - Use the top paying jobs from the first query.
 - Discover the required skills for each job.
 - I used subqueries to answer this question, but also CTE's could be used.
 - Why? This provides a detailed look for each job's required skills,
 which would help me find the most suitable job.
 */
SELECT top_jobs_skills.job_id,
    top_jobs_skills.job_title,
    top_jobs_skills.company_name,
    top_jobs_skills.job_location,
    top_jobs_skills.job_schedule_type,
    top_jobs_skills.avg_yearly_salary,
    top_jobs_skills.job_posted_date::DATE,
    skills.skills
FROM (
        SELECT job_postings_fact.job_id,
            job_title,
            company_dim.name AS company_name,
            job_location,
            job_schedule_type,
            salary_year_avg AS avg_yearly_salary,
            job_posted_date
        FROM job_postings_fact
            LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
        WHERE job_title_short LIKE '%Data%Analyst%'
            AND salary_year_avg IS NOT NULL
            AND job_location LIKE '%Egypt%'
        ORDER BY avg_yearly_salary DESC
    ) AS top_jobs_skills
    LEFT JOIN skills_job_dim AS job_skills ON top_jobs_skills.job_id = job_skills.job_id
    INNER JOIN skills_dim AS skills ON job_skills.skill_id = skills.skill_id;
/*
 Here's a breakdown of the most in demand skills:
 
 Top Skills Summary:
 Skill  Count
 python      3
 sql      2
 flow      2
 azure      1
 power bi      1
 dax      1
 sap      1
 r      1
 spark      1
 excel      1
 
 - Python is the most in-demand skill, followed by SQL and Flow.
 - Other skills like Azure, Power BI, DAX, SAP, R, Spark, and Excel appear less frequently, indicating more specialized requirements for certain roles.
 
 
 [
 {
 "job_id": 151019,
 "job_title": "Data Analyst - D&T",
 "company_name": "HEINEKEN",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "75550.0",
 "job_posted_date": "2023-12-10",
 "skills": "sql"
 },
 {
 "job_id": 151019,
 "job_title": "Data Analyst - D&T",
 "company_name": "HEINEKEN",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "75550.0",
 "job_posted_date": "2023-12-10",
 "skills": "python"
 },
 {
 "job_id": 151019,
 "job_title": "Data Analyst - D&T",
 "company_name": "HEINEKEN",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "75550.0",
 "job_posted_date": "2023-12-10",
 "skills": "azure"
 },
 {
 "job_id": 151019,
 "job_title": "Data Analyst - D&T",
 "company_name": "HEINEKEN",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "75550.0",
 "job_posted_date": "2023-12-10",
 "skills": "power bi"
 },
 {
 "job_id": 151019,
 "job_title": "Data Analyst - D&T",
 "company_name": "HEINEKEN",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "75550.0",
 "job_posted_date": "2023-12-10",
 "skills": "dax"
 },
 {
 "job_id": 151019,
 "job_title": "Data Analyst - D&T",
 "company_name": "HEINEKEN",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "75550.0",
 "job_posted_date": "2023-12-10",
 "skills": "sap"
 },
 {
 "job_id": 151019,
 "job_title": "Data Analyst - D&T",
 "company_name": "HEINEKEN",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "75550.0",
 "job_posted_date": "2023-12-10",
 "skills": "flow"
 },
 {
 "job_id": 569587,
 "job_title": "Data Analyst",
 "company_name": "Contentsquare",
 "job_location": "Cairo, Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "57500.0",
 "job_posted_date": "2023-08-18",
 "skills": "python"
 },
 {
 "job_id": 751554,
 "job_title": "Market Data Analyst f/m",
 "company_name": "Bosch Group",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "51014.0",
 "job_posted_date": "2023-01-19",
 "skills": "sql"
 },
 {
 "job_id": 751554,
 "job_title": "Market Data Analyst f/m",
 "company_name": "Bosch Group",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "51014.0",
 "job_posted_date": "2023-01-19",
 "skills": "python"
 },
 {
 "job_id": 751554,
 "job_title": "Market Data Analyst f/m",
 "company_name": "Bosch Group",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "51014.0",
 "job_posted_date": "2023-01-19",
 "skills": "r"
 },
 {
 "job_id": 751554,
 "job_title": "Market Data Analyst f/m",
 "company_name": "Bosch Group",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "51014.0",
 "job_posted_date": "2023-01-19",
 "skills": "spark"
 },
 {
 "job_id": 751554,
 "job_title": "Market Data Analyst f/m",
 "company_name": "Bosch Group",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "51014.0",
 "job_posted_date": "2023-01-19",
 "skills": "excel"
 },
 {
 "job_id": 751554,
 "job_title": "Market Data Analyst f/m",
 "company_name": "Bosch Group",
 "job_location": "Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "51014.0",
 "job_posted_date": "2023-01-19",
 "skills": "tableau"
 },
 {
 "job_id": 687385,
 "job_title": "Imaging Geophysicist / Scientist - 2023 Graduate Programme",
 "company_name": "CGG",
 "job_location": "Cairo, Egypt",
 "job_schedule_type": "Full-time",
 "avg_yearly_salary": "50400.0",
 "job_posted_date": "2023-05-19",
 "skills": "flow"
 }
 ]
 */