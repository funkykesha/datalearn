DROP VIEW IF exists orders_prod;
create view orders_prod as
select 
	o.*, 
	p.person, 
	case 
		when r.returned is null then 'No'
		when r.returned is not null then 'Yes'
	end returned
from orders o
left join people p on o.region = p.region 
left join "returns" r on o.order_id = r.order_id