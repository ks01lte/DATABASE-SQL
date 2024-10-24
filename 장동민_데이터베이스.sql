drop schema if exists asd;
create schema asd;
use asd;
----------- 테이블 SQL
CREATE TABLE Mall (
    Mall_ID INT PRIMARY KEY,
    Mall_Name VARCHAR(255) NOT NULL,
    Join_Date DATE NOT NULL,
    Contact_Number VARCHAR(20) NOT NULL
);

CREATE TABLE Userr (
    User_ID INT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL
);
CREATE TABLE Mileage (
    Mileage_ID INT PRIMARY KEY,
    User_ID INT,
    Company_Name VARCHAR(255) NOT NULL,
    Mileage_Earned INT NOT NULL,
    Mileage_Used INT NOT NULL,
    Transaction_Date DATE NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Userr(User_ID)
);
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);
CREATE TABLE Orderr (
    Order_ID INT PRIMARY KEY,
    Product_ID INT,
    User_ID INT,
    Quantity INT NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Purchase_Date DATE NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (User_ID) REFERENCES Userr(User_ID)
);

CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Product_ID INT,
    User_ID INT,
    Sale_Amount DECIMAL(10, 2) NOT NULL,
    Sale_Date DATE NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (User_ID) REFERENCES Userr(User_ID)
);

CREATE TABLE Point_History (
    Point_ID INT PRIMARY KEY,
    User_ID INT,
    Points_Earned INT NOT NULL,
    Points_Used INT NOT NULL,
    Transaction_Date DATE NOT NULL,
    FOREIGN KEY (User_ID) REFERENCES Userr(User_ID)
);

----------- 예제 데이터 SQL
-- 쇼핑몰 데이터 삽입
INSERT INTO Mall (Mall_ID, Mall_Name, Join_Date, Contact_Number) VALUES
(1, '아디다스 신발', '2021-01-01', '032-123-1311'),
(2, '디올', '2022-02-15', '032-123-1312'),
(3, '오니츠카 타이거', '2023-07-01', '032-123-1313'),
(4, '아레나 수영복', '2021-03-15', '032-123-1314'),
(5, '컨버스', '2021-01-01', '032-123-1315'),
(6, '프로스펙스', '2023-08-15', '032-123-1316'),
(7, '구찌', '2021-11-01', '032-123-1317'),
(8, '켈빈 클라인', '2022-05-15', '032-123-1318'),
(9, '라코스테 핸드백', '2021-02-01', '032-123-1319'),
(10, '다이슨', '2022-12-15', '032-123-1320'),
(11, '필립스', '2021-01-01', '032-123-1321'),
(12, 'LG 전자', '2022-08-15', '032-123-1322');

-- 상품 데이터 삽입
INSERT INTO Product (Product_ID, Product_Name, Price, Stock) VALUES
(1, '아디다스 그랜드 코트 K 운동화', 99000, 45),
(2, '디올 WALK N DIOR 스니커즈', 235000, 235),
(3, '오니츠카 멕시코 66', 150000, 7),
(4, '아레나 여성 반신 수영복', 60000, 60),
(5, '컨버스 척테일러 올스타', 82000, 144),
(6, '프로스펙스 베어리 씬', 55000, 100),
(7, '구찌 타이거 gg 스몰 토트백', 1480000, 500),
(8, '켈빈 클라인 청바지', 299900, 200),
(9, '라코스테 플랫 핸드백', 599000, 59),
(10, '다이슨 V12 청소기', 135000, 40),
(11, '필립스 에어프라이어 3000', 100000, 5),
(12, 'LG전자 퓨리케어 공기청정기', 350000, 50);


