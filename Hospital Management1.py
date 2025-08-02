import tkinter as tk
from tkinter import messagebox
import mysql.connector
import subprocess
def insert_data(table_name, values, query):
    try:
        conn = mysql.connector.connect(
            host='localhost',
            user='root',
            password='',  #xxxxxxxxxxxxx
            database=''  #xxxxxxxxxxxxxx
        )
        cursor = conn.cursor()
        cursor.execute(query, values)
        conn.commit()
        messagebox.showinfo("Success", f"Data inserted into {table_name}!")
        conn.close()
    except Exception as e:
        messagebox.showerror("Error", str(e))

def show_employee():
    home_frame.pack_forget()
    employee_frame.pack(fill='both', expand=True)

def back_to_home():
    employee_frame.pack_forget()
    home_frame.pack(fill='both', expand=True)

app = tk.Tk()
app.title("Hospital Management System")
app.geometry("1000x700")
app.configure(bg='black')

home_frame = tk.Frame(app, bg='black')
home_frame.pack(fill='both', expand=True)

home_title = tk.Label(home_frame, text="// Welcome to Hospital Management Software //", font=("Arial", 18, "bold"), fg='blue', bg='black')
home_title.pack(pady=30)

emp_button = tk.Button(home_frame, text="Hospital Management", font=("Arial", 14), bg='green', fg='blue', relief='solid', bd=2, command=show_employee)
emp_button.pack(pady=20)

employee_frame = tk.Frame(app, bg='black')

back_btn = tk.Button(employee_frame, text="Back", command=back_to_home, bg='green', fg='blue', relief='solid', bd=2)
back_btn.pack(pady=10)

button_frame = tk.Frame(employee_frame, bg='black')
button_frame.pack(pady=20)

form_frame = tk.Frame(employee_frame, bg='black')
form_frame.pack(pady=10)

tables = [
    "pasent_info", "pasent_desise", "docter_info", "other_employee",
    "blood_storage", "medition_storage", "farmasi", "desise"
]

buttons = {}
for i, table in enumerate(tables):
    def make_command(tbl=table):
        return lambda: show_form(tbl)
    btn = tk.Button(button_frame, text=f"Manage {table}", bg='black', fg='blue', highlightbackground='green', relief='solid', bd=2, command=make_command())
    btn.grid(row=0, column=i, padx=5, pady=5)
    buttons[table] = btn
form_fields = {
    "pasent_info": ["Patient ID", "Name", "Age", "Address", "Phone", "Blood Group", "Disease Name", "Disease ID", "Room", "Bed No"],
    "pasent_desise": ["Patient ID", "Disease Name", "Disease ID"],
    "docter_info": ["Doctor ID", "Name", "Specialization", "Phone"],
    "other_employee": ["Employee ID", "Name", "Role", "Phone"],
    "blood_storage": ["Blood Type", "Units Available"],
    "medition_storage": ["Medicine ID", "Name", "Stock"],
    "farmasi": ["Pharmacy ID", "Name", "Location"],
    "desise": ["Disease ID", "Name", "Symptoms"]
}

def show_form(table_name):
    for widget in form_frame.winfo_children():
        widget.destroy()

    tk.Label(form_frame, text=f"{table_name.replace('_', ' ').title()}", font=("Arial", 16, "bold"), fg='blue', bg='black').pack(pady=10)

    entries = {}
    for field in form_fields.get(table_name, []):
        tk.Label(form_frame, text=field, font=("Arial", 12), fg='blue', bg='black').pack(pady=2)
        entry = tk.Entry(form_frame, width=30)
        entry.pack(pady=2)
        entries[field] = entry

    def insert_action():
        values = tuple(entry.get() for entry in entries.values())
        columns = ', '.join(entries.keys())
        placeholders = ', '.join(['%s'] * len(entries))
        query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
        insert_data(table_name, values, query)

    def show_table_data():
        try:
            conn = mysql.connector.connect(
                host='localhost',
                user='root',
                password=' ',  #xxxxxxxxxxxxxxxxxxx
                database=''  #xxxxxxxxxxxxxxxxxx
            )
            cursor = conn.cursor()
            cursor.execute(f"SELECT * FROM {table_name}")
            rows = cursor.fetchall()
            cols = [desc[0] for desc in cursor.description]
            conn.close()

            table_window = tk.Toplevel(app)
            table_window.title(f"{table_name} Data")
            table_window.configure(bg='black')

            for j, col in enumerate(cols):
                tk.Label(table_window, text=col, font=('Arial', 10, 'bold'), fg='blue', bg='black', relief='solid', borderwidth=1, width=15).grid(row=0, column=j)

            for i, row in enumerate(rows):
                for j, val in enumerate(row):
                    tk.Label(table_window, text=str(val), fg='white', bg='black', relief='solid', borderwidth=1, width=15).grid(row=i+1, column=j)

        except Exception as e:
            messagebox.showerror("Error", str(e))

    btn_frame = tk.Frame(form_frame, bg='black')
    btn_frame.pack(pady=10)

    tk.Button(btn_frame, text=f"Insert into {table_name}", bg='green', fg='blue', relief='solid', bd=2, command=insert_action).pack(side='left', padx=5)
    tk.Button(btn_frame, text=f"See {table_name} Table", bg='green', fg='blue', relief='solid', bd=2, command=show_table_data).pack(side='left', padx=5)




app.mainloop()
