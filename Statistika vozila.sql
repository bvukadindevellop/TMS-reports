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


-- Ukupan broj servisa po vozilu i broj redovnih servisa po vozilu
WITH veh (vehicle_id) as (
   values (101626)
   )
select t_service.vehicle_id, count (*) as total_number_of_services, count(case when service_type in (0,1,2) then 1 end) as number_of_regular_services, sum(coalesce(amount, 0)) as amount, sum (coalesce (amount_in_eur, 0)) as amount_in_eur 
from 
t_service join 
veh on t_service.vehicle_id = veh.vehicle_id 
group by t_service.vehicle_id

-- Broj steta po vozilu
WITH veh (vehicle_id) as (
   values (101626)
   )
select t_damage.vehicle_id, count (*) as number_of_damages, sum(coalesce(amount, 0)) as amount, sum (coalesce (amount_in_eur, 0)) as amount_in_eur 
from 
t_damage join 
veh on t_damage.vehicle_id = veh.vehicle_id 
group by t_damage.vehicle_id;

-- Broj kilometara za vozilo po mesecima

drop table tmp3;
CREATE TEMPORARY TABLE tmp3(
   id integer,
   mesec varchar (15),
   ukupno_km decimal (19,2),
   ukupno_km_pre_god_dana decimal (19,2),
    efektivna_voznja decimal (19,2),
   efektivna_voznja_pre_god_dana decimal (19,2)
);
drop table tmp4;
CREATE TEMPORARY TABLE tmp4(
   id integer,
   mesec varchar (15),
   ukupno_km decimal (19,2),
   ukupno_km_pre_god_dana decimal (19,2),
   efektivna_voznja decimal (19,2),
   efektivna_voznja_pre_god_dana decimal (19,2)
);
insert into tmp4
values (1, 'Januar', 0, 0, 0, 0),
       (2, 'Februar', 0, 0, 0,0),
       (3, 'Mart', 0, 0, 0,0),
       (4, 'April', 0, 0, 0,0),
       (5, 'Maj', 0, 0, 0,0),
       (6, 'Jun', 0, 0, 0,0),
       (7, 'Jul', 0, 0, 0,0),
       (8, 'Avgust', 0, 0, 0,0),
       (9, 'Septembar', 0, 0, 0,0),
       (10, 'Oktobar', 0, 0, 0,0),
       (11, 'Novembar', 0, 0, 0,0),
       (12, 'Decembar', 0, 0, 0,0);

