-- 1.	How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
FROM data_analyst_jobs;

--1793 

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT company
FROM data_analyst_jobs
LIMIT 10;

--ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN';
--21 Jobs in Tennessee

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';
--27 jobs in both Tennessee or Kentucky

-- 4.	How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating >4;

--3 postings are in TN with above a 4 star rating

-- 5.	How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT (*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 and 1000;

--151 postings exist with counts between 500 and 1000

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS average_rating
FROM data_analyst_jobs
GROUP BY state
ORDER BY average_rating DESC;

--Nebraska has the highest average rating

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;

--881 unique job titles are listed in the data

-- 8.	How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';

--230 unique titles are listed for companies in California

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, ROUND(AVG(review_count),2) AS rating,
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY company;

--There are 40 companies that have more than 5000 reviews across all locations

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, ROUND(AVG(review_count),2) AS review, AVG(star_rating) AS stars,
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY company, location
ORDER BY stars DESC;

--Unilever, General Motors, Nike, American Express, Microsoft, and Kaiser Permanente have the highest star rating with a 4.19 (rounded).

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT COUNT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--1669 total jobs

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

--There are 774 different job titles that contain "Analyst".

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%analyst%' AND title NOT ILIKE '%analytics%';

--4 job titles do not contain 'Analyst' or 'Analytics'. The most common word seems to be the word 'Tableau'

-- **BONUS:**
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
--  - Disregard any postings where the domain is NULL. 
--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
--   - What are the top 4 industries in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT COUNT(title) AS jobs, domain
FROM data_analyst_jobs
WHERE domain IS NOT NULL AND days_since_posting > 21 AND skill ILIKE '%SQL%'
GROUP BY domain
ORDER BY jobs DESC
LIMIT 4;

--Internet and Software had 62 jobs, Bank and Financial Services had 61, Consulting and Business Services had 57, and Health Care had 52
