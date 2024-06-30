CREATE TYPE status_enum AS ENUM ('active', 'inactive', 'blacklisted');

CREATE TABLE Categories (
    category_id varchar(50) PRIMARY KEY,
    name varchar(30),
    status status_enum,
    description text
);

CREATE TABLE Customers (
    customer_id varchar(50) PRIMARY KEY,
    name varchar(30),
	phone varchar(17),
	location varchar(100),
    status status_enum
);

CREATE TYPE s_enum AS ENUM ('Cancelled', 'Completed', 'Pending');

CREATE TABLE Orders (
    order_id varchar(50) PRIMARY KEY,
	customer_id varchar(50),
    status s_enum,
	order_timestamp timestamp,
	total_amount float,
	foreign key(customer_id) references Customers(customer_id) 
);

CREATE TABLE Suppliers (
    supplier_id varchar(50) PRIMARY KEY,
	name varchar(50),
	phone varchar(17),
	location varchar(100),
    status status_enum,
	category varchar(50)
);

CREATE TYPE st_enum AS ENUM ('active', 'inactive', 'Out of Stock');

CREATE TABLE Products (
    product_id varchar(50) PRIMARY KEY,
	name varchar(50),
	supplier_id varchar(50),
	category varchar(50),
	price float,
    status st_enum,
	stock_available int,
	product_createtimestamp timestamp,
	foreign key(supplier_id) references Suppliers(supplier_id) 
);

CREATE TYPE sta_enum AS ENUM ('Pending', 'Shipped', 'Delivered');

CREATE TABLE Items (
    item_id varchar(50) PRIMARY KEY,
	order_id varchar(50),
	product_id varchar(50),
	amount float,
    status sta_enum,
	item_timestamp timestamp,
	foreign key(order_id) references Orders(order_id),
	foreign key(product_id) references Products(product_id)
);

