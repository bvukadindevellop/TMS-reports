
-- Izvestaj o koriscenju vozila:
WITH dat ( date_from, date_to, user_id) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

   select  a.radno_vreme, a.ukupno_km, b.ukupno_km as ukupno_km_pre_god_dana, a.efektivna_voznja, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select  radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = dat.user_id :: int
group by  radno_vreme
)a 
left join 
(
select  radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from analiza_mdi, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_mdi.user_id = dat.user_id :: int
group by  radno_vreme
)b on  a.radno_vreme = b.radno_vreme  
 --4.7
------------------------------------------------------
WITH dat ( date_from, date_to, subuser) as (
   values ('2021-06-05', '2021-07-05', '1192')
   )

   select  a.radno_vreme, a.ukupno_km, b.ukupno_km as ukupno_km_pre_god_dana, a.efektivna_voznja, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select  radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from analiza_mdi, dat 
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_mdi.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by  radno_vreme
)a 
left join 
(
select  radno_vreme, sum(coalesce(period_1_km, 0)) as ukupno_km, sum(coalesce(efektivna_voznja, 0)) as efektivna_voznja
from analiza_mdi, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_mdi.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by  radno_vreme
)b on  a.radno_vreme = b.radno_vreme  


-- Izvestraj o voznjama(ovde sam obisala par grupisanja, treba u rezultatu da se doda I efektivna voznja I efekt. voznja pre god dana):

WITH dat ( date_from, date_to, user_id) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

   select  a.grupa, a.ukupno_km, a.efektivna_voznja, b.ukupno_km as ukupno_km_pre_god_dana, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select  grupa, sum(coalesce(kilometraza, 0)) as ukupno_km, sum(coalesce (vozio, 0)) as efektivna_voznja
from analiza_voznji, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_voznji.user_id = dat.user_id :: int
group by  grupa
)a 
left join 
(
select  grupa,  sum(coalesce(kilometraza, 0)) as ukupno_km, sum(coalesce (vozio, 0)) as efektivna_voznja
from analiza_voznji, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_voznji.user_id = dat.user_id :: int
group by  grupa
)b on  a.grupa = b.grupa 
--8.9

------------------------------------------------------
WITH dat ( date_from, date_to, subuser) as (
   values ('2021-06-05', '2021-07-05', '1192')
   )

   select  a.grupa, a.ukupno_km, a.efektivna_voznja, b.ukupno_km as ukupno_km_pre_god_dana, b.efektivna_voznja as efektivna_voznja_pre_god_dana
   from (
select  grupa, sum(coalesce(kilometraza, 0)) as ukupno_km, sum(coalesce (vozio, 0)) as efektivna_voznja
from analiza_voznji, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_voznji.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by  grupa
)a 
left join 
(
select  grupa,  sum(coalesce(kilometraza, 0)) as ukupno_km, sum(coalesce (vozio, 0)) as efektivna_voznja
from analiza_voznji, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_voznji.user_id = (select user_id from subuser where id = dat.subuser :: int)
group by  grupa
)b on  a.grupa = b.grupa 


-- Izvestaj o zadrzavanjima(ovde treba samo da se vrati jedan podatak a to je prosecno zadrzavanje za odredjeni datumski rang (avg(duzina_zadrzavanja))):

WITH dat ( date_from, date_to, user_id ) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

   select a.avg_zadrzavanja, b.avg_zadrzavanja as avg_zadrzavanja_pre_god_dana
   from (
select sum(coalesce(duzina_zadrzavanja, 0))/count (*) :: decimal (19,2) as avg_zadrzavanja, 1 as id
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_zadrzavanja.user_id = dat.user_id :: int
)a 
left join 
(
select sum(coalesce(duzina_zadrzavanja, 0))/count (*):: decimal (19,2) as avg_zadrzavanja, 1 as id
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_zadrzavanja.user_id = dat.user_id :: int
)b on a.id = b. id
--11.6
-----------------------------------------------------------
WITH dat ( date_from, date_to, subuser ) as (
   values ('2021-06-05', '2021-07-05', '1192')
   )

   select a.avg_zadrzavanja, b.avg_zadrzavanja as avg_zadrzavanja_pre_god_dana
   from (
select sum(coalesce(duzina_zadrzavanja, 0))/count (*) :: decimal (19,2) as avg_zadrzavanja, 1 as id
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date
and analiza_zadrzavanja.user_id = (select user_id from subuser where id = dat.subuser :: int)
)a 
left join 
(
select sum(coalesce(duzina_zadrzavanja, 0))/count (*):: decimal (19,2) as avg_zadrzavanja, 1 as id
from analiza_zadrzavanja, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_zadrzavanja.user_id = (select user_id from subuser where id = dat.subuser :: int)
)b on a.id = b. id


