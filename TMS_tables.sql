alter table subuser
add company_id int

drop SEQUENCE  history_seq
CREATE SEQUENCE history_seq start 1;
--drop table t_history
create table t_history
(id integer NOT NULL DEFAULT nextval('history_seq'::regclass) primary key,
 date timestamp default null, 
 category_id int not null,
 sub_category_id int not null,
 old_value varchar (100) null,
 new_value varchar (100) null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null
)

--drop table t_currency_exchange_code
create table t_currency_exchange_code
(id integer NOT NULL primary key,
currency_code_alfa char (3) not null,
currency_name varchar (64) null,
country_name varchar (64) null );

insert into t_currency_exchange_code
(id, currency_code_alfa, currency_name, country_name)
select currency_code::integer, currency_code_alfa_char,currency_name_ser_lat, country_name_ser_lat from current_exchange_rates



drop SEQUENCE  company_seq;
CREATE SEQUENCE company_seq start 1;

-- drop table t_company
create table t_company
(id integer NOT NULL DEFAULT nextval(('public.company_seq'::text)::regclass) primary key,
 company_name varchar (100) null,
 address varchar (100) null,
 city varchar(50) null,
 postal_code varchar (10) null,
 state varchar(30) null,
 country varchar (30) null,
 -- company_type int not null, --this needs to be added additionally
 PIB bigint null,
 MB int null,
 LOGO varchar null, 
 CEO varchar (50) null,
 email varchar (80) null,
 phone_number varchar (20) null,
 web_site varchar (80) null,
 current_account varchar(100) null,
 banka varchar (100) null,
 SWIFT varchar (10) null,
 IBAN varchar (10) null,
 active boolean default 'T',
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null
  CONSTRAINT fk_country_id
      FOREIGN KEY(country_id) 
	  REFERENCES tr_country(id)
);
ALTER TABLE t_company ALTER COLUMN inactive SET DEFAULT 'N' ;
ALTER TABLE t_company ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_company ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
----------------------------------------------------------------------

drop SEQUENCE  driver_seq;
CREATE SEQUENCE driver_seq start 1;

select * from t_driver
-- drop table t_driver
create table t_driver 
(id integer NOT NULLDEFAULT nextval(('public.driver_seq'::text)::regclass) primary key,
 company_id int not null, 
 first_name varchar (50) null,
 middle_name varchar(20) null,
 last_name varchar (50) null,
 ID_number varchar (20) null,
 address varchar (100) null,
 city varchar(50) null,
 postal_code varchar (10) null,
 state varchar(30) null,
 country varchar (30) null,
 mobile_phone_1 varchar(20) nll,
 mobile_phone_2 varchar(20) null,
 email varchar (80) null,
 date_of_birth date null,
 contract_date date null,
 licence varchar (30) null, --- ????
 active boolean default 'T',
 free boolean default 'T',
 end_date_of_absence date null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_company_id
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);
ALTER TABLE t_driver ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_driver ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-----------------------------------------------------------------
drop SEQUENCE  vehicle_seq;
CREATE SEQUENCE vehicle_seq start 100000;

-- drop table t_vehicle
create table t_vehicle
(id integer NOT NULL DEFAULT nextval(('public.vehicle_seq'::text)::regclass) primary key,
 unit_id character varying null,
 company_id int not null, 
 make varchar (50), --marka
 model varchar (50), -- model
 registration_number varchar (20), -- registrarski broj 
 engine_serial_number varchar(20), -- broj motora 
 engine_volume varchar (20), -- zapremina motora
 engine_capacity varchar (20), -- snaga motora
 emission_norms varchar (20), --emisiona klasa
 vehicle_type varchar(20), -- tip vozila
 chassis_number varchar (40),-- broj sasije
 fuel varchar (20), -- gorivo 
 color varchar (20), --boja
 seat_number int,-- broj sedista
 maximum_capacity int,-- broj mesta za stajanje
 weight int, -- masa
 max_weight int, --maksimalna masa
 max_load float, -- maksimalana teret
 year_of_production int, -- datum proizvodnje
 milage int, -- kilometraza
 category varchar (20), -- kategorija
 certificate varchar (20), --sertifikat
 valid_to date, --validan do 
 invalid_until date, -- nevalidan do 
 additionally varchar (100), -- nadgradnja
 leasing_expiration_date date, -- lizing zakup do,
 history char (3), -- istorija 
 active boolean default 'T',
 free boolean default 'T',
 end_date_of_absence date null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_unit
      FOREIGN KEY(unit_id) 
	  REFERENCES unit(id),
 CONSTRAINT fk_company_id
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);

ALTER TABLE t_vehicle ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_vehicle ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
---------------------------------------------------------------------

drop SEQUENCE  trailer_seq;
CREATE SEQUENCE trailer_seq start 200000;

-- drop table t_trailer
create table t_trailer
(id integer NOT NULL DEFAULT nextval(('public.trailer_seq'::text)::regclass) primary key,
 unit_id character varying null,
 company_id int not null, 
 make varchar (50), --marka
 model varchar (50), -- model
 registration_number varchar (20), -- registrarski broj 
 emission_norms varchar (20), --emisiona klasa
 trailer_type varchar(20), -- tip vozila
 chassis_number varchar (40),-- broj sasije
 color varchar (20), --boja
 maximum_capacity int,-- broj mesta za stajanje
 weight int, -- masa
 max_weight int, --maksimalna masa
 max_load float, -- maksimalana teret
 year_of_production int, -- datum proizvodnje
 milage int, -- kilometraza
 category varchar (20), -- kategorija
 certificate varchar (20), --sertifikat
 valid_to date, --validan do 
 invalid_until date, -- nevalidan do 
 additionally varchar (100), -- nadgradnja
 leasing_expiration_date date, -- lizing zakup do,
 history char (3), -- istorija 
 active boolean default 'T',
 free boolean default 'T', 
 end_date_of_absence date null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_unit
      FOREIGN KEY(unit_id) 
	  REFERENCES unit(id),
 CONSTRAINT fk_company_id
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);