-- 사용자 데이터 삽입
INSERT INTO Userr (User_ID, Username, Email) VALUES
(1, '고주현', 'gojuhyun@daum.net'),
(2, '장동민', 'dongmin08@naver.com'),
(3, '윤승민', 'yoon@nate.com');
-- 판매 데이터 삽입
INSERT INTO Sales (Sale_ID, Product_ID, User_ID, Sale_Amount, Sale_Date) VALUES
(1, 1, 1, 10000, '2022-11-05'),
(2, 2, 1, 15000, '2022-11-05'),
(3, 3, 2, 8000, '2022-11-05'),
(4, 4, 2, 12000, '2022-11-05'),
(5, 5, 3, 5000, '2022-11-06'),
(6, 6, 1, 10000, '2022-12-06'),
(7, 7, 1, 15000, '2022-12-06'),
(8, 8, 2, 8000, '2022-12-07'),
(9, 9, 2, 12000, '2022-12-07'),
(10, 10, 3, 5000, '2022-12-07');

-- 마일리지 사용 기록 데이터 삽입
INSERT INTO Point_History (Point_ID, User_ID, Points_Earned, Points_Used, Transaction_Date) VALUES
(1, 1, 500, 300, '2022-11-05'),
(2, 1, 700, 400, '2022-11-05'),
(3, 2, 400, 200, '2022-11-05'),
(4, 2, 600, 300, '2022-11-05'),
(5, 3, 200, 100, '2022-11-06'),
(6, 1, 500, 300, '2022-12-06'),
(7, 1, 700, 400, '2022-12-06'),
(8, 2, 400, 200, '2022-12-07'),
(9, 2, 600, 300, '2022-12-07'),
(10, 3, 200, 100, '2022-12-07');
-- 주문 데이터 삽입
INSERT INTO Orderr (Order_ID, Product_ID, User_ID, Quantity, Status, Purchase_Date) VALUES
(1, 1, 1, 2, 'Completed', '2023-11-05'),
(2, 2, 1, 1, 'Completed', '2023-11-05'),
(3, 3, 2, 3, 'In Progress', '2023-11-05'),
(4, 4, 2, 2, 'In Progress', '2023-11-05'),
(5, 5, 3, 1, 'Completed', '2023-11-06'),
(6, 6, 1, 2, 'Completed', '2023-12-06'),
(7, 7, 1, 1, 'Completed', '2023-12-06'),
(8, 8, 2, 3, 'In Progress', '2023-12-07'),
(9, 9, 2, 2, 'In Progress', '2023-12-07'),
(10, 10, 3, 1, 'Completed', '2023-12-07');

----------- 요구 사항 SQL 
-- 1. 플랫폼 운영자는 입점 쇼핑몰의 1년치 판매액에 대한 플랫폼 사용료를 청구한다.
--        입점 0년 ~1년차는 1년치     판매액 * 0.1%
--        입점 1년 ~2년차는 1년치     판매액 * 0.2%
--        입점 3년차 이상     판매액 * 1%
SELECT
    Mall_ID AS '쇼핑몰 ID',
    Mall_Name AS '쇼핑몰 이름',
    SUM(Sale_Amount) * 
        CASE
            WHEN DATEDIFF(CURDATE(), Join_Date) <= 365 THEN 0.001
            WHEN DATEDIFF(CURDATE(), Join_Date) <= 730 THEN 0.002
            ELSE 0.01
        END AS '플랫폼 사용료'
FROM
    Mall
JOIN
    Sales ON Mall.Mall_ID = Sales.Product_ID
GROUP BY
    Mall_ID, Mall_Name;
-- 2. 입점한 쇼핑몰의 정보 (이름, 입점일, 연락처, 품목, 누적된 플랫폼 사용료)가 필요하다.
SELECT
    Mall_Name AS '쇼핑몰 이름',
    Join_Date AS '입점일',
    Contact_Number AS '연락처',
    GROUP_CONCAT(DISTINCT Product_Name) AS '판매 품목',
    SUM(Sale_Amount * 
        CASE
            WHEN DATEDIFF(CURDATE(), Join_Date) <= 365 THEN 0.001
            WHEN DATEDIFF(CURDATE(), Join_Date) <= 730 THEN 0.002
            ELSE 0.01
        END) AS '누적 플랫폼 사용료'
FROM
    Mall
JOIN
    Sales ON Mall.Mall_ID = Sales.Product_ID
JOIN
    Product ON Sales.Product_ID = Product.Product_ID
GROUP BY
    Mall_Name, Join_Date, Contact_Number;
