CREATE DATABASE sprint3;

CREATE USER 'admins3'@'localhost' IDENTIFIED BY 'pass1234';
GRANT ALL PRIVILEGES ON sprint3.* TO 'admins3'@'localhost';

USE sprint3;

CREATE TABLE clientes(
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR(50),
apellido VARCHAR(50),
direccion VARCHAR(150),
telefono VARCHAR(20),
email VARCHAR(100)
);

CREATE TABLE directores(
id_director INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR(50),
apellido VARCHAR(50),
nacionalidad VARCHAR(50)
);

CREATE TABLE generos(
id_genero INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre_genero VARCHAR(50)
);

CREATE TABLE pelis(
id_pelicula INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
titulo VARCHAR(150),
anio_lanzamiento INT,
id_director INT,
id_genero INT,
FOREIGN KEY (id_director) REFERENCES directores(id_director),
FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
);

CREATE TABLE rentas(
id_renta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
fecha_renta DATETIME,
fecha_devolucion DATETIME,
id_cliente INT,
id_pelicula INT,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_pelicula) REFERENCES pelis(id_pelicula)
);

INSERT INTO clientes (nombre, apellido, direccion, telefono, email)
VALUES
('Ana', 'López', 'Calle 123', '555-1234', 'ana.lopez@example.com'),
('Juan', 'García', 'Avenida 456', '555-5678', 'juan.garcia@example.com'),
('María', 'González', 'Calle 789', '555-9012', 'maria.gonzalez@example.com'),
('Pedro', 'Hernández', 'Avenida 123', '555-3456', 'pedro.hernandez@example.com'),
('Sofía', 'Pérez', 'Calle 456', '555-7890', 'sofia.perez@example.com'),
('Jorge', 'Martínez', 'Avenida 789', '555-1234', 'jorge.martinez@example.com'),
('Lucía', 'Sánchez', 'Calle 123', '555-5678', 'lucia.sanchez@example.com'),
('Diego', 'Ruiz', 'Avenida 456', '555-9012', 'diego.ruiz@example.com'),
('Ana', 'Torres', 'Calle 789', '555-3456', 'ana.torres@example.com'),
('Javier', 'Flores', 'Avenida 123', '555-7890', 'javier.flores@example.com');

INSERT INTO directores (nombre, nacionalidad)
VALUES
('Christopher Nolan', 'británico'),
('Martin Scorsese', 'estadounidense'),
('Quentin Tarantino', 'estadounidense'),
('Alfonso Cuarón', 'mexicano'),
('Pedro Almodóvar', 'español'),
('Bong Joon-ho', 'coreano'),
('Sofia Coppola', 'estadounidense'),
('Wes Anderson', 'estadounidense'),
('Guillermo del Toro', 'mexicano'),
('David Fincher', 'estadounidense');

INSERT INTO generos (nombre_genero)
VALUES
('Acción'),
('Comedia'),
('Drama'),
('Terror'),
('Aventura'),
('Ciencia Ficción'),
('Romance'),
('Thriller'),
('Documental'),
('Animación');

INSERT INTO pelis (titulo, anio_lanzamiento, id_director, id_genero)
VALUES
('El Caballero de la Noche', 2008, 1, 1),
('La La Land', 2016, 2, 7),
('Parásitos', 2019, 6, 3),
('Pulp Fiction', 1994, 3, 8),
('Gravity', 2013, 4, 6),
('Hable con ella', 2002, 5, 3),
('Moonrise Kingdom', 2012, 8, 7),
('El laberinto del fauno', 2006, 9, 4),
('Zodiac', 2007, 10, 8),
('Akira', 1988, 7, 6);

INSERT INTO rentas (id_cliente, id_pelicula, fecha_renta)
VALUES
(1, 2, '2023-05-05'),
(3, 7, '2023-05-06'),
(5, 1, '2023-05-01'),
(2, 8, '2023-05-02'),
(7, 5, '2023-05-03'),
(9, 3, '2023-05-04'),
(4, 6, '2023-05-05'),
(10, 4, '2023-05-06'),
(1, 9, '2023-05-07'),
(6, 10, '2023-05-08');

UPDATE rentas SET fecha_devolucion = '2023-05-08' WHERE id_renta IN (1, 2, 5);
UPDATE rentas SET fecha_devolucion = NOW() WHERE id_renta IN (7, 8, 9);

-- Muestra una lista de todas las películas disponibles, incluyendo su título, género, director y disponibilidad.

