ALTER TABLE t_trailer ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_trailer ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
------------------------------------------------------------------------

drop SEQUENCE  doc_veh_seq;
CREATE SEQUENCE doc_veh_seq start 1;

-- drop table t_document_vehicle
Create table t_document_vehicle
( id integer NOT NULL DEFAULT nextval(('public.doc_veh_seq'::text)::regclass) primary key,
document_name varchar (100) null,
company_id int not null,
created_by char (10) null ,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);
ALTER TABLE t_document_vehicle ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_document_vehicle ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-----------------------------------------------------------------------------------

drop SEQUENCE  doc_tra_seq;
CREATE SEQUENCE doc_tra_seq start 1;

-- drop table t_document_trailer
Create table t_document_trailer
( id integer NOT NULL DEFAULT nextval(('public.doc_tra_seq'::text)::regclass) primary key,
document_name varchar (100) null,
company_id int not null,
created_by char (10) null ,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);
ALTER TABLE t_document_trailer ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_document_trailer ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-----------------------------------------------------------------------------------

drop SEQUENCE  doc_driver_seq;
CREATE SEQUENCE doc_driver_seq start 1;

-- drop table t_document_driver
Create table t_document_driver
(id integer NOT NULL DEFAULT nextval(('public.doc_driver_seq'::text)::regclass) primary key,
document_name varchar (100) null,
company_id int not null,
created_by char (10) null ,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);
ALTER TABLE t_document_driver ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_document_driver ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-----------------------------------------------------------------------------------

drop SEQUENCE  service_item_seq;
CREATE SEQUENCE service_item_seq start 1;

create table tr_service_item
(id integer NOT NULL DEFAULT nextval(('public.service_item_seq'::text)::regclass) primary key,
 category varchar (100) null, --  pretpostavljam da se ovde unosi opisno da li je antifriz, ulje ....
 name_of_producer varchar (50) null,
 mileage int null,
 interval_in_months int not null,
 company_id int not null,
 is_default boolean null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
	  );
ALTER TABLE tr_service_item ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tr_service_item ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
--------------------------------------------------------------------------------------------

drop SEQUENCE  service_cat_seq;
CREATE SEQUENCE service_cat_seq start 1;

create table tr_emergency_service_category
(id integer NOT NULL DEFAULT nextval(('public.service_cat_seq'::text)::regclass) primary key,
 category_name varchar (100) null, 
 mileage int null,
 interval int not null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null
	  );
ALTER TABLE tr_emergency_service_category ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tr_emergency_service_category ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
---------------------------------------------------------------------------------------------

drop SEQUENCE  service_comp_seq;
CREATE SEQUENCE service_comp_seq start 1;

create table t_service_company
(id integer NOT NULL DEFAULT nextval(('public.service_comp_seq'::text)::regclass) primary key,
 name varchar (50) null,
 address varchar (100) null,
 city varchar(50) null,
 postal_code varchar (10) null,
 state varchar(30) null,
 country_id int null,
 PIB bigint null,
 MB int null,
 email varchar (80) null,
 phone_number varchar (20) null,
 web_site varchar (80) null,
 company_id int not null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id),	  
 CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
	  REFERENCES tr_country(id)
	  );
ALTER TABLE t_service_company ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_service_company ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
---------------------------------------------------------------------------------
drop SEQUENCE  service_seq;
CREATE SEQUENCE service_seq start 1;