insert into tmp3
WITH veh (vehicle_id) as (
   values (101412)
   )
   select row_number() over (order by a.mesec_id) as id, a.mesec, coalesce(a.ukupno_km,0) as ukupno_km, coalesce(b.ukupno_km, 0) as ukupno_km_pre_god_dana, coalesce(a.efektivna_voznja, 0) as efektivna_voznja, coalesce(b.efektivna_voznja, 0) as efektivna_voznja_pre_god_dana
   from (
select extract( month from analiza_mdi.dan) as mesec_id, case when extract( month from analiza_mdi.dan) = 1 then 'Januar'
			  when extract( month from analiza_mdi.dan) = 2 then 'Februar'
			  when extract( month from analiza_mdi.dan) = 3 then 'Mart'
			  when extract( month from analiza_mdi.dan) = 4 then 'April'
			  when extract( month from analiza_mdi.dan) = 5 then 'Maj'
			  when extract( month from analiza_mdi.dan) = 6 then 'Jun'
			  when extract( month from analiza_mdi.dan) = 7 then 'Jul'
			  when extract( month from analiza_mdi.dan) = 8 then 'Avgust'
			  when extract( month from analiza_mdi.dan) = 9 then 'Septembar'
			  when extract( month from analiza_mdi.dan) = 10 then 'Oktobar'
			  when extract( month from analiza_mdi.dan) = 11 then 'Novembar'
			  when extract( month from analiza_mdi.dan) = 12 then 'Decembar' end as mesec,			  

  sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from t_vehicle join veh on t_vehicle.id = veh.vehicle_id
join analiza_mdi on analiza_mdi.unit_id = t_vehicle.unit_id 
where analiza_mdi.dan >(extract (year from current_date)::varchar || '-01-01')::date and analiza_mdi.dan <=current_date
group by  case when extract( month from analiza_mdi.dan) = 1 then 'Januar'
			  when extract( month from analiza_mdi.dan) = 2 then 'Februar'
			  when extract( month from analiza_mdi.dan) = 3 then 'Mart'
			  when extract( month from analiza_mdi.dan) = 4 then 'April'
			  when extract( month from analiza_mdi.dan) = 5 then 'Maj'
			  when extract( month from analiza_mdi.dan) = 6 then 'Jun'
			  when extract( month from analiza_mdi.dan) = 7 then 'Jul'
			  when extract( month from analiza_mdi.dan) = 8 then 'Avgust'
			  when extract( month from analiza_mdi.dan) = 9 then 'Septembar'
			  when extract( month from analiza_mdi.dan) = 10 then 'Oktobar'
			  when extract( month from analiza_mdi.dan) = 11 then 'Novembar'
			  when extract( month from analiza_mdi.dan) = 12 then 'Decembar' end,
			  extract( month from analiza_mdi.dan)
)a 
full outer join 
(
select extract( month from analiza_mdi.dan) as mesec_id,case when extract( month from analiza_mdi.dan) = 1 then 'Januar'
			  when extract( month from analiza_mdi.dan) = 2 then 'Februar'
			  when extract( month from analiza_mdi.dan) = 3 then 'Mart'
			  when extract( month from analiza_mdi.dan) = 4 then 'April'
			  when extract( month from analiza_mdi.dan) = 5 then 'Maj'
			  when extract( month from analiza_mdi.dan) = 6 then 'Jun'
			  when extract( month from analiza_mdi.dan) = 7 then 'Jul'
			  when extract( month from analiza_mdi.dan) = 8 then 'Avgust'
			  when extract( month from analiza_mdi.dan) = 9 then 'Septembar'
			  when extract( month from analiza_mdi.dan) = 10 then 'Oktobar'
			  when extract( month from analiza_mdi.dan) = 11 then 'Novembar'
			  when extract( month from analiza_mdi.dan) = 12 then 'Decembar' end as mesec,	
sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from t_vehicle join veh on t_vehicle.id = veh.vehicle_id
join analiza_mdi on analiza_mdi.unit_id = t_vehicle.unit_id 
where analiza_mdi.dan > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and analiza_mdi.dan < (extract (year from current_date)::varchar || '-01-01')::date
group by  case when extract( month from analiza_mdi.dan) = 1 then 'Januar'
			  when extract( month from analiza_mdi.dan) = 2 then 'Februar'
			  when extract( month from analiza_mdi.dan) = 3 then 'Mart'
			  when extract( month from analiza_mdi.dan) = 4 then 'April'
			  when extract( month from analiza_mdi.dan) = 5 then 'Maj'
			  when extract( month from analiza_mdi.dan) = 6 then 'Jun'
			  when extract( month from analiza_mdi.dan) = 7 then 'Jul'
			  when extract( month from analiza_mdi.dan) = 8 then 'Avgust'
			  when extract( month from analiza_mdi.dan) = 9 then 'Septembar'
			  when extract( month from analiza_mdi.dan) = 10 then 'Oktobar'
			  when extract( month from analiza_mdi.dan) = 11 then 'Novembar'
			  when extract( month from analiza_mdi.dan) = 12 then 'Decembar' end,
			  extract( month from analiza_mdi.dan) 
)b on  a.mesec = b.mesec  
order by a.mesec_id;

select tmp4.mesec, coalesce (tmp3.ukupno_km, 0) ukupno_km, coalesce (tmp3.ukupno_km_pre_god_dana,0) ukupno_km_pre_god_dana, coalesce (tmp3.efektivna_voznja,0) as efektivna_voznja, coalesce (tmp3.efektivna_voznja_pre_god_dana, 0) efektivna_voznja_pre_god_dana
from tmp4 full join tmp3 on tmp4.id = tmp3.id;


-- Broj kilometara i ruta po mesecima 

drop table tmp2;
CREATE TEMPORARY TABLE tmp2(
   id integer,
   mesec varchar (15),
   ukupno_km decimal (19,2),
   ukupno_km_pre_god_dana decimal (19,2),
   broj_tura integer,
   broj_tura_pre_god_dana integer
);
drop table tmp1;
CREATE TEMPORARY TABLE tmp1(
   id integer,
   mesec varchar (15),
   ukupno_km decimal (19,2),
   ukupno_km_pre_god_dana decimal (19,2),
   broj_tura integer,
   broj_tura_pre_god_dana integer
);
insert into tmp1
values (1, 'Januar', 0, 0),
       (2, 'Februar', 0, 0),
       (3, 'Mart', 0, 0),
       (4, 'April', 0, 0),
       (5, 'Maj', 0, 0),
       (6, 'Jun', 0, 0),
       (7, 'Jul', 0, 0),
       (8, 'Avgust', 0, 0),
       (9, 'Septembar', 0, 0),
       (10, 'Oktobar', 0, 0),
       (11, 'Novembar', 0, 0),
       (12, 'Decembar', 0, 0);

