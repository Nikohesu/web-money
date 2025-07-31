CREATE DATABASE IF NOT EXISTS money_control
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE money_control;

CREATE TABLE IF NOT EXISTS tipo_de_usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_de_usuario VARCHAR(10) NOT NULL,
    duracion_meses INT NOT NULL
    -- agregar el campo id_pago más adelante como clave foránea
);

CREATE TABLE IF NOT EXISTS tipo_de_sugerencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_de_sugerencia VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(40) NOT NULL,
    segundo_nombre VARCHAR(40) NOT NULL,
    primer_apellido VARCHAR(40) NOT NULL,
    segundo_apellido VARCHAR(40) NOT NULL,
    nombre_de_usuario VARCHAR(40) NOT NULL,
    contrasena VARCHAR(40) NOT NULL,
    telefono VARCHAR(100) NOT NULL,
    correo VARCHAR(40) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    fecha_de_nacimiento DATE NOT NULL,
    genero VARCHAR(100) NOT NULL,
    fecha_de_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_de_usuario INT NOT NULL,
    FOREIGN KEY (tipo_de_usuario) REFERENCES tipo_de_usuario(id)
);

CREATE TABLE IF NOT EXISTS sugerencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    calificacion INT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comentario VARCHAR(300) NOT NULL,
    usuario INT NOT NULL,
    tipo_sugerencia INT NOT NULL,
    FOREIGN KEY (usuario) REFERENCES usuarios(id),
    FOREIGN KEY (tipo_sugerencia) REFERENCES tipo_de_sugerencia(id)
);



--Pagos
CREATE TABLE IF NOT EXTIST pagos
id INT AUTO_INCREMENT PRIMARY KEY
tipo_de_pago VARCHAR(100) NOT NULL


--gastos
CREATE TABLE IF NOT EXISTS gastos
id INT AUTO_INCREMENT PRIMARY KEY
valor INT AUTO_INCREMENT PRIMARY KEY
fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
id_usuario INT AUTO_INCREMENT PRIMARY KEY --CLAVE FORANEA

--ingresos
CREATE TABLE IF NOT EXISTS ingresos
id INT AUTO_INCREMENT PRIMARY KEY
valor INT AUTO_INCREMENT PRIMARY KEY
fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
id_usuario INT AUTO_INCREMENT PRIMARY KEY --CLAVE FORANEA

--tipo de sugerencias
CREATE TABLE IF NOT EXISTS tipo_sugerencia
id INT AUTO_INCREMENT PRIMARY KEY
nombre_tipo_sugerencia VARCHAR(100) NOT NULL

--categoria gastos
CREATE TABLE IF NOT EXISTS categoria_gastos
id INT AUTO_INCREMENT PRIMARY KEY
nombre VARCHAR(100) NOT NULL
id_usuario INT AUTO_INCREMENT PRIMARY KEY --CLAVE FORANEA

--categoria ingresos
CREATE TABLE IF NOT EXISTS categoria_ingresos
id INT AUTO_INCREMENT PRIMARY KEY
nombre VARCHAR(100) NOT NULL
id_usuario INT AUTO_INCREMENT PRIMARY KEY --CLAVE FORANEA