-- drop table t_service;
create table t_service 
(id integer NOT NULL DEFAULT nextval(('public.service_seq'::text)::regclass) primary key,
 vehicle_id int null,
 trailer_id int null,
 date_of_service date not null,
 amount numeric (19,2) null, 
 currency_id int null,
 amount_in_eur numeric (19,2) null, 
 local_amount_currency numeric (19,2) null,
 note varchar (255),
 service_type int not null,
 date_of_next_service timestamp default null,
 milage integer default null,
 next_milage integer default null,
 service_company_id int null,
 warranty timestamp default null,
 is_changed_antifreeze boolean null,
 antifreeze_service_item_id int null,
 is_changed_ad_blue boolean null, 
 ad_blue_service_item_id int null, 
 is_changed_motor_oil boolean null,
 motor_oil_service_item_id int null, 
 is_changed_break_pads_oil boolean null,
 break_pads_oil_service_item_id int null, 
 is_changed_transmission_fluid boolean null, 
 transmission_fluid_service_item_id int null,
 is_changed_differential_oil boolean null,  
 differential_oil_service_item_id int null,
 is_changed_oil_filter boolean null,
 oil_filter_service_item_id int null,
 is_changed_fuel_filter boolean null,
 fuel_filter_service_item_id int,
 is_changed_air_filter boolean null,
 air_filter_service_item_id int null, 
 is_changed_air_cabin_filter boolean null,
 air_cabin_filter_service_item_id int null,
 is_changed_engine_belt boolean null,
 engine_belt_service_item_id int null, 
 is_changed_air_condition_belt boolean null,
 air_condition_belt_service_item_id int null,
 is_changed_break_pad boolean null,
 break_pad_service_item_id int null,
 is_changed_break_disk boolean null,
 break_disk_service_item_id int null, 
 is_changed_pipe boolean null, --- ????
 pipe_service_item_id int null,
 is_changed_lamella_and_basket boolean null,
 lamella_basket_service_item_id int null, 
 is_changed_car_differential_system boolean null,
 car_differential_system_service_item_id int null,
 next_service_in_days int null,
 next_service_in_km int null,
 category_of_emergency_service_id int,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_vehicle
      FOREIGN KEY(vehicle_id) 
	  REFERENCES t_vehicle(id),
 CONSTRAINT fk_trailer
      FOREIGN KEY(trailer_id) 
	  REFERENCES t_trailer(id),	  
CONSTRAINT fk_antifreeze_service_item_id
      FOREIGN KEY(antifreeze_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_ad_blue_service_item_id
      FOREIGN KEY(ad_blue_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_motor_oil_service_item_id
      FOREIGN KEY(motor_oil_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_break_pads_oil_service_item_id
      FOREIGN KEY(break_pads_oil_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_transmission_fluid_service_item_id
      FOREIGN KEY(transmission_fluid_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_differential_oil_service_item_id
      FOREIGN KEY(differential_oil_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_oil_filter_service_item_id
      FOREIGN KEY(oil_filter_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_fuel_filter_service_item_id
      FOREIGN KEY(fuel_filter_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_air_filter_service_item_id
      FOREIGN KEY(air_filter_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_air_cabin_filter_service_item_id
      FOREIGN KEY(air_cabin_filter_service_item_id) 
	  REFERENCES tr_service_item(id),
 CONSTRAINT fk_engine_belt_service_item_id
      FOREIGN KEY(engine_belt_service_item_id) 
	  REFERENCES tr_service_item(id),
 CONSTRAINT fk_air_condition_belt_service_item_id
      FOREIGN KEY(air_condition_belt_service_item_id) 
	  REFERENCES tr_service_item(id),
 CONSTRAINT fk_break_pad_service_item_id
      FOREIGN KEY(break_pad_service_item_id) 
	  REFERENCES tr_service_item(id),
 CONSTRAINT fk_break_disk_service_item_id
      FOREIGN KEY(break_disk_service_item_id) 
	  REFERENCES tr_service_item(id),
 CONSTRAINT fk_pipe_service_item_id
      FOREIGN KEY(pipe_service_item_id) 
	  REFERENCES tr_service_item(id),
 CONSTRAINT fk_lamella_basket_service_item_id
      FOREIGN KEY(lamella_basket_service_item_id) 
	  REFERENCES tr_service_item(id),
 CONSTRAINT fk_car_differential_system_service_item_id
      FOREIGN KEY(car_differential_system_service_item_id) 
	  REFERENCES tr_service_item(id),
CONSTRAINT fk_category_of_emergency_service_id
      FOREIGN KEY(category_of_emergency_service_id) 
	  REFERENCES tr_emergency_service_category(id),
CONSTRAINT fk_service_company_id
      FOREIGN KEY(service_company_id) 
	  REFERENCES t_service_company(id)	  
	  );
ALTER TABLE t_service ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_service ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

------------ TRIGGER 1 --------------------------------
 CREATE OR REPLACE FUNCTION service_insert1() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.amount_in_eur = NEW.amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.amount_in_eur = NEW.amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_service))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_service))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER service_insert1 BEFORE INSERT OR UPDATE ON t_service FOR 
 EACH ROW EXECUTE PROCEDURE service_insert1();

------------ TRIGGER 2 --------------------------------
 CREATE OR REPLACE FUNCTION service_insert2() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_amount_currency = NEW.amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_service))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_amount_currency = NEW.amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.date_of_service))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_service)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_service)) ::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER service_insert2 BEFORE INSERT OR UPDATE ON t_service FOR 
 EACH ROW EXECUTE PROCEDURE service_insert2();
 ------------------------------------------------------------
drop SEQUENCE  damage_seq;
CREATE SEQUENCE damage_seq start 1;

-- drop table t_damage;
create table t_damage
(id integer NOT NULL DEFAULT nextval(('public.damage_seq'::text)::regclass) primary key,
 vehicle_id int null,
 trailer_id int null,
 date_of_damage date not null,
 amount numeric (19,2) null, 
 currency_id int null,
 amount_in_eur numeric (19,2) null, 
 local_amount_currency numeric (19,2) null,
 damage_status varchar(10) null, 
 damage_type varchar (30) null,
 insurance_type varchar(30) null,
 place varchar(30) null,
 registration_status varchar(20) null,
 registration_date timestamp null,
 amount_paid numeric(19,2) null,
 currency_id_paid int null,
 amount_in_eur_paid numeric(19,2) null,
 local_amount_currency_paid numeric(19,2),
 payout_type varchar(30) null,
 payout_status varchar (20) null,
 service_company_id int null,
 note varchar(255) null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
CONSTRAINT fk_vehicle
      FOREIGN KEY(vehicle_id) 
	  REFERENCES t_vehicle(id),
CONSTRAINT fk_trailer
      FOREIGN KEY(trailer_id) 
	  REFERENCES t_trailer(id),
CONSTRAINT fk_service_company_id
      FOREIGN KEY(service_company_id) 
	  REFERENCES t_service_company(id)
);
ALTER TABLE t_damage ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_damage ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

------------ TRIGGER 1 --------------------------------
 CREATE OR REPLACE FUNCTION damage_insert1() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.amount_in_eur = NEW.amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.amount_in_eur = NEW.amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_damage))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER damage_insert1 BEFORE INSERT OR UPDATE ON t_damage FOR 
 EACH ROW EXECUTE PROCEDURE damage_insert1();

------------ TRIGGER 2 --------------------------------
 CREATE OR REPLACE FUNCTION damage_insert2() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_amount_currency = NEW.amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_amount_currency = NEW.amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER damage_insert2 BEFORE INSERT OR UPDATE ON t_damage FOR 
 EACH ROW EXECUTE PROCEDURE damage_insert2();
 
------------ TRIGGER 3 --------------------------------
 CREATE OR REPLACE FUNCTION damage_insert3() RETURNS trigger AS '
       BEGIN
IF NEW.currency_id_paid = 978 THEN NEW.amount_in_eur_paid = NEW.amount_paid;				   
     END IF;
IF NEW.currency_id_paid = 1 THEN NEW.amount_in_eur_paid = NEW.amount_paid/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::integer;
     END IF;
