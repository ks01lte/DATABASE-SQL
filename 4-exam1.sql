show databases;
use madang;
show table status;
desc book;
select * from book;
desc customer;
select * from customer;
desc orders;
select * from customer;
insert ignore into customer values (6, '장동민', '서울', '1234-5678');
insert ignore into customer values (7, '장동민', '서울', '1234-5678');
insert ignore into customer values (8, '장동민', '서울', '1234-5678');
insert ignore into customer values (9, '장동민', '서울', '1234-5678');
insert ignore into customer values (10, '장동민', '서울', '1234-5678');
delete from customer where custid between 6 and 10;
/*delete from customer where custid = 1;*/
select * from orders;
/*insert into orders values(11,11,1,10000,'2023-09-20');*/
/*insert into orders values(12,100,1,10000,'2023-09-20');*/
desc orders;
/*insert into orders(orderid,custid,bookid) values(13,11,1,NULL,NULL);*/
/*insert into orders(orderid,custid,bookid) values(14,11,1);*/
update orders set saleprice = 123455 where saleprice is null;
select * from orders where saleprice is null;
delete from orders where custid=11;
select * from customer;