insert into tmp2 
WITH veh (vehicle_id) as (
   values (101626)
   )
   
   select row_number() over (order by a.mesec_id) as id, a.mesec, coalesce(a.ukupno_km, 0)ukupno_km, coalesce(b.ukupno_km, 0) as ukupno_km_pre_god_dana, coalesce (a.broj_tura, 0) as broj_tura, coalesce (b.broj_tura,0) as broj_tura_pre_god_dana
   from (
select extract( month from t_route.loading_date) as mesec_id, case when extract( month from t_route.loading_date) = 1 then 'Januar'
			  when extract( month from t_route.loading_date) = 2 then 'Februar'
			  when extract( month from t_route.loading_date) = 3 then 'Mart'
			  when extract( month from t_route.loading_date) = 4 then 'April'
			  when extract( month from t_route.loading_date) = 5 then 'Maj'
			  when extract( month from t_route.loading_date) = 6 then 'Jun'
			  when extract( month from t_route.loading_date) = 7 then 'Jul'
			  when extract( month from t_route.loading_date) = 8 then 'Avgust'
			  when extract( month from t_route.loading_date) = 9 then 'Septembar'
			  when extract( month from t_route.loading_date) = 10 then 'Oktobar'
			  when extract( month from t_route.loading_date) = 11 then 'Novembar'
			  when extract( month from t_route.loading_date) = 12 then 'Decembar' end as mesec,			  

  sum(coalesce(mileage, 0)) as ukupno_km, count (*) as broj_tura
from t_route join t_working_order on t_route.working_order_id = t_working_order.id  
join veh on t_working_order.vehicle_id = veh.vehicle_id
where t_route.loading_date >(extract (year from current_date)::varchar || '-01-01')::date and t_route.loading_date < (extract (year from current_date)::varchar || '-12-31')::date
group by  case when extract( month from t_route.loading_date) = 1 then 'Januar'
			  when extract( month from t_route.loading_date) = 2 then 'Februar'
			  when extract( month from t_route.loading_date) = 3 then 'Mart'
			  when extract( month from t_route.loading_date) = 4 then 'April'
			  when extract( month from t_route.loading_date) = 5 then 'Maj'
			  when extract( month from t_route.loading_date) = 6 then 'Jun'
			  when extract( month from t_route.loading_date) = 7 then 'Jul'
			  when extract( month from t_route.loading_date) = 8 then 'Avgust'
			  when extract( month from t_route.loading_date) = 9 then 'Septembar'
			  when extract( month from t_route.loading_date) = 10 then 'Oktobar'
			  when extract( month from t_route.loading_date) = 11 then 'Novembar'
			  when extract( month from t_route.loading_date) = 12 then 'Decembar' end,
			  extract( month from t_route.loading_date)
)a 
full outer join 
(
select extract( month from t_route.loading_date) as mesec_id,case when extract( month from t_route.loading_date) = 1 then 'Januar'
			  when extract( month from t_route.loading_date) = 2 then 'Februar'
			  when extract( month from t_route.loading_date) = 3 then 'Mart'
			  when extract( month from t_route.loading_date) = 4 then 'April'
			  when extract( month from t_route.loading_date) = 5 then 'Maj'
			  when extract( month from t_route.loading_date) = 6 then 'Jun'
			  when extract( month from t_route.loading_date) = 7 then 'Jul'
			  when extract( month from t_route.loading_date) = 8 then 'Avgust'
			  when extract( month from t_route.loading_date) = 9 then 'Septembar'
			  when extract( month from t_route.loading_date) = 10 then 'Oktobar'
			  when extract( month from t_route.loading_date) = 11 then 'Novembar'
			  when extract( month from t_route.loading_date) = 12 then 'Decembar' end as mesec,	
sum(coalesce(mileage, 0)) as ukupno_km, count(*) as broj_tura
from t_route join t_working_order on t_route.working_order_id = t_working_order.id  
join veh on t_working_order.vehicle_id = veh.vehicle_id
where t_route.loading_date > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_route.loading_date < (extract (year from current_date)::varchar || '-01-01')::date
group by  case when extract( month from t_route.loading_date) = 1 then 'Januar'
			  when extract( month from t_route.loading_date) = 2 then 'Februar'
			  when extract( month from t_route.loading_date) = 3 then 'Mart'
			  when extract( month from t_route.loading_date) = 4 then 'April'
			  when extract( month from t_route.loading_date) = 5 then 'Maj'
			  when extract( month from t_route.loading_date) = 6 then 'Jun'
			  when extract( month from t_route.loading_date) = 7 then 'Jul'
			  when extract( month from t_route.loading_date) = 8 then 'Avgust'
			  when extract( month from t_route.loading_date) = 9 then 'Septembar'
			  when extract( month from t_route.loading_date) = 10 then 'Oktobar'
			  when extract( month from t_route.loading_date) = 11 then 'Novembar'
			  when extract( month from t_route.loading_date) = 12 then 'Decembar' end,
			  extract( month from t_route.loading_date) 
)b on  a.mesec = b.mesec  
order by a.mesec_id;