IF NEW.currency_id_paid = 36 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 124 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 156 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 191 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 203 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 208 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 348 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_damage))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 392 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 414 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 578 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 643 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 752 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 756 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 826 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 840 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 933 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 946 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 949 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 975 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 977 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 985 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 40 THEN NEW.amount_in_eur_paid = NEW.amount_paid *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 56 THEN NEW.amount_in_eur_paid = NEW.amount_paid *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 246 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 250 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 280 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 300 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 372 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 380 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 442 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 620 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 724 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 960 THEN NEW.amount_in_eur_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_damage))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER damage_insert3 BEFORE INSERT OR UPDATE ON t_damage FOR 
 EACH ROW EXECUTE PROCEDURE damage_insert3();
 
 ------------ TRIGGER 4 --------------------------------
 CREATE OR REPLACE FUNCTION damage_insert4() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id_paid = 978 THEN new.local_amount_currency_paid = NEW.amount_paid*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_damage))::numeric;				   
     END IF;
IF NEW.currency_id_paid = 1 THEN new.local_amount_currency_paid = NEW.amount_paid :: numeric;
     END IF;
IF NEW.currency_id_paid = 36 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 124 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 156 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 191 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 203 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 208 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 348 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 392 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 414 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 578 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 643 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 752 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 756 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 826 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 840 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 933 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 946 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 949 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 975 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 977 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 985 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 40 THEN new.local_amount_currency_paid = NEW.amount_paid *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.date_of_damage))::numeric;
     END IF;
IF NEW.currency_id_paid = 56 THEN new.local_amount_currency_paid = NEW.amount_paid *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 246 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 250 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 280 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 300 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 372 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 380 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 442 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 620 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 724 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
IF NEW.currency_id_paid = 960 THEN new.local_amount_currency_paid = NEW.amount_paid * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_damage)) ::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER damage_insert4 BEFORE INSERT OR UPDATE ON t_damage FOR 
 EACH ROW EXECUTE PROCEDURE damage_insert4();

--------------------------------------------------------------------------

SELECT nextval('vehicle_doc_id_seq');
-- drop table tx_vehicle_document_vehicle
create table tx_vehicle_document_vehicle
(id integer NOT NULL  DEFAULT nextval(('public.vehicle_doc_id_seq'::text)::regclass) primary key,
 vehicle_id int,
 document_vehicle_id int not null,
 start_date date,
 exp_date date,
 document_number varchar (20),
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_vehicle
      FOREIGN KEY(vehicle_id) 
	  REFERENCES t_vehicle(id),
 CONSTRAINT fk_document_vehicle_id
      FOREIGN KEY(document_vehicle_id) 
	  REFERENCES t_document_vehicle(id)
);
ALTER TABLE tx_vehicle_document_vehicle ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tx_vehicle_document_vehicle ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
--------------------------------------------------------------------------------

drop SEQUENCE  trailer_doc_id_seq;
CREATE SEQUENCE trailer_doc_id_seq start 1;

SELECT nextval('trailer_doc_id_seq');
-- drop table tx_trailer_document_trailer
create table tx_trailer_document_trailer
(id integer NOT NULL  DEFAULT nextval(('public.trailer_doc_id_seq'::text)::regclass) primary key,
 trailer_id int,
 document_trailer_id int not null,
 start_date date,
 exp_date date,
 document_number varchar (20),
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_trailer
      FOREIGN KEY(trailer_id) 
	  REFERENCES t_trailer(id),
 CONSTRAINT fk_document_trailer_id
      FOREIGN KEY(document_trailer_id) 
	  REFERENCES t_document_trailer(id)
);
ALTER TABLE tx_trailer_document_trailer ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tx_trailer_document_trailer ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-----------------------------------------------------------------------------------------------

drop SEQUENCE  driver_doc_id_seq;
CREATE SEQUENCE driver_doc_id_seq start 1

ALTER TABLE t_document_vehicle ALTER COLUMN id SET DEFAULT nextval(('public.doc_veh_seq'::text)::regclass);

-- drop table tx_driver_document_driver
Create table tx_driver_document_driver
(id integer NOT NULL DEFAULT nextval(('public.driver_doc_id_seq'::text)::regclass) primary key,
document_number varchar (30) null,
start_date timestamp default null,
exp_date timestamp default null,
driver_id int not null,
document_driver_id int not null,
created_by char (10) null ,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  CONSTRAINT fk_driver
      FOREIGN KEY(driver_id) 
	  REFERENCES t_driver(id),
 CONSTRAINT fk_document_diver_id
      FOREIGN KEY(document_driver_id) 
	  REFERENCES t_document_driver(id)
);
ALTER TABLE tx_driver_document_driver ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tx_driver_document_driver ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
------------------------------------------------------------------------------------------

drop SEQUENCE  country_seq;
CREATE SEQUENCE country_seq start 1;

create table tr_country
(id integer NOT NULL DEFAULT nextval('country_seq'::regclass) primary key,
 description varchar (100) default null, 
 short_desc char (3),
 local_currency char (3),
 alternative_currency char (3),
 language varchar (20),
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null
);
ALTER TABLE tr_country ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tr_country ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
--------------------------------------------------

drop SEQUENCE  absence_t_seq;
CREATE SEQUENCE absence_t_seq start 1;

create table tr_absence_type
(id integer NOT NULL DEFAULT nextval('absence_t_seq'::regclass) primary key,
 description varchar (100) default null, 
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null
) ;

ALTER TABLE tr_absence_type ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tr_absence_type ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
------------------------------------------------

drop SEQUENCE  absence_seq;
CREATE SEQUENCE absence_seq start 1;

--drop table t_absence
create table t_absence
(id integer NOT NULL DEFAULT nextval('absence_seq'::regclass) primary key,
 absence_type_id int,
 absence_start_date timestamp default null,
 absence_end_date timestamp default null, 
 document_date date null, 
 driver_id int,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_driver
      FOREIGN KEY(driver_id) 
	  REFERENCES t_driver(id),
 CONSTRAINT fk_absence_type
      FOREIGN KEY(absence_type_id) 
	  REFERENCES tr_absence_type(id)
) ;

ALTER TABLE t_absence ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_absence ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
------------------------------------------------------------

drop SEQUENCE  ticket_t_seq;
CREATE SEQUENCE ticket_t_seq start 1;

