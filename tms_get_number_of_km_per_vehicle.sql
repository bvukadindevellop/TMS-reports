-- Broj kilometara za vozilo po mesecima
drop function if exists tms_get_number_of_km_per_vehicle ();

create or replace function tms_get_number_of_km_per_vehicle
(
veh_id int
)

returns table (mesec varchar (15), ukupno_km numeric(19,2), ukupno_km_pre_god_dana numeric (19,2), efektivna_voznja numeric(19,2), efektivna_voznja_pre_god_dana numeric(19,2))

language plpgsql    
as $$
begin

drop table if exists tmp3;
CREATE TEMPORARY TABLE tmp3(
   id integer,
   mesec varchar (15),
   ukupno_km decimal (19,2),
   ukupno_km_pre_god_dana decimal (19,2),
   efektivna_voznja decimal (19,2),
   efektivna_voznja_pre_god_dana decimal (19,2)
);
drop table if exists tmp4;
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

   select row_number() over (order by a.mesec_id)::int as id, coalesce(a.mesec, b.mesec) :: varchar(15), coalesce(a.ukupno_km,0):: numeric as ukupno_km, coalesce(b.ukupno_km, 0)::numeric as ukupno_km_pre_god_dana, coalesce(a.efektivna_voznja, 0)::numeric as efektivna_voznja, coalesce(b.efektivna_voznja, 0)::numeric as efektivna_voznja_pre_god_dana
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

  sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(analiza_mdi.efektivna_voznja, 0)) as efektivna_voznja
from t_vehicle 
join analiza_mdi on analiza_mdi.unit_id = t_vehicle.unit_id 
where analiza_mdi.dan >(extract (year from current_date)::varchar || '-01-01')::date and analiza_mdi.dan <=current_date
and t_vehicle.id = veh_id
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
sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(analiza_mdi.efektivna_voznja, 0)) as efektivna_voznja
from t_vehicle 
join analiza_mdi on analiza_mdi.unit_id = t_vehicle.unit_id 
where analiza_mdi.dan > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and analiza_mdi.dan < (extract (year from current_date)::varchar || '-01-01')::date
and t_vehicle.id = veh_id
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

 RETURN QUERY select  tmp4.mesec:: varchar (15), coalesce (tmp3.ukupno_km, 0)::numeric(19,2) ukupno_km, coalesce (tmp3.ukupno_km_pre_god_dana,0)::numeric(19,2) ukupno_km_pre_god_dana, 
 coalesce (tmp3.efektivna_voznja,0)::numeric(19,2) as efektivna_voznja, coalesce (tmp3.efektivna_voznja_pre_god_dana, 0)::numeric(19,2) efektivna_voznja_pre_god_dana
from tmp4 full join tmp3 on tmp4.mesec = tmp3.mesec
order by tmp3.id;

--commit;
end;$$


--SELECT * FROM tms_get_number_of_km_per_vehicle(101412)