

WITH city ( loading , unloading ) as (
   values ('Beograd', 'Beograd')
   )

select r.id, r.working_order_id,
 loading_date, 
 unloading_date, 
 TRUNC(DATE_PART('day', unloading_date ::timestamp - loading_date ::timestamp)) route_duration,
 c.local_amount_currency,
 c.amount_in_eur
--select *
 from t_route r
left join (
select sum(coalesce(amount_in_eur, 0)) amount_in_eur, sum(coalesce(local_amount_currency,0)) local_amount_currency, working_order_id
from t_cost
group by working_order_id) c on c.working_order_id = r.working_order_id,
city
where loading_city = city.loading and unloading_city = city.unloading
order by unloading_date desc --limit 10

