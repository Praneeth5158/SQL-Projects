create database libraryDB;
use libraryDB;
show tables;
/* table creation */
create table books(
	book_id int primary key auto_increment,
    title varchar(200) not null,
    author varchar(200) not null,
    publisher varchar(200) not null,
    category varchar(20) not null,
    total_copies int not null, 
    available_copies int not null );

create table members(
	member_id int primary key auto_increment,
    name varchar(100) not null,
    email varchar(100) not null,
    contact_number varchar(15),
    departments varchar(100));
    
create table borrowedBooks(
	borrow_id int primary key auto_increment,
    member_id int,
    book_id int,
    issue_date date,
    due_date date,
    return_date date,
	foreign key (member_id )references members(member_id),
    foreign key (book_id) references books(book_id));
    
create table fines(
	fine_id int primary key auto_increment,
    borrow_id int,
    amount int,
    status varchar(100),
    foreign key (borrow_id) references borrowedBooks (borrow_id));

/* insert data*/
select* from books;
insert into books(title,author,publisher,category,total_copies,available_copies) values 
	('c language','Dennis Ritchies','prentice hall','education',10,10),
    ('Database Systems','elmasri','pearson','database',8,8),
    ('Ramayanam','valmiki','agastya','devotional',10,10),
    ('Harry porter','parker','disney','adventure',15,15),
    ('Python','Guido van Rossom','Guidos','coding',7,7);

    
select * from members;
insert into members (name,email,contact_number,departments) values 
	('Praneeth','praneeth@gmail.com','6304776432','cse'),
    ('Satya','satya@gmail.com','987654321','AI'),
    ('Deepu','deepu@gmail.com','123456789','CSE'),
    ('Karthik','karthik@gmail.com','9959246587','EEE'),
    ('Darshita','darsi@gmail.com','124578963','arts');
    
select * from borrowedBooks;
insert into borrowedBooks(member_id,book_id,issue_date,due_date,return_date) values 
	(1,4,'2025-04-21','2025-04-29','2025-04-28'),
    (3,1,'2025-08-18','2025-08-25','2025-08-26'),
    (2,5,'2025-07-1','2025-07-8','2025-07-10');
    
/*automatically calclulates the fines amount*/
select * from fines;
insert into fines (borrow_id,amount,status) 
select borrow_id,
case
	when return_date<due_date then 0
    else datediff(return_date,due_date) *10
end as amount,
case
	when return_date<=due_date then 'not paid'
    else 'paid'
end as status
from borrowedBooks;

select * from members;
select * from fines;
select * from books;
select * from borrowedBooks;

/* showing avalilable books*/
select * from books where available_copies>0;

/* showing total of the fines */
select * from fines;
select sum(amount) as total from fines;

/*Show which member borrowed which book */
select members.member_id , members.name,books.title from members inner join borrowedBooks on members.member_id=borrowedBooks.member_id inner join books on borrowedBooks.book_id=books.book_id;