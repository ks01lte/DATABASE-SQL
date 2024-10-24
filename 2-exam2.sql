SELECT * FROM madang.book ;
SELECT * FROM madang.book where publisher='대한미디어';
select * from book where bookname like '%축구%';
select * from book where publisher like '%미디어%';
select * from book where bookname like '_구%';
select * from book where publisher not in ('나무수','굿스포츠');
select * from book where publisher='나무수' or publisher='굿스포츠';
