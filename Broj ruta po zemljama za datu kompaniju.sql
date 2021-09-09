

WITH cn ( comp_id ) as (
   values (2)
   ) 
select  unloading_country_id, c.description as Country, count(*) as number_of_routes
from t_route r join t_working_order wo on wo.id = r.working_order_id
join tr_country c on c.id = r.unloading_country_id
,cn
where wo.company_id = comp_id
group by unloading_country_id, c.description 