-- drop table tr_ticket_type
create table tr_ticket_type
(id integer NOT NULL DEFAULT nextval('ticket_t_seq'::regclass) primary key,
 description varchar (100) default null, 
 company_id int null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
   CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
) ;

ALTER TABLE tr_ticket_type ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE tr_ticket_type ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
----------------------------------------
DROP SEQUENCE t_ticket_seq;
CREATE SEQUENCE t_ticket_seq start 1;

-- drop table t_ticket;
create table t_ticket
(id integer NOT NULL DEFAULT nextval('t_ticket_seq'::regclass) primary key,
 ticket_type_id int,
 ticket_date date not null,
 amount numeric (19,2) null, 
 currency_id int null,
 amount_in_eur numeric (19,2) null, 
 local_amount_currency numeric (19,2) null,
 ticket_place varchar (100) null,
 driver_id int,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_driver
      FOREIGN KEY(driver_id) 
	  REFERENCES t_driver(id),
 CONSTRAINT fk_ticket_type
      FOREIGN KEY(ticket_type_id) 
	  REFERENCES tr_ticket_type(id)
);

ALTER TABLE t_absence ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_absence ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

------------ TRIGGER 1 --------------------------------
 CREATE OR REPLACE FUNCTION ticket_insert1() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.amount_in_eur = NEW.amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.amount_in_eur = NEW.amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.ticket_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.ticket_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER ticket_insert1 BEFORE INSERT OR UPDATE ON t_ticket FOR 
 EACH ROW EXECUTE PROCEDURE ticket_insert1();

------------ TRIGGER 2 --------------------------------
 CREATE OR REPLACE FUNCTION ticket_insert2() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_amount_currency = NEW.amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.ticket_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_amount_currency = NEW.amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.ticket_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.ticket_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.ticket_date)) ::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER ticket_insert2 BEFORE INSERT OR UPDATE ON t_ticket FOR 
 EACH ROW EXECUTE PROCEDURE ticket_insert2();
-------------------------------------------------
drop sequence client_seq;
CREATE SEQUENCE client_seq start 1;
 
create table t_client
(id integer NOT NULL DEFAULT nextval(('public.client_seq'::text)::regclass) primary key,
name varchar (150) null,
contact_person varchar(150) null,
address varchar (100) null,
city varchar(50) null,
postal_code varchar (10) null,
state varchar(30) null,
country_id int null,
PIB bigint null,
MB int null,
email varchar (80) null,
phone_number varchar (20) null,
web_site varchar (80) null,
company_id int not null,
payment_deadline integer null, 
active boolean default 'T',
created_by char (10) null,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
        REFERENCES t_company(id),     
 CONSTRAINT fk_country
      FOREIGN KEY(country_id) 
        REFERENCES tr_country(id)
        );

ALTER TABLE t_client  ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_client ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
------------------------------------------------------------------
DROP  SEQUENCE working_order_seq ;
CREATE SEQUENCE working_order_seq start 1;

--drop table t_working_order

create table t_working_order
(id integer NOT NULL DEFAULT nextval(('public. working_order_seq'::text)::regclass) primary key,
company_id int not null,
number int not null,
driver_id int not null,
vehicle_id int not null,
trailer_id int null,
advance_payment numeric(19,2) null,
advance_payment_eur numeric (19,2) null,
is_submitted boolean null default false
created_by char (10) null,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  CONSTRAINT fk_vehicle
      FOREIGN KEY(vehicle_id) 
        REFERENCES t_vehicle(id),
CONSTRAINT fk_trailer
      FOREIGN KEY(trailer_id) 
        REFERENCES t_trailer(id),
CONSTRAINT fk_driver
      FOREIGN KEY(driver_id) 
        REFERENCES t_driver (id),
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
        REFERENCES t_company(id)
        );
ALTER TABLE t_working_order ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_working_order ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

CREATE OR REPLACE FUNCTION function_wo_number() RETURNS trigger AS '
     BEGIN
    
   
   new.number = coalesce((select max(number) + 1 from t_working_order 
   where t_working_order.company_id = new.company_id), 10001);
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER function_wo_number BEFORE INSERT ON t_working_order FOR 
 EACH ROW EXECUTE PROCEDURE function_wo_number();

-----------------------------------------------------------

DROP SEQUENCE route_seq;
CREATE SEQUENCE route_seq start 1;

-- drop table t_route;
create table t_route
(id integer NOT NULL DEFAULT nextval(('public.route_seq'::text)::regclass) primary key,
working_order_id int not null,
client_id int not null,
service_name varchar (50)null,
loading_address varchar (100) null,
loading_city varchar(50) null,
loading_country_id int null,
unloading_address varchar (100) null,
unloading_city varchar(50) null, 
unloading_country_id int null,
import_customs varchar (100) null,
export_customs varchar (100) null,
loading_date date null,
unloading_date date null,
mileage int null,
load_type varchar(50) null,
palette_number int null,
weight int null,
measure_unit varchar(50) null,
quantity int null,
amount numeric (19,2) null, 
currency_id int null,
amount_in_eur numeric (19,2) null, 
local_amount_currency numeric (19,2) null,
unit_price int null,
loading_order_number int null,
has_invoice boolean default 'F',
created_by char (10) null,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  
CONSTRAINT fk_working_order
      FOREIGN KEY(working_order_id) 
        REFERENCES t_working_order(id),
CONSTRAINT fk_client
      FOREIGN KEY(client_id) 
        REFERENCES t_client(id) ,     
 CONSTRAINT fk_country_loading
      FOREIGN KEY(loading_country_id) 
        REFERENCES tr_country(id) ,   
 CONSTRAINT fk_country_unloading
      FOREIGN KEY(unloading_country_id) 
        REFERENCES tr_country(id)
        );

ALTER TABLE t_route ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_route ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

