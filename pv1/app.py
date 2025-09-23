from flask import Flask, render_template, request, redirect, url_for
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
    database="prueba"
)

try:
    cursor = db.cursor()
except mysql.connector.errors.InterfaceError as err :
    print (f"error en la base de datos {err}")

@app.route('/')
def index():
    return render_template('form.html')

@app.route('/registrar', methods=['POST'])
def registrar():
    nombre = request.form.get('nombre')
    apellido = request.form.get('apellido')
    email = request.form.get('email')

    if not nombre or not apellido or not email:
        return "Todos los campos son obligatorios", 400

    try:
        cursor = db.cursor()
        query = "INSERT INTO usuarios (nombre, apellido, email) VALUES (%s, %s, %s)"
        valores = (nombre, apellido, email)
        cursor.execute(query, valores)
        db.commit()
        return redirect(url_for('index'))
    except mysql.connector.Error as err:
        return f"Error al insertar en la base de datos: {err}", 500


@app.route('/users')
def users():
    try:
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT nombre, apellido, email FROM usuarios")
        lista_usuarios = cursor.fetchall()
        return render_template('users.html', usuarios=lista_usuarios)
    except mysql.connector.Error as err:
        return f"Error al recuperar usuarios: {err}", 500



if __name__ == "__main__":
    app.run(debug=True)