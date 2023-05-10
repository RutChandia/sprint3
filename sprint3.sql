/*
Integrantes: 
Nicolás Ortega
Rut Chandía

GITHUB: https://github.com/RutChandia/sprint3
*/

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

ALTER TABLE clientes
ADD COLUMN fecha_nacimiento DATE;

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
('Juan', 'Pérez', 'Calle 123', '555-1234', 'juan@example.com'),
('María', 'González', 'Avenida 456', '555-5678', 'maria@example.com'),
('Pedro', 'López', 'Calle 789', '555-9012', 'pedro@example.com'),
('Ana', 'Martínez', 'Avenida 111', '555-3456', 'ana@example.com'),
('Diego', 'Hernández', 'Calle 222', '555-7890', 'diego@example.com'),
('Sofía', 'Ramírez', 'Avenida 333', '555-2345', 'sofia@example.com'),
('Carlos', 'Gómez', 'Calle 444', '555-6789', 'carlos@example.com'),
('Laura', 'Díaz', 'Avenida 555', '555-1234', 'laura@example.com'),
('Jorge', 'Vargas', 'Calle 666', '555-5678', 'jorge@example.com'),
('Mónica', 'Fernández', 'Avenida 777', '555-9012', 'monica@example.com');

UPDATE clientes SET fecha_nacimiento = '2007-01-01' WHERE id_cliente IN (1, 2, 5);
UPDATE clientes SET fecha_nacimiento = '2008-01-01' WHERE id_cliente = 3;
UPDATE clientes SET fecha_nacimiento = '2000-02-01' WHERE id_cliente = 4;
UPDATE clientes SET fecha_nacimiento = '1990-03-25' WHERE id_cliente = 7;


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

--- agregamos más directores para variedad
INSERT INTO directores (nombre, nacionalidad)
VALUES
('Todd Phillips', 'estadounidense'),
('Ben Stiller', 'estadounidense'),
( 'Rob Reiner', 'estadounidense');

-- y pelis de comedia y otros, para que funcionen las querys
INSERT INTO pelis (titulo, anio_lanzamiento, id_director, id_genero)
VALUES
('The Grand Budapest Hotel', 2014, 8, 2),
('¿Qué pasó ayer?', 2009, 11, 2),
('Zoolander', 2001, 12, 2),
('This Is Spinal Tap', 1984, 13, 2),
('Children of Men', 2006, 4, 6);

INSERT INTO directores (nombre, nacionalidad)
VALUES
('Todd Phillips', 'estadounidense'),
('Ben Stiller', 'estadounidense'),
( 'Rob Reiner', 'estadounidense'),


INSERT INTO rentas (id_cliente, id_pelicula, fecha_renta)
VALUES
(5, 8, '2023-05-01'),
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
SELECT pelis.titulo AS titulo_pelicula, generos.nombre_genero, directores.nombre AS nombre_director
FROM pelis
INNER JOIN generos ON pelis.id_genero = generos.id_genero
INNER JOIN directores ON pelis.id_director = directores.id_director
LEFT JOIN rentas ON pelis.id_pelicula = rentas.id_pelicula
WHERE rentas.fecha_devolucion IS NULL
GROUP BY pelis.titulo, generos.nombre_genero, directores.nombre;

-- Encuentra todas las películas del género de comedia.
SELECT pelis.titulo, generos.nombre_genero 
FROM pelis
INNER JOIN generos ON pelis.id_genero = generos.id_genero
WHERE generos.id_genero = 2;

-- Muestra una lista de todos los directores y sus películas correspondientes.
SELECT pelis.titulo, directores.nombre
FROM pelis
INNER JOIN directores ON pelis.id_director = directores.id_director 
GROUP BY pelis.titulo ASC;

--- Se veía desordenada, así aplicamos GROUP_CONCAT
SELECT directores.nombre, GROUP_CONCAT(pelis.titulo ORDER BY pelis.titulo ASC SEPARATOR ', ') AS peliculas
FROM pelis
INNER JOIN directores ON pelis.id_director = directores.id_director 
GROUP BY directores.nombre;

-- Encuentra todos los clientes que han rentado una película en particular.
SELECT clientes.nombre, clientes.apellido, rentas.fecha_renta, rentas.fecha_devolucion
FROM rentas 
INNER JOIN clientes ON rentas.id_cliente = clientes.id_cliente
WHERE rentas.id_pelicula = 8;

-- Encuentra el número total de rentas de una película en particular.
SELECT pelis.titulo, COUNT(*) AS rentas_totales
FROM rentas
INNER JOIN pelis ON rentas.id_pelicula = pelis.id_pelicula
WHERE pelis.id_pelicula = 8;

-- Muestra una lista de todas las películas que tienen menos de 3 rentas existentes.
SELECT pelis.titulo AS nombre_pelicula, COUNT(*) AS rentas_totales
FROM rentas
INNER JOIN pelis ON rentas.id_pelicula = pelis.id_pelicula
GROUP BY pelis.titulo;

-- Encuentra los clientes que tienen el mismo nombre.
SELECT nombre, apellido AS nombre_cliente, COUNT(*) AS num_ocurrencias
FROM clientes
GROUP BY nombre_cliente
HAVING COUNT(*) > 1;

-- Encuentra el número de rentas que han sido realizadas por clientes menores de 18 años.
SELECT COUNT(*) AS num_rentas
FROM rentas
INNER JOIN clientes ON rentas.id_cliente = clientes.id_cliente
WHERE DATEDIFF(CURRENT_DATE, clientes.fecha_nacimiento) / 365 < 18;

-- Encuentra el número de rentas que han sido realizadas por clientes con un correo electrónico que contiene la letra "a".
SELECT COUNT(*) AS num_rentas
FROM rentas
INNER JOIN clientes ON rentas.id_cliente = clientes.id_cliente
WHERE clientes.email LIKE '%a%';

-- Muestra una lista de todos los clientes que han realizado una renta, 
-- incluyendo su nombre, película rentada y fecha de renta.
SELECT clientes.nombre, clientes.apellido, pelis.titulo, rentas.fecha_renta 
FROM rentas
INNER JOIN clientes ON rentas.id_cliente = clientes.id_cliente
INNER JOIN pelis ON rentas.id_pelicula = pelis.id_pelicula
WHERE clientes.id_cliente IN (SELECT rentas.id_cliente
FROM rentas 
GROUP BY rentas.id_cliente
HAVING COUNT(*) = 1);


























