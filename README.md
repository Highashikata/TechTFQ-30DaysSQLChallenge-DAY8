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

```

