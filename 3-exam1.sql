show databases; # 데이터 베이스 조회
use madang; # madang 데이터 베이스 사용
show tables; # madang 데이터 베이스 안에 테이블 조회
show table status; # madang 데이터 베이스 안에 튜플 조회

select * from book; # book 테이블 조회
select * from orders; # orders 테이블 조회 

select publisher, price from book; # book 테이블 안에 publisher, price 조회
select publisher, price from book where price >= 10000; # book 테이블 안에 price가 10000원 이상인 publisher, price 조회

# 여기서부터 하나씩 다시 해보기 
# inner join 
select * from customer, orders where customer.custid = orders.custid
and saleprice >= 10000;    # where가 있어서 and문을 쓴다.

select customer.custid, customer.name, count(*) as '권수' from customer inner join orders
on customer.custid = orders.custid
where saleprice >= 10000
group by custid; # 구매 참여자중 만원 이상 구매한 고객 정보

select customer.custid, name, address from customer left outer join orders
on customer.custid = orders.custid
where orderid is null;

select customer.name, bookname from customer left outer join orders
on customer.custid = orders.custid
left outer join book
on orders.bookid = book.bookid;

select distinct name from customer, orders where customer.custid = orders.custid; # 책을 산 손님 이름 조회 

select * from customer;

select c.custid, c.name, count(*) as '책권수' from customer c, orders o
where c.custid = o.custid group by c.custid;
