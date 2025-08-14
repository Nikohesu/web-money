CREATE USER 'Jhoan'@'%' IDENTIFIED BY '1217';
GRANT ALL PRIVILEGES ON *.* TO 'Jhoan'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

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
    firstname VARCHAR(40) NOT NULL,
    lastname VARCHAR(40) NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    email VARCHAR(40) NOT NULL,
    pais VARCHAR(40),
    nacimiento DATE NOT NULL,
    fecha_de_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_de_usuario INT,
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