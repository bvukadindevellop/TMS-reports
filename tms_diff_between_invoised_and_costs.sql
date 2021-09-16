-- Function: tms_diff_between_invoised_and_costs(integer)

--DROP FUNCTION tms_diff_between_invoised_and_costs(integer);

CREATE OR REPLACE FUNCTION tms_diff_between_invoised_and_costs(IN comp_id integer)
  RETURNS TABLE(mesec character varying, amount_in_eur numeric, amount_in_eur_one_year_before numeric) AS
$BODY$
begin

drop table if exists tmp10;
CREATE TEMPORARY TABLE tmp10(
   mesec varchar (15),
   amount_in_eur numeric (19,2),
   amount_in_eur_one_year_before numeric(19,2)
);
drop table if exists tmp11;
CREATE TEMPORARY TABLE tmp11(
   id integer,
   mesec varchar (15),
   amount_in_eur numeric (19,2),
   amount_in_eur_one_year_before numeric(19,2)
);
drop table if exists tmp12;
CREATE TEMPORARY TABLE tmp12(
   mesec varchar (15),
   amount_in_eur numeric (19,2),
   amount_in_eur_one_year_before numeric(19,2)
);

insert into tmp11
values (1, 'Januar', 0, 0),
       (2, 'Februar',0, 0),
       (3, 'Mart', 0, 0),
       (4, 'April',0, 0),
       (5, 'Maj', 0, 0),
       (6, 'Jun', 0, 0),
       (7, 'Jul', 0, 0),
       (8, 'Avgust', 0, 0),
       (9, 'Septembar', 0, 0),
       (10, 'Oktobar', 0, 0),
       (11, 'Novembar', 0, 0),
       (12, 'Decembar', 0, 0);

insert into tmp10
select * from tms_total_inovice_amount(comp_id);

insert into tmp12
select * from tms_costs_by_month_for_company(comp_id);


return query select tmp11.mesec:: varchar (15), 
sum(coalesce (tmp10.amount_in_eur, 0))::numeric(19,2) - sum(coalesce (tmp12.amount_in_eur, 0))::numeric(19,2) amount_in_eur, 
sum(coalesce (tmp10.amount_in_eur_one_year_before,0))::numeric(19,2) - sum(coalesce (tmp12.amount_in_eur_one_year_before,0))::numeric(19,2) amount_in_eur_one_year_before
from tmp11 full join tmp10 on tmp11.mesec = tmp10.mesec
full join tmp12 on tmp12.mesec = tmp10.mesec 
group by tmp11.mesec, tmp11.id
order by tmp11.id;


end;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION tms_diff_between_invoised_and_costs(integer)
  OWNER TO postgres;

--select * from tms_diff_between_invoised_and_costs(2)

--select * from tms_total_inovice_amount(2)

--select * from tms_costs_by_month_for_company (2);