------------ TRIGGER 1 --------------------------------
 CREATE OR REPLACE FUNCTION route_insert1() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.amount_in_eur = NEW.amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.amount_in_eur = NEW.amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.loading_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.loading_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER route_insert1 BEFORE INSERT OR UPDATE ON t_route FOR 
 EACH ROW EXECUTE PROCEDURE route_insert1();

------------ TRIGGER 2 --------------------------------
 CREATE OR REPLACE FUNCTION route_insert2() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_amount_currency = NEW.amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.loading_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_amount_currency = NEW.amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.loading_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.loading_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.loading_date)) ::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER route_insert2 BEFORE INSERT OR UPDATE ON t_route FOR 
 EACH ROW EXECUTE PROCEDURE route_insert2();


---------------------------------------------
DROP SEQUENCE cost_type_seq;
CREATE SEQUENCE cost_type_seq start 1;

create table tr_cost_type
(id integer NOT NULL DEFAULT nextval(('public.cost_type_seq'::text)::regclass) primary key,
 name varchar (100) not null,
 quantity boolean,
 company_id int not null, 
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
        REFERENCES t_company(id)
 )

--------------------------------------------------

DROP  SEQUENCE cost_seq;
CREATE SEQUENCE cost_seq start 1;

--drop table t_cost;
create table t_cost 
(id integer NOT NULL DEFAULT nextval(('public.cost_seq'::text)::regclass) primary key,
 date_of_cost date not null,
 cost_type_id int not null,
 company_id int not null,
 amount numeric (19,2) null, 
 currency_id int null,
 amount_in_eur numeric (19,2) null, 
 local_amount_currency numeric (19,2) null,
 working_order_id int null, 
 driver_id int null,
 vehicle_id int null,
 trailer_id int null, 
 is_client_cost boolean null,
 route_id int null,
 xendle_document_id int,
 quantity bigint null,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
  CONSTRAINT fk_company
      FOREIGN KEY(company_id) 
        REFERENCES t_company(id),
  CONSTRAINT fk_driver
      FOREIGN KEY(driver_id) 
        REFERENCES t_driver(id),
  CONSTRAINT fk_vehicle
      FOREIGN KEY(vehicle_id) 
        REFERENCES t_vehicle(id),
  CONSTRAINT fk_trailer
      FOREIGN KEY(trailer_id) 
        REFERENCES t_trailer(id),
  CONSTRAINT fk_working_order
      FOREIGN KEY(working_order_id) 
        REFERENCES t_working_order(id),
  CONSTRAINT fk_cost_type
      FOREIGN KEY(cost_type_id) 
        REFERENCES tr_cost_type(id),
   CONSTRAINT fk_currency_exchange_code
      FOREIGN KEY(currency_id) 
        REFERENCES t_currency_exchange_code(id),   
   CONSTRAINT fk_route
      FOREIGN KEY(route_id) 
        REFERENCES t_route(id)     
 );

ALTER TABLE t_cost ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_cost ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

 ------------ TRIGGER 1 --------------------------------
 CREATE OR REPLACE FUNCTION cost_insert() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.amount_in_eur = NEW.amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.amount_in_eur = NEW.amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_cost))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_cost))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER cost_insert BEFORE INSERT OR UPDATE ON t_cost FOR 
 EACH ROW EXECUTE PROCEDURE cost_insert();

------------ TRIGGER 2 --------------------------------
 CREATE OR REPLACE FUNCTION cost_insert2() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_amount_currency = NEW.amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.date_of_cost))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_amount_currency = NEW.amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.date_of_cost))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_amount_currency = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_amount_currency = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.date_of_cost)) ::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER cost_insert2 BEFORE INSERT OR UPDATE ON t_cost FOR 
 EACH ROW EXECUTE PROCEDURE cost_insert2();

-----------------------------------------------
DROP SEQUENCE employee_seq;
CREATE SEQUENCE employee_seq start 1;

create table t_employee
(id integer NOT NULL DEFAULT nextval(('public.employee_seq'::text)::regclass) primary key,
 company_id int not null, 
 first_name varchar (50) null,
 middle_name varchar(20) null,
 last_name varchar (50) null,
 ID_number varchar (20) null,
 address varchar (100) null,
 city varchar(50) null,
 postal_code varchar (10) null,
 state varchar(30) null,
 country varchar (30) null,
 mobile_phone_1 varchar(20),
 mobile_phone_2 varchar(20),
 email varchar (80) null, 
 date_of_birth date null,
 active boolean default 'T',
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_company_id
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);
ALTER TABLE t_employee ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_employee ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-----------------------------------------------------------------------------------
DROP SEQUENCE invoice_seq;
CREATE SEQUENCE invoice_seq start 1;


