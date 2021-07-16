
-- Izvestaj o koriscenju vozila:
WITH dat ( date_from, date_to) as (
   values ('2021-06-05', '2021-07-05')
   )

   select a.unit_id, a.user_id, a.opis, a.radno_vreme, a.ukupno_km, b.ukupno_km as ukupno_km_pre_god_dana, a.efektivna_voznja, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select unit_id, user_id, opis, radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from analiza_mdi, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
group by unit_id, opis, radno_vreme, user_id
)a 
left join 
(
select unit_id, user_id, opis, radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from analiza_mdi, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
group by unit_id, opis, radno_vreme, user_id
)b on a.unit_id = b.unit_id and a.user_id = b.user_id and a.radno_vreme = b.radno_vreme and a.opis = b.opis 


-- Izvestraj o voznjama:

WITH dat ( date_from, date_to) as (
   values ('2021-06-05', '2021-07-05')
   )

   select a.unit_id, a.user_id, a.opis, a.grupa, a.ukupno_km, b.ukupno_km as ukupno_km_pre_god_dana
   from (
select unit_id, user_id, opis, grupa, sum(coalesce(kilometraza, 0)) as ukupno_km
from analiza_voznji, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
group by unit_id, opis, user_id, grupa
)a 
left join 
(
select unit_id, user_id, opis, grupa,  sum(coalesce(kilometraza, 0)) as ukupno_km
from analiza_voznji, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
group by unit_id, opis,  user_id, grupa
)b on a.unit_id = b.unit_id and a.user_id = b.user_id and a.opis = b.opis and a.grupa = b.grupa 

-- Izvestaj o zadrzavanjima:

select * from analiza_zadrzavanja limit 100


WITH dat ( date_from, date_to) as (
   values ('2021-06-05', '2021-07-05')
   )

   select a.unit_id, a.user_id, a.opis, a.grupa, a.duzina_zadrzavanja, b.duzina_zadrzavanja as duzina_zadrzavanja_pre_god_dana
   from (
select unit_id, user_id, opis, grupa, sum(coalesce(duzina_zadrzavanja, 0)) as duzina_zadrzavanja
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
group by unit_id, opis, user_id, grupa
)a 
left join 
(
select unit_id, user_id, opis, grupa,  sum(coalesce(duzina_zadrzavanja, 0)) as duzina_zadrzavanja
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
group by unit_id, opis,  user_id, grupa
)b on a.unit_id = b.unit_id and a.user_id = b.user_id and a.opis = b.opis and a.grupa = b.grupa 

-- Izvestaj o prekoracenjima brzime:

select * from analiza_prekoracenja limit 100

WITH dat ( date_from, date_to) as (
   values ('2021-06-05', '2021-07-05')
   )

  
select unit_id, user_id, opis, grupa, case when brzina - dozvoljena_brzina <= 10 then '0-10'
					   when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
					   when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
					   when brzina - dozvoljena_brzina > 50 then '50+' end as tip_prekoracenja,
					   count(*) as broj_prekoracenja
					   	
from analiza_prekoracenja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
group by unit_id, opis, user_id, grupa,
case when brzina - dozvoljena_brzina <= 10 then '0-10'
					   when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
					   when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
					   when brzina - dozvoljena_brzina > 50 then '50+' end 
order by 
case when brzina - dozvoljena_brzina <= 10 then '0-10'
					   when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
					   when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
					   when brzina - dozvoljena_brzina > 50 then '50+' end


-- Top 10 prekoracenja:
WITH dat ( date_from, date_to) as (
   values ('2021-06-05', '2021-07-05')
   )

  
select unit_id, user_id, opis, grupa, brzina - dozvoljena_brzina 
from analiza_prekoracenja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date 
order by brzina - dozvoljena_brzina  desc limit 10 

