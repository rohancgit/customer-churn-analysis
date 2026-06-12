use churndb;
select * from churn ;

alter table churn
rename column ï»¿CustomerID to customer_id,
RENAME COLUMN `Zip Code` TO zip_code,
rename column `Churn Label` to churn_label,
rename column `Churn Value` to churn_value,
rename column `Churn Score` to churn_score;

-- count and null/blank check 
select count(*) from churn;
select count(customer_id) from churn where customer_id is null;
select count(customer_id) from churn where customer_id = '';
select count(distinct(customer_id)) from churn;

select  
sum(case when count is null or count = '' then 1 else 0 end) as count_missing,
sum(case when Country is null or Country = '' then 1 else 0 end) as Country_missing,
sum(case when State is null or State = '' then 1 else 0 end) as State_missing,
sum(case when City is null or City = '' then 1 else 0 end) as City_missing,
sum(case when zip_code is null or zip_code = '' then 1 else 0 end) as zip_code_missing,
sum(case when Latitude is null or Latitude = '' then 1 else 0 end) as Latitude_missing,
sum(case when Longitude is null or Longitude = '' then 1 else 0 end) as Longitude_missing ,
SUM(CASE WHEN Gender IS NULL OR Gender = '' THEN 1 ELSE 0 END) AS gender_missing,
SUM(CASE WHEN senior_citizen IS NULL OR senior_citizen = '' THEN 1 ELSE 0 END) AS senior_citizen_missing,
SUM(CASE WHEN Partner IS NULL OR Partner = '' THEN 1 ELSE 0 END) AS partner_missing,
SUM(CASE WHEN Dependents IS NULL OR Dependents = '' THEN 1 ELSE 0 END) AS dependents_missing,
SUM(CASE WHEN tenure_months IS NULL THEN 1 ELSE 0 END) AS tenure_months_missing,
SUM(CASE WHEN phone_service IS NULL OR phone_service = '' THEN 1 ELSE 0 END) AS phone_service_missing,
SUM(CASE WHEN multiple_lines IS NULL OR multiple_lines = '' THEN 1 ELSE 0 END) AS multiple_lines_missing,
SUM(CASE WHEN internet_service IS NULL OR internet_service = '' THEN 1 ELSE 0 END) AS internet_service_missing,
SUM(CASE WHEN online_security IS NULL OR online_security = '' THEN 1 ELSE 0 END) AS online_security_missing,
SUM(CASE WHEN online_backup IS NULL OR online_backup = '' THEN 1 ELSE 0 END) AS online_backup_missing,
SUM(CASE WHEN device_protection IS NULL OR device_protection = '' THEN 1 ELSE 0 END) AS device_protection_missing,
SUM(CASE WHEN tech_support IS NULL OR tech_support = '' THEN 1 ELSE 0 END) AS tech_support_missing,
SUM(CASE WHEN streaming_TV IS NULL OR streaming_TV = '' THEN 1 ELSE 0 END) AS streaming_tv_missing,
SUM(CASE WHEN streaming_movies IS NULL OR streaming_movies = '' THEN 1 ELSE 0 END) AS streaming_movies_missing,
SUM(CASE WHEN Contract IS NULL OR Contract = '' THEN 1 ELSE 0 END) AS contract_missing,
SUM(CASE WHEN paperless_billing IS NULL OR paperless_billing = '' THEN 1 ELSE 0 END) AS paperless_billing_missing,
SUM(CASE WHEN payment_method IS NULL OR payment_method = '' THEN 1 ELSE 0 END) AS payment_method_missing,
SUM(CASE WHEN monthly_charges IS NULL THEN 1 ELSE 0 END) AS monthly_charges_missing,
SUM(CASE WHEN total_charges IS NULL THEN 1 ELSE 0 END) AS total_charges_missing,
SUM(CASE WHEN churn_label IS NULL OR churn_label = '' THEN 1 ELSE 0 END) AS churn_label_missing,
SUM(CASE WHEN churn_value IS NULL THEN 1 ELSE 0 END) AS churn_value_missing,
SUM(CASE WHEN churn_score IS NULL THEN 1 ELSE 0 END) AS churn_score_missing,
SUM(CASE WHEN CLTV IS NULL THEN 1 ELSE 0 END) AS cltv_missing,
SUM(CASE WHEN churn_reason IS NULL OR churn_reason = '' THEN 1 ELSE 0 END) AS churn_reason_missing
FROM churn;

Update churn set churn_reason = 'No Churn' where churn_reason = '';
SELECT COUNT(*) FROM churn;              -- total rows
SELECT COUNT(DISTINCT customer_id) FROM churn;  -- unique IDs

CREATE TABLE churn_clean AS
SELECT * FROM churn;

-- KPI 
-- 1)Overall Churn Rate
select 
round((sum(case when churn_label = 'yes' then 1 else 0 end)*100) / count(*),2) as Churn_rate_pct
 from churn_clean;
 
 -- 2)Churn by contract type
select 
Contract,
count(*) as total_customer ,
sum(churn_value) as total_churn ,
round((sum(churn_value)*100) / count(*),2) as Churn_rate_pct,
round(avg(monthly_charges),2) as monthly_charges
from churn_clean
group by Contract
order by Churn_rate_pct desc;

-- 3. Churn by tenure bucket
select
case 
     when tenure_months between 1 and 12 then "0-12 months"
	 when tenure_months between 13 and 24 then "13-24 months" 
     when tenure_months between 25 and 36 then "25-48 months"
     when tenure_months between 37 and 48 then "49-72 months"
     else "72+ months"
     end as tenure_bracket,
count(*) as total_customer ,
sum(churn_value) as total_churn ,
round((sum(churn_value)*100) / count(*),2) as Churn_rate_pct
from churn_clean
group by tenure_bracket
order by tenure_bracket;

-- 4. Revenue at risk by contract type
select 
contract,
round(sum(case when churn_label = 'yes' then monthly_charges else 0 end),2) as monthly_revunue_loss,
round(sum(case when churn_label = 'yes' then monthly_charges else 0 end) * 12 ,2) as yearly_revenue_loss
from churn_clean
group by contract
order by monthly_revunue_loss desc ;

-- 5. Churn by payment method
select
payment_method,
count(*) as total_customer ,
sum(churn_value) as total_churn ,
round((sum(churn_value)*100) / count(*),2) as Churn_rate_pct
from churn_clean
group by payment_method
order by Churn_rate_pct desc;

-- 6. Senior citizen churn — your unique angle
select
senior_citizen,
Contract,
count(*) as total_customer ,
sum(churn_value) as total_churn ,
round((sum(churn_value)*100) / count(*),2) as Churn_rate_pct
from churn_clean
group by senior_citizen,Contract
order by Churn_rate_pct desc;

-- Churn reason breakdown
select
churn_reason,
count(*) as total_customer ,
round((count(*) * 100) / sum(count(*)) over(),2) as Churn_rate_pct
from churn_clean
where churn_label = 'yes'
group by churn_reason
order by Churn_rate_pct desc;

-- CLTV vs churn — are high-value customers churning?
select 
case
    when CLTV < 2000 then 'Low (<2000)'
    when CLTV between 2000 and 4000 then 'Mid (<4000)'
	when CLTV between 4001 and 6000 then 'High (<6000)'
    else 'High 6000+'
    end as CLTV_Bracket,
count(*) as total_customer,
sum(churn_value) as total_churn ,
round((sum(churn_value)*100) / count(*),2) as Churn_rate_pct
from churn_clean
group by CLTV_Bracket
order by Churn_rate_pct desc;




