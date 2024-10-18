/*
 Question: What are the most optimal skills to learn?
 - Building on the third and fourth query.
 - To find the skills with high demand and high pay,
 where the avg_pay and number of jobs is above average
 */
WITH top_paying_skills AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_pay
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short LIKE '%Data%Analyst%'
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),
most_demand AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        number_of_jobs
    FROM (
            SELECT skills_job_dim.skill_id,
                COUNT(job_postings_fact.job_id) AS number_of_jobs
            FROM job_postings_fact
                LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
            WHERE job_title_short LIKE '%Data%Analyst'
            GROUP BY skills_job_dim.skill_id
        ) AS skill_job_id
        INNER JOIN skills_dim ON skill_job_id.skill_id = skills_dim.skill_id
)
SELECT top_paying_skills.skills,
    avg_pay,
    number_of_jobs
FROM top_paying_skills
    INNER JOIN most_demand ON top_paying_skills.skill_id = most_demand.skill_id
WHERE avg_pay > 97348
    AND -- 97348 is the average pay across Data Analysts jobs.
    number_of_jobs > 3118 -- The average number of jobs per skill.
    /*
     INSIGHTS:
     
     1. **Top Skills**:
     - **SQL** has the highest demand with 110,380 job postings and an average pay of $100,299, making it a key skill in the job market.
     - **AWS** and **Azure** are highly demanded cloud skills with job postings around 11,197 and 13,221, respectively, and average pays of over $107,000.
     - **Python** remains a critical programming language with 68,409 job postings and a solid average pay of $105,115.
     
     2. **Data-related Tools**: Skills such as **Tableau** (56,569 job postings), **Spark**, and **Databricks** also feature prominently, reflecting the increasing demand for data analytics and engineering.
     
     3. **High-Paying Skills**: **Snowflake** ($112,876), **GCP** ($113,367), and **Databricks** ($114,910) offer among the highest average salaries, indicating the growing importance of cloud and data processing platforms.
     
     */