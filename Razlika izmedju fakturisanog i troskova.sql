-- Razlika izmedju fakturisanog i troskova 
drop function if exists tms_difference_between_invoised_and_costs ();

create or replace function tms_difference_between_invoised_and_costs
(
comp_id int
)

returns table (mesec varchar (15), amount_in_eur numeric(19,2), amount_in_eur_one_year_before numeric(19,2))

language plpgsql    
as $$
begin


drop table if exists tmp2;
CREATE TEMPORARY TABLE tmp2(
   id integer,
   mesec varchar (15),
   amount_in_eur numeric (19,2),
   amount_in_eur_one_year_before numeric(19,2)
);
drop table if exists tmp1;
CREATE TEMPORARY TABLE tmp1(
   id integer,
   mesec varchar (15),
   amount_in_eur numeric (19,2),
   amount_in_eur_one_year_before numeric(19,2)
);
insert into tmp1
values (1, 'Januar', 0, 0),
       (2, 'Februar',0, 0),
       (3, 'Mart', 0, 0),
       (4, 'April',0, 0),
       (5, 'Maj', 0, 0),
       (6, 'Jun', 0, 0),
       (7, 'Jul', 0, 0),
       (8, 'Avgust', 0, 0),
       (9, 'Septembar', 0, 0),
       (10, 'Oktobar', 0, 0),
       (11, 'Novembar', 0, 0),
       (12, 'Decembar', 0, 0);

