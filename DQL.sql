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
	select row_id, jobrole, skills from job_skills where row_id = 1
	UNION
	
)






