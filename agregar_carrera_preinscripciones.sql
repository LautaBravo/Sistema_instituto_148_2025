-- Agregar campo id_carrera a la tabla pre_inscripciones
-- Ejecutar en phpMyAdmin: Copiar y pegar en la pestaña SQL

ALTER TABLE `pre_inscripciones` 
ADD COLUMN `id_carrera` int(11) NOT NULL AFTER `id_institucion`;

-- Agregar índice y foreign key
ALTER TABLE `pre_inscripciones`
ADD KEY `id_carrera` (`id_carrera`),
ADD CONSTRAINT `pre_inscripciones_ibfk_1` FOREIGN KEY (`id_carrera`) REFERENCES `lista_carreras` (`id_carrera`);
