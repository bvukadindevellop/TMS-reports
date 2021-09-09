WITH comp ( comp_id ) as (
   values (2)
   )

select sum(amount_in_eur), a.vehicle_id from (
   select  b.vehicle_id, sum(amount_in_eur) amount_in_eur 
   from t_vehicle a
   join t_cost b on a.id = b.vehicle_id,
   comp
   where a.company_id = comp_id
   group by b.vehicle_id
   union all

   select  c.vehicle_id, sum(amount_in_eur_paid) amount_in_eur 
   from t_damage c 
   join t_vehicle v on v.id = c.vehicle_id 
   , comp
   where v.company_id = comp_id
   group by c.vehicle_id

   union all 

   select  c.vehicle_id, sum(amount_in_eur) amount_in_eur 
   from t_service c 
   join t_vehicle v on v.id = c.vehicle_id 
   , comp
   where v.company_id = comp_id
   group by c.vehicle_id)a
   group by a.vehicle_id
   order by sum(amount_in_eur) limit 10 
