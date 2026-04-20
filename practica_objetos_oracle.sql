/* Ejercicio 1: Tipo base */
CREATE TYPE Producto AS OBJECT (
  id_producto NUMBER,
  nombre      VARCHAR2(50),
  precio      NUMBER(6,2)
) NOT FINAL;    /* SIGNIFICA QUE PUEDE TENER SUBTIPOS
/

/* Tabla basada en el tipo objeto */
CREATE TABLE Productos OF Producto (
  CONSTRAINT pk_productos PRIMARY KEY (id_producto) /* SON RESTRICCIONES / REGLAS
);
/

/* Insertar 3 productos (tipo base) */
INSERT INTO Productos VALUES (Producto(1, 'Cuaderno', 2.50));
INSERT INTO Productos VALUES (Producto(2, 'Bolígrafo', 1.20));
INSERT INTO Productos VALUES (Producto(3, 'Mochila', 29.90));

/* Ejercicio 2: Subtipo con herencia */
CREATE TYPE ProductoElectronico UNDER Producto (
  garantia NUMBER
);
/

/* Insertar 1 producto electrónico en la MISMA tabla Productos */
INSERT INTO Productos
VALUES (ProductoElectronico(5, 'Auriculares 2', 149.99, 24));

/* Consulta: todos los productos con su info
   - TREAT(...) permite ver "garantia" cuando realmente es electrónico */
SELECT
  p.id_producto,
  p.nombre,
  p.precio,
  TREAT(VALUE(p) AS ProductoElectronico).garantia AS garantia_meses
FROM Productos p
ORDER BY p.id_producto;

/* Ejercicio 3: Consultas sobre Objetos */
/*Recupera el id_producto y el nombre de todos los productos.*/
SELECT
    p.id_producto,
    p.nombre
FROM Productos p;

/*Recupera el nombre y el precio de los productos cuyo precio sea mayor a 50*/
SELECT
    p.nombre,
    p.precio
FROM Productos p
WHERE p.precio > 50;

/*Si existen productos de tipo ProductoElectronico, obtén su garantia junto con su nombre.*/
SELECT
  p.nombre,
  TREAT(VALUE(p) AS ProductoElectronico).garantia AS garantia_meses
FROM Productos p
WHERE VALUE(p) IS OF (ONLY ProductoElectronico);

/*Ejercicio 4: Manipulación de Objetos*/
/*Crea un nuevo tipo de objeto llamado Cliente*/
CREATE TYPE Cliente AS OBJECT (
  id_cliente NUMBER,
  nombre     VARCHAR2(50),
  telefono   VARCHAR2(15)
);
/

/*Crea una tabla Clientes basada en Cliente*/
/*Agrega una restricción de clave primaria sobre id_cliente.*/
CREATE TABLE Clientes OF Cliente (
  CONSTRAINT pk_clientes PRIMARY KEY (id_cliente)
);
/

/*Inserta al menos tres clientes en la tabla*/
INSERT INTO Clientes VALUES (Cliente(1, 'Ana López', '600123456'));
INSERT INTO Clientes VALUES (Cliente(2, 'Carlos Pérez', '611987654'));
INSERT INTO Clientes VALUES (Cliente(3, 'Alberto Ruiz', '622456789'));

COMMIT;

/*Realiza una consulta para obtener los clientes cuyo nombre comience con "A".*/
SELECT
  c.id_cliente,
  c.nombre,
  c.telefono
FROM Clientes c
WHERE c.nombre LIKE 'A%';
COMMIT;
