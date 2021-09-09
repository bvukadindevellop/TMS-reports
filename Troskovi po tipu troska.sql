
WITH comp (comp_id) as (
   values (2)
   )
select ct.name as tip_troska, sum(amount_in_eur)amount_in_eur from t_cost c
join tr_cost_type ct on ct.id = c.cost_type_id,
comp
where company_id = comp_id
group by ct.name
