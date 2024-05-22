use board2;
create table author
(id INT auto_increment,
 name VARCHAR(255),
 email VARCHAR(255) not null unique,
 password VARCHAR(255),
created_time datetime default current_timestamp,
primary key (id)
);

create table post
(id INT auto_increment,
 title VARCHAR(255) not null,
 contents VARCHAR(3000),
created_time datetime default current_timestamp,
primary key (id)
);

create table author_post
(id INT auto_increment,
    author_id int,
    post_id int,
    foreign key(author_id) references author(id),
    foreign key(post_id) references post(id),
primary key (id)
);

create table author_address
( city VARCHAR(255),
    street VARCHAR(255),
    author_id int not null unique,
    foreign key (author_id) references author(id)
);

show tables;
describe author;
describe post;
describe author_post;
describe author_address;

select * from author;
select * from post;
select * from author_post;
select * from author_address;
insert into author(name, email) values('milcho', 'milcho0604@gmail.com');
insert into author(name, email) values('choco', 'choco@gmail.com');
insert into author(name, email, password) values('milk', 'milk0904@gmail.com', 1234);

insert into post(title, contents) values('맛집', '순대');
insert into post(title, contents) values('dog', 'stu');
insert into post(title, contents) values('cat', 'cute');
insert into post(title, contents) values('dog_cat', 'good');
insert into post(title, contents) values('smile', 'today');


insert into author_post(author_id, post_id) values('1', '1');
insert into author_post(author_id, post_id) values('2', '1');
insert into author_post(author_id, post_id) values('3', '2');
insert into author_post(author_id, post_id) values('1', '1');
insert into author_post(author_id, post_id) values('3', '5');
insert into author_post(author_id, post_id) values('2', '4');


insert into author_address(city, street, author_id) values('seoul', 'hong', '1');
insert into author_address(city, street, author_id) values('g_g', 'th', '2');
insert into author_address(city, street, author_id) values('g_g', 'ilsan', '3');


select * from author;
select * from post;
select * from author_post;
select * from author_address;

select * from author
         where id = (select author_id from author_post where id = 7) ;

select * from author
         where id = (select author_id from author_address where city = 'seoul') ;

select * from post
        where id = (select post_id from author_post where id = 3)


