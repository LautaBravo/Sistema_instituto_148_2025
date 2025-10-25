-- Script para crear la tabla inscripciones_materias
-- Ejecutar en phpMyAdmin: Copiar y pegar TODO este contenido en la pestaña SQL

CREATE TABLE `inscripciones_materias` (
  `id_inscripcion_materia` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(50) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `id_carrera` int(11) NOT NULL,
  `fecha_inscripcion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,x
  `anio` int(4) NOT NULL,
  `estado` varchar(50) NOT NULL DEFAULT 'inscripto',
  PRIMARY KEY (`id_inscripcion_materia`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_materia` (`id_materia`),
  KEY `id_carrera` (`id_carrera`),
  CONSTRAINT `inscripciones_materias_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `inscripciones_materias_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`),
  CONSTRAINT `inscripciones_materias_ibfk_3` FOREIGN KEY (`id_carrera`) REFERENCES `lista_carreras` (`id_carrera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Estados posibles: 'inscripto', 'cursando', 'aprobado', 'abandonó'
