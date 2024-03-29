-- DATE
CREATE TABLE dim_date (
	date_key       int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	"date"         date NOT NULL,
	"year"         int4 NOT NULL,
	"month"        int4 NOT NULL,
	"day"          int4 NOT NULL,
	week_number    int4 NOT NULL,
	weekday_number int4 NOT NULL,
	is_workday     bool NOT NULL
);

--SELECT * FROM dim_date;

--DROP TABLE dim_date


-- PRODUCTS
CREATE TABLE dim_product (
	product_key    int4 NOT NULL DEFAULT 0,
	product_id     int4 NOT NULL DEFAULT 0,
	product_name   varchar NOT NULL,
	unit_price     numeric(10, 2) NULL,
	discontinued   bool NOT NULL,
	category_name  varchar NULL,
	updated_at_src timestamp(0) NULL,
	valid_from     date NULL,
	valid_to       date NULL,
	active         bool NULL,
	created_at     timestamp(0) NULL,
	updated_at     timestamp(0) NULL,
	"version"      int 
);

--SELECT * FROM dim_product;


--DROP TABLE dim_product

-- в случае, если для какого-то продукта не будет записи (но она будет в fct_sales)
INSERT INTO dim_product
(product_key, product_id, product_name, unit_price, discontinued, category_name, updated_at_src, valid_from, valid_to, active, created_at, updated_at, "version")
VALUES(0, 0, 'No data', 0, false, 'No data', '1900-01-01', '1900-01-01', '2099-01-01', true, '1900-01-01', '1900-01-01',1);


-- CUSTOMERS
CREATE TABLE dim_customer (
	customer_key   int NOT NULL DEFAULT 0,
	customer_id    varchar NOT NULL DEFAULT '0',
	company_name   varchar NOT NULL,
	contact_name   varchar,
	address        varchar,
	city           varchar,
	region         varchar,
	postal_code    varchar,
	phone          varchar,
	fax            varchar,
	updated_at_src timestamp(0) NULL,
	valid_from     date NULL,
	valid_to       date NULL,
	active         bool NULL,
	created_at     timestamp(0) NULL,
	updated_at     timestamp(0) NULL,
	"version"      int
);

-- добавляем 'нулевую' запись
INSERT INTO dim_customer (
	customer_key, 
	customer_id, 
	company_name, 
	contact_name, 
	address,
	city,
	region,
	postal_code,
	phone,
	fax,
	updated_at_src,
	valid_from,
	valid_to,
	active,
	created_at,
	updated_at,
	"version"
)
VALUES(
	0,
	'0',
	'0',
	'No data',
	'No data',
	'No data',
	'No data',
	'No data',
	'No data',
	'No data',
	'1900-01-01',
	'1900-01-01',
	'2099-01-01',
	FALSE,
	'1900-01-01',
	'1900-01-01',
	1
);

--SELECT * FROM dim_customer;


-- FACT TABLE
CREATE TABLE fct_sales (
	date_key                int NOT NULL,
	customer_key            int NOT NULL,
	product_key             int NOT NULL,
	order_id                int NOT NULL,
	order_date              date NOT NULL,
	required_date           date,
	shipped_date            date,
	unit_price              numeric(10, 2) NOT NULL,
	quantity                int NOT NULL,
	discount                numeric(10, 2) NOT NULL,
	line_total              numeric(10, 2) NOT NULL,
	line_total_and_discount numeric(10, 2) NOT NULL
);