select tmp1.mesec, coalesce (tmp2.ukupno_km, 0) ukupno_km, coalesce (tmp2.ukupno_km_pre_god_dana,0) ukupno_km_pre_god_dana, coalesce (tmp2.broj_tura,0) broj_tura, coalesce (tmp2.broj_tura_pre_god_dana,0) broj_tura_pre_god_dana
from tmp1 full join tmp2 on tmp1.id = tmp2.id;

/*
-- Broj tura po zemljama za vozilo

WITH veh (vehicle_id) as (
   values (101626)
   )
SELECT t_working_order.vehicle_id, loading_country_id, unloading_country_id, count(*) number_of_routes
FROM t_route join t_working_order on t_route.working_order_id = t_working_order.id
left join veh on t_working_order.vehicle_id = veh.vehicle_id
where t_working_order.vehicle_id = veh.vehicle_id
group by t_working_order.vehicle_id,  loading_country_id, unloading_country_id
*/
-- Broj vozaca po vozilu:

WITH veh (vehicle_id) as (
   values (101626)
   )
select count (distinct driver_id) as number_of_different_drivers from t_working_order, veh
where t_working_order.vehicle_id = veh.vehicle_id

-- Lista dokumenata koja isticu u naredhin 30 dana po vozilu 
WITH veh (vehicle_id) as (
   values (101626)
   )

select * from tx_vehicle_document_vehicle, veh
where exp_date < current_date + INTERVAL '6 month'
and tx_vehicle_document_vehiclevehicle_id = veh.vehicle_id

-- kilometri po turama za vozaca

WITH drv (driver_id) as (
   values (3)
   )
select t_working_order.driver_id, sum(mileage) as number_of_km, count (*) as numbe_of_routes
from t_working_order 
join t_route 
on t_working_order.id = t_route.working_order_id
join drv on drv.driver_id = t_working_order.driver_id
group by t_working_order.driver_id

-- Broj tura za vozaca za tekucu i predhodnu godinu
WITH drv (driver_id) as (
   values (3)
   )
   select a.*, b.number_of_routes_previous_year from (
select t_working_order.driver_id, count(*) as number_of_routes_current_year 
from t_working_order join t_route 
on t_working_order.id = t_route.working_order_id
join drv on drv.driver_id = t_working_order.driver_id
where t_route.loading_date >(extract (year from current_date)::varchar || '-01-01')::date and t_route.loading_date < (extract (year from current_date)::varchar || '-12-31')::date
group by t_working_order.driver_id)a
full join 
(
select t_working_order.driver_id, count(*) as number_of_routes_previous_year
from t_working_order join t_route 
on t_working_order.id = t_route.working_order_id
join drv on drv.driver_id = t_working_order.driver_id
where t_route.loading_date > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_route.loading_date < (extract (year from current_date)::varchar || '-01-01')::date
group by t_working_order.driver_id)b
on a.driver_id = b.driver_id

-- Broj kazni po vozacu

WITH drv (driver_id) as (
   values (3)
   ) 

select t_ticket.driver_id, count(*) as number_of_tickets 
from t_ticket, drv
where t_ticket.driver_id = drv.driver_id
group by t_ticket.driver_id

-- Broj tura po zemljama za vozaca

WITH drv (driver_id) as (
   values (3)
   ) 
SELECT t_working_order.driver_id, loading_country_id, unloading_country_id, count(*) number_of_routes
FROM t_route join t_working_order on t_route.working_order_id = t_working_order.id
left join drv on t_working_order.driver_id = drv.driver_id
where t_working_order.driver_id = drv.driver_id
group by t_working_order.driver_id,  loading_country_id, unloading_country_id

-- Broj tura po zemljama za odrednjeno vozilo

WITH veh (vehicle_id) as (
   values (101626)
   ) 
SELECT t_working_order.vehicle_id, loading_country_id, unloading_country_id, count(*) number_of_routes
FROM t_route join t_working_order on t_route.working_order_id = t_working_order.id
join veh on t_working_order.vehicle_id = veh.vehicle_id
where t_working_order.vehicle_id =  veh.vehicle_id
group by t_working_order.vehicle_id,  loading_country_id, unloading_country_id

-- Lista Kamiona koje je vozio vozac:

WITH drv (driver_id) as (
   values (1)
   ) 
   select t_working_order.driver_id , count (*) number_of_vehicles  from t_working_order 
   join drv on drv.driver_id = t_working_order.driver_id
   group by t_working_order.driver_id

