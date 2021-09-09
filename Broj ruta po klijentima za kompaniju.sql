
WITH comp ( comp_id ) as (
   values (2)
   )

select client_id, count(*) number_of_routes 
from t_route r join t_working_order wo on wo.id = r.working_order_id,
comp
where wo.company_id = comp_id
group by client_id

