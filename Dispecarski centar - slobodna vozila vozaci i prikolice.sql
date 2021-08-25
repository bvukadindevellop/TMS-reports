-- free vehicles
select a.id, a.registration_number, ro.unloading_date, current_date - ro.loading_date,* from t_vehicle a
left join (select max(id) id, vehicle_id from t_working_order group by vehicle_id) b on a.id = b.vehicle_id
left join (select max(id) id, working_order_id from t_route group by working_order_id) r on r.working_order_id = b.id
left join t_route ro on ro.id = r.id
where free = 'T'
order by current_date - ro.loading_date desc

-- fre drivers
select a.id, a.first_name, a.last_name, ro.unloading_date, current_date - ro.loading_date,* from t_driver a
left join (select max(id) id, driver_id from t_working_order group by driver_id) b on a.id = b.driver_id
left join (select max(id) id, working_order_id from t_route group by working_order_id) r on r.working_order_id = b.id
left join t_route ro on ro.id = r.id
where free = 'T'
order by current_date - ro.loading_date desc

--free trailers 
select a.id, a.make, a.model, ro.unloading_date, current_date - ro.loading_date,* from t_trailer a
left join (select max(id) id, trailer_id from t_working_order group by trailer_id) b on a.id = b.trailer_id
left join (select max(id) id, working_order_id from t_route group by working_order_id) r on r.working_order_id = b.id
left join t_route ro on ro.id = r.id
where free = 'T'
order by current_date - ro.loading_date desc

