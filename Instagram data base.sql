create database instagram;
use instagram;

create table users(
	 id int primary key auto_increment,
     name varchar(40),
     email varchar(50),
     phone varchar (10),
     password varchar (20),
     createdBy datetime default now()
    
);

create table usermetadata(
	id int primary key auto_increment,
    user_id int ,
    followers int default 0,
    following int default 0,
    bio varchar(255) ,
    foreign key (user_id) references users(id)
);

create table posts(
	id int primary key auto_increment,
    post_desc varchar(255),
    likes_count int default 0,
    comments_count int default 0,
    posted_date datetime default now()
);

create table post_media(
	id int primary key auto_increment,
    post_id int ,
    image_link varchar(255),
    foreign key (post_id) references posts(id)
);

create table user_followers(
	id int primary key auto_increment,
    user_id int,
    follower_id int,
    foreign key (user_id) references users(id),
    foreign key (follower_id ) references users(id)
);

create table user_following(
	id int primary key auto_increment,
    user_id int,
    following_id int,
    foreign key (user_id) references users(id),
    foreign key (following_id) references users(id)
);
select * from users;
select * from usermetadata;
select * from posts;
select * from post_media;
select * from user_followers;
select * from user_following;

insert into users(name,email,phone,password) values
	('praneeth','pra@gmaol.com','123000783','123@123'),
    ('satya','sat@gmail.com','232412543','543@222'),
    ('deepu','deepu@mail.com','123456789','1243');

insert into usermetadata(user_id,followers,following,bio) values
	(2,10,24,'aimition is an IAS officer'),
    (1,150,30,'Nobody is too busy all about priorities'),
    (3,10,50,'hatake kakashi');

update usermetadata set bio='anime lover' where id=3;

insert into posts (post_desc) values 
	('hero'),
    ('thagaddele');

update posts set likes_count=5 where id=2;

insert into post_media (post_id,image_link) values
	(2,'fh.img'),
    (1,'jf.img');

insert into user_followers (user_id,follower_id) values 
	(1,2),
    (2,1),
    (3,1),
    (3,2);

insert into user_following (user_id,following_id) values
	(2,1),
    (2,2),
    (2,3);
    
select * from users where name like '%th';
select * from usermetadata where followers in (100,150,200);
select * from usermetadata where followers between 5 and 10;
select upper(name) as capital_letters from users;
select count(followers) as Number_of_count from usermetadata;
select sum(followers) as Total_followers from usermetadata;

create view vw_users as select * from users;
select * from vw_users;
select * from users;
insert into users (name,email,phone,password) value 
	('karthik','kar@gmail.com','142546378','4444');

select * from users;
select * from posts;
select * from posts p inner join users u on p.id=u.id;
select * from posts p left join users u on p.id=u.id;
select * from posts p right join users u on p.id=u.id;

