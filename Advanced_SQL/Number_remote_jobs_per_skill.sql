-- Discovering the top 5 skills for data analyst's remote jobs
SELECT skills_dim.skill_id,
    skills_dim.skills,
    number_of_jobs
FROM (
        SELECT skills_job_dim.skill_id,
            COUNT(remote_jobs.job_id) AS number_of_jobs
        FROM (
                SELECT job_id
                FROM job_postings_fact
                WHERE job_work_from_home = true
                    AND job_title LIKE '%Data%Analyst%'
            ) AS remote_jobs
            INNER JOIN skills_job_dim ON remote_jobs.job_id = skills_job_dim.job_id
        GROUP BY skills_job_dim.skill_id
    ) AS number_remote
    INNER JOIN skills_dim ON number_remote.skill_id = skills_dim.skill_id
ORDER BY number_of_jobs DESC
LIMIT 5;