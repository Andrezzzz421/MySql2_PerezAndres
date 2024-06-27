use autorenta;

-- Evento para Limpiar Alquileres Antiguos:
DELIMITER //
CREATE EVENT limpiar_alquileres_antiguos
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    DELETE FROM Alquiler
    WHERE fecha_llegada < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
END //
DELIMITER ;

ALTER EVENT limpiar_alquileres_antiguos
ON SCHEDULE EVERY 1 MINUTE;

-- Esperar un par de minutos y luego verificar si los registros antiguos se han eliminado
SELECT * FROM Alquiler WHERE fecha_llegada < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
SHOW EVENTS;
