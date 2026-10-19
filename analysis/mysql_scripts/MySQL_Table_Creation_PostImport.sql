create database if not exists ai_adoption_db;
use ai_adoption_db;

describe ai_usage_data;

-- creating a survey date column from string date column
set SQL_SAFE_UPDATES = 0;
alter table ai_usage_data add survey_date date after record_id;
update ai_usage_data set survey_date = str_to_date(date,'%d-%m-%Y');
select survey_data from ai_usage_data limit 1;
set SQL_SAFE_UPDATES = 1;

-- checking post updation
describe ai_usage_data;
show columns from ai_usage_data;
select record_id, survey_date from ai_usage_data limit 5;
