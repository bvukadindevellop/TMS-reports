
WITH comp (comp_id) as (
   values (2)
   )
select v.registration_number
,count (*) from t_vehicle v
join t_service s on v.id = s.vehicle_id,
comp
where v.company_id = comp.comp_id
group by v.registration_number 
order by count (*) desc limit 10 