insert into tmp2 

   select row_number() over (order by a.mesec_id) as id, a.mesec, coalesce(c.amount_in_eur, 0) - coalesce(a.amount_in_eur, 0) as amount_in_eur, coalesce(b.amount_in_eur, 0)- coalesce(b.amount_in_eur, 0) as amount_in_eur_one_year_before
   from (
select extract( month from t_cost.date_of_cost) as mesec_id, case when extract( month from t_cost.date_of_cost) = 1 then 'Januar'
			  when extract( month from t_cost.date_of_cost) = 2 then 'Februar'
			  when extract( month from t_cost.date_of_cost) = 3 then 'Mart'
			  when extract( month from t_cost.date_of_cost) = 4 then 'April'
			  when extract( month from t_cost.date_of_cost) = 5 then 'Maj'
			  when extract( month from t_cost.date_of_cost) = 6 then 'Jun'
			  when extract( month from t_cost.date_of_cost) = 7 then 'Jul'
			  when extract( month from t_cost.date_of_cost) = 8 then 'Avgust'
			  when extract( month from t_cost.date_of_cost) = 9 then 'Septembar'
			  when extract( month from t_cost.date_of_cost) = 10 then 'Oktobar'
			  when extract( month from t_cost.date_of_cost) = 11 then 'Novembar'
			  when extract( month from t_cost.date_of_cost) = 12 then 'Decembar' end as mesec, sum (t_cost.amount_in_eur) amount_in_eur
from t_cost   
where t_cost.date_of_cost >(extract (year from current_date)::varchar || '-01-01')::date and t_cost.date_of_cost < (extract (year from current_date)::varchar || '-12-31')::date
and t_cost.company_id = comp_id
group by  case when extract( month from t_cost.date_of_cost) = 1 then 'Januar'
			  when extract( month from t_cost.date_of_cost) = 2 then 'Februar'
			  when extract( month from t_cost.date_of_cost) = 3 then 'Mart'
			  when extract( month from t_cost.date_of_cost) = 4 then 'April'
			  when extract( month from t_cost.date_of_cost) = 5 then 'Maj'
			  when extract( month from t_cost.date_of_cost) = 6 then 'Jun'
			  when extract( month from t_cost.date_of_cost) = 7 then 'Jul'
			  when extract( month from t_cost.date_of_cost) = 8 then 'Avgust'
			  when extract( month from t_cost.date_of_cost) = 9 then 'Septembar'
			  when extract( month from t_cost.date_of_cost) = 10 then 'Oktobar'
			  when extract( month from t_cost.date_of_cost) = 11 then 'Novembar'
			  when extract( month from t_cost.date_of_cost) = 12 then 'Decembar' end,
			  extract( month from t_cost.date_of_cost)

union all 

select extract( month from t_damage.date_of_damage) as mesec_id, case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end as mesec, sum (t_damage.amount_in_eur_paid) amount_in_eur
from t_damage join t_vehicle on t_damage.vehicle_id = t_vehicle.id  
where t_damage.date_of_damage >(extract (year from current_date)::varchar || '-01-01')::date and t_damage.date_of_damage < (extract (year from current_date)::varchar || '-12-31')::date
and t_vehicle.company_id = comp_id
group by  case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end,
			  extract( month from t_damage.date_of_damage)

union all

select extract( month from t_service.date_of_service) as mesec_id, case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end as mesec, sum (t_service.amount_in_eur) amount_in_eur
from t_service join t_vehicle on t_service.vehicle_id = t_vehicle.id  
where t_service.date_of_service >(extract (year from current_date)::varchar || '-01-01')::date and t_service.date_of_service < (extract (year from current_date)::varchar || '-12-31')::date
and t_vehicle.company_id = comp_id
group by  case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end,
			  extract( month from t_service.date_of_service)

union all

select extract( month from t_damage.date_of_damage) as mesec_id, case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end as mesec, sum (t_damage.amount_in_eur_paid) amount_in_eur
from t_damage join t_trailer on t_damage.vehicle_id = t_trailer.id  
where t_damage.date_of_damage >(extract (year from current_date)::varchar || '-01-01')::date and t_damage.date_of_damage < (extract (year from current_date)::varchar || '-12-31')::date
and t_trailer.company_id = comp_id
group by  case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end,
			  extract( month from t_damage.date_of_damage)

union all

select extract( month from t_service.date_of_service) as mesec_id, case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end as mesec, sum (t_service.amount_in_eur) amount_in_eur
from t_service join t_trailer on t_service.vehicle_id = t_trailer.id  
where t_service.date_of_service >(extract (year from current_date)::varchar || '-01-01')::date and t_service.date_of_service < (extract (year from current_date)::varchar || '-12-31')::date
and t_trailer.company_id = comp_id
group by  case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end,
			  extract( month from t_service.date_of_service)

)a 
full outer join 
(
select extract( month from t_cost.date_of_cost) as mesec_id,case when extract( month from t_cost.date_of_cost) = 1 then 'Januar'
			  when extract( month from t_cost.date_of_cost) = 2 then 'Februar'
			  when extract( month from t_cost.date_of_cost) = 3 then 'Mart'
			  when extract( month from t_cost.date_of_cost) = 4 then 'April'
			  when extract( month from t_cost.date_of_cost) = 5 then 'Maj'
			  when extract( month from t_cost.date_of_cost) = 6 then 'Jun'
			  when extract( month from t_cost.date_of_cost) = 7 then 'Jul'
			  when extract( month from t_cost.date_of_cost) = 8 then 'Avgust'
			  when extract( month from t_cost.date_of_cost) = 9 then 'Septembar'
			  when extract( month from t_cost.date_of_cost) = 10 then 'Oktobar'
			  when extract( month from t_cost.date_of_cost) = 11 then 'Novembar'
			  when extract( month from t_cost.date_of_cost) = 12 then 'Decembar' end as mesec, sum (t_cost.amount_in_eur) amount_in_eur
from t_cost
where t_cost.company_id = comp_id
and t_cost.date_of_cost > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_cost.date_of_cost < (extract (year from current_date)::varchar || '-01-01')::date
group by  case when extract( month from t_cost.date_of_cost) = 1 then 'Januar'
			  when extract( month from t_cost.date_of_cost) = 2 then 'Februar'
			  when extract( month from t_cost.date_of_cost) = 3 then 'Mart'
			  when extract( month from t_cost.date_of_cost) = 4 then 'April'
			  when extract( month from t_cost.date_of_cost) = 5 then 'Maj'
			  when extract( month from t_cost.date_of_cost) = 6 then 'Jun'
			  when extract( month from t_cost.date_of_cost) = 7 then 'Jul'
			  when extract( month from t_cost.date_of_cost) = 8 then 'Avgust'
			  when extract( month from t_cost.date_of_cost) = 9 then 'Septembar'
			  when extract( month from t_cost.date_of_cost) = 10 then 'Oktobar'
			  when extract( month from t_cost.date_of_cost) = 11 then 'Novembar'
			  when extract( month from t_cost.date_of_cost) = 12 then 'Decembar' end,
			  extract( month from t_cost.date_of_cost)

union all 

select extract( month from t_damage.date_of_damage) as mesec_id, case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end as mesec, sum (t_damage.amount_in_eur_paid) amount_in_eur
from t_damage join t_vehicle on t_damage.vehicle_id = t_vehicle.id  
where t_damage.date_of_damage > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_damage.date_of_damage < (extract (year from current_date)::varchar || '-01-01')::date
and t_vehicle.company_id = comp_id
group by  case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end,
			  extract( month from t_damage.date_of_damage)

union all

select extract( month from t_service.date_of_service) as mesec_id, case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end as mesec, sum (t_service.amount_in_eur) amount_in_eur
from t_service join t_vehicle on t_service.vehicle_id = t_vehicle.id  
where t_service.date_of_service > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_service.date_of_service < (extract (year from current_date)::varchar || '-01-01')::date
and t_vehicle.company_id = comp_id
group by  case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end,
			  extract( month from t_service.date_of_service)

union all

select extract( month from t_damage.date_of_damage) as mesec_id, case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end as mesec, sum (t_damage.amount_in_eur_paid) amount_in_eur
from t_damage join t_trailer on t_damage.vehicle_id = t_trailer.id  
where t_damage.date_of_damage > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_damage.date_of_damage < (extract (year from current_date)::varchar || '-01-01')::date
and t_trailer.company_id = comp_id
group by  case when extract( month from t_damage.date_of_damage) = 1 then 'Januar'
			  when extract( month from t_damage.date_of_damage) = 2 then 'Februar'
			  when extract( month from t_damage.date_of_damage) = 3 then 'Mart'
			  when extract( month from t_damage.date_of_damage) = 4 then 'April'
			  when extract( month from t_damage.date_of_damage) = 5 then 'Maj'
			  when extract( month from t_damage.date_of_damage) = 6 then 'Jun'
			  when extract( month from t_damage.date_of_damage) = 7 then 'Jul'
			  when extract( month from t_damage.date_of_damage) = 8 then 'Avgust'
			  when extract( month from t_damage.date_of_damage) = 9 then 'Septembar'
			  when extract( month from t_damage.date_of_damage) = 10 then 'Oktobar'
			  when extract( month from t_damage.date_of_damage) = 11 then 'Novembar'
			  when extract( month from t_damage.date_of_damage) = 12 then 'Decembar' end,
			  extract( month from t_damage.date_of_damage)

union all

select extract( month from t_service.date_of_service) as mesec_id, case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end as mesec, sum (t_service.amount_in_eur) amount_in_eur
from t_service join t_trailer on t_service.vehicle_id = t_trailer.id  
where t_service.date_of_service > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_service.date_of_service < (extract (year from current_date)::varchar || '-01-01')::date
and t_trailer.company_id = comp_id
group by  case when extract( month from t_service.date_of_service) = 1 then 'Januar'
			  when extract( month from t_service.date_of_service) = 2 then 'Februar'
			  when extract( month from t_service.date_of_service) = 3 then 'Mart'
			  when extract( month from t_service.date_of_service) = 4 then 'April'
			  when extract( month from t_service.date_of_service) = 5 then 'Maj'
			  when extract( month from t_service.date_of_service) = 6 then 'Jun'
			  when extract( month from t_service.date_of_service) = 7 then 'Jul'
			  when extract( month from t_service.date_of_service) = 8 then 'Avgust'
			  when extract( month from t_service.date_of_service) = 9 then 'Septembar'
			  when extract( month from t_service.date_of_service) = 10 then 'Oktobar'
			  when extract( month from t_service.date_of_service) = 11 then 'Novembar'
			  when extract( month from t_service.date_of_service) = 12 then 'Decembar' end,
			  extract( month from t_service.date_of_service) 
)b on  a.mesec = b.mesec 
full outer join 

