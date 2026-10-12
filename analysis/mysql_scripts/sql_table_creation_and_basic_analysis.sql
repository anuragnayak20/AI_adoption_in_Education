create database if not exists ai_adoption_db;
use ai_adoption_db;

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