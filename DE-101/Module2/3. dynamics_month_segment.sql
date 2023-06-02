DROP VIEW IF exists dynamics_month_segment;
create view dynamics_month_segment as
with sales_months as (select
	segment,
	extract('year' from order_date) years,
	extract('month' from order_date) months,
	sum(sales) total_sales
from orders_prod op
group by 1,2,3)

select
	*,
	COALESCE(
		round(
			100 * total_sales/lag(total_sales) OVER(PARTITION BY segment ORDER BY years,months)
			, 2)
		, 0) growth_rate_percent
from sales_months