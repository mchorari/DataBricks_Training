create materialized view mohit_gold.customer_active as 
select * from mohit_silver.customers_cleaned where `__END_AT` is NULL;


create materialized view mohit_gold.top_customers as
select
  s.customer_id,
  c.customer_name,
  c.customer_email,
  c.customer_city,
  sum(s.total_amount) as total_sales
from mohit_silver.sales_clean s
join mohit_gold.customer_active c
  on s.customer_id = c.customer_id
group by all
order by total_sales desc
limit 3;