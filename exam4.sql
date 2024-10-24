select count(*) as 갯수, sum(saleprice) as 합, max(saleprice) 최대, min(saleprice) 최소 from orders;
select custid, count(*), max(saleprice) from orders group by custid;
select * from orders order by custid;
select custid, bookid from orders order by custid,bookid;
select bookid from orders group by bookid;