-- 3. 쇼핑몰 사장은 상품별 월간 판매액의 자료가 필요하다.
SELECT
    Product.Product_ID AS '상품 ID',
    Product.Product_Name AS '상품 이름',
    MONTH(Sales.Sale_Date) AS '월',
    YEAR(Sales.Sale_Date) AS '년도',
    SUM(Sales.Sale_Amount) AS '월간 판매액'
FROM
    Sales
JOIN
    Product ON Sales.Product_ID = Product.Product_ID
GROUP BY
    Product.Product_ID, Product.Product_Name, MONTH(Sales.Sale_Date), YEAR(Sales.Sale_Date);
-- 4. 쇼핑몰 사장은 고객별 월간 판매액의 자료가 필요하다.
SELECT
    Userr.User_ID AS '고객 ID',
    Userr.Username AS '고객 이름',
    MONTH(Sale_Date) AS '월',
    YEAR(Sale_Date) AS '년도',
    SUM(Sale_Amount) AS '월간 판매액'
FROM
    Userr
JOIN
    Sales ON Userr.User_ID = Sales.User_ID
GROUP BY
    Userr.User_ID, Userr.Username, MONTH(Sale_Date), YEAR(Sale_Date);
-- 5. 쇼핑몰 사장은 년간 판매액의 자료가 필요하다.
SELECT
    YEAR(Sale_Date) AS '년도',
    SUM(Sale_Amount) AS '연간 판매액'
FROM
    Sales
GROUP BY
    YEAR(Sale_Date);
-- 6. 고객의 마일리지 중 사용한 마일리지와 사용하지 않은 마일리지를 관리한다.
SELECT
    User_ID AS '사용자 ID',
    SUM(Points_Earned) AS '총 적립 마일리지',
    SUM(Points_Used) AS '총 사용 마일리지',
    SUM(Points_Earned - Points_Used) AS '남은 마일리지'
FROM
    Point_History
GROUP BY
    User_ID;
-- 7. 연간 순수 이익금은 총매출액 - 플랫폼 사용료 이다.
SELECT
    YEAR(Sale_Date) AS '년도',
    SUM(Sale_Amount) AS '총 매출',
    SUM(Sale_Amount) - 
        SUM(Sale_Amount * 
            CASE
                WHEN DATEDIFF(CURDATE(), Join_Date) <= 365 THEN 0.001
                WHEN DATEDIFF(CURDATE(), Join_Date) <= 730 THEN 0.002
                ELSE 0.01
            END) AS '순이익'
FROM
    Sales
JOIN
    Mall ON Sales.Product_ID = Mall.Mall_ID
GROUP BY
    YEAR(Sale_Date);
-- 8. 사용자는 자신의 월간 마일리지의 자료가 필요하다.
SELECT
    YEAR(Purchase_Date) AS '년도',
    MONTH(Purchase_Date) AS '월',
    SUM(Quantity * Price) AS '월간 구매액'
FROM
    Orderr
JOIN
    Product ON Orderr.Product_ID = Product.Product_ID
WHERE
    User_ID = 1
GROUP BY
    YEAR(Purchase_Date), MONTH(Purchase_Date);
-- 9. 사용자는 자신의 구매 이력의 자료가 필요하다.
SELECT
    Orderr.Order_ID AS '주문 ID',
    Product_Name AS '상품 이름',
    Quantity AS '수량',
    Status AS '주문 상태',
    Purchase_Date AS '구매일'
FROM
    Orderr
JOIN
    Product ON Orderr.Product_ID = Product.Product_ID
WHERE
    User_ID = 1
ORDER BY
    Purchase_Date DESC;
-- 10. 사용자는 자신의 월간 마일리지의 자료가 필요하다.
SELECT
    User_ID AS '사용자 ID',
    MONTH(Transaction_Date) AS '월',
    YEAR(Transaction_Date) AS '년도',
    SUM(Points_Earned) AS '월간 적립 마일리지',
    SUM(Points_Used) AS '월간 사용 마일리지'
FROM
    Point_History
WHERE
    User_ID = 1
GROUP BY
    User_ID, MONTH(Transaction_Date), YEAR(Transaction_Date);
