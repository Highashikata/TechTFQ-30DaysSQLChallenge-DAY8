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
*/ ------ Solution 1

SELECT row_id,
       COALESCE(job_role,
                  (SELECT job_role
                   FROM job_skills
                   WHERE row_id < js.row_id
                     AND job_role IS NOT NULL
                   ORDER BY row_id DESC
                   LIMIT 1)) AS job_role,
       skills
FROM job_skills js;

------ Solution 2: using a FLAG on each row
 -- Step 1 : Flag Constrution

SELECT *,
       CASE
           WHEN job_role IS NULL THEN 0
           ELSE 1
       END AS flag
FROM job_skills -- Step 2 : Summing over the Flag

SELECT *,
       sum(CASE
               WHEN job_role IS NULL THEN 0
               ELSE 1
           END) over(
                     ORDER BY row_id) AS flag
FROM job_skills;

-- Final query

SELECT row_id ,
       CASE
           WHEN flag = 1 THEN 'Data Engineer'
           WHEN flag = 2 THEN 'Web Developer'
           WHEN flag = 3 THEN 'Data Scientist'
       END AS job_role ,
       skills
FROM
  (SELECT *,
          Sum(CASE
                  WHEN job_role IS NULL THEN 0
                  ELSE 1
              END) OVER(
                        ORDER BY row_id) AS flag
   FROM job_skills) x;

------ Solution 3: using the same logic
 WITH cte_skills AS
  (SELECT *,
          Sum(CASE
                  WHEN job_role IS NULL THEN 0
                  ELSE 1
              END) OVER(
                        ORDER BY row_id) AS flag
   FROM job_skills)
SELECT row_id ,
       first_value(job_role) over(PARTITION BY flag
                                  ORDER BY row_id) AS job_role ,
       skills
FROM cte_skills;

------ Solution 4: More tricky Solution, using recursive queyr
 WITH RECURSIVE CTE_Recu AS
  (SELECT row_id,
          job_role,
          skills
   FROM job_skills
   WHERE row_id = 1
   UNION SELECT js.row_id,
                coalesce(js.job_role, CTE_Recu.job_role) AS job_role,
                js.skills
   FROM CTE_Recu
   JOIN job_skills js ON js.row_id = CTE_Recu.row_id+1)
SELECT *
FROM CTE_Recu;

-- Using Subquery

SELECT row_id,
       first_value(job_role) over(PARTITION BY flag
                                  ORDER BY row_id) AS jb_role,
       skills
FROM
  (SELECT *,
          SUM(CASE
                  WHEN job_role IS NOT NULL THEN 1
                  ELSE 0
              END) over(
                        ORDER BY row_id) AS flag
   FROM job_skills);