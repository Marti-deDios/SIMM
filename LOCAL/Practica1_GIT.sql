
--Ejercicio 1

-- 1. Crea el tipo de objeto Producto
CREATE OR REPLACE TYPE Producto AS OBJECT (
    id_producto NUMBER,
    nombre VARCHAR2(50),
    precio NUMBER(6,2)
) NOT FINAL;
/

-- 2. Crea una tabla llamada Productos basada en ese tipo
CREATE TABLE Productos OF Producto (
    id_producto PRIMARY KEY
);

-- 3. Inserta tres productos en la tabla
INSERT INTO Productos VALUES (Producto(1, 'Silla de Oficina', 45.50));
INSERT INTO Productos VALUES (Producto(2, 'Escritorio', 120.00));
INSERT INTO Productos VALUES (Producto(3, 'Lámpara LED', 15.99));



--Ejercicio 2


-- 1. Crea el tipo ProductoElectronico como un subtipo de Producto
CREATE OR REPLACE TYPE ProductoElectronico UNDER Producto (
    garantia NUMBER
);
/

-- 2. Inserta un producto en la tabla Productos utilizando ProductoElectronico
INSERT INTO Productos VALUES (ProductoElectronico(4, 'Monitor 24 pulgadas', 150.00, 24));

-- 3. Realiza una consulta para obtener todos los productos con su información
-- Usamos VALUE() para ver la instancia completa del objeto
SELECT VALUE(p) FROM Productos p;

-- Opcional: Vista en formato relacional estándar (columnas)
SELECT p.id_producto, p.nombre, p.precio FROM Productos p;


--Ejercicio 3

-- 1. Recupera el id_producto y el nombre de todos los productos
SELECT p.id_producto, p.nombre 
FROM Productos p;

-- 2. Recupera el nombre y el precio de los productos cuyo precio sea mayor a 50
SELECT p.nombre, p.precio 
FROM Productos p 
WHERE p.precio > 50;

-- 3. Obtén la garantía y el nombre de los productos de tipo ProductoElectronico
SELECT p.nombre, 
       TREAT(VALUE(p) AS ProductoElectronico).garantia AS meses_garantia
FROM Productos p
WHERE VALUE(p) IS OF (ProductoElectronico);


--Ejercicio 4

-- 1. Crea un nuevo tipo de objeto llamado Cliente
CREATE OR REPLACE TYPE Cliente AS OBJECT (
    id_cliente NUMBER,
    nombre VARCHAR2(50),
    telefono VARCHAR2(15)
);
/

-- 2 y 3. Crea una tabla Clientes y agrega restricción de clave primaria
CREATE TABLE Clientes OF Cliente (
    id_cliente PRIMARY KEY
);

-- 4. Inserta al menos tres clientes en la tabla
INSERT INTO Clientes VALUES (Cliente(101, 'Ana Martinez', '600123456'));
INSERT INTO Clientes VALUES (Cliente(102, 'Carlos Ruiz', '600987654'));
INSERT INTO Clientes VALUES (Cliente(103, 'Alberto Gomez', '600555444'));

-- 5. Realiza una consulta para obtener los clientes cuyo nombre comience con "A"
SELECT c.nombre, c.telefono 
FROM Clientes c 
WHERE c.nombre LIKE 'A%';
