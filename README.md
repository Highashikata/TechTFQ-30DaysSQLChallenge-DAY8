# TechTFQ-30DaysSQLChallenge-DAY8


Add Missing values SQL challenge

going through the challenge of SQL interview questions featured in the TechTFQ channel



In this repository we will be going through the SQL interview questions featured in the following YouTube video [SQL Interview Questions](https://www.youtube.com/watch?v=Xx09nRpwEtU&list=PLavw5C92dz9Hxz0YhttDniNgKejQlPoAn&index=8).

# **Day 8: The problem statement: Add Missing values SQL**


PROBLEM STATEMENT:
In the given input table, there are rows with missing JOB_ROLE values. Write a query to fill in those blank fields with appropriate values.
Assume row_id is always in sequence and job_role field is populated only for the first skill.
Provide two different solutions to the problem.

![image](https://github.com/Highashikata/TechTFQ-30DaysSQLChallenge-DAY8/assets/96960411/fd8eae50-b8af-4cdb-a5b1-e4c5d2971b89)

**DDL & DML**
```
drop table if exists job_skills;
create table job_skills
(
	row_id		int,
	job_role	varchar(20),
	skills		varchar(20)
);
insert into job_skills values (1, 'Data Engineer', 'SQL');
insert into job_skills values (2, null, 'Python');
insert into job_skills values (3, null, 'AWS');
insert into job_skills values (4, null, 'Snowflake');
insert into job_skills values (5, null, 'Apache Spark');
insert into job_skills values (6, 'Web Developer', 'Java');
insert into job_skills values (7, null, 'HTML');
insert into job_skills values (8, null, 'CSS');
insert into job_skills values (9, 'Data Scientist', 'Python');
insert into job_skills values (10, null, 'Machine Learning');
insert into job_skills values (11, null, 'Deep Learning');
insert into job_skills values (12, null, 'Tableau');

select * from job_skills;

```


**DQL**
```
SELECT *
FROM JOB_SKILLS;

/* Draft testing some queries

SELECT X.*,
	CASE
		WHEN JOB_ROLE IS NULL THEN X.PREVIOUS_JOB_ROLE
	END
FROM
	(SELECT *,
			LAG(JOB_ROLE,1) OVER(ORDER BY ROW_ID) AS PREVIOUS_JOB_ROLE
		FROM JOB_SKILLS) X;
*/

------ Solution 1
SELECT 
    row_id,
    COALESCE(job_role, (
        SELECT job_role 
        FROM job_skills 
        WHERE row_id < js.row_id AND job_role IS NOT NULL 
        ORDER BY row_id DESC 
        LIMIT 1
    )) AS job_role,
    skills
FROM 
    job_skills js;


------ Solution 2: using a FLAG or each row

-- Step 1 : Flag Constrution
SELECT *,
		CASE
             WHEN job_role IS NULL THEN 0
             ELSE 1
           END AS flag
FROM   job_skills


-- Step 2 : Suming over the Flag 
SELECT *,
		sum(CASE
             WHEN job_role IS NULL THEN 0
             ELSE 1
           END) over(order by row_id) AS flag
FROM   job_skills;



-- Final query
SELECT 
		row_id
	    ,case 
			when flag = 1 then 'Data Engineer'
			when flag = 2 then 'Web Developer'
			when flag = 3 then 'Data Scientist'
		END as job_role
		, skills
from (SELECT *,
       Sum(CASE
             WHEN job_role IS NULL THEN 0
             ELSE 1
           END)
         OVER(
           ORDER BY row_id) AS flag
FROM   job_skills ) x;


------ Solution 3: using the same logic 

with cte_skills as(
	SELECT *,
       Sum(CASE
             WHEN job_role IS NULL THEN 0
             ELSE 1
           END)
         OVER(
           ORDER BY row_id) AS flag
	FROM   job_skills 
)

select row_id
		, first_value(job_role) over(partition by flag order by row_id) as job_role
		, skills
from cte_skills;



------ Solution 4: More tricky Solution, using recursive queyr

with recursive CTE_Recu as
(
	
)







```

