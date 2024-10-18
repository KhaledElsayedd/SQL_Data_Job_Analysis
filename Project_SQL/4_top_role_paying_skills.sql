/*
 Question: What are the top skills based on salary for my role?
 - Looking at the average salary for each skill for data analyst postions.
 - Focusing on roles with specified salary, regardless of location.
 - Why? This help identify the most financially rewarding skills to acquire and improve.
 */
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_pay
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short LIKE '%Data%Analyst%'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_pay DESC
LIMIT 25;
/*
 INSIGHTS FROM PAY-PER-SKILL ANALYSIS:
 
 1. SVN commands the highest average salary at $400,000, showing its importance in software version control.
 2. Virtualization skills like VMware have a high demand, with an average pay of $261,250.
 3. Web development and blockchain-related skills such as Yarn, FastAPI, and Solidity are highly valued, with average salaries ranging from $179,000 to $219,575.
 4. Machine learning frameworks (e.g., PyTorch, TensorFlow) and AI tools (e.g., Hugging Face) offer competitive average salaries, around $123,000 to $125,000.
 5. Overall, specialized technical skills in areas like version control, web frameworks, blockchain, virtualization, and machine learning are in high demand with significant pay scales.
 */