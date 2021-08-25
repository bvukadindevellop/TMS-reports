
-- Slobodna vozila u datoj zemlji
with cont(country_id) as
(
values (3)
)
select wo.vehicle_id, r.loading_city, r.unloading_city, r.loading_country_id, r.unloading_country_id
from t_route r
join t_working_order wo on wo.id = r.working_order_id,
cont
where unloading_date < current_date
and not exists (select * from t_route ro 
join t_working_order wor on wor.id = ro.working_order_id
where ro.loading_date >= current_date 
and wo.driver_id = wor.driver_id)
and r.unloading_country_id = cont.country_id

-- slobodni vozaci u datoj zemlji
with cont(country_id) as
(
values (3)
)
select wo.vehicle_id, r.loading_city, r.unloading_city, r.loading_country_id, r.unloading_country_id
from t_route r
join t_working_order wo on wo.id = r.working_order_id,
cont
where unloading_date < current_date
and not exists (select * from t_route ro 
join t_working_order wor on wor.id = ro.working_order_id
where ro.loading_date >= current_date 
and wo.vehicle_id = wor.vehicle_id)
and r.unloading_country_id = cont.country_id

