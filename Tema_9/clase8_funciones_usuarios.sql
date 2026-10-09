-- ============================================================
-- ACTIVIDAD CLASE 8 - FUNCIONES Y GESTIÓN DE USUARIOS
-- Bases de Datos II - Jhon James Cano Sánchez
-- Autor: Alejandra Restrepo
-- Fecha: 8 de octubre de 2026
-- ============================================================

-- ============================================================
-- PARTE 1: FUNCIONES EN bbdd_db
-- ============================================================

USE bbdd_db;

-- ------------------------------------------------------------
-- EJERCICIO 1: fn_calcular_descuento
-- ------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_calcular_descuento;

DELIMITER $$
CREATE FUNCTION fn_calcular_descuento(
    p_precio DECIMAL(10,2),
    p_porcentaje DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_descuento DECIMAL(10,2);
    DECLARE v_precio_final DECIMAL(10,2);
    SET v_descuento = p_precio * (p_porcentaje / 100);
    SET v_precio_final = p_precio - v_descuento;
    RETURN v_precio_final;
END$$
DELIMITER ;

-- Pruebas:
-- SELECT fn_calcular_descuento(100000, 10) AS precio_con_descuento;
-- SELECT fn_calcular_descuento(50000, 25) AS precio_con_descuento;

-- ------------------------------------------------------------
-- EJERCICIO 2: fn_clasificar_edad
-- ------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_clasificar_edad;

DELIMITER $$
CREATE FUNCTION fn_clasificar_edad(p_edad INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_clasificacion VARCHAR(20);
    IF p_edad < 12 THEN
        SET v_clasificacion = 'Niño';
    ELSEIF p_edad >= 12 AND p_edad <= 17 THEN
        SET v_clasificacion = 'Adolescente';
    ELSEIF p_edad >= 18 AND p_edad <= 59 THEN
        SET v_clasificacion = 'Adulto';
    ELSE
        SET v_clasificacion = 'Adulto mayor';
    END IF;
    RETURN v_clasificacion;
END$$
DELIMITER ;

-- Pruebas:
-- SELECT fn_clasificar_edad(8) AS clasificacion;
-- SELECT fn_clasificar_edad(30) AS clasificacion;


-- ============================================================
-- PARTE 2: GESTIÓN DE USUARIOS EN bbdd_db
-- ============================================================

-- ------------------------------------------------------------
-- EJERCICIO 4: CREACIÓN DE USUARIOS
-- ------------------------------------------------------------
CREATE USER 'admin_bbdd'@'%' IDENTIFIED BY 'Admin123*';
CREATE USER 'consulta_bbdd'@'%' IDENTIFIED BY 'Consulta123*';
CREATE USER 'app_bbdd'@'%' IDENTIFIED BY 'App123*';

SELECT user, host FROM mysql.user WHERE user LIKE '%bbdd%';

-- ------------------------------------------------------------
-- OTORGAMIENTO DE PRIVILEGIOS
-- ------------------------------------------------------------
GRANT ALL PRIVILEGES ON bbdd_db.* TO 'admin_bbdd'@'%' WITH GRANT OPTION;
GRANT SELECT ON bbdd_db.* TO 'consulta_bbdd'@'%';
GRANT SELECT, INSERT, UPDATE, EXECUTE ON bbdd_db.* TO 'app_bbdd'@'%';

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'admin_bbdd'@'%';
SHOW GRANTS FOR 'consulta_bbdd'@'%';
SHOW GRANTS FOR 'app_bbdd'@'%';

-- ------------------------------------------------------------
-- EJERCICIO 5: REVOCACIÓN Y ELIMINACIÓN
-- ------------------------------------------------------------
REVOKE INSERT ON bbdd_db.* FROM 'app_bbdd'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'app_bbdd'@'%';

DROP USER 'consulta_bbdd'@'%';
FLUSH PRIVILEGES;
SELECT user, host FROM mysql.user WHERE user LIKE '%bbdd%';

-- ============================================================
-- FIN DEL ARCHIVO
-- ============================================================
