--2396
WIth us (user_id) as (
   VALUES ('3869')
   )
select groups.name AS grupa,  unit.reg_broj, unit.model_vozila, unit.marka_vozila, unit.vrsta_vozila 
from group_units 
join unit on group_units.unit_id = unit.id
join groups on groups.id = group_units.group_id
join us on us.user_id ::int = groups.user_id ::int
order by groups.name, group_units.unit_id


WIth us (subuser) as (
   values ('1030')
   )
select groups.name AS grupa,  unit.reg_broj, unit.model_vozila, unit.marka_vozila, unit.vrsta_vozila 
from group_units 
join unit on group_units.unit_id = unit.id
join groups on groups.id = group_units.group_id
join subuser on subuser.user_id = unit.user_id
--join us on us.user_id ::int = groups.user_id ::int
join us on subuser.id :: int= us.subuser ::int
--where group_units.user_id = (select user_id from subuser where id = us.subuser :: int)
order by groups.name, subuser.id 

--2396
WIth us (user_id) as (
   values ('2376')
   )
select distinct subuser.username as subuser_username, group_units.unit_id,unit.reg_broj,  unit.model_vozila, unit.marka_vozila, unit.vrsta_vozila 
from group_units 
join unit on group_units.unit_id = unit.id
join groups on groups.id = group_units.group_id
join us on us.user_id ::int = groups.user_id ::int
join subuser on subuser.user_id = groups.user_id 
where unit.id = group_units.unit_id --:: int   
order by subuser.username, group_units.unit_id, unit.reg_broj
--where unit.id = group_units.unit_id --:: int
