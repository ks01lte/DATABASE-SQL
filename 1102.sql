use employees;
show tables;
use madang;
show table status;
show databases;
use information_schema;
show tables;
select * from tables where table_schema = 'madang';
select * from views where table_schema = 'madang';
select * from triggers where trigger_schema = 'madang';
select * from routines where routine_schema = 'madang';

select * from v_customer;
use madang;
drop view v_customer;
create VIEW `v_customer` AS
	SELECT
		`madang`,`customer`,`custid` AS `custid`,
        `madang`,`customer`,`'name` AS `name`,
        `madang`,`customer`,`address` AS `address`
	FROM
    `madang`,`customer`
    WHERE
    (`customer`,`address` LIKE "대한%");
    
use madang;
drop view v_customer2;
create VIEW `v_customer2` AS SELECT * FROM `customer`;

drop schema if exists sqldb; 
CREATE SCHEMA sqldb;
USE sqldb;

drop table if exists tbl1;
CREATE TABLE tbl1
	(	a INT PRIMARY KEY,
		b INT,
        c INT
	);
SHOW INDEX FROM tbl1;

drop table if exists tbl2;
CREATE TABLE tbl2
	(	a INT PRIMARY KEY,
		b INT UNIQUE,
        c INT UNIQUE,
        d INT
	);
SHOW INDEX FROM tbl2;

drop table if exists tbl3;
CREATE TABLE tbl3
	(	a INT UNIQUE,
		b INT UNIQUE,
        c INT UNIQUE,
        d INT
	);
SHOW INDEX FROM tbl3;

drop table if exists tbl4;
CREATE TABLE tbl4
	(	a INT UNIQUE NOT NULL,
		b INT UNIQUE,
        c INT UNIQUE,
        d INT
	);
SHOW INDEX FROM tbl4;

CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
-- 
DROP TABLE IF EXISTS clustertbl;
CREATE TABLE clustertbl
( userID CHAR(8),
name VARCHAR(10)
);
INSERT INTO clustertbl VALUES('LSG','이승기');
INSERT INTO clustertbl VALUES('KBS','김범수');
INSERT INTO clustertbl VALUES('KKH','김경호');
INSERT INTO clustertbl VALUES('JYP','조용필');
INSERT INTO clustertbl VALUES('SSK','성시경');
INSERT INTO clustertbl VALUES('LJB','임재범');
INSERT INTO clustertbl VALUES('YJS','윤종신');
INSERT INTO clustertbl VALUES('EJW','은지원');
INSERT INTO clustertbl VALUES('JKW','조관우');
INSERT INTO clustertbl VALUES('BBK','바비킴');
select * from clustertbl;
desc clustertbl;

ALTER TABLE clustertbl
	ADD PRIMARY KEY (userID);
alter table clustertbl drop primary key;
alter table clustertbl add primary key(name);

select * from clustertbl;
-- 
DROP TABLE IF EXISTS secondarytbl;
CREATE TABLE secondarytbl
( userID CHAR(8),
name VARCHAR(10)
);
INSERT INTO secondarytbl VALUES('LSG','이승기');
INSERT INTO secondarytbl VALUES('KBS','김범수');
INSERT INTO secondarytbl VALUES('KKH','김경호');
INSERT INTO secondarytbl VALUES('JYP','조용필');
INSERT INTO secondarytbl VALUES('SSK','성시경');
INSERT INTO secondarytbl VALUES('LJB','임재범');
INSERT INTO secondarytbl VALUES('YJS','윤종신');
INSERT INTO secondarytbl VALUES('EJW','은지원');
INSERT INTO secondarytbl VALUES('JKW','조관우');
INSERT INTO secondarytbl VALUES('BBK','바비킴');
desc secondarytbl;

ALTER TABLE secondarytbl
	ADD UNIQUE (userID);
show index from secondarytbl;
SELECT * FROM secondarytbl;

USE testdb;
INSERT INTO clustertbl VALUES('FNT','푸나타');
INSERT INTO clustertbl VALUES('KAI','카아이');
SELECT * FROM clustertbl;
INSERT INTO secondarytbl VALUES('FNT','푸나타');
INSERT INTO secondarytbl VALUES('KAI','카아이');
SELECT * FROM secondarytbl;
-- 
DROP TABLE IF EXISTS mixedtbl;
CREATE TABLE mixedtbl
( userID CHAR(8) NOT NULL,
name VARCHAR(10) NOT NULL,
addr	CHAR(2)
);
INSERT INTO mixedtbl VALUES('LSG','이승기','서울');
INSERT INTO mixedtbl VALUES('KBS','김범수','경남');
INSERT INTO mixedtbl VALUES('KKH','김경호','전남');
INSERT INTO mixedtbl VALUES('JYP','조용필','경기');
INSERT INTO mixedtbl VALUES('SSK','성시경','서울');
INSERT INTO mixedtbl VALUES('LJB','임재범','서울');
INSERT INTO mixedtbl VALUES('YJS','윤종신','경남');
INSERT INTO mixedtbl VALUES('EJW','은지원','서울');
INSERT INTO mixedtbl VALUES('JKW','조관우','전남');
INSERT INTO mixedtbl VALUES('BBK','바비킴','서울');

ALTER TABLE mixedtbl ADD PRIMARY KEY (userID);
ALTER TABLE mixedtbl ADD UNIQUE(name);

drop index name on mixedtbl;
alter table maxedtbl drop primary key;

SELECT addr FROM mixedtbl WHERE name = '임재범';
