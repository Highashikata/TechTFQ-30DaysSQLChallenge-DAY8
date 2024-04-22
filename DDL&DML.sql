DROP TABLE IF EXISTS job_skills;


CREATE TABLE job_skills (
	row_id int
	, job_role varchar(20)
	, skills varchar(20));


INSERT INTO job_skills
VALUES (1, 'Data Engineer', 'SQL');


INSERT INTO job_skills
VALUES (2, NULL, 'Python');


INSERT INTO job_skills
VALUES (3, NULL, 'AWS');


INSERT INTO job_skills
VALUES (4, NULL, 'Snowflake');


INSERT INTO job_skills
VALUES (5, NULL, 'Apache Spark');


INSERT INTO job_skills
VALUES (6, 'Web Developer', 'Java');


INSERT INTO job_skills
VALUES (7, NULL, 'HTML');


INSERT INTO job_skills
VALUES (8, NULL, 'CSS');


INSERT INTO job_skills
VALUES (9, 'Data Scientist', 'Python');


INSERT INTO job_skills
VALUES (10, NULL, 'Machine Learning');


INSERT INTO job_skills
VALUES (11, NULL, 'Deep Learning');


INSERT INTO job_skills
VALUES (12, NULL, 'Tableau');


SELECT *
FROM job_skills;