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
    database="user_auth"
)

try:
    cursor = db.cursor()
except mysql.connector.errors.InterfaceError as err :
    print (f"error en la base de datos {err}")

@app.route('/')
def index():
    return render_template('index.html')




if __name__ == "__main__":
    app.run(debug=True)