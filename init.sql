-- create db
CREATE USER ppstats WITH PASSWORD '----';
CREATE DATABASE ppstats OWNER ppstats;
GRANT ALL PRIVILEGES ON DATABASE ppstats to ppstats;

GRANT ALL ON SCHEMA public TO ppstats; 


-- create tables
create table visit_log(
id SERIAL PRIMARY KEY,
app_id varchar(100),
req_host varchar(500),
req_path varchar(1024),
remote_ip varchar(100),
status varchar(50),
created_date timestamp not null default CURRENT_TIMESTAMP,
modified_date timestamp,
req_url varchar(1024),
user_agent varchar(1024)
);


create table reg_application(
	id SERIAL PRIMARY KEY,
	app_id varchar(100),
	name varchar(100),
	description varchar(2048),
	status varchar(50),
	created_date timestamp not null default CURRENT_TIMESTAMP,
	modified_date timestamp
);

create table  allow_hosts (
	id SERIAL PRIMARY KEY,
	app_id varchar(100),
	host  varchar(200),
	status varchar(50)
);
