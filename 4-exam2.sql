/*show databases;
create schema testdb;
show databases;*/
use testdb;
/*show tables;*/

drop table if exists member;
create table member(
	id int primary key,
	name varchar(30)
);
desc member;
/*insert into member values(1,'김덕령'),(1,'김덕령'),(1,'김덕령'),(1,'김덕령');
select * from member;*/
alter table member add address varchar(30);

drop table if exists book;
create table book(
id int primary key,
bookname varchar(30)
);
insert into book values(1,'history'),(2,'math'),(3,'english');
select * from book;

drop table if exists orders;
create table orders(
	orderid int,
	memberid int,
	bookid int,
	orderdate date,
	primary key(orderid),
	foreign key(memberid) references member(id),
    foreign key(bookid) references book(id) on delete cascade
);
desc orders;
insert into orders values(1,1,1,sysdate());
insert into orders values(2,2,2,sysdate());
insert into orders values(3,1,3,sysdate());
insert into orders values(4,4,1,sysdate());
insert into orders values(5,4,2,sysdate());

select * from member,orders where member.id = orders.memberid;
select * from member,orders,book where member.id = orders.memberid and orders.bookid=book.id;

select * from member;
select * from orders;
select * from member,orders where member.id = orders.memberid and orders.memberid;
select * from member inner join orders on member.id = orders.memberid inner join book on orders.bookid=book.id;