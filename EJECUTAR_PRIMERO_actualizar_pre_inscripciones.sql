-- ================================================================
-- SCRIPT DE ACTUALIZACIÓN DE TABLA pre_inscripciones
-- IMPORTANTE: Ejecutar este script ANTES de usar el sistema
-- Fecha: Octubre 2025
-- ================================================================

-- 1. Agregar campo id_carrera (si no existe)
ALTER TABLE `pre_inscripciones` 
ADD COLUMN `id_carrera` int(11) NULL AFTER `id_institucion`;

-- 2. Agregar índice y foreign key para id_carrera
ALTER TABLE `pre_inscripciones`
ADD KEY `idx_id_carrera` (`id_carrera`);

ALTER TABLE `pre_inscripciones`
ADD CONSTRAINT `fk_pre_inscripciones_carrera` 
FOREIGN KEY (`id_carrera`) REFERENCES `lista_carreras` (`id_carrera`)
ON DELETE SET NULL 
ON UPDATE CASCADE;

-- 3. Agregar campo observaciones
ALTER TABLE `pre_inscripciones` 
ADD COLUMN `observaciones` TEXT NULL AFTER `id_carrera`;

-- 4. Agregar campos email alternativos
ALTER TABLE `pre_inscripciones` 
ADD COLUMN `email_alternativo` VARCHAR(100) NULL AFTER `email`;

ALTER TABLE `pre_inscripciones`
ADD COLUMN `email_alternativo_2` VARCHAR(100) NULL AFTER `email_alternativo`;

-- 5. Agregar campos adicionales para otros estudios (2 y 3)
ALTER TABLE `pre_inscripciones` 
ADD COLUMN `otros_estudios_2` VARCHAR(100) NULL AFTER `anio_egreso_otros`;

ALTER TABLE `pre_inscripciones`
ADD COLUMN `anio_egreso_otros_2` INT(4) NULL AFTER `otros_estudios_2`;

ALTER TABLE `pre_inscripciones`
ADD COLUMN `otros_estudios_3` VARCHAR(100) NULL AFTER `anio_egreso_otros_2`;

ALTER TABLE `pre_inscripciones`
ADD COLUMN `anio_egreso_otros_3` INT(4) NULL AFTER `otros_estudios_3`;

-- ================================================================
-- OPCIONAL: Agregar los mismos campos a la tabla usuarios
-- (solo si también se usa para usuarios regulares)
-- ================================================================

ALTER TABLE `usuarios` 
ADD COLUMN `email_alternativo` VARCHAR(100) NULL AFTER `email`;

ALTER TABLE `usuarios`
ADD COLUMN `email_alternativo_2` VARCHAR(100) NULL AFTER `email_alternativo`;

-- ================================================================
-- VERIFICACIÓN: Ejecutar para confirmar que los campos existen
-- ================================================================

SHOW COLUMNS FROM `pre_inscripciones`;

-- ================================================================
-- FIN DEL SCRIPT
-- ================================================================
