-- Kilometraza po vozilu:

WITH veh (vehicle_id) as (
   values (101412)
   )

   select  a.radno_vreme, a.ukupno_km, b.ukupno_km as ukupno_km_pre_god_dana, a.efektivna_voznja, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select  radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from t_vehicle join veh on t_vehicle.id = veh.vehicle_id
join analiza_mdi on analiza_mdi.unit_id = t_vehicle.unit_id 
where analiza_mdi.dan >(extract (year from current_date)::varchar || '-01-01')::date and analiza_mdi.dan <=current_date
group by  radno_vreme
)a 
left join 
(
select  radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from t_vehicle join veh on t_vehicle.id = veh.vehicle_id
join analiza_mdi on analiza_mdi.unit_id = t_vehicle.unit_id 
where analiza_mdi.dan > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and analiza_mdi.dan < (extract (year from current_date)::varchar || '-01-01')::date
group by  radno_vreme
)b on  a.radno_vreme = b.radno_vreme  


-- Broj servisa po vozilu
WITH veh (vehicle_id) as (
   values (101412)
   )
select count (*), t_service.vehicle_id, sum(coalesce(amount, 0)) as amount, sum (coalesce (amount_in_eur, 0)) as amount_in_eur 
from 
t_service join 
veh on t_service.vehicle_id = veh.vehicle_id 
group by t_service.vehicle_id


-- Broj steta po vozilu
WITH veh (vehicle_id) as (
   values (101412)
   )
select count (*), t_damage.vehicle_id, sum(coalesce(amount, 0)) as amount, sum (coalesce (amount_in_eur, 0)) as amount_in_eur 
from 
t_damage join 
veh on t_damage.vehicle_id = veh.vehicle_id 
group by t_damage.vehicle_id