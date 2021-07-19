-- Top 5 vozila sa najvecom ukupnom kilometrazom 

WITH dat ( date_from, date_to, user_id) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

select unit_id, sum(coalesce(period_1_km, 0)) as ukupno_km
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = dat.user_id :: int
group by unit_id 
order by sum(coalesce(period_1_km, 0)) desc limit 5

WITH dat ( date_from, date_to, subuser) as (
   values ('2021-06-05', '2021-07-05', '1192')
   )

select unit_id, sum(coalesce(period_1_km, 0)) as ukupno_km
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by unit_id 
order by sum(coalesce(period_1_km, 0)) desc limit 5

-- Top 5 vozila sa najmanjom ukupnom kilometrazom 

WITH dat ( date_from, date_to, user_id) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

select unit_id, sum(coalesce(period_1_km, 0)) as ukupno_km
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = dat.user_id :: int
group by unit_id 
order by sum(coalesce(period_1_km, 0)) limit 5

WITH dat ( date_from, date_to, subuser) as (
   values ('2021-06-05', '2021-07-05', '1192')
   )

select unit_id, sum(coalesce(period_1_km, 0)) as ukupno_km
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by unit_id 
order by sum(coalesce(period_1_km, 0)) limit 5


-- Top 10 vozila sa najduzim prosecnim zadrzavanjem

WITH dat ( date_from, date_to, user_id ) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

select unit_id, sum(coalesce(duzina_zadrzavanja, 0))/count (*) :: decimal (19,2) as avg_zadrzavanja
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_zadrzavanja.user_id = dat.user_id :: int
group by unit_id 
order by sum(coalesce(duzina_zadrzavanja, 0))/count (*) :: decimal (19,2) desc limit 10 

WITH dat ( date_from, date_to, subuser ) as (
   values ('2021-06-05', '2021-07-05', '1192')
   )

select unit_id, sum(coalesce(duzina_zadrzavanja, 0))/count (*) :: decimal (19,2) as avg_zadrzavanja
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_zadrzavanja.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by unit_id 
order by sum(coalesce(duzina_zadrzavanja, 0))/count (*) :: decimal (19,2) desc limit 10 

