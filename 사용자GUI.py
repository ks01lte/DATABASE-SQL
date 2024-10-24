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
        self.window.geometry("300x500")
        self.window.title("사용자용 정보 조회")
        self.logged_in_user_id = None
        self.logged_in = False

        self.frame = tk.Frame(self.window)
        self.frame.grid(row=0, column=0, padx=50, pady=50)

        self.label_welcome = tk.Label(self.frame, text="환영합니다!", font=("Arial", 12, "bold"))
        self.label_welcome.grid(row=0, column=0, columnspan=2, pady=10, padx=10, sticky="nsew")

        self.btn_login = tk.Button(self.frame, text="로그인", command=self.login)
        self.btn_login.grid(row=1, column=0, columnspan=2, pady=15, padx=15, sticky="nsew")

        self.btn_monthly_purchase = tk.Button(self.frame, text="8. 월간 구매액 조회", command=self.get_monthly_purchase, state=tk.DISABLED)
        self.btn_monthly_purchase.grid(row=2, column=0, columnspan=2, pady=10, padx=0, sticky="nsew")

        self.btn_purchase_history = tk.Button(self.frame, text="9. 구매 이력 조회", command=self.get_user_purchase_history, state=tk.DISABLED)
        self.btn_purchase_history.grid(row=3, column=0, columnspan=2, pady=10, padx=0, sticky="nsew")

        self.btn_monthly_mileage = tk.Button(self.frame, text="10. 월간 마일리지 조회", command=self.get_user_monthly_mileage, state=tk.DISABLED)
        self.btn_monthly_mileage.grid(row=4, column=0, columnspan=2, pady=10, padx=0, sticky="nsew")

        self.btn_logout = tk.Button(self.frame, text="로그아웃", command=self.logout, state=tk.DISABLED)
        self.btn_logout.grid(row=5, column=0, columnspan=2, pady=10, padx=0, sticky="nsew")

        self.window.columnconfigure(0, weight=1)
        self.window.rowconfigure(0, weight=1)

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
        self.logged_in_user_id = None
        self.label_welcome.config(text="환영합니다!")
        self.show_buttons([])
        self.btn_login.config(state=tk.NORMAL)
        self.btn_logout.config(state=tk.DISABLED)

        messagebox.showinfo("로그아웃", "로그아웃되었습니다.")
        
    def authenticate(self, username, password, login_window):
        if self.check_user_credentials(username, password):
            self.logged_in = True
            self.logged_in_user_id = self.get_user_id(username)

            welcome_text = f"{username}님 환영합니다!"
            self.label_welcome.config(text=welcome_text)
            
            self.show_buttons(['btn_monthly_purchase', 'btn_purchase_history', 'btn_monthly_mileage'])
            messagebox.showinfo("로그인 성공", "로그인에 성공했습니다.")
            login_window.destroy()
        else:
            messagebox.showerror("로그인 실패", "사용자 이름 또는 비밀번호가 올바르지 않습니다.")
    def get_user_id(self, username):
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = "SELECT User_ID FROM Userr WHERE Username = %s"
                    cursor.execute(sql, (username,))
                    result = cursor.fetchone()
                    if result:
                        return result['User_ID']
        except Exception as e:
            print("Error fetching user ID:", e)
        finally:
            if conn:
                conn.close()
    def check_user_credentials(self, username, password):
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = "SELECT * FROM Userr WHERE Username = %s AND User_ID = %s"
                    cursor.execute(sql, (username, password))
                    result = cursor.fetchone()
                    return result is not None
        except Exception as e:
            print("Error checking user credentials:", e)
        finally:
            if conn:
                conn.close()

    def show_buttons(self, btn_list):
        buttons = {
            'btn_monthly_purchase' : self.btn_monthly_purchase,
            'btn_purchase_history' : self.btn_purchase_history,
            'btn_monthly_mileage' : self.btn_monthly_mileage
            
        }
        for btn_name, btn in buttons.items():
            if btn_name in btn_list:
                btn.config(state=tk.NORMAL)
            else:
                btn.config(state=tk.DISABLED)


    # 데이터 처리 함수 - 8번 요구사항
    def get_monthly_purchase(self):
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
                        SELECT
                            YEAR(Purchase_Date) AS '년도',
                            MONTH(Purchase_Date) AS '월',
                            SUM(Quantity * Price) AS '월간 구매액'
                        FROM
                            Orderr
                        JOIN
                            Product ON Orderr.Product_ID = Product.Product_ID
                        WHERE
                            User_ID = %s
                        GROUP BY
                            YEAR(Purchase_Date), MONTH(Purchase_Date)
                        ORDER BY
                            MONTH(Purchase_Date);
                    """
                    cursor.execute(sql, (self.logged_in_user_id,))
                    result = cursor.fetchall()

                    result_window = tk.Toplevel(self.window)
                    result_window.title("월간 구매액 조회 결과")

                    listbox = tk.Listbox(result_window, width=70)
                    listbox.pack(padx=10, pady=10)

                    for row in result:
                        listbox.insert(tk.END, f"{row['년도']}년 {row['월']}월 구매액 : {row['월간 구매액']:.0f}원")

        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()
                
    # 데이터 처리 함수 - 9번 요구사항
    def get_user_purchase_history(self):
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
                        SELECT

                            Product.Product_Name AS '상품 이름',
                            Orderr.Purchase_Date AS '구매일'
                        FROM
                            Orderr
                        JOIN
                            Product ON Orderr.Product_ID = Product.Product_ID
                        WHERE
                            User_ID = %s;
                    """
                    cursor.execute(sql, (self.logged_in_user_id,))
                    result = cursor.fetchall()

                    result_window = tk.Toplevel(self.window)
                    result_window.title("구매 이력 조회 결과")

                    listbox = tk.Listbox(result_window, width=70)
                    listbox.pack(padx=10, pady=10)

                    for row in result:
                        order_info = f"구매일 : {row['구매일']} | 상품 : {row['상품 이름']}"
                        listbox.insert(tk.END, order_info)

        except Exception as e:
            print("Error executing SQL query:", e)
        finally:
            if conn:
                conn.close()


    # 데이터 처리 함수 - 10번 요구사항
    def get_user_monthly_mileage(self):
        try:
            conn = connect_to_db()
            if conn:
                with conn.cursor() as cursor:
                    sql = """
                        SELECT
                            User_ID AS '사용자 ID',
                            MONTH(Transaction_Date) AS '월',
                            YEAR(Transaction_Date) AS '년도',
                            SUM(Points_Earned) AS '월간 적립 마일리지',
                            SUM(Points_Used) AS '월간 사용 마일리지'
                        FROM
                            Point_History
                        WHERE
                            User_ID = %s
                        GROUP BY
                            User_ID, MONTH(Transaction_Date), YEAR(Transaction_Date)
                        ORDER BY
                            MONTH(Transaction_Date);
                    """
                    cursor.execute(sql, (self.logged_in_user_id,))
                    result = cursor.fetchall()

                    result_window = tk.Toplevel(self.window)
                    result_window.title("월간 마일리지 조회 결과")

                    listbox = tk.Listbox(result_window, width=70)
                    listbox.pack(padx=10, pady=10)

                    for row in result:
                        mileage_info = f"{row['년도']}년 {row['월']}월 적립 마일리지 : {row['월간 적립 마일리지']}포인트 | 사용 마일리지 : {row['월간 사용 마일리지']}포인트"
                        listbox.insert(tk.END, mileage_info)

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

        file_path = "i_hate_database_subject.xlsx"
        wb.save(file_path)
        os.system(f'start excel.exe {file_path}')

def main():
    root = tk.Tk()
    app = App(root)
    root.mainloop()

if __name__ == "__main__":
    main()
