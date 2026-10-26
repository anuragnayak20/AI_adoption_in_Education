create database if not exists ai_adoption_db;
use ai_adoption_db;

alter table ai_usage_data rename to ai_data;

show columns from ai_data;
select * from ai_data limit 1;
alter table ai_data rename column ï»¿record_id to record_id;
alter table ai_data modify column record_id int;
alter table ai_data modify column date date;
alter table ai_data rename column date to survey_date;
alter table ai_data add primary key (record_id);

-- seeing distribution of survey takers among students and teachers
select count(record_id) as "head count", role from ai_data group by role order by "head count" desc;
select count(record_id) as "head count", education_level, role from ai_data group by role,education_level  order by role asc, education_level asc,"head count" desc;

-- most frequent usecases (across all roles) is note organization > writing feedback > quiz practice > plagiarism screening
select ai_use_purpose, count(*), dense_rank() over (order by count(*) desc) as rn from ai_data group by ai_use_purpose limit 5;
-- most frequent usecases (top 3) among the 2 roles.
select role,ai_use_purpose, rn from (
select role, ai_use_purpose, count(ai_use_purpose), dense_rank() over (partition by role order by count(ai_use_purpose) desc) as rn from ai_data group by role, ai_use_purpose
) as ranking_sub_query where rn <= 3;
-- top 3 subject area where AI is used by students and teachers
select role, subject_area from (
select role, subject_area, count(subject_area), dense_rank() over (partition by role order by count(subject_area) desc) as rn from ai_data group by role, subject_area ) as ranking_subject_subquery
where rn <= 3;

-- which AI tool (top 3) used by students?
select role, ai_tool from (
select role, ai_tool, count(ai_tool), dense_rank() over (partition by role order by count(ai_tool) desc) as tool_rn from ai_data group by role, ai_tool )
as ai_tool_ranking
where tool_rn <= 3 and role = "student";

-- Step 0: sanity checks (2 minutes)
-- Which use purposes deliver results → core features
-- Which tool types work best → what to copy or avoid
-- Sentiment and emotion → experience design
-- Ethical concerns → trust and safety features
-- What drives adoption → what to prioritize
-- Engagement vs. outcomes → habit and retention features
-- In-app mechanics vs. improvement → specific feature design
-- Dropout profile → risk and retention features
-- Segment cut → one product or role-specific modes
-- Time trend