-- 1. Creación del tipo de objeto Producto
CREATE OR REPLACE TYPE Producto AS OBJECT (
    id_producto NUMBER,
    nombre VARCHAR2(100),
    precio NUMBER(10,2)
);
/

-- 2. Creación de la tabla basada en el tipo Producto
CREATE TABLE Productos OF Producto;

-- 3. Inserción de al menos dos registros
INSERT INTO Productos VALUES (Producto(1, 'Laptop', 1000.00));
INSERT INTO Productos VALUES (Producto(2, 'Ratón Inalámbrico', 25.50));
INSERT INTO Productos VALUES (Producto(3, 'Teclado Mecánico', 85.00));

COMMIT;

------------------------------------------------------


-- 1. Consulta todos los productos
SELECT * FROM Productos;

-- 2. Modifica el precio del producto con id_producto = 1 a 1250.00
UPDATE Productos 
SET precio = 1250.00 
WHERE id_producto = 1;

-- 3. Elimina el producto con id_producto = 2
DELETE FROM Productos 
WHERE id_producto = 2;

COMMIT;

--------------------------------------------------------------------

-- 1. Define un tipo Empleado
CREATE OR REPLACE TYPE Empleado AS OBJECT (
    id_emp NUMBER,
    nombre VARCHAR2(50)
);
/

-- 2. Crea una tabla Empleados basada en este tipo
CREATE TABLE Empleados OF Empleado;

-- 3. Define un tipo Proyecto (incluyendo un REF a Empleado)
CREATE OR REPLACE TYPE Proyecto AS OBJECT (
    id_proyecto NUMBER,
    nombre_proyecto VARCHAR2(100),
    responsable REF Empleado
);
/

-- 4. Crea una tabla Proyectos con la restricción SCOPE
-- La restricción SCOPE asegura que las referencias apunten únicamente a la tabla Empleados
CREATE TABLE Proyectos OF Proyecto (
    SCOPE FOR (responsable) IS Empleados
);

-- 5. Inserta datos y realiza la consulta
-- Primero, insertamos un empleado
INSERT INTO Empleados VALUES (Empleado(101, 'Ana García'));

-- Luego, insertamos el proyecto buscando la referencia (REF) del empleado
INSERT INTO Proyectos 
SELECT 1, 'Migración de Base de Datos', REF(e) 
FROM Empleados e 
WHERE e.id_emp = 101;

COMMIT;

-- Consulta para obtener el nombre del empleado responsable navegando a través del REF
SELECT p.nombre_proyecto, 
       p.responsable.nombre AS nombre_responsable 
FROM Proyectos p;


----------------------------------------------

-- 1. Define un tipo Telefonos como un VARRAY
CREATE OR REPLACE TYPE Telefonos AS VARRAY(3) OF VARCHAR2(15);
/

-- 2. Crea/Modifica el tipo Cliente para incluir los teléfonos
CREATE OR REPLACE TYPE Cliente AS OBJECT (
    id_cliente NUMBER,
    nombre_cliente VARCHAR2(50),
    lista_telefonos Telefonos
);
/

-- 3. Crea una tabla Clientes basada en este tipo y agrega datos
CREATE TABLE Clientes OF Cliente;

-- Insertamos un cliente con dos teléfonos y otro cliente con un solo teléfono
INSERT INTO Clientes VALUES (Cliente(1, 'Carlos López', Telefonos('555-1234', '555-5678')));
INSERT INTO Clientes VALUES (Cliente(2, 'María Fernández', Telefonos('555-9999')));

COMMIT;

-- 4. Realiza una consulta para obtener los teléfonos almacenados
-- Opción A: Ver la colección tal cual (dependerá de cómo lo muestre tu cliente SQL)
SELECT id_cliente, nombre_cliente, lista_telefonos FROM Clientes;

-- Opción B: "Desenrollar" (unnest) el VARRAY para ver los teléfonos en filas usando la función TABLE()
SELECT c.nombre_cliente, t.column_value AS telefono 
FROM Clientes c, TABLE(c.lista_telefonos) t;