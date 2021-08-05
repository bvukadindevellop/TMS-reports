
WITH cmp (company_id) as (
   values (2)

   )
    select a.number, a.driver_id, a.vehicle_id, a.trailer_id, amount_in_eur, local_amount_currency, total_amount_with_tax_in_eur, local_total_amount_with_tax, total_amount_with_tax_in_eur - amount_in_eur as divergence_in_eur,
    local_total_amount_with_tax - local_amount_currency as divergence_in_local_currency
    from 
(
select  t_working_order.number, t_working_order.driver_id, t_working_order.vehicle_id, t_working_order.trailer_id, sum( coalesce( t_cost.amount_in_eur, 0)) amount_in_eur, sum( coalesce( local_amount_currency, 0)) local_amount_currency
from t_working_order
join cmp on cmp.company_id = t_working_order.company_id
join t_cost on t_cost.working_order_id = t_working_order.id
group by  t_working_order.number, t_working_order.driver_id, t_working_order.vehicle_id, t_working_order.trailer_id) a
join 
(

select t_working_order.number, t_working_order.driver_id, t_working_order.vehicle_id, t_working_order.trailer_id, sum( coalesce(total_amount_with_tax_in_eur, 0)) total_amount_with_tax_in_eur, sum(coalesce( local_total_amount_with_tax, 0)) local_total_amount_with_tax
from t_working_order
join cmp on cmp.company_id = t_working_order.company_id
join t_invoice on t_invoice.working_order_id = t_working_order.id 
group by t_working_order.number, t_working_order.driver_id, t_working_order.vehicle_id, t_working_order.trailer_id
) b 
on  coalesce(a.number, 0) =  coalesce(a.number, 0) and  coalesce(a.driver_id, 0) =  coalesce(b.driver_id, 0) and  coalesce(a.vehicle_id, 0) =  coalesce(b.vehicle_id, 0) and  coalesce(a.trailer_id, 0) =   coalesce(b.trailer_id, 0)