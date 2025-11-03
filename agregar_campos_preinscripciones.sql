-- Script para agregar campos nuevos a la tabla pre_inscripciones
-- Fecha: Octubre 2025

-- Agregar campo observaciones
ALTER TABLE `pre_inscripciones` 
ADD COLUMN `observaciones` TEXT NULL AFTER `id_carrera`;

-- Agregar campos email alternativos
ALTER TABLE `pre_inscripciones` 
ADD COLUMN `email_alternativo` VARCHAR(100) NULL AFTER `email`,
ADD COLUMN `email_alternativo_2` VARCHAR(100) NULL AFTER `email_alternativo`;

-- También agregar a tabla usuarios
ALTER TABLE `usuarios` 
ADD COLUMN `email_alternativo` VARCHAR(100) NULL AFTER `email`,
ADD COLUMN `email_alternativo_2` VARCHAR(100) NULL AFTER `email_alternativo`;

-- Agregar campos adicionales para otros estudios
ALTER TABLE `pre_inscripciones` 
ADD COLUMN `otros_estudios_2` VARCHAR(100) NULL AFTER `otros_estudios`,
ADD COLUMN `anio_egreso_otros_2` INT(4) NULL AFTER `anio_egreso_otros`,
ADD COLUMN `otros_estudios_3` VARCHAR(100) NULL AFTER `otros_estudios_2`,
ADD COLUMN `anio_egreso_otros_3` INT(4) NULL AFTER `anio_egreso_otros_2`;
