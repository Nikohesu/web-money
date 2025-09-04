from flask import Flask, render_template, request, redirect, session, url_for
import mysql.connector
from flask_session import Session
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

app.secret_key = "clave_secreta"
app.config['SESSION_TYPE'] = 'filesystem'
Session(app)

db = mysql.connector.connect(
    host="localhost",
    user="Jhoan",
    password="1217",
    database="money_control"
)

try:
    cursor = db.cursor()
except mysql.connector.errors.InterfaceError as err :
    print (f"error en la base de datos {err}")

@app.route('/')
def index():
    return render_template('index.html')

@app.route("/register", methods=["GET","POST"])
def register():
    if request.method == "POST":
        firstname = request.form["firstname"]
        lastname = request.form["lastname"]
        email = request.form["email"]
        telefono = request.form["telefono"]
        password = request.form["password"]
        hashed_password = generate_password_hash(password)
        nacimiento = request.form["nacimiento"]
        cursor.execute("INSERT INTO usuarios (firstname, lastname, email, telefono, password, nacimiento) VALUES (%s,%s,%s,%s,%s,%s)", (firstname,lastname,email,telefono,hashed_password,nacimiento))
        db.commit()
        return redirect ("/")
    return render_template("registrate.html")

@app.route("/login", methods=["GET","POST"])
def login ():
    if request.method== "POST":
        email = request.form["email"]
        password = request.form["password"]

        cursor.execute("SELECT * FROM `usuarios` WHERE email = %s", (email, )) 
        user = cursor.fetchone()

        if user and check_password_hash(str(user[3]), password):
            session['email'] = email
            session["tipo_usuario"] = user[10]

            if session["tipo_usuario"] == 0:
                return redirect(url_for("crud"))
            else:
                return redirect(url_for("informate"))
        else:
            return "Credenciales incorrectas. Inténtalo de nuevo."

    return render_template("login.html")

@app.route("/informate")
def informate():
    if "email" in session:
        return render_template ("informate.html")
    else:
        return redirect(url_for('login'))
    
@app.route("/crud")
def crud():
    if "email" in session:
        if session["tipo_usuario"] == 0:
            cursor.execute("SELECT * FROM `usuarios`")
            users = cursor.fetchall()
            print(users)
            return render_template ("crud.html", user_rol = 0, users=users)
        else :
            return redirect (url_for("informate"))
    else:
        return redirect (url_for("login"))
    


@app.route('/logout')
def logout():
    session.pop('nombre', None)
    session.pop('email', None)
    return redirect(url_for('index'))




if __name__ == "__main__":
    app.run(debug=True)