Create Type sa_enum as ENUM('Cancelled', 'Returned', 'Shipped', 'Pending', 'Delivered');

Create Table Clean_DataSet (
	item_id varchar(250),
	--foreign key(item_id) references items(item_id),
	order_id int,
	--foreign key(order_id) references orders(order_id),
	product_id int, 
	--foreign key(product_id) references products(product_id),
	amount float, 
	status sa_enum,
	item_time timestamp,
	location varchar(250),
	customer_name varchar(250),
	customer_phone varchar(100),
	country varchar(250),
	description text
);