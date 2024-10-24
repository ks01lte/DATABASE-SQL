import pymysql
import tkinter as tk
from tkinter import messagebox
from openpyxl import Workbook
import os

def connect_to_db():
    try:
        conn = pymysql.connect(
            host='127.0.0.1',
            user='root',
            password='1234',
            db='asd',
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        return conn
    except Exception as e:
        print("Error connecting to the database:", e)

class App:
    def __init__(self, window):
        self.window = window
        self.window.geometry("355x400")
        self.window.title("관리자용 데이터 관리")

        self.logged_in = False
    
        self.btn_login = tk.Button(self.window, text="로그인", command=self.login)
        self.btn_login.grid(row=0, column=3, pady=5, padx=10, sticky="NE")

        self.btn_logout = tk.Button(self.window, text="로그아웃", command=self.logout, state=tk.DISABLED)
        self.btn_logout.grid(row=1, column=3, pady=5, padx=10, sticky="NE")

        self.btn_insert = tk.Button(self.window, text="1. 플랫폼 사용료 청구 조회", command=self.calculate_platform_fee, state=tk.DISABLED)
        self.btn_insert.grid(row=2, column=0, pady=10, padx=10, sticky="W")

        self.btn_select = tk.Button(self.window, text="2. 쇼핑몰 정보 조회", command=self.get_mall_information, state=tk.DISABLED)
        self.btn_select.grid(row=3, column=0, pady=10, padx=10, sticky="W")

        self.btn_prod_sales = tk.Button(self.window, text="3. 상품별 월간 판매액 조회", command=self.get_monthly_product_sales, state=tk.DISABLED)
        self.btn_prod_sales.grid(row=4, column=3, pady=10, padx=10, sticky="E")

        self.btn_cust_sales = tk.Button(self.window, text="4. 고객별 월간 판매액 조회", command=self.get_monthly_customer_sales, state=tk.DISABLED)
        self.btn_cust_sales.grid(row=5, column=3, pady=10, padx=10, sticky="E")

        self.btn_yearly_sales = tk.Button(self.window, text="5. 연간 판매액 조회", command=self.get_yearly_sales, state=tk.DISABLED)
        self.btn_yearly_sales.grid(row=6, column=3, pady=10, padx=10, sticky="E")

        self.btn_manage_mileage = tk.Button(self.window, text="6. 고객의 마일리지 관리", command=self.manage_customer_mileage, state=tk.DISABLED)
        self.btn_manage_mileage.grid(row=7, column=3, pady=10, padx=10, sticky="E")

        self.btn_annual_profit = tk.Button(self.window, text="7. 년간 순수 이익금 조회", command=self.calculate_annual_profit, state=tk.DISABLED)
        self.btn_annual_profit.grid(row=8, column=3, pady=10, padx=10, sticky="E")


    def login(self):
        login_window = tk.Toplevel(self.window)
        login_window.title("로그인")
        login_window.geometry("250x200")
        tk.Label(login_window, text="").pack()
        label_username = tk.Label(login_window, text="아이디")
        label_username.pack()
        entry_username = tk.Entry(login_window)
        entry_username.pack()
        tk.Label(login_window, text="").pack()
        label_password = tk.Label(login_window, text="패스워드")
        label_password.pack()
        entry_password = tk.Entry(login_window, show="*")
        entry_password.pack()
        tk.Label(login_window, text="").pack()
        btn_login = tk.Button(login_window, text="로그인", command=lambda: self.authenticate(entry_username.get(), entry_password.get(), login_window))
        btn_login.pack()

        self.btn_login.config(state=tk.DISABLED)
        self.btn_logout.config(state=tk.NORMAL)

    def logout(self):
        self.logged_in = False
        self.show_buttons([])
        self.btn_login.config(state=tk.NORMAL)
        self.btn_logout.config(state=tk.DISABLED)
    
        messagebox.showinfo("로그아웃", "로그아웃되었습니다.")
    
    def authenticate(self, username, password, login_window):
        if (username == '운영자' and password == '123'):
            self.logged_in = True
            self.show_buttons(['btn_insert', 'btn_select'])
            messagebox.showinfo("로그인 성공", "운영자 로그인에 성공했습니다.")
            login_window.destroy()
        elif (username == '사장' and password == '123'):
            self.logged_in = True
            self.show_buttons(['btn_prod_sales', 'btn_cust_sales', 'btn_yearly_sales','btn_manage_mileage','btn_annual_profit'])
            messagebox.showinfo("로그인 성공", "사장 로그인에 성공했습니다.")
            login_window.destroy()
        else:
            messagebox.showerror("로그인 실패", "관리자 이름 또는 비밀번호가 올바르지 않습니다.")

    def show_buttons(self, btn_list):
        buttons = {
            'btn_insert': self.btn_insert,
            'btn_select': self.btn_select,
            'btn_prod_sales': self.btn_prod_sales,
            'btn_cust_sales': self.btn_cust_sales,
            'btn_yearly_sales': self.btn_yearly_sales,
            'btn_manage_mileage' : self.btn_manage_mileage,
            'btn_annual_profit' : self.btn_annual_profit,
            
        }
        for btn_name, btn in buttons.items():
            if btn_name in btn_list:
                btn.config(state=tk.NORMAL)
            else:
                btn.config(state=tk.DISABLED)


    def calculate_platform_fee(self): # 데이터 처리 함수 - 1번 요구사항
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
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
                    """
                    cursor.execute(sql)
                    result = cursor.fetchall()
                    self.save_to_excel(result)
        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()

    def get_mall_information(self): # 데이터 처리 함수 - 2번 요구사항
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
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
                    """
                    cursor.execute(sql)
                    result = cursor.fetchall()
                    self.save_to_excel(result)
        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()


    def get_monthly_product_sales(self): # 데이터 처리 함수 - 3번 요구사항
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
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
                    """
                    cursor.execute(sql)
                    result = cursor.fetchall()
                    self.save_to_excel(result)
        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()

    def get_monthly_customer_sales(self): # 데이터 처리 함수 - 4번 요구사항
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
                        SELECT
                            Userr.User_ID AS '고객 ID',
                            Userr.Username AS '고객 이름',
                            MONTH(Sales.Sale_Date) AS '월',
                            YEAR(Sales.Sale_Date) AS '년도',
                            SUM(Sales.Sale_Amount) AS '월간 판매액'
                        FROM
                            Userr
                        JOIN
                            Sales ON Userr.User_ID = Sales.User_ID
                        GROUP BY
                            Userr.User_ID, Userr.Username, MONTH(Sales.Sale_Date), YEAR(Sales.Sale_Date)
                        ORDER BY
                            MONTH(Sales.Sale_Date)
                    """
                    cursor.execute(sql)
                    result = cursor.fetchall()
                    self.save_to_excel(result)
        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()


    def get_yearly_sales(self): # 데이터 처리 함수 - 5번 요구사항
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
                        SELECT
                            YEAR(Sales.Sale_Date) AS '년도',
                            SUM(Sales.Sale_Amount) AS '연간 판매액'
                        FROM
                            Sales
                        GROUP BY
                            YEAR(Sales.Sale_Date);
                    """
                    cursor.execute(sql)
                    result = cursor.fetchall()
                    self.save_to_excel(result)
        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()


    def manage_customer_mileage(self): # 데이터 처리 함수 - 6번 요구사항
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
                        SELECT
                            User_ID AS '사용자 ID',
                            SUM(Points_Earned) AS '총 적립 마일리지',
                            SUM(Points_Used) AS '총 사용 마일리지',
                            SUM(Points_Earned - Points_Used) AS '남은 마일리지'
                        FROM
                            Point_History
                        GROUP BY
                            User_ID;
                    """
                    cursor.execute(sql)
                    result = cursor.fetchall()
                    self.save_to_excel(result)
        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()

    def calculate_annual_profit(self): # 데이터 처리 함수 - 7번 요구사항
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
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
                    """
                    cursor.execute(sql)
                    result = cursor.fetchall()
                    self.save_to_excel(result)
        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()

                
    def save_to_excel(self, data):
        wb = Workbook()
        ws = wb.active

        headers = list(data[0].keys()) if data else []
        ws.append(headers)

        for row in data:
            ws.append(list(row.values()))

        file_path = "data.xlsx"
        wb.save(file_path)
        os.system(f'start excel.exe {file_path}')

def main():
    root = tk.Tk()
    app = App(root)
    root.mainloop()

if __name__ == "__main__":
    main()
