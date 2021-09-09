WITH comp (comp_id) as (
   values (2)
   )

   select 'Broj vozila: ', count (*) from t_vehicle, comp
   where company_id = comp_id
   union all
   select 'Broj prikolica: ', count (*) from t_trailer, comp
   where company_id = comp_id
   union all
   select 'Broj vozaca:', count (*) from t_driver, comp
   where company_id = comp_id