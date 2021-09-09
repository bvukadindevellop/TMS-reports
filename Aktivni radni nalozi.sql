WITH comp (comp_id) as (
   values (2)
   )
select * from t_working_order, comp
where is_submitted = 'f'
and company_id = comp_id