----------- 프로시저 
-- 1. 플랫폼 운영자는 입점 쇼핑몰의 1년치 판매액에 대한 플랫폼 사용료를 청구합니다.
    DELIMITER //
CREATE PROCEDURE GetPlatformFees()
BEGIN
    SELECT
        Mall_ID AS '쇼핑몰 ID',
        Mall_Name AS '쇼핑몰 이름',
        SUM(Sale_Amount) * 
            CASE
                WHEN DATEDIFF(CURDATE(), Join_Date) <= 365 THEN 0.001
                WHEN DATEDIFF(CURDATE(), Join_Date) <= 730 THEN 0.002
                ELSE 0.01
            END AS '플랫폼 사용료'
    FROM
        Mall
    JOIN
        Sales ON Mall.Mall_ID = Sales.Product_ID
    GROUP BY
        Mall_ID, Mall_Name;
END //
-- 2. 입점한 쇼핑몰의 정보 (이름, 입점일, 연락처, 품목, 누적된 플랫폼 사용료) 가 필요합니다.
    DELIMITER //
CREATE PROCEDURE GetMallInformation()
BEGIN
    SELECT
        Mall_Name AS '쇼핑몰 이름',
        Join_Date AS '입점일',
        Contact_Number AS '연락처',
        GROUP_CONCAT(DISTINCT Product_Name) AS '판매 품목',
        SUM(Sale_Amount * 
            CASE
                WHEN DATEDIFF(CURDATE(), Join_Date) <= 365 THEN 0.001
                WHEN DATEDIFF(CURDATE(), Join_Date) <= 730 THEN 0.002
                ELSE 0.01
            END) AS '누적 플랫폼 사용료'
    FROM
        Mall
    JOIN
        Sales ON Mall.Mall_ID = Sales.Product_ID
    JOIN
        Product ON Sales.Product_ID = Product.Product_ID
    GROUP BY
        Mall_Name, Join_Date, Contact_Number;
END //
-- 3. 쇼핑몰 사장은 상품별 월간 판매액의 자료가 필요합니다.
    DELIMITER //
CREATE PROCEDURE GetMonthlySalesByProduct()
BEGIN
    SELECT
        Product.Product_ID AS '상품 ID',
        Product.Product_Name AS '상품 이름',
        MONTH(Sales.Sale_Date) AS '월',
        YEAR(Sales.Sale_Date) AS '년도',
        SUM(Sales.Sale_Amount) AS '월간 판매액'
    FROM
        Sales
    JOIN
        Product ON Sales.Product_ID = Product.Product_ID
    GROUP BY
        Product.Product_ID, Product.Product_Name, MONTH(Sales.Sale_Date), YEAR(Sales.Sale_Date);
END //
-- 4. 쇼핑몰 사장은 고객별 월간 판매액의 자료가 필요합니다.
    DELIMITER //
CREATE PROCEDURE GetMonthlySalesByUser()
BEGIN
    SELECT
        Userr.User_ID AS '고객 ID',
        Userr.Username AS '고객 이름',
        MONTH(Sale_Date) AS '월',
        YEAR(Sale_Date) AS '년도',
        SUM(Sale_Amount) AS '월간 판매액'
    FROM
        Userr
    JOIN
        Sales ON Userr.User_ID = Sales.User_ID
    GROUP BY
        Userr.User_ID, Userr.Username, MONTH(Sale_Date), YEAR(Sale_Date);
END //
-- 5. 쇼핑몰 사장은 년간 판매액의 자료가 필요합니다.
    DELIMITER //
CREATE PROCEDURE GetYearlySales()
BEGIN
    SELECT
        YEAR(Sale_Date) AS '년도',
        SUM(Sale_Amount) AS '연간 판매액'
    FROM
        Sales
    GROUP BY
        YEAR(Sale_Date);
END //
-- 6. 고객의 마일리지 중 사용한 마일리지와 사용하지 않은 마일리지를 관리합니다.
    DELIMITER //