(
select extract( month from t_invoice.invoice_date) as mesec_id, case when extract( month from t_invoice.invoice_date) = 1 then 'Januar'
			  when extract( month from t_invoice.invoice_date) = 2 then 'Februar'
			  when extract( month from t_invoice.invoice_date) = 3 then 'Mart'
			  when extract( month from t_invoice.invoice_date) = 4 then 'April'
			  when extract( month from t_invoice.invoice_date) = 5 then 'Maj'
			  when extract( month from t_invoice.invoice_date) = 6 then 'Jun'
			  when extract( month from t_invoice.invoice_date) = 7 then 'Jul'
			  when extract( month from t_invoice.invoice_date) = 8 then 'Avgust'
			  when extract( month from t_invoice.invoice_date) = 9 then 'Septembar'
			  when extract( month from t_invoice.invoice_date) = 10 then 'Oktobar'
			  when extract( month from t_invoice.invoice_date) = 11 then 'Novembar'
			  when extract( month from t_invoice.invoice_date) = 12 then 'Decembar' end as mesec, sum (t_invoice.amount_in_eur) amount_in_eur
from t_invoice join t_route on t_invoice.working_order_id = t_route.id  
where t_invoice.invoice_date >(extract (year from current_date)::varchar || '-01-01')::date and t_invoice.invoice_date < (extract (year from current_date)::varchar || '-12-31')::date
and t_invoice.company_id = comp_id
and t_route.has_invoice = 't'
group by  case when extract( month from t_invoice.invoice_date) = 1 then 'Januar'
			  when extract( month from t_invoice.invoice_date) = 2 then 'Februar'
			  when extract( month from t_invoice.invoice_date) = 3 then 'Mart'
			  when extract( month from t_invoice.invoice_date) = 4 then 'April'
			  when extract( month from t_invoice.invoice_date) = 5 then 'Maj'
			  when extract( month from t_invoice.invoice_date) = 6 then 'Jun'
			  when extract( month from t_invoice.invoice_date) = 7 then 'Jul'
			  when extract( month from t_invoice.invoice_date) = 8 then 'Avgust'
			  when extract( month from t_invoice.invoice_date) = 9 then 'Septembar'
			  when extract( month from t_invoice.invoice_date) = 10 then 'Oktobar'
			  when extract( month from t_invoice.invoice_date) = 11 then 'Novembar'
			  when extract( month from t_invoice.invoice_date) = 12 then 'Decembar' end,
			  extract( month from t_invoice.invoice_date)) c
		  on a.mesec = c.mesec 

