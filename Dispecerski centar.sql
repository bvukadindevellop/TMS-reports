
-- radni nalozi za dispecerski centar

select wo.number as wo_number, d.first_name, d.last_name, veh.registration_number, veh.vehicle_type, tr.registration_number as trailer_reg_number, lp.stanje_vozila, ro.loading_city, ro.unloading_city, ro.loading_date, ro.unloading_date, lp.grad as current_city
from t_working_order wo
join t_vehicle v on wo.vehicle_id = v.id
join last_position lp on lp.unit_id = v.unit_id
join (select max(id) id, working_order_id from t_route group by working_order_id)r on wo.id = r.working_order_id
join t_route ro on ro.id = r.id 
join t_driver d on d.id = wo.driver_id
join t_vehicle veh on veh.id = wo.vehicle_id 
join t_trailer tr on tr.id = wo.trailer_id



-- sva vozila cija je poslednja pozicija u datoj drzavi
WITH state ( state) as (
   values ('Crna Gora')
   )
select * from last_position , state
where drzava =state.state 
limit 100
