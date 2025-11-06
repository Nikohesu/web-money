CREATE USER IF NOT EXISTS 'Jhoan'@'%' IDENTIFIED BY '1217';
GRANT ALL PRIVILEGES ON *.* TO 'Jhoan'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS money_control
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE money_control;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(40) NOT NULL,
    lastname VARCHAR(40) NOT NULL,
    password VARCHAR(255) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    email VARCHAR(40) NOT NULL,
    pais VARCHAR(40),
    nacimiento DATE NOT NULL,
    genero ENUM('masculino', 'femenino', 'no_binario', 'prefiero_no_decir') DEFAULT 'prefiero_no_decir',
    fecha_de_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_de_usuario INT DEFAULT 1,
    duracion_tipo_de_usuario INT,
    theme INT DEFAULT 0;
);

CREATE TABLE IF NOT EXISTS sugerencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    calificacion INT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comentario VARCHAR(300) NOT NULL,
    usuario INT NOT NULL,
    tipo_sugerencia VARCHAR(100) NOT NULL,
    FOREIGN KEY (usuario) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS categorias_gr (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_name VARCHAR(100) NOT NULL
);

INSERT INTO categorias_gr (categoria_name) VALUES
('Ropa'),
('Transporte'),
('Alimentación');

CREATE TABLE IF NOT EXISTS categorias_ig (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_name VARCHAR(100) NOT NULL
);

INSERT INTO categorias_ig (categoria_name) VALUES
('Salario'),
('Inversiones'),
('Emprendimiento');

CREATE TABLE IF NOT EXISTS ingresos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor INT NOT NULL,
    categoria INT NOT NULL,
    usuario INT NOT NULL,
    FOREIGN KEY (categoria) REFERENCES categorias_ig(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS egresos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor INT NOT NULL,
    categoria INT NOT NULL,
    usuario INT NOT NULL,
    FOREIGN KEY (categoria) REFERENCES categorias_gr(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario) REFERENCES usuarios(id) ON DELETE CASCADE
);

