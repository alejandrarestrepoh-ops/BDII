-- ============================================================
-- PARTE 4: ACTIVIDAD INDEPENDIENTE (inventario_db)
-- ============================================================
USE inventario_db;

-- Modificar tabla clientes para hash/cifrado
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS sal CHAR(16) NOT NULL DEFAULT 's41L4ur4Xy9Qw2Ab';
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS clave_hash CHAR(64) NULL;
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS tarjeta_cifrada VARBINARY(64) NULL;

SET @llave_inv = 'Llave_Inventario_2026';
UPDATE clientes SET 
    clave_hash = SHA2(CONCAT(sal, 'Cliente2026*'), 256),
    tarjeta_cifrada = AES_ENCRYPT('4000123412341234', @llave_inv) 
WHERE id_cliente = 1;

-- Vistas Seguras
CREATE OR REPLACE SQL SECURITY DEFINER VIEW vw_clientes_seguro AS 
SELECT id_cliente, nombre, CONCAT(LEFT(cedula, 2), '***') AS cedula_segura, CONCAT(LEFT(correo, 2), '***@***') AS correo_seguro FROM clientes;

CREATE OR REPLACE SQL SECURITY DEFINER VIEW vw_facturas_detalle AS 
SELECT f.numero_factura, c.nombre AS cliente, f.total, f.fecha FROM facturas f INNER JOIN clientes c ON f.id_cliente = c.id_cliente;

-- Procedimiento DEFINER
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_registrar_venta_inv$$
CREATE PROCEDURE sp_registrar_venta_inv(IN p_id_cliente INT, IN p_id_producto INT, IN p_cantidad INT) 
SQL SECURITY DEFINER MODIFIES SQL DATA
BEGIN
    DECLARE v_stock INT;
    DECLARE v_precio DECIMAL(10,2);
    SELECT stock, precio_venta INTO v_stock, v_precio FROM productos WHERE id_producto = p_id_producto;
    IF v_stock < p_cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente en inventario_db';
    END IF;
    UPDATE productos SET stock = stock - p_cantidad WHERE id_producto = p_id_producto;
    SELECT 'Venta en proyecto OK' AS mensaje;
END$$
DELIMITER ;

-- Trigger Auditoría
CREATE TABLE IF NOT EXISTS auditoria_clientes_inv (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    campo VARCHAR(30),
    valor_anterior VARCHAR(100),
    valor_nuevo VARCHAR(100),
    usuario VARCHAR(100),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
DROP TRIGGER IF EXISTS trg_auditar_clientes_inv$$
CREATE TRIGGER trg_auditar_clientes_inv 
AFTER UPDATE ON clientes FOR EACH ROW
BEGIN
    IF NOT (OLD.correo <=> NEW.correo) THEN
        INSERT INTO auditoria_clientes_inv (cliente_id, campo, valor_anterior, valor_nuevo, usuario) VALUES (NEW.id_cliente, 'correo', OLD.correo, NEW.correo, USER());
    END IF;
END$$
DELIMITER ;

-- Roles y usuarios del proyecto
DROP ROLE IF EXISTS rol_consulta_inv;
DROP ROLE IF EXISTS rol_admin_inv;
DROP USER IF EXISTS 'ana_inv'@'%';
DROP USER IF EXISTS 'admin_inv'@'%';

CREATE ROLE rol_consulta_inv;
CREATE ROLE rol_admin_inv;

GRANT SELECT ON inventario_db.vw_clientes_seguro TO rol_consulta_inv;
GRANT ALL PRIVILEGES ON inventario_db.* TO rol_admin_inv;

CREATE USER 'ana_inv'@'%' IDENTIFIED BY 'Ana#Inventario2026';
CREATE USER 'admin_inv'@'%' IDENTIFIED BY 'Admin#Inventario2026';

GRANT rol_consulta_inv TO 'ana_inv'@'%';
GRANT rol_admin_inv TO 'admin_inv'@'%';

SET DEFAULT ROLE rol_consulta_inv FOR 'ana_inv'@'%';
SET DEFAULT ROLE rol_admin_inv FOR 'admin_inv'@'%';
FLUSH PRIVILEGES;
