-- Izvestaj o koriscenju vozila grupisan po grupi 

WITH dat ( date_from, date_to, user_id) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

   select   a.grupa, a.ukupno_km, b.ukupno_km as ukupno_km_pre_god_dana, a.efektivna_voznja, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select   sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja, grupa
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = dat.user_id :: int
group by  grupa
)a 
left join 
(
select  sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja, grupa
from analiza_mdi, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_mdi.user_id = dat.user_id :: int
group by   grupa
)b on   a.grupa = b.grupa 


------------------------------------------------------
WITH dat ( date_from, date_to, subuser) as (
   values ('2021-06-05', '2021-07-05', '1192')
   )

   select  a.grupa, a.ukupno_km, b.ukupno_km as ukupno_km_pre_god_dana, a.efektivna_voznja, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select   sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja, grupa
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by   grupa
)a 
left join 
(
select  sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja, grupa
from analiza_mdi, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_mdi.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by  grupa
)b on  a.grupa = b.grupa