drop table t_invoice;
create table t_invoice
(id integer NOT NULL DEFAULT nextval(('public.invoice_seq'::text)::regclass) primary key, 
number bigint not null,
invoice_date date not null,
payment_currency date null, 
unloading_date date null,
service_description varchar (100) null,
loading_city varchar (50) null,
loading_country_id int null, 
unloading_city varchar (50) null,
unloading_country_id int null, 
unit_measure varchar (50) null,  
quantity int null,
bank_account varchar (30) null,
invoiced_by varchar (30) null,
note varchar (100) null,
sent boolean, 
sent_date date null, 
paid_amount numeric (19,2) null,
payment_date date null, 
client_id int null,
company_id int null, 
working_order_id int null,
spelled_out_invoice_amount varchar (100) null,
loading_date date null,
currency_id int not null,
route_id int null, 
vehicle varchar null,

amount numeric (19,2) null,
unit_price numeric (19,2) null,
discount_percentage numeric (19,2) null,
discount_amount numeric (19,2) null,
tax_percentage numeric (19,2) null,
tax_amount numeric (19,2) null,
amount_without_tax numeric (19,2) null,
total_amount numeric (19,2) null,
total_amount_with_tax numeric (19,2) null,

local_amount numeric (19,2) null,
local_unit_price numeric (19,2) null,
local_discount_amount numeric (19,2) null,
local_tax_amount numeric (19,2) null,
local_amount_without_tax numeric (19,2) null,
local_total_amount numeric (19,2) null,
local_total_amount_with_tax numeric (19,2) null,

amount_in_eur numeric (19,2) null,
unit_price_in_eur numeric (19,2) null,
discount_amount_in_eur numeric (19,2) null,
tax_amount_in_eur numeric (19,2) null,
amount_without_tax_in_eur numeric (19,2) null,
total_amount_in_eur numeric (19,2) null,
total_amount_with_tax_in_eur numeric (19,2) null,

created_by char (10) null,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
 CONSTRAINT fk_company_id
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id),
 CONSTRAINT fk_working_order_id
      FOREIGN KEY(working_order_id) 
	  REFERENCES t_working_order(id),
 CONSTRAINT fk_currency_exchange_code
      FOREIGN KEY(currency_id) 
        REFERENCES t_currency_exchange_code(id),
  CONSTRAINT fk_route
      FOREIGN KEY(route_id) 
        REFERENCES t_route(id),
  CONSTRAINT fk_client_id
      FOREIGN KEY(client_id) 
	  REFERENCES t_client(id),
  CONSTRAINT fk_loading_country_id
      FOREIGN KEY(loading_country_id) 
	  REFERENCES tr_country(id),
  CONSTRAINT fk_unloading_country_id
      FOREIGN KEY(unloading_country_id) 
	  REFERENCES tr_country(id)
);


ALTER TABLE t_invoice ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_invoice ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

--select * from t_invoice
--truncate table t_invoice

--insert into t_invoice(invoice_date, loading_country_id, unloading_country_id, note, client_id, company_id, working_order_id, currency_id, route_id, amount)
--values ('2021-08-04', 1,3,'test', 16, 1, 82, 978, 2,100)

---------------- TRIGGER 1 -----------------------------
CREATE OR REPLACE FUNCTION function_number() RETURNS trigger AS '
     BEGIN
    
   
   new.number = coalesce((select max(number) + 1 from t_invoice 
   where company_id = new.company_id)::bigint, replace(extract (year from current_date)::text ||  
   lpad(extract(month from current_date)::text, 2) || ''10001'':: text, '' '' , ''0''):: bigint);

     return new;
     
    end;
 
 ' LANGUAGE plpgsql;
 

 CREATE TRIGGER  function_number BEFORE INSERT ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE  function_number();

 select   coalesce((select max(number) + 1 from t_invoice 
   where company_id = 1) :: text, replace(extract (year from current_date)::text ||  lpad(extract(month from current_date)::text, 2) || '10001':: text, '' '' , ''0'')

, '' '' , ''0''

 select   coalesce((select max(number) + 1 from t_invoice 
   where company_id = 1)::bigint, replace(extract (year from current_date)::text ||  lpad(extract(month from current_date)::text, 2) || '10001':: text, ' ' , '0'):: bigint)

------------- TRIGGER 2 --------------------------

CREATE OR REPLACE FUNCTION invoice_insert2() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_amount = NEW.amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_amount = NEW.amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_amount = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_amount = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_amount = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date)) ::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert2 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert2();

 ------------- TRIGGER 3 --------------------------

CREATE OR REPLACE FUNCTION invoice_insert3() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_unit_price = new.unit_price*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_unit_price = new.unit_price :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_unit_price = new.unit_price *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_unit_price = new.unit_price *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_unit_price = new.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date)) ::numeric;
     END IF;
     
     return new;
    end;
  
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert3 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert3();

 -------------------- TRIGGER 4 --------------------------

CREATE OR REPLACE FUNCTION invoice_insert4() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_discount_amount = new.discount_amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_discount_amount = new.discount_amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_discount_amount = new.discount_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_discount_amount = new.discount_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_discount_amount = new.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date)) ::numeric;
     END IF;
     
     return new;
    end;
  
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert4 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert4();

 -------------------- TRIGGER 5 --------------------------

CREATE OR REPLACE FUNCTION invoice_insert5() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_tax_amount = new.tax_amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_tax_amount = new.tax_amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_tax_amount = new.tax_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_tax_amount = new.tax_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_tax_amount = new.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date)) ::numeric;
     END IF;
     
     return new;
    end;
  
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert5 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert5();

 -------------------- TRIGGER 6 --------------------------

CREATE OR REPLACE FUNCTION invoice_insert6() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_amount_without_tax = new.amount_without_tax*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_amount_without_tax = new.amount_without_tax :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_amount_without_tax = new.amount_without_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_amount_without_tax = new.amount_without_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_amount_without_tax = new.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date)) ::numeric;
     END IF;
     
     return new;
    end;
  
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert6 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert6();

-------------------- TRIGGER 7 --------------------------

CREATE OR REPLACE FUNCTION invoice_insert7() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_total_amount = new.total_amount*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_total_amount = new.total_amount :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_total_amount = new.total_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_total_amount = new.total_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_total_amount = new.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date)) ::numeric;
     END IF;
     
     return new;
    end;
  
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert7 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert7();


-------------------- TRIGGER 8 --------------------------

CREATE OR REPLACE FUNCTION invoice_insert8() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.local_total_amount_with_tax =new.total_amount_with_tax*(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;				   
     END IF;
IF NEW.currency_id = 1 THEN new.local_total_amount_with_tax =new.total_amount_with_tax :: numeric;
     END IF;
IF NEW.currency_id = 36 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.local_total_amount_with_tax =new.total_amount_with_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 40 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 40 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.local_total_amount_with_tax =new.total_amount_with_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 56 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 56 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.local_total_amount_with_tax =new.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date)) ::numeric;
     END IF;
     
     return new;
    end;
  
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert8 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert8();

------------------- TRIGGER 9 --------------------------------
 CREATE OR REPLACE FUNCTION invoice_insert9() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.amount_in_eur = NEW.amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.amount_in_eur = NEW.amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.amount_in_eur = NEW.amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.amount_in_eur = NEW.amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert9 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert9();

 ------------------- TRIGGER 10 --------------------------------
 CREATE OR REPLACE FUNCTION invoice_insert10() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.unit_price_in_eur = NEW.unit_price;				   
     END IF;
