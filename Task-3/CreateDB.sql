CREATE TYPE ss_enum AS ENUM ('Active', 'Inactive');

CREATE TABLE Cities (
    city_id varchar(250) PRIMARY KEY,
    name varchar(250),
	province varchar(250),
	country varchar(250),
    status ss_enum
);


CREATE TYPE status_enum AS ENUM ('Active', 'Inactive');

CREATE TABLE Categories (
    category_id varchar(250) PRIMARY KEY,
    name varchar(230),
    status status_enum,
    description text
);

CREATE TYPE statuss_enum AS ENUM ('Active', 'InActive', 'Blacklisted');

CREATE TABLE Customers (
    customer_id varchar(250) PRIMARY KEY,
    name varchar(230),
	phone varchar(17),
	location varchar(200),
    status statuss_enum
);

ALTER TABLE Customers
ALTER COLUMN phone TYPE VARCHAR(50);

CREATE TYPE s_enum AS ENUM ('Cancelled', 'Completed', 'Pending');

CREATE TABLE Orders (
    order_id varchar(250) PRIMARY KEY,
	customer_id varchar(250),
    status s_enum,
	order_timestamp timestamp,
	total_amount float,
	foreign key(customer_id) references Customers(customer_id) 
);

CREATE TABLE Suppliers (
    supplier_id varchar(250) PRIMARY KEY,
	name varchar(250),
	phone varchar(17),
	location varchar(200),
    status status_enum,
	category varchar(250)
);

ALTER TABLE Suppliers
ALTER COLUMN phone TYPE VARCHAR(50);

ALTER TABLE Suppliers
ALTER COLUMN status TYPE statuss_enum
USING status::text::statuss_enum;

CREATE TYPE st_enum AS ENUM ('Active', 'InActive', 'Out of Stock');

CREATE TABLE Products (
    product_id varchar(250) PRIMARY KEY,
	name varchar(250),
	supplier_id varchar(250),
	category varchar(250),
	price float,
	stock_available int,
	status st_enum,
	product_createtimestamp timestamp,
	foreign key(supplier_id) references Suppliers(supplier_id) 
);

CREATE TYPE sta_enum AS ENUM ('Pending', 'Shipped', 'Delivered');

CREATE TABLE Items (
    item_id varchar(250) PRIMARY KEY,
	order_id varchar(250),
	product_id varchar(250),
	amount float,
    status sta_enum,
	item_timestamp timestamp,
	foreign key(order_id) references Orders(order_id),
	foreign key(product_id) references Products(product_id)
);