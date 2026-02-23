CREATE TYPE Producto AS OBJECT (
	id_producto NUMBER,
	nombre VARCHAR2(50),
	precio NUMBER(6,2)
) NOT FINAL;
/

CREATE TABLE Productos OF Producto;
/

INSERT INTO Productos (id_producto, nombre, precio) VALUES (1, 'Ordenador', 300);
INSERT INTO Productos (id_producto, nombre, precio) VALUES (2, 'Manzana', 2.5);
INSERT INTO Productos (id_producto, nombre, precio) VALUES (3, 'Camiseta', 19.99);

CREATE TYPE ProductoElectronico UNDER Producto (
	garantia NUMBER
);
/

INSERT INTO Productos VALUES (ProductoElectronico(4, 'Vaper', 6, 2));

SELECT p.*
FROM Productos p;

SELECT p.id_producto AS ID, p.nombre AS NOMBRE
FROM Productos p;

SELECT p.nombre AS NOMBRE, p.precio AS PRECIO
FROM Productos p
WHERE p.precio > 50;

SELECT p.nombre,
       TREAT(VALUE(p) AS ProductoElectronico).garantia AS garantia
FROM Productos p
WHERE VALUE(p) IS OF (ProductoElectronico);

CREATE TYPE Cliente AS OBJECT (
	id_cliente NUMBER,
	nombre VARCHAR2(50),
	telefono VARCHAR2(15)
);
/

CREATE TABLE Clientes OF Cliente;
/

ALTER TABLE Clientes ADD CONSTRAINT pk_clientes PRIMARY KEY (id_cliente);
/

INSERT INTO Clientes VALUES (1, 'Movistar', '626642634');
INSERT INTO Clientes VALUES (2, 'Orange', '688888634');
INSERT INTO Clientes VALUES (3, 'Zara', '626643333');

SELECT c.nombre AS CLIENTE
FROM Clientes c
WHERE c.nombre LIKE 'A%';