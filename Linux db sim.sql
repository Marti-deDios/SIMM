1. -- CLASE 11/2/2026

-- Crear un usuario devuser con privilegios de conexión
-- CREATE USER devuser IDENTIFIED BY "DevPass123";
-- GRANT CONNECT TO devuser;
-- Cambiar la contraseña y verificar acceso
-- ALTER USER devuser IDENTIFIED BY "NewDevPass2!";
-- Bloquear y desbloquear 
-- ALTER USER devuser ACCOUNT LOCK;
-- ALTER USER devuser ACCOUNT UNLOCK;

2. -- CLASE 16/2/2026

-- Ver si la BD está levantada
SELECT status FROM v$instance;
-- Ver modo OPEN o MOUNT
SELECT open_mode FROM v$database;
-- Entender memoria
SELECT * FROM v$sga;
-- Ver DBWR, LGWR, etc.
SELECT pname FROM v$process;
-- Ver usuarios conectados
SELECT username FROM v$session;
-- Ver configuración actual
SELECT name, value FROM v$parameter;

-- Crear tabla básica
CREATE TABLE prueba (id NUMBER, nombre VARCHAR(255));
-- Insertar un registro
INSERT INTO prueba (id, nombre) VALUES (1, 'Hugo');
-- Actualizar un registro
UPDATE prueba SET nombre = 'Hugo Muñoz' WHERE id = 1;
-- Hacer commit
COMMIT;