IF NEW.currency_id = 1 THEN new.unit_price_in_eur = NEW.unit_price/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.unit_price_in_eur = NEW.unit_price *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.unit_price_in_eur = NEW.unit_price *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.unit_price_in_eur = NEW.unit_price * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert10 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert10();

------------------- TRIGGER 11 --------------------------------
 CREATE OR REPLACE FUNCTION invoice_insert11() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.discount_amount_in_eur = NEW.discount_amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.discount_amount_in_eur = NEW.discount_amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.discount_amount_in_eur = NEW.discount_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.discount_amount_in_eur = NEW.discount_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.discount_amount_in_eur = NEW.discount_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert11 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert11();

 ------------------- TRIGGER 12 --------------------------------
 CREATE OR REPLACE FUNCTION invoice_insert12() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.tax_amount_in_eur = NEW.tax_amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.tax_amount_in_eur = NEW.tax_amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.tax_amount_in_eur = NEW.tax_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.tax_amount_in_eur = NEW.tax_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.tax_amount_in_eur = NEW.tax_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert12 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert12();
 
------------------- TRIGGER 13 --------------------------------
 CREATE OR REPLACE FUNCTION invoice_insert13() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax;				   
     END IF;
IF NEW.currency_id = 1 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.amount_without_tax_in_eur = NEW.amount_without_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert13 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert13();

 ------------------- TRIGGER 14 --------------------------------
 CREATE OR REPLACE FUNCTION invoice_insert14() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.total_amount_in_eur = NEW.total_amount;				   
     END IF;
IF NEW.currency_id = 1 THEN new.total_amount_in_eur = NEW.total_amount/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.total_amount_in_eur = NEW.total_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.total_amount_in_eur = NEW.total_amount *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.total_amount_in_eur = NEW.total_amount * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert14 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert14();

 
 ------------------- TRIGGER 15 --------------------------------
 CREATE OR REPLACE FUNCTION invoice_insert15() RETURNS trigger AS '
     BEGIN
IF NEW.currency_id = 978 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax;				   
     END IF;
IF NEW.currency_id = 1 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::integer;
     END IF;
IF NEW.currency_id = 36 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 36 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 36 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 124 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 124 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 124 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 156 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 156 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 156 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 191 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 191 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 191 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date)) ::numeric;
     END IF;
IF NEW.currency_id = 203 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 203 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 203 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 208 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 208 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 208 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 348 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 348 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 348 and date <= NEW.invoice_date))/ (select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id =(select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 392 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 392 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 392 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 414 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 414 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 414 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 578 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 578 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 578 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 643 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 643 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 643 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 752 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 752 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 752 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 756 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 756 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 756 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 826 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 826 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 826 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 840 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 840 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 840 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 933 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 933 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 933 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 946 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 946 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 946 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 949 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 949 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 949 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 975 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 975 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 975 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 977 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 977 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 977 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 985 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 985 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 985 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 40 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  40 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  40 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 56 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax *  (select middle_rate/unit from current_exchange_rates where currency_code_num_char =  56 and id = (select max (id) from current_exchange_rates where currency_code_num_char =  56 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 246 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 246 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 246 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 250 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 250 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 250 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 280 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 280 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 280 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 300 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 300 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 300 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 372 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 372 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 372 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 380 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 380 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 380 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 442 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 442 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 442 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 620 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 620 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 620 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 724 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 724 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 724 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
IF NEW.currency_id = 960 THEN new.total_amount_with_tax_in_eur = NEW.total_amount_with_tax * (select middle_rate/unit from current_exchange_rates where currency_code_num_char = 960 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 960 and date <= NEW.invoice_date))/(select middle_rate from current_exchange_rates where currency_code_num_char = 978 and id = (select max (id) from current_exchange_rates where currency_code_num_char = 978 and date <= NEW.invoice_date))::numeric;
     END IF;
     
     return new;
    end;
 
 ' LANGUAGE plpgsql;

 CREATE TRIGGER invoice_insert15 BEFORE INSERT OR UPDATE ON t_invoice FOR 
 EACH ROW EXECUTE PROCEDURE invoice_insert15();

------------------------------------------------------------
select * from t_route

select * from t_vehicle
where id = 101626
select * from t_invoice

delete from tx_vehicle_document_vehicle  where id=-1

select * from tx_vehicle_document_vehicle

insert into t_vehicle (	id, 
			registration_number, 
			chassis_number, 
			year_of_production, 
			vehicle_type,
			category ,
			certificate,
			valid_to,
		        invalid_until,
		        max_load,
			additionally,
			leasing_expiration_date,
			history,
			company_id )


 select nextval('serial'),
 registarski_broj,
 broj_sasije, 
 godina_proizvodnje:: INTEGER, 
 tip_vozila, 
 kategorija, 
 sertifikat,
 case when validan_do = '-' then null else validan_do :: date end ,
 case when nevalidan_do = '-' then null else nevalidan_do :: date end ,
 REPLACE(tovarni_kapacitet, 't', ''):: float as tovarni_kapacitet,
 nedgradnja, 
 case when lezing_zakup_do = '-' then null else lezing_zakup_do :: date end ,
 istorija,
 company_id:: INTEGER
 from checkpoint_vehicle
 WHERE company_id = '2' 


 
--drop table checkpoint_vehicle
create table checkpoint_vehicle
(registarski_broj character varying,
broj_sasije character varying,
godina_proizvodnje character varying,
tip_vozila character varying,
tip_vlasnistva character varying,
kategorija character varying,
sertifikat character varying,
validan_do character varying,
nevalidan_do character varying, 
tovarni_kapacitet character varying,
nedgradnja character varying,
lezing_zakup_do character varying,
istorija character varying,
company_id character varying)
