
with cont(country_id, comp_id) as
(
values (1,3)
)
select v.registration_number, v.free, v.company_id  from last_position lp 
join t_vehicle v on lp.unit_id = v.unit_id
join tr_country c on c.description = lp.drzava,
cont
where c.id = cont.country_id
and v.company_id = comp_id