full outer join 

(
select extract( month from t_invoice.invoice_date) as mesec_id, case when extract( month from t_invoice.invoice_date) = 1 then 'Januar'
			  when extract( month from t_invoice.invoice_date) = 2 then 'Februar'
			  when extract( month from t_invoice.invoice_date) = 3 then 'Mart'
			  when extract( month from t_invoice.invoice_date) = 4 then 'April'
			  when extract( month from t_invoice.invoice_date) = 5 then 'Maj'
			  when extract( month from t_invoice.invoice_date) = 6 then 'Jun'
			  when extract( month from t_invoice.invoice_date) = 7 then 'Jul'
			  when extract( month from t_invoice.invoice_date) = 8 then 'Avgust'
			  when extract( month from t_invoice.invoice_date) = 9 then 'Septembar'
			  when extract( month from t_invoice.invoice_date) = 10 then 'Oktobar'
			  when extract( month from t_invoice.invoice_date) = 11 then 'Novembar'
			  when extract( month from t_invoice.invoice_date) = 12 then 'Decembar' end as mesec, sum (t_invoice.amount_in_eur) amount_in_eur
from t_invoice join t_route on t_invoice.working_order_id = t_route.id  
where t_invoice.invoice_date > (extract (year from current_date - INTERVAL '1 year')::varchar || '-01-01')::date and t_invoice.invoice_date < (extract (year from current_date)::varchar || '-01-01')::date
and t_invoice.company_id = comp_id
and t_route.has_invoice = 't'
group by  case when extract( month from t_invoice.invoice_date) = 1 then 'Januar'
			  when extract( month from t_invoice.invoice_date) = 2 then 'Februar'
			  when extract( month from t_invoice.invoice_date) = 3 then 'Mart'
			  when extract( month from t_invoice.invoice_date) = 4 then 'April'
			  when extract( month from t_invoice.invoice_date) = 5 then 'Maj'
			  when extract( month from t_invoice.invoice_date) = 6 then 'Jun'
			  when extract( month from t_invoice.invoice_date) = 7 then 'Jul'
			  when extract( month from t_invoice.invoice_date) = 8 then 'Avgust'
			  when extract( month from t_invoice.invoice_date) = 9 then 'Septembar'
			  when extract( month from t_invoice.invoice_date) = 10 then 'Oktobar'
			  when extract( month from t_invoice.invoice_date) = 11 then 'Novembar'
			  when extract( month from t_invoice.invoice_date) = 12 then 'Decembar' end,
			  extract( month from t_invoice.invoice_date)) d
		  on a.mesec = d.mesec 
 
order by a.mesec_id;

return query select tmp1.mesec:: varchar (15), 
sum(coalesce (tmp2.amount_in_eur, 0))::numeric(19,2) amount_in_eur, 
sum(coalesce (tmp2.amount_in_eur_one_year_before,0))::numeric(19,2) amount_in_eur_one_year_before
from tmp1 full join tmp2 on tmp1.mesec = tmp2.mesec
group by tmp1.mesec, tmp1.id
order by tmp1.id
;

end;$$

--SELECT * FROM tms_difference_between_invoised_and_costs(2)

