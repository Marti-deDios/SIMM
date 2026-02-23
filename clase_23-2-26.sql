CREATE TYPE Producto AS OBJECT (
	id_producto NUMBER,
	nombre VARCHAR2(50),
	precio NUMBER(6,2)
) NOT FINAL;