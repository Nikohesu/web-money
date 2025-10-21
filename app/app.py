from flask import Flask, render_template, request, redirect, session, url_for, jsonify
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

@app.route("/signup", methods=["GET","POST"])
def signup():
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
    return render_template("signup.html")

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
                return redirect(url_for("home"))
        else:
            return "Credenciales incorrectas. Inténtalo de nuevo."

    return render_template("login.html")

@app.route("/academy")
def academy():
    return render_template("academy.html")
@app.route("/home")
def home():
    return render_template("home.html")
    
@app.route("/admin/crud")
def crud():
    cursor.execute("SELECT * FROM `usuarios`")
    users = cursor.fetchall()
    return render_template ("admin-crud.html", users=users)

@app.route("/admin/crud/add", methods=["GET","POST"])
def add_user():
        if request.method == "POST":
            firstname = request.form["firstname"]
            lastname = request.form["lastname"]
            email = request.form["email"]
            telefono = request.form["telefono"]
            password = request.form["password"]
            hashed_password = generate_password_hash(password)
            nacimiento = request.form["nacimiento"]
            user_type = request.form["tipo_usuario"]
            cursor.execute("INSERT INTO usuarios (firstname, lastname, email, telefono, password, nacimiento,tipo_de_usuario) VALUES (%s,%s,%s,%s,%s,%s,%s)", (firstname,lastname,email,telefono,hashed_password,nacimiento,user_type))
            db.commit()
        return redirect(url_for("crud"))

@app.route("/admin/crud/delete/<int:user_id>", methods=["POST"])
def delete_user(user_id):
    cursor.execute("DELETE FROM usuarios WHERE id = %s", (user_id,))
    db.commit()
    return redirect(url_for("crud"))

"""""
@app.route("/admin/consult", methods=["POST"])
async def admin_consult():
    valor=request.get_json().get("user_id")
    print("recibido valor: ",valor)

    cursor.execute("SELECT * FROM usuarios WHERE id=%s",(valor,))
    info_user = cursor.fetchall()
    return jsonify({"mensaje": "Valor recibido correctamente", "info": info_user})
    
"""


#app.route("admin/crud/delete/<int:user_id>")

#app.route("admin/crud/update/<int:user_id>")
"""def update_user(user_id):
    cursor.execute("SELECT * FROM `usuarios` WHERE id = %s", (user_id,))
    user = cursor.fetchone()
    if request.method == "POST":
        firstname = request.form["firstname"]
        lastname = request.form["lastname"]
        email = request.form["email"]
        telefono = request.form["telefono"]
        nacimiento = request.form["nacimiento"]
        cursor.execute("UPDATE `usuarios` SET firstname=%s, lastname=%s, email=%s, telefono=%s, nacimiento=%s WHERE id=%s", (firstname, lastname, email, telefono, nacimiento, user_id))
        db.commit()
        return redirect(url_for("crud"))
    return redirect(url_for("crud"))
@app.route("admin/crud/more/<int:user_id>")
"""

@app.route('/logout')
def logout():
    session.pop('nombre', None)
    session.pop('email', None)
    return redirect(url_for('index'))

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/public/comming-soon')
def comming_soon_public():
    return render_template('comming-soon.html')

@app.route('/comming-soon')
def comming_soon():
    return render_template('comming-soon.html')

@app.context_processor
def user_context():
    if 'email' in session:
        return dict(user_rol=session["tipo_usuario"], profile_image=None)
    else:
        return {}


@app.before_request
def access ():
    public_routes = ['index','login','signup','contact', 'comming_soon_public']
    #evita el bloqueo de los css, las imagenes y el js
    if request.endpoint == 'static' or request.endpoint is None:
        return
    
    if 'email' in session and request.endpoint in public_routes:
        return redirect(url_for("home"))
    if not "email" in session and not request.endpoint in public_routes:
        return redirect(url_for("login"))
    if request.path.startswith("/admin") and not session["tipo_usuario"] == 0:
        return redirect(url_for("home"))
    

if __name__ == "__main__":
    app.run(debug=True)