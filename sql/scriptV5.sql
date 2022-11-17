-- phpMyAdmin SQL Dump
-- version 5.0.4deb2+deb11u1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 16-11-2022 a las 18:07:59
-- Versión del servidor: 8.0.31
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `syllabus`
--
CREATE DATABASE IF NOT EXISTS `syllabus` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `syllabus`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `addAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAlumno` (IN `nom` VARCHAR(15), IN `ap_p` VARCHAR(15), IN `ap_m` VARCHAR(15), IN `sem` INT, IN `em` VARCHAR(60), IN `psw` VARCHAR(15))  begin
insert into alumno (nombre, apellido_p, apellido_m, no_semestre, correo) values (nom, ap_p, ap_m, sem, em);
insert into cred_a (id_alumno, cred) values (last_insert_id(), psw);
end$$

DROP PROCEDURE IF EXISTS `assignCalif`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `assignCalif` (IN `idA` INT, IN `idM` INT, IN `calif` FLOAT, IN `prcl` INT)  begin
insert into calificacion (id_materia, calificacion, parcial) values (idM, calif, prcl);
select @idCal := last_insert_id();
call insertAlumCalif(idA, @idCal);
end$$

DROP PROCEDURE IF EXISTS `changeCal`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `changeCal` (IN `idA` INT, IN `idM` INT, IN `prcl` INT, IN `newCal` FLOAT)  begin
select @califID := c.id_calif, @alum_calID := ac.id_alum_cal from calificacion as c, materia as m, alum_calif as ac where ac.id_calif = c.id_calif and ac.id_alumno = idA and c.parcial = prcl and c.id_materia = m.id_materia and m.id_materia = idM;
update calificacion set calificacion = newCal where id_calif = @califID;
end$$

