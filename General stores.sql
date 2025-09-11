create database GeneralStores;
use GeneralStores;

/* creating table of items with amount */
create table items (
	S_NO int primary key auto_increment, 
    Items varchar(20) unique,
    KG int,
    Half_KG int,
    Pav_KG int);

/*inserting items into the items table */
select * from items;
insert into items (Items,KG,Half_KG,Pav_KG) values
	('sugar',45,23,12),
    ('godam pindi',48,24,12),
    ('upma ravva',48,24,12),
    ('bellam',66,33,17),
    ('kobbera',340,170,85),
    ('pappulu',110,55,30),
    ('budda pappulu',130,65,35),
    ('chinta pandu',180,90,45),
    ('ellipaayalu',120,60,30),
    ('kandi byallu',110,55,28),
    ('myda pindi',48,24,12),
    ('shanaga pindi',100,50,25),
    ('idly ravva',50,25,13),
    ('mina byallu',120,60,30),
    ('pesara byallu',120,60,35),
    ('bombay ravva',50,25,13),
    ('shanaga byallu',95,47,23);

/*changing the name of sugas as chekkera */
update  items set Items='chekkara' where Items='sugar';

/* creating customerers table */

create table customers(
	C_ID int primary key auto_increment,
    Customer_name varchar(25) ,
    Number varchar(11));
    
select * from customers;

/*inserting into customer table*/
insert into customers(Customer_name,Number) values
	('Praneeth',123456789),
    ('Satya','56123789'),
    ('Deepu','741852963'),
    ('Karthik','852741963'),
    ('Darshi','7896321456'),
    ('Cherry','4567789123');

/* creating sales table */ 
create table sales(
	sales_id int primary key auto_increment,
    C_ID int ,
    item_name varchar(25),
    quantity int,
    foreign key (C_ID) references customers(C_ID));

/* iam changing the quantity as decimal then no need to include the halfkg,pavkg at the time of calculation*/

alter table sales modify quantity decimal(5,2);

/*customers came and taking items */
select * from sales;
insert into  sales (C_ID,item_name,quantity) values
	(1,'chekkara',2),
    (1,'bellam',3),
    (1,'kandi byallu',0.5),
    (2,'ellipaayalu',0.25),
    (2,'pappulu',0.5),
    (3,'budda pappulu',2),
    (3,'chekkara',1),
    (3,'upma ravva',0.5),
    (4,'chinta pandu',0.25),
    (5,'bellam',1),
    (6,'bellam',1);

/*calculate the items cost per each quantity and for each person*/

select 
	sales.C_ID,
    customers.customer_name,
    sales.item_name,
    sales.quantity,
    (sales.quantity*items.KG) as total_amount
    From sales 
		inner join customers on sales.C_ID=customers.C_ID
        inner join items on sales.item_name=items.Items;
        
/*creating bill table*/
create table bill (
	C_ID int,
	customer_name varchar(20),
    total_cost int);
    
insert into bill (C_ID,customer_name,total_cost) 
	select customers.C_ID ,customers.customer_name,sum(sales.quantity*items.kg) as total_cost 
    from customers
    inner join sales on sales.C_ID= customers.C_ID
    inner join items on sales.item_name = items.Items
    group by customers.C_ID,customers.Customer_name;

select * from bill;


/*iam adding another item into sales for checking*/
insert into sales(C_ID,item_name,quantity) values
	(5,'chekkara',1);