use madang;
select * from orders where orderdate = '2014-07-07';
select * from orders where orderdate = '2014/07/07';
select * from orders where orderdate = '2014.07.07';
select * from orders where orderdate = '2014@07@07';

insert into orders values(11,1,1,1,'2023-10-05'),(11,1,1,1,'2023-10-05'),(11,1,1,1,'2023-10-05'),(11,1,1,1,'2023-10-05');
select * from orders where orderdate between '2000/01/01' and '2020/1/1';
select * from orders where orderdate > '2020/1/1';
delete from orders where orderdate > '2020/1/1';