DROP PROCEDURE IF EXISTS `insertAlumCalif`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertAlumCalif` (IN `idA` INT, IN `idC` INT)  begin
insert into alum_calif (id_alumno, id_calif) values (idA, idC);
end$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `readCalif`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `readCalif` (`idAl` INT, `idMat` INT, `prcl` INT) RETURNS FLOAT READS SQL DATA
begin
declare calif float;
select c.calificacion into calif from calificacion as c, materia as m, alum_calif as ac where ac.id_calif = c.id_calif and ac.id_alumno = idAl and c.parcial = prcl and c.id_materia = m.id_materia and m.id_materia = idMat;
return calif;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

DROP TABLE IF EXISTS `alumno`;
CREATE TABLE `alumno` (
  `id_alumno` int NOT NULL,
  `nombre` varchar(15) NOT NULL,
  `apellido_p` varchar(15) NOT NULL,
  `apellido_m` varchar(15) NOT NULL,
  `no_semestre` int NOT NULL,
  `correo` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELACIONES PARA LA TABLA `alumno`:
--

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id_alumno`, `nombre`, `apellido_p`, `apellido_m`, `no_semestre`, `correo`) VALUES
(55000, 'Agustin', 'Barlovento', 'Gonzalez', 1, 'ba55000@esc.edu.mx'),
(55001, 'Mikael', 'Correl', 'Balmoral', 2, 'co55001@esc.edu.mx'),
(55002, 'Finix', 'Orlean', 'Tox', 3, 'or55002@esc.edu.mx'),
(55003, 'Raphael', 'Dinin', 'Merrik', 4, 'di55003@esc.edu.mx'),
(55004, 'Vincent', 'Paires', 'Ivor', 5, 'pa55004@esc.edu.mx'),
(55005, 'Tairel', 'Fixer', 'Doer', 6, 'fi55005@esc.edu.mx'),
(55006, 'Roxan', 'Truver', 'Pox', 7, 'tr55006@esc.edu.mx'),
(55007, 'Bernard', 'Lennin', 'Tossein', 8, 'le55007@esc.edu.mx'),
(55008, 'Dulock', 'Shrink', 'Fedex', 9, 'sh55008@esc.edu.mx'),
(55009, 'Warlock', 'Chester', 'Benson', 5, 'ch55009@esc.edu.mx'),
(55010, 'Bellatrix', 'Lestrange', 'Corvet', 1, 'le55010@esc.edu.mx'),
(55011, 'Tornelio', 'Turner', 'Trax', 2, 'tu55011@esc.edu.mx'),
(55012, 'Wenceslao', 'Ritto', 'Rempus', 3, 'ri55012@esc.edu.mx'),
(55013, 'Jonny', 'Joestar', 'Jary', 4, 'jo55013@esc.edu.mx'),
(55014, 'Quintin', 'Beckham', 'Lorem', 6, 'be55014@esc.edu.mx'),
(55015, 'Namor', 'Atlante', 'Escalante', 7, 'at55015@esc.edu.mx'),
(55016, 'Beniju', 'Borjes', 'Banto', 8, 'bo55016@esc.edu.mx'),
(55017, 'Yossel', 'Jordan', 'Jinx', 9, 'jo55017@esc.edu.mx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alum_calif`
--

DROP TABLE IF EXISTS `alum_calif`;
CREATE TABLE `alum_calif` (
  `id_alum_cal` int NOT NULL,
  `id_alumno` int NOT NULL,
  `id_calif` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELACIONES PARA LA TABLA `alum_calif`:
--   `id_alumno`
--       `alumno` -> `id_alumno`
--   `id_calif`
--       `calificacion` -> `id_calif`
--

--
-- Volcado de datos para la tabla `alum_calif`
--

INSERT INTO `alum_calif` (`id_alum_cal`, `id_alumno`, `id_calif`) VALUES
(1, 55000, 1),
(2, 55000, 2),
(3, 55000, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
CREATE TABLE `calificacion` (
  `id_calif` int NOT NULL,
  `id_materia` int NOT NULL,
  `calificacion` float NOT NULL,
  `parcial` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELACIONES PARA LA TABLA `calificacion`:
--   `id_materia`
--       `materia` -> `id_materia`
--

--
-- Volcado de datos para la tabla `calificacion`
--

INSERT INTO `calificacion` (`id_calif`, `id_materia`, `calificacion`, `parcial`) VALUES
(1, 1, 9.5, 1),
(2, 2, 9.1, 1),
(3, 3, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cred_a`
--

DROP TABLE IF EXISTS `cred_a`;
CREATE TABLE `cred_a` (
  `id_cred_a` int NOT NULL,
  `id_alumno` int NOT NULL,
  `cred` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELACIONES PARA LA TABLA `cred_a`:
--   `id_alumno`
--       `alumno` -> `id_alumno`
--

--
-- Volcado de datos para la tabla `cred_a`
--

INSERT INTO `cred_a` (`id_cred_a`, `id_alumno`, `cred`) VALUES
(1, 55000, '55000'),
(2, 55001, '55001'),
(3, 55002, '55002'),
(4, 55003, '55003'),
(5, 55004, '55004'),
(6, 55005, '55005'),
(7, 55006, '55006'),
(8, 55007, '55007'),
(9, 55008, '55008'),
(10, 55009, '55009'),
(11, 55010, '55010'),
(12, 55011, '55011'),
(13, 55012, '55012'),
(14, 55013, '55013'),
(15, 55014, '55014'),
(16, 55015, '55015'),
(17, 55016, '55016'),
(18, 55017, '55017');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cred_p`
--

DROP TABLE IF EXISTS `cred_p`;
CREATE TABLE `cred_p` (
  `id_cred_p` int NOT NULL,
  `id_profesor` int NOT NULL,
  `cred` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELACIONES PARA LA TABLA `cred_p`:
--   `id_profesor`
--       `profesor` -> `id_profesor`
--

--
-- Volcado de datos para la tabla `cred_p`
--

INSERT INTO `cred_p` (`id_cred_p`, `id_profesor`, `cred`) VALUES
(1, 33001, '33001'),
(2, 33002, '33002'),
(3, 33003, '33003'),
(4, 33004, '33004'),
(5, 33005, '33005'),
(6, 33006, '33006'),
(7, 33007, '33007'),
(8, 33008, '33008'),
(9, 33009, '33009'),
(10, 33010, '33010'),
(11, 33011, '33011'),
(12, 33012, '33012'),
(13, 33013, '33013'),
(14, 33014, '33014'),
(15, 33015, '33015'),
(16, 33016, '33016'),
(17, 33017, '33017'),
(18, 33018, '33018'),
(19, 33019, '33019'),
(20, 33020, '33020'),
(21, 33021, '33021'),
(22, 33022, '33022'),
(23, 33023, '33023'),
(24, 33024, '33024'),
(25, 33025, '33025'),
(26, 33026, '33026'),
(27, 33027, '33027'),
(28, 33028, '33028'),
(29, 33029, '33029'),
(30, 33030, '33030'),
(31, 33031, '33031'),
(32, 33032, '33032');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

DROP TABLE IF EXISTS `materia`;
CREATE TABLE `materia` (
  `id_materia` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `id_profesor` int NOT NULL,
  `no_semestre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELACIONES PARA LA TABLA `materia`:
--   `id_profesor`
--       `profesor` -> `id_profesor`
--

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`id_materia`, `nombre`, `id_profesor`, `no_semestre`) VALUES
(1, 'Precalculo', 33002, 1),
(2, 'Aprender a aprender', 33001, 1),
(3, 'Des. Sustentable y Medio Amb.', 33003, 1),
(4, 'Fundamentos Program.', 33004, 1),
(5, 'Matematicas Discretas', 33005, 1),
(6, 'Ingles I', 33006, 1),
(7, 'Logica Computacional', 33008, 2),
(8, 'Calculo Dif. e Integral', 33002, 2),
(9, 'Estructura de Datos', 33009, 2),
(10, 'AyDOO', 33010, 2),
(11, 'Mexico Magico', 33011, 2),
(12, 'Ingles II', 33012, 2),
(13, 'Algebra Lineal', 33013, 3),
(14, 'Diseño BD', 33014, 3),
(15, 'POO', 33015, 3),
(16, 'Fund. Electronicos para Com.', 33016, 3),
(17, 'Ing. de Software', 33010, 3),
(18, 'Ingles III', 33017, 3),
(19, 'Estadistica y Probab.', 33004, 4),
(20, 'Prog. de Microprocesadores', 33009, 4),
(21, 'Admin. DB', 33018, 4),
(22, 'Gestion Proy. Informaticos', 33019, 4),
(23, 'Graficacion', 33020, 4),
(24, 'Ingles IV', 33006, 4),
(25, 'Org. de Computadoras', 33009, 5),
(26, 'Sistemas Operativos', 33019, 5),
(27, 'Comunicacion en Redes', 33021, 5),
(28, 'Inteligencia Artificial', 33022, 5),
(29, 'Sistemas Multimedia', 33023, 5),
(30, 'Ingles V', 33024, 5),
(31, 'Sis. Basados en Conoc.', 33025, 6),
(32, 'Automatas y Compiladores', 33026, 6),
(33, 'BD Distribuidas', 33019, 6),
(34, 'Investigacion', 33027, 6),
(35, 'Redes de Computadoras', 33028, 6),
(36, 'Ingles VI', 33024, 6),
(37, 'Seguridad en Redes', 33021, 7),
(38, 'AFI', 33010, 7),
(39, 'Sis. Realidad Virtual', 33026, 7),
(40, 'Programacion Web', 33019, 7),
(41, 'Optativa I', 33018, 7),
(42, 'Optativa II', 33029, 8),
(43, 'Optativa III', 33030, 8),
(44, 'Servicio Social', 33031, 8),
(45, 'Desarrollo Proy. Computacionales', 33025, 9),
(46, 'Practicas Profesionales', 33032, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

DROP TABLE IF EXISTS `profesor`;
CREATE TABLE `profesor` (
  `id_profesor` int NOT NULL,
  `nombre` varchar(15) NOT NULL,
  `apellido_p` varchar(15) NOT NULL,
  `apellido_m` varchar(15) NOT NULL,
  `correo` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- RELACIONES PARA LA TABLA `profesor`:
--

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido_p`, `apellido_m`, `correo`) VALUES
(33001, 'Juventino', 'Rosas', 'Verdes', 'doc_33001@esc.edu.mx'),
(33002, 'Judith', 'Torres', 'Franco', 'doc_33002@esc.edu.mx'),
(33003, 'Altagracia', 'Prado', 'Jimenez', 'doc_33003@esc.edu.mx'),
(33004, 'Cecilia', 'Cruz', 'Cordero', 'doc_33004@esc.edu.mx'),
(33005, 'Fabiola', 'Martinez', 'Juarez', 'doc_33005@esc.edu.mx'),
(33006, 'Fernanda', 'Mino', 'Paredes', 'doc_33006@esc.edu.mx'),
(33007, 'Maria', 'Rojo', 'Fernandez', 'doc_33007@esc.edu.mx'),
(33008, 'Maria', 'Alonso', 'Lavernia', 'doc_33008@esc.edu.mx'),
(33009, 'Isaias', 'Perez', 'Perez', 'doc_33009@esc.edu.mx'),
(33010, 'Carmen', 'Vera', 'Carranza', 'doc_33010@esc.edu.mx'),
(33011, 'Sonia', 'German', 'Rivera', 'doc_33011@esc.edu.mx'),
(33012, 'Natalia', 'Meneses', 'Escamilla', 'doc_33012@esc.edu.mx'),
(33013, 'Mariano', 'Pozas', 'Gutierrez', 'doc_33013@esc.edu.mx'),
(33014, 'Teira', 'Irasema', 'Ventura', 'doc_33014@esc.edu.mx'),
(33015, 'Ismael', 'Sanchez', 'Roma', 'doc_33015@esc.edu.mx'),
(33016, 'Daniel', 'Carrera', 'Lopez', 'doc_33016@esc.edu.mx'),
(33017, 'Señora', 'Desconocida', 'Uno', 'doc_33017@esc.edu.mx'),
(33018, 'Kristell', 'Franco', 'Sanchez', 'doc_33018@esc.edu.mx'),
(33019, 'Norma', 'Salazar', 'Viveros', 'doc_33019@esc.edu.mx'),
(33020, 'Jahir', 'Monroy', 'Cedillo', 'doc_33020@esc.edu.mx'),
(33021, 'Vanessa', 'Ureña', 'Medina', 'doc_33021@esc.edu.mx'),
(33022, 'Karla', 'Lopez', 'de la Cruz', 'doc_33022@esc.edu.mx'),
(33023, 'Arturo', 'Curiel', 'Anaya', 'doc_33023@esc.edu.mx'),
(33024, 'Jose', 'Uribe', 'Mejia', 'doc_33024@esc.edu.mx'),
(33025, 'Martha', 'RIvera', 'Gonzalez', 'doc_33025@esc.edu.mx'),
(33026, 'Sandra', 'Pereira', 'Lagunez', 'doc_33026@esc.edu.mx'),
(33027, 'Victor', 'Martinez', 'Lopez', 'doc_33027@esc.edu.mx'),
(33028, 'Ana', 'Vargas', 'Ramirez', 'doc_33028@esc.edu.mx'),
(33029, 'Profea', 'Uno', 'Uno', 'doc_33029@esc.edu.mx'),
(33030, 'Profea', 'Dos', 'Dos', 'doc_33030@esc.edu.mx'),
(33031, 'Profea', 'Tres', 'Tres', 'doc_33031@esc.edu.mx'),
(33032, 'Profea', 'Cuatro', 'Cuatro', 'doc_33032@esc.edu.mx');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id_alumno`);

--
-- Indices de la tabla `alum_calif`
--
ALTER TABLE `alum_calif`
  ADD PRIMARY KEY (`id_alum_cal`),
  ADD KEY `id_alumno` (`id_alumno`),
  ADD KEY `id_calif` (`id_calif`);

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_calif`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `cred_a`
--
ALTER TABLE `cred_a`
  ADD PRIMARY KEY (`id_cred_a`),
  ADD KEY `id_alumno` (`id_alumno`);

--
-- Indices de la tabla `cred_p`
--
ALTER TABLE `cred_p`
  ADD PRIMARY KEY (`id_cred_p`),
  ADD KEY `id_profesor` (`id_profesor`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`id_materia`),
  ADD KEY `id_profesor` (`id_profesor`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`id_profesor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id_alumno` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55018;

--
-- AUTO_INCREMENT de la tabla `alum_calif`
--
ALTER TABLE `alum_calif`
  MODIFY `id_alum_cal` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `id_calif` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cred_a`
--
ALTER TABLE `cred_a`
  MODIFY `id_cred_a` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `cred_p`
--
ALTER TABLE `cred_p`
  MODIFY `id_cred_p` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `id_materia` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `profesor`
--
ALTER TABLE `profesor`
  MODIFY `id_profesor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33033;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alum_calif`
--
ALTER TABLE `alum_calif`
  ADD CONSTRAINT `alum_calif_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE CASCADE,
  ADD CONSTRAINT `alum_calif_ibfk_2` FOREIGN KEY (`id_calif`) REFERENCES `calificacion` (`id_calif`) ON DELETE CASCADE;

--
-- Filtros para la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `calificacion_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cred_a`
--
ALTER TABLE `cred_a`
  ADD CONSTRAINT `cred_a_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cred_p`
--
ALTER TABLE `cred_p`
  ADD CONSTRAINT `cred_p_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`id_profesor`) ON DELETE CASCADE;

--
-- Filtros para la tabla `materia`
--
ALTER TABLE `materia`
  ADD CONSTRAINT `materia_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`id_profesor`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
