-- Broj kilometara i ruta po mesecima za sva vozila jedne kompanije
drop function if exists tms_get_number_of_km_and_routes_per_all_vehicle ();

create or replace function tms_get_number_of_km_and_routes_per_all_vehicle
(
comp_id int
)

returns table (mesec varchar (15), ukupno_km numeric(19,2), ukupno_km_pre_god_dana numeric (19,2), broj_tura integer, broj_tura_pre_god_dana integer)

language plpgsql    
as $$
begin


drop table if exists tmp2;
CREATE TEMPORARY TABLE tmp2(
   id integer,
   mesec varchar (15),
   ukupno_km decimal (19,2),
   ukupno_km_pre_god_dana decimal (19,2),
   broj_tura integer,
   broj_tura_pre_god_dana integer
);
drop table if exists tmp1;
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

   select row_number() over (order by a.mesec_id) as id, a.mesec, coalesce(a.ukupno_km, 0)ukupno_km, coalesce(b.ukupno_km, 0) as ukupno_km_pre_god_dana, 
   coalesce (a.broj_tura, 0) as broj_tura, coalesce (b.broj_tura,0) as broj_tura_pre_god_dana
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
where t_route.loading_date >(extract (year from current_date)::varchar || '-01-01')::date and t_route.loading_date < (extract (year from current_date)::varchar || '-12-31')::date
and t_working_order.company_id = comp_id
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
and t_working_order.company_id = comp_id
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

return query select tmp1.mesec:: varchar (15), 
coalesce (tmp2.ukupno_km, 0)::numeric(19,2) ukupno_km, 
coalesce (tmp2.ukupno_km_pre_god_dana,0)::numeric(19,2) ukupno_km_pre_god_dana, 
coalesce (tmp2.broj_tura,0)::integer broj_tura, 
coalesce (tmp2.broj_tura_pre_god_dana,0)::integer broj_tura_pre_god_dana
--from tmp1 full join tmp2 on tmp1.id = tmp2.id;
from tmp1 full join tmp2 on tmp1.mesec = tmp2.mesec
--group by tmp1.mesec, tmp1.id
order by tmp1.id;

end;$$


--select * from t_route
--SELECT * FROM tms_get_number_of_km_and_routes_per_all_vehicle(2)