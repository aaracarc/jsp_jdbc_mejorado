CREATE TABLE IF NOT EXISTS `entrenamiento` (
    `entrenamientoID` int(11) NOT NULL AUTO_INCREMENT,
    `socioID` int(11) NOT NULL,
    `tipo_entrenamiento` varchar(30) NOT NULL,
    `ubicacion` varchar(60) DEFAULT NULL COLLATE utf8_spanish2_ci,
    `fecha_realizacion` date NOT NULL,
    PRIMARY KEY (`entrenamientoID`),
    FOREIGN KEY (`socioID`) REFERENCES `socio` (`socioID`) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;