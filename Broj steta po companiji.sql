
WITH comp (comp_id) as (
   values (2)
   )

   select sum (cnt) from (
select count (*)cnt from t_vehicle v
join t_damage s on v.id = s.vehicle_id,
comp
where v.company_id = comp.comp_id

union all 

select count (*)cnt from t_trailer v
join t_damage s on v.id = s.trailer_id,
comp
where v.company_id = comp.comp_id
)a