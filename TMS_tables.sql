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
 LOGO bytea null, 
 CEO varchar (50) null,
 email varchar (80) null,
 phone_number varchar (20) null,
 web_site varchar (80) null,
 current_account varchar(100) null,
 SWIFT varchar (10) null,
 IBAN varchar (10) null,
 inactive char(1),
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
 mobile_phone_1 varchar(20),
 mobile_phone_2 varchar(20),
 date_of_birth date null,
 contract_date date null,
 licence varchar (30) null, --- ????
 inactive char(1),
 free boolean,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_company_id
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id)
);
ALTER TABLE t_driver ALTER COLUMN inactive SET DEFAULT 'N' ;
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
 inactive char(1),
 free boolean,
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

ALTER TABLE t_vehicle ALTER COLUMN inactive SET DEFAULT 'N' ;
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
 inactive char(1),
 free boolean, 
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

ALTER TABLE t_trailer ALTER COLUMN inactive SET DEFAULT 'N' ;
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
  CONSTRAINT tr_company
      FOREIGN KEY(company_id) 
	  REFERENCES t_company(id),	  
 CONSTRAINT tr_country
      FOREIGN KEY(country_id) 
	  REFERENCES tr_country(id)
	  );
ALTER TABLE t_service_company ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_service_company ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
---------------------------------------------------------------------------------
drop SEQUENCE  service_seq;
CREATE SEQUENCE service_seq start 1;

-- drop table t_service
create table t_service 
(id integer NOT NULL DEFAULT nextval(('public.service_seq'::text)::regclass) primary key,
 vehicle_id int null,
 trailer_id int null,
 date_of_service timestamp default null,
 amount decimal null, 
 currency varchar(10) null,
 amount_in_EUR decimal null, 
 local_amount_currency varchar(10) null,
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
---------------------------------------------------------------------------------

drop SEQUENCE  damage_seq;
CREATE SEQUENCE damage_seq start 1;

-- drop table t_damage
create table t_damage
(id integer NOT NULL DEFAULT nextval(('public.damage_seq'::text)::regclass) primary key,
 vehicle_id int null,
 trailer_id int null,
 date_of_damage timestamp default null,
 amount decimal (19,2) null, 
 currency varchar(10) null,
 amount_in_eur decimal (19,2) null, 
 local_amount_currency varchar(10) null,
 damage_status varchar(10) null, 
 damage_type varchar (30) null,
 insurance_type varchar(30) null,
 place varchar(30) null,
 registration_status varchar(20) null,
 registration_date timestamp null,
 amount_paid decimal(19,2) null,
 currency_paid varchar(10) null,
 amount_in_eur_paid decimal(19,2) null,
 local_amount_currency_paid varchar (10),
 payout_type varchar(30) null,
 payout_status varchar (20) null,
 service_company_id int not null,
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
 CONSTRAINT tr_absence_type
      FOREIGN KEY(absence_type_id) 
	  REFERENCES tr_absence_type(id)
) ;

ALTER TABLE t_absence ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_absence ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
------------------------------------------------------------

--drop SEQUENCE  ticket_t_seq
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

CREATE SEQUENCE t_ticket_seq start 1;

-- drop table t_ticket
create table t_ticket
(id integer NOT NULL DEFAULT nextval('t_ticket_seq'::regclass) primary key,
 ticket_type_id int,
 ticket_date timestamp default null,
 amount decimal null, 
 currency varchar(10) null,
 amount_in_EUR decimal null, 
 local_amount_currency varchar(10) null,
 ticket_place varchar (100) null,
 driver_id int,
 created_by char (10) null,
 create_dt timestamp default null,
 last_updated_by char (10) null,
 last_update_dt timestamp default null,
 CONSTRAINT fk_driver
      FOREIGN KEY(driver_id) 
	  REFERENCES t_driver(id),
 CONSTRAINT tr_ticket_type
      FOREIGN KEY(ticket_type_id) 
	  REFERENCES tr_ticket_type(id)
);

ALTER TABLE t_absence ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_absence ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-------------------------------------------------
 
CREATE SEQUENCE client_seq start 1;
ALTER TABLE t_client  ADD inactive VARCHAR(1)

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
inactive VARCHAR(1) null,
created_by char (10) null,
create_dt timestamp default null,
last_updated_by char (10) null,
last_update_dt timestamp default null,
  CONSTRAINT tr_company
      FOREIGN KEY(company_id) 
        REFERENCES t_company(id),     
 CONSTRAINT tr_country
      FOREIGN KEY(country_id) 
        REFERENCES tr_country(id)
        );

ALTER TABLE t_client  ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_client ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
------------------------------------------------------------------

CREATE SEQUENCE working_order_seq start 1;

create table t_working_order
(id integer NOT NULL DEFAULT nextval(('public. working_order_seq'::text)::regclass) primary key,
company_id int not null,
number int not null,
driver_id int not null,
vehicle_id int not null,
trailer_id int null,
advance_payment int null,
advance_payment_eur int null,
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
  CONSTRAINT tr_company
      FOREIGN KEY(company_id) 
        REFERENCES t_company(id)
        );
ALTER TABLE t_working_order ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_working_order ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;
-----------------------------------------------------------

CREATE SEQUENCE route_seq start 1;

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
amount decimal null, 
currency varchar(10) null,
amount_in_eur decimal null, 
local_amount_currency varchar(10) null,
price int null,
loading_order_number int null,
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
 CONSTRAINT tr_country_loading
      FOREIGN KEY(loading_country_id) 
        REFERENCES tr_country(id) ,   
 CONSTRAINT tr_country_unloading
      FOREIGN KEY(unloading_country_id) 
        REFERENCES tr_country(id)
        );

ALTER TABLE t_route ALTER COLUMN create_dt SET DEFAULT CURRENT_DATE;
ALTER TABLE t_route ALTER COLUMN last_update_dt SET DEFAULT CURRENT_DATE;

--------------------------------------------------
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
