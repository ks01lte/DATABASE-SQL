create database test;
show databases;

use test;

create table usrtbl(id integer, name varchar(30)); # table 생성 

show tables;

show table status;

select * from usrtbl;

insert into usrtbl values(1,'김화랑');
insert into usrtbl values(1,'김화랑');
insert into usrtbl values(1,'김화랑'),(2,'김연아'),(3,'박세리');

select count(*) from usrtbl; 
 
select * from usrtbl order by id; # usrtbl 테이블 조회

set sql_safe_Updates=0; # 안전모드 OFF

update usrtbl set id=100 where name = '김화랑'; # 이름이 김화랑 아이디를 100으로 수정 

delete from usrtbl where name='김연아'; # 이름이 김연아 삭제

create table usrtbl2 select * from usrtbl; # 테이블 복사 
select * from usrtbl2;

create table usrtbl3(id3 int, name3 varchar(30));
insert into usrtbl3   # 테이블 복사2
select id, name from usrtbl;
select * from usrtbl3;

show tables;
delete from usrtbl; # 테이블구조는 유지하되 레코드를 모두 삭제 단 중간에 문제가 생기면 다시 복구됨 (백업 가능 -> 트렌젝션, 시간이 오래걸림)
drop table usrtbl2; # 테이블구조까지 모두 삭제
truncate table usrtbl3; # 테이블구조는 유지하되 데이터를 모두 삭제 복구 불가능 

show tables;
drop tables usrtbl, usrtb3;
drop database test;