CREATE PROCEDURE GetPointsManagement()
BEGIN
    SELECT
        User_ID AS '사용자 ID',
        SUM(Points_Earned) AS '총 적립 마일리지',
        SUM(Points_Used) AS '총 사용 마일리지',
        SUM(Points_Earned - Points_Used) AS '남은 마일리지'
    FROM
        Point_History
    GROUP BY
        User_ID;
END //
-- 7. 연간 순수 이익금은 총 매출액에서 플랫폼 사용료를 차감한 값입니다.
    DELIMITER //
CREATE PROCEDURE GetAnnualNetProfits()
BEGIN
    SELECT
        YEAR(Sale_Date) AS '년도',
        SUM(Sale_Amount) AS '총 매출',
        SUM(Sale_Amount) - 
            SUM(Sale_Amount * 
                CASE
                    WHEN DATEDIFF(CURDATE(), Join_Date) <= 365 THEN 0.001
                    WHEN DATEDIFF(CURDATE(), Join_Date) <= 730 THEN 0.002
                    ELSE 0.01
                END) AS '순이익'
    FROM
        Sales
    JOIN
        Mall ON Sales.Product_ID = Mall.Mall_ID
    GROUP BY
        YEAR(Sale_Date);
END //
-- 8. 사용자는 자신의 월간 구매액 자료가 필요합니다.
	DELIMITER //
CREATE PROCEDURE GetUserMonthlyPurchaseAmount(IN userID INT)
BEGIN
    SELECT
        YEAR(Purchase_Date) AS '년도',
        MONTH(Purchase_Date) AS '월',
        SUM(Quantity * Price) AS '월간 구매액'
    FROM
        Orderr
    JOIN
        Product ON Orderr.Product_ID = Product.Product_ID
    WHERE
        User_ID = userID
    GROUP BY
        YEAR(Purchase_Date), MONTH(Purchase_Date);
END //
-- 9. 사용자는 자신의 구매 이력 자료가 필요합니다.
    DELIMITER //
CREATE PROCEDURE GetUserPurchaseHistory()
BEGIN
    SELECT
        Orderr.Order_ID AS '주문 ID',
        Product_Name AS '상품 이름',
        Quantity AS '수량',
        Status AS '주문 상태',
        Purchase_Date AS '구매일'
    FROM
        Orderr
    JOIN
        Product ON Orderr.Product_ID = Product.Product_ID
    WHERE
        User_ID = 1
    ORDER BY
        Purchase_Date DESC;
END //
-- 10. 사용자는 자신의 월간 마일리지 자료가 필요합니다.
    DELIMITER //
CREATE PROCEDURE GetMonthlyPointsByUser()
BEGIN
    SELECT
        User_ID AS '사용자 ID',
        MONTH(Transaction_Date) AS '월',
        YEAR(Transaction_Date) AS '년도',
        SUM(Points_Earned) AS '월간 적립 마일리지',
        SUM(Points_Used) AS '월간 사용 마일리지'
    FROM
        Point_History
    WHERE
        User_ID = 1
    GROUP BY
        User_ID, MONTH(Transaction_Date), YEAR(Transaction_Date);
END //
DELIMITER ;

-- 1. 플랫폼 사용료 조회 프로시저 호출
CALL GetPlatformFees();
-- 2. 입점한 쇼핑몰 정보 조회 프로시저 호출
CALL GetMallInformation();
-- 3. 쇼핑몰 상품별 월간 판매액 조회 프로시저 호출
CALL GetMonthlySalesByProduct();
-- 4. 사용자별 월간 판매액 조회 프로시저 호출
CALL GetMonthlySalesByUser();
-- 5. 년간 판매액 조회 프로시저 호출
CALL GetYearlySales();
-- 6. 마일리지 관리 조회 프로시저 호출
CALL GetPointsManagement();
-- 7. 연간 순수 이익금 조회 프로시저 호출
CALL GetAnnualNetProfits();
-- 8. 사용자의 월간 마일리지 조회 프로시저 호출 (사용자 ID = 1)
CALL GetUserMonthlyPurchaseAmount(1);
-- 9. 사용자의 구매 이력 조회 프로시저 호출
CALL GetUserPurchaseHistory();
-- 10. 사용자의 월간 마일리지 조회 프로시저 호출
CALL GetMonthlyPointsByUser();