DROP VIEW IF exists dynamics_overview;
create view dynamics_overview as
select 
	extract('year' from order_date) years,
	extract('quarter' from order_date) quarters,
	round(sum(sales), 2) total_sales,
	round(sum(profit), 2) total_profit,
	round(sum(profit) / sum(sales) * 100, 2) ROI,
	round(sum(profit) / count(distinct order_id), 2) profit_per_order,
	round(sum(sales) / count(distinct customer_id), 2) sales_per_customer,
	round(avg(sales * nullif(discount / (1 - discount), 0)), 2) avg_amount_discount
from orders_prod op
group by 1,2
order by 1,2