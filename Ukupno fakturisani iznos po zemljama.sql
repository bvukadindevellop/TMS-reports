

WITH cn ( comp_id ) as (
   values (2)
   ) 
select  r.unloading_country_id, c.description as Country, sum(i.amount_in_eur) as amount_in_eur
from t_route r 
join t_working_order wo on wo.id = r.working_order_id
join t_invoice i on i.working_order_id = wo.id
join tr_country c on c.id = r.unloading_country_id
,cn
where wo.company_id = comp_id
and r.has_invoice = 't'
group by r.unloading_country_id, c.description 