-- Izvestaj o prekoracenjima brzine(maknula sam par grupisanja, ovde isto stvar treba da se doda za user id-em):

WITH dat ( date_from, date_to, user_id) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

  select a.tip_prekoracenja, a.Broj_prekoracenja, b.broj_prekoracenja as broj_prekoracenja_pre_god_dana from (
SELECT 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end as tip_prekoracenja,
                                 count(*) as broj_prekoracenja
                                    
from analiza_prekoracenja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: DATE
and analiza_prekoracenja.user_id = dat.user_id :: int
group BY 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end 
order by 
case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end)a
left join 
(SELECT 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end as tip_prekoracenja,
                                 count(*) as broj_prekoracenja
                                    
from analiza_prekoracenja, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_prekoracenja.user_id = dat.user_id :: int
group BY 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end 
order by 
case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end)b
                                 on a.tip_prekoracenja = b.tip_prekoracenja

--                                 
---------------------------------------------
WITH dat ( date_from, date_to, subuser) as (
   values ('2021-06-05', '2021-07-05', '507')
   )

 select a.tip_prekoracenja, a.Broj_prekoracenja, b.broj_prekoracenja as broj_prekoracenja_pre_god_dana from ( 
SELECT 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end as tip_prekoracenja,
                                 count(*) as broj_prekoracenja
                                    
from analiza_prekoracenja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: DATE
and analiza_prekoracenja.user_id = (select user_id from subuser where id = dat.subuser :: int)
group BY 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end 
order by 
case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end)a
left join 
(
SELECT 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end as tip_prekoracenja,
                                 count(*) as broj_prekoracenja
                                    
from analiza_prekoracenja, dat
where dan > dat.date_from ::date - INTERVAL '1 year'
and dan < dat.date_to :: date - INTERVAL '1 year'
and analiza_prekoracenja.user_id = (select user_id from subuser where id = dat.subuser :: int)
group BY 

case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end 
order by 
case when brzina - dozvoljena_brzina <= 10 then '0-10'
                                 when brzina - dozvoljena_brzina > 10 and brzina - dozvoljena_brzina <=30 then '10-30'
                                 when brzina - dozvoljena_brzina > 30 and brzina - dozvoljena_brzina <=50 then '30-50'
                                 when brzina - dozvoljena_brzina > 50 then '50+' end) b
                                 on a.tip_prekoracenja = b.tip_prekoracenja


-- Top 10 prekoracenja(ovde sam smenila podatke za response u select-u, takogje treba da se doda user id stvar):
WITH dat ( date_from, date_to, user_id) as (
   values ('2021-06-05', '2021-07-05', '2677')
   )

  
select *, brzina - dozvoljena_brzina AS prekoracenje
from analiza_prekoracenja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date 
and analiza_prekoracenja.user_id = dat.user_id :: int
order by brzina - dozvoljena_brzina  desc limit 10 

----------------------------------------------------
WITH dat ( date_from, date_to, subuser) as (
   values ('2021-06-05', '2021-07-05', '507')
   )

  
select *, brzina - dozvoljena_brzina AS prekoracenje
from analiza_prekoracenja, dat
where dan > dat.date_from ::date
and dan < dat.date_to :: date 
and analiza_prekoracenja.user_id = (select user_id from subuser where id = dat.subuser :: int)
order by brzina - dozvoljena_brzina  desc limit 10 


