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
    duracion_tipo_de_usuario INT DEFAULT NULL --DURACION DE UN USUARIO PREMIUM
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

CREATE TABLE IF NOT EXISTS ingresos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor INT NOT NULL,
    categoria VARCHAR(300) NOT NULL,
    usuario INT NOT NULL,
    FOREIGN KEY (usuario) REFERENCES usuarios(id),
    --FOREIGN KEY (tipo_sugerencia) REFERENCES tipo_de_sugerencia(id)
);

