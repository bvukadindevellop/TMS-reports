
WITH comp ( comp_id ) as (
   values (2)
   )

select 'Current Month', sum(amount_in_eur)
from( 
select 1 as id, sum(coalesce(amount_in_eur,0)) amount_in_eur 
from t_cost c , comp
where c.company_id = comp_id
and date_of_cost >= date_trunc('month', current_date) and date_of_cost <=now ()
union all
select 1 as id,  sum(coalesce(amount_in_eur_paid, 0)) amount_in_eur  
from t_damage c 
join t_vehicle v on v.id = c.vehicle_id 
--left join t_trailer t on t.id = c.trailer_id
, comp
where (v.company_id = comp_id )
and date_of_damage >= date_trunc('month', current_date) and date_of_damage <=now ()
union all 
select 1 as id,  sum(coalesce(amount_in_eur_paid, 0)) amount_in_eur  
from t_damage c 
join t_trailer t on t.id = c.trailer_id
, comp
where (t.company_id = comp_id)
and date_of_damage >= date_trunc('month', current_date) and date_of_damage <=now ()

union all

select 1 as id,  sum(coalesce(amount_in_eur, 0)) amount_in_eur  
from t_service c 
join t_vehicle v on v.id = c.vehicle_id 
--left join t_trailer t on t.id = c.trailer_id
, comp
where (v.company_id = comp_id)
and date_of_service>= date_trunc('month', current_date) and date_of_service <=now ()

union all
select 1 as id,  sum(coalesce(amount_in_eur, 0)) amount_in_eur  
from t_service c 
join t_trailer t on t.id = c.trailer_id
, comp
where t.company_id = comp_id
and date_of_service>= date_trunc('month', current_date) and date_of_service <=now ())a


union all


select 'Previous Month',sum(amount_in_eur) 
from 
(
select 1 as id, sum(coalesce(amount_in_eur,0)) amount_in_eur 
from t_cost c , comp
where c.company_id = comp_id
and date_of_cost >= date_trunc('month', current_date - interval '1' month) and date_of_cost < date_trunc('month', current_date) 

union all

select 1 as id,  sum(coalesce(amount_in_eur_paid, 0)) amount_in_eur  from t_damage c 
join t_vehicle v on v.id = c.vehicle_id 
--left join t_trailer t on t.id = c.trailer_id
, comp
where (v.company_id = comp_id )
and date_of_damage >= date_trunc('month', current_date - interval '1' month) and date_of_damage < date_trunc('month', current_date) 

union all

select 1 as id,  sum(coalesce(amount_in_eur_paid, 0)) amount_in_eur  from t_damage c 
--join t_vehicle v on v.id = c.vehicle_id 
join t_trailer t on t.id = c.trailer_id
, comp
where (t.company_id = comp_id )
and date_of_damage >= date_trunc('month', current_date - interval '1' month) and date_of_damage < date_trunc('month', current_date) 

union all

select 1 as id,  sum(coalesce(amount_in_eur, 0)) amount_in_eur  from t_service c 
join t_vehicle v on v.id = c.vehicle_id 
--left join t_trailer t on t.id = c.trailer_id
, comp
where (v.company_id = comp_id)
and date_of_service >= date_trunc('month', current_date - interval '1' month) and date_of_service < date_trunc('month', current_date) 

union all

select 1 as id,  sum(coalesce(amount_in_eur, 0)) amount_in_eur  from t_service c 
join t_trailer t on t.id = c.trailer_id
, comp
where (t.company_id = comp_id)
and date_of_service >= date_trunc('month', current_date - interval '1' month) and date_of_service < date_trunc('month', current_date) )b
