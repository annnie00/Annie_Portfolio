use datascience

CREATE TABLE job_salaries (
  work_year INT,
  experience_level VARCHAR(2),
  employment_type VARCHAR(2),
  job_title VARCHAR(50),
  salary INT,
  salary_currency VARCHAR(3),
  salary_in_usd INT,
  employee_residence VARCHAR(2),
  remote_ratio INT,
  company_location VARCHAR(2),
  company_size VARCHAR(1)
);

select * from job_salaries
/*average salary of all jobs from dataset*/
SELECT job_title, AVG(salary_in_usd) AS avg_salary
FROM job_salaries
GROUP BY job_title

/*highest salary and corresponding role*/
SELECT job_title, MAX(salary_in_usd) AS highest_salary
FROM job_salaries
GROUP BY job_title
ORDER BY highest_salary DESC
LIMIT 1

/*average salary for data scientists in US*/
SELECT job_title, AVG(salary_in_usd) AS average_salary_US
FROM job_salaries
WHERE company_location = 'US' AND job_title = 'Data Scientist'

/*number of jobs available for each role*/
SELECT job_title, COUNT(job_title) AS job_title_count
FROM job_salaries
GROUP BY job_title

/*total salary paid for all data analysts in DE*/
SELECT job_title, SUM(salary_in_usd) as total_salary_data_analyst_DE
FROM job_salaries
WHERE job_title = 'Data Analyst' AND company_location = 'DE'
GROUP BY job_title

/*top 5 highest paying salaries and corresponding average salaries*/
SELECT job_title, salary_in_usd, AVG(salary_in_usd) OVER (PARTITION BY job_title) AS average_role_salary
FROM job_salaries
ORDER BY salary_in_usd DESC
LIMIT 5

/*number of jobs available in each location*/
SELECT company_location, COUNT(*) AS total_jobs_per_location
FROM job_salaries
GROUP BY company_location

/*top 3 job titles with most jobs available*/
SELECT job_title, COUNT(*) AS most_jobs_available
FROM job_salaries
GROUP BY job_title
ORDER BY most_jobs_available DESC
LIMIT 3

/*top 5 countries with highest salaries*/
SELECT company_location, AVG(salary_in_usd) AS average_salary
FROM job_salaries
GROUP BY company_location
ORDER BY average_salary DESC
LIMIT 5

/*the average salary for each job title and the total number of jobs available*/
SELECT job_title, AVG(salary_in_usd) AS average_salary, COUNT(job_title) AS jobs_available_per_role
FROM job_salaries
GROUP BY job_title

/*top 5 job titles with highest salaries and total number of jobs available per job*/
SELECT job_title, salary_in_usd, COUNT(job_title) AS jobs_available_per_role
FROM job_salaries
GROUP BY job_title
ORDER BY salary_in_usd DESC
LIMIT 5

/*top 5 locations with highest salaries and total num of jobs available per location*/
SELECT company_location, SUM(salary_in_usd) AS highest_salaries, COUNT(*) AS jobs_available
FROM job_salaries
GROUP BY company_location
ORDER BY highest_salaries DESC
LIMIT 5

/*the average salary for each job in each location and the total number of jobs available
for each job in each location*/
SELECT job_title, AVG(salary_in_usd) AS average_salary, company_location, COUNT(*) AS jobs_available
FROM job_salaries
GROUP BY job_title, company_location
ORDER BY job_title

/*the total number of jobs available for each year of experience and the average salary for each year of xp*/
SELECT experience_level, AVG(salary_in_usd) AS average_salary, COUNT(*) AS num_jobs_available
FROM job_salaries
GROUP BY experience_level

/*top 5 jobs with highest average salaries in each location*/
SELECT job_title, company_location, AVG(salary_in_usd) AS average_salary
FROM job_salaries
WHERE job_title IN (
					SELECT job_title
					FROM job_salaries
                    GROUP BY job_title
                    ORDER BY AVG(salary_in_usd) DESC)
GROUP BY job_title, company_location
ORDER BY company_location

/*What are the top 5 job titles with the highest salaries, and what is the name of the company that offers the
highest job salary for each job title*/
SELECT job_title, salary
FROM job_salaries
GROUP BY job_title, salary
ORDER BY salary DESC
LIMIT 5 

        








