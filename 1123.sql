DROP PROCEDURE IF EXISTS ifProc;
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
	DECLARE var1 INT;
	SET var1 = 100;

	IF var1 = 100 THEN
		SELECT '100입니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER ;
CALL ifProc();
-- 
use employees;
select * from employees limit 10;

DROP PROCEDURE IF EXISTS ifProc2;
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE hireDATE DATE; -- 입사일 
	DECLARE curDATE DATE; -- 오늘
	DECLARE days INT; -- 근무한 일수

	SELECT hire_date INTO hireDATE
		FROM employees.employees
		WHERE emp_no = 10001;

	SET curDATE= CURRENT_DATE();-- 현재 날짜
	SET days= DATEDIFF(curDATE, hireDATE); -- 날짜의 차이, 일 단위

	IF (days/365) >= 5 THEN -- 5년이 지났다면
		SELECT CONCAT('입사한지 ', days , '일이나 지났습니다. 축하합니다!');
	ELSE
		SELECT ('입사한지'+ days +'일밖에 안되었네요. 열심히 일하세요.');
	END IF;
END $$
DELIMITER ;
CALL ifProc2();
--
DROP PROCEDURE IF EXISTS ifProc3;
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE point INT ;
	DECLARE credit CHAR(1);
	SET point = 77 ;
	
    IF point >= 90 THEN
		SET credit = 'A';
	ELSEIF point >= 80 THEN
		SET credit = 'B';
	ELSEIF point >= 70 THEN
		SET credit = 'C';
	ELSEIF point >= 60 THEN
		SET credit = 'D';
	ELSE
		SET credit = 'F';
	END IF;
    SELECT CONCAT('취득점수==>',point), CONCAT('학점==>', credit);
	END $$
DELIMITER ;
CALL ifProc3();
--
DROP PROCEDURE IF EXISTS caseProc:
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point INT ;
	DECLARE credit CHAR(1);
	SET point = 77 ;

	CASE
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
	END CASE;
	SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', Credit);
END $$
DELIMITER ;
CALL caseProc();
--
use sqldb;
select * from buytbl;
SELECT userID, SUM(price*amount) AS '총구매액'
	FROM buytbl
	GROUP BY userID
	ORDER BY SUM(price*amount) DESC;
--
SELECT B.UserID, U.name, Sum(price*amount) AS '총구매액'
	FROM buytbl B
		INNER JOIN usertbl U
			ON B.userID = U.userID
	GROUP BY B.userID, U.name
	ORDER BY SUM(price*amount) DESC;
--
SELECT B.userID, U.name, SUM(price*amount) AS '총구매액' 
	FROM buytbl B
		RIGHT OUTER JOIN usertbl U
			ON B.userID = U.userID
	GROUP BY B.userID, U.name
	ORDER BY SUM(price*amount) DESC ;
--
SELECT U.userID, U.name, SUM(price*amount) AS '총구매액' 
	FROM buytbl B
		RIGHT OUTER JOIN usertbl U
			ON B.userID = U.userID
	GROUP BY U.userID, U.name
	ORDER BY SUM(price*amount) DESC ;
--
SELECT U.userID, U.name, SUM(price*amount) AS '총구매액',
	CASE
		WHEN (SUM(price*amount)>= 1500) THEN '최우수고객' 
        WHEN (SUM(price*amount)>= 1000) THEN '우수고객' 
        WHEN (SUM(price*amount)>= 1) THEN '일반고객' 
        ELSE '유령고객'
	END AS '고객등급'
FROM buytbl B
	RIGHT OUTER JOIN usertbl U
		ON B.userID = U.userID
GROUP BY U.userID, U.name
ORDER BY sum(price*amount) DESC ;
--
DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
		DECLARE i INT; -- 1에서 100까지 증가할 변수
		DECLARE hap INT; -- 더한 값을 누적할 변수
	SET i = 1;
	SET hap = 0;

		WHILE (i <= 100) DO
			SET hap = hap + i;
			SET i = i +1;
		END WHILE;
        
		SELECT hap;
END $$
DELIMITER ;
CALL whileProc();