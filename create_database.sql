create database if not exists estore;
connect estore;

-- Categories
create table if not exists categories (
	id tinyint auto_increment primary key,

	name varchar(20) not null,

	unique (name)
);

-- Products
create table if not exists products (
	id int auto_increment primary key ,

	product_id varchar(30) not null,
	name varchar(50),
	in_stock boolean,
	description varchar(3000),
	brand varchar(30),
	category_id tinyint,

	foreign key (category_id) references categories(id),
	unique (product_id)
);

-- Gallery
create table if not exists gallery(
	id int auto_increment primary key,
	url varchar(500),
	product_id int not null,

	foreign key (product_id) references products(id)
);

-- Currencies
create table if not exists currencies(
	id int auto_increment primary key,

	label varchar(10),
	symbol char,

	unique (label)
);

-- Prices
create table if not exists prices(
	id int auto_increment primary key,

	amount decimal(6, 2),
	currency_id int,
	product_id int,

	foreign key (product_id) references products(id),
	foreign key (currency_id) references currencies(id)
);

-- Colors
create table if not exists colors(
	id int auto_increment primary key,
	value varchar(6),
	name varchar(20),
	unique(name)
);

create table if not exists product_color(
	product_id int,
	color_id int,
	foreign key (product_id) references products(id),
	foreign key (color_id) references colors(id)
);

-- Sizes
create table if not exists sizes(
	id int auto_increment primary key,
	value varchar(2),
	name varchar(20),
	unique(name)
);

create table if not exists product_size(
	product_id int,
	size_id int,
	foreign key (product_id) references products(id),
	foreign key (size_id) references sizes(id)
);

-- Capacities
create table if not exists capacities(
	id int auto_increment primary key,
	value varchar(4),
	name varchar(4),
	unique(name)
);

create table if not exists product_capacity(
	product_id int,
	capacity_id int,
	foreign key (product_id) references products(id),
	foreign key (capacity_id) references capacities(id)
);

-- USB3 Availability
create table if not exists product_usb3(
	product_id int,
	foreign key (product_id) references products(id)
);

-- TouchID in Keyboard
create table if not exists product_touchID(
	product_id int,
	foreign key (product_id) references products(id)
);

-- Orders
create table if not exists orders(
	id int auto_increment primary key,
	total decimal(12, 2),
	order_time timestamp not null
);

create table if not exists order_products(
	order_id int not null,
	product_id int not null,
	amount int not null,
	color varchar(20),
	size varchar(20),
	capacity varchar(4),
	usb3 boolean,
	touchID boolean,
	foreign key (order_id) references orders(id),
	foreign key (product_id) references products(id),
	foreign key (color) references colors(name),
	foreign key (size) references sizes(name),
	foreign key (capacity) references capacities(name)
);
