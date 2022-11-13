-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: syllabus
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alum_calif`
--

DROP TABLE IF EXISTS `alum_calif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alum_calif` (
  `id_alum_cal` int NOT NULL AUTO_INCREMENT,
  `id_alumno` int NOT NULL,
  `id_calif` int NOT NULL,
  PRIMARY KEY (`id_alum_cal`),
  KEY `id_alumno` (`id_alumno`),
  KEY `id_calif` (`id_calif`),
  CONSTRAINT `alum_calif_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`),
  CONSTRAINT `alum_calif_ibfk_2` FOREIGN KEY (`id_calif`) REFERENCES `calificacion` (`id_calif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alum_calif`
--

LOCK TABLES `alum_calif` WRITE;
/*!40000 ALTER TABLE `alum_calif` DISABLE KEYS */;
/*!40000 ALTER TABLE `alum_calif` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `id_alumno` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(15) NOT NULL,
  `apellido_p` varchar(15) NOT NULL,
  `apellido_m` varchar(15) NOT NULL,
  `no_semestre` int NOT NULL,
  `correo` varchar(60) NOT NULL,
  PRIMARY KEY (`id_alumno`)
) ENGINE=InnoDB AUTO_INCREMENT=55009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE;
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */;
INSERT INTO `alumno` VALUES (55000,'Agustin','Barlovento','Gonzalez',1,'ba55000@esc.edu.mx'),(55001,'Mikael','Correl','Balmoral',2,'co55001@esc.edu.mx'),(55002,'Finix','Orlean','Tox',3,'or55002@esc.edu.mx'),(55003,'Raphael','Dinin','Merrik',4,'di55003@esc.edu.mx'),(55004,'Vincent','Paires','Ivor',5,'pa55004@esc.edu.mx'),(55005,'Tairel','Fixer','Doer',6,'fi55005@esc.edu.mx'),(55006,'Roxan','Truver','Pox',7,'tr55006@esc.edu.mx'),(55007,'Bernard','Lennin','Tossein',8,'le55007@esc.edu.mx'),(55008,'Dulock','Shrink','Fedex',9,'sh55008@esc.edu.mx');
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificacion` (
  `id_calif` int NOT NULL AUTO_INCREMENT,
  `id_materia` int NOT NULL,
  `calificacion` float NOT NULL,
  PRIMARY KEY (`id_calif`),
  KEY `id_materia` (`id_materia`),
  CONSTRAINT `calificacion_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materia`
--

DROP TABLE IF EXISTS `materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materia` (
  `id_materia` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `id_profesor` int NOT NULL,
  `no_semestre` int NOT NULL,
  PRIMARY KEY (`id_materia`),
  KEY `id_profesor` (`id_profesor`),
  CONSTRAINT `materia_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `profesor` (`id_profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia`
--

LOCK TABLES `materia` WRITE;
/*!40000 ALTER TABLE `materia` DISABLE KEYS */;
INSERT INTO `materia` VALUES (1,'Precalculo',33002,1),(2,'Aprender a aprender',33001,1),(3,'Des. Sustentable y Medio Amb.',33003,1),(4,'Fundamentos Program.',33004,1),(5,'Matematicas Discretas',33005,1),(6,'Ingles I',33006,1),(7,'Logica Computacional',33008,2),(8,'Calculo Dif. e Integral',33002,2),(9,'Estructura de Datos',33009,2),(10,'AyDOO',33010,2),(11,'Mexico Magico',33011,2),(12,'Ingles II',33012,2),(13,'Algebra Lineal',33013,3),(14,'Diseño BD',33014,3),(15,'POO',33015,3),(16,'Fund. Electronicos para Com.',33016,3),(17,'Ing. de Software',33010,3),(18,'Ingles III',33017,3),(19,'Estadistica y Probab.',33004,4),(20,'Prog. de Microprocesadores',33009,4),(21,'Admin. DB',33018,4),(22,'Gestion Proy. Informaticos',33019,4),(23,'Graficacion',33020,4),(24,'Ingles IV',33006,4),(25,'Org. de Computadoras',33009,5),(26,'Sistemas Operativos',33019,5),(27,'Comunicacion en Redes',33021,5),(28,'Inteligencia Artificial',33022,5),(29,'Sistemas Multimedia',33023,5),(30,'Ingles V',33024,5),(31,'Sis. Basados en Conoc.',33025,6),(32,'Automatas y Compiladores',33026,6),(33,'BD Distribuidas',33019,6),(34,'Investigacion',33027,6),(35,'Redes de Computadoras',33028,6),(36,'Ingles VI',33024,6),(37,'Seguridad en Redes',33021,7),(38,'AFI',33010,7),(39,'Sis. Realidad Virtual',33026,7),(40,'Programacion Web',33019,7),(41,'Optativa I',33018,7),(42,'Optativa II',33029,8),(43,'Optativa III',33030,8),(44,'Servicio Social',33031,8),(45,'Desarrollo Proy. Computacionales',33025,9),(46,'Practicas Profesionales',33032,9);
/*!40000 ALTER TABLE `materia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `id_profesor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(15) NOT NULL,
  `apellido_p` varchar(15) NOT NULL,
  `apellido_m` varchar(15) NOT NULL,
  `correo` varchar(60) NOT NULL,
  PRIMARY KEY (`id_profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=33033 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE;
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */;
INSERT INTO `profesor` VALUES (33001,'Juventino','Rosas','Verdes','doc_33001@esc.edu.mx'),(33002,'Judith','Torres','Franco','doc_33002@esc.edu.mx'),(33003,'Altagracia','Prado','Jimenez','doc_33003@esc.edu.mx'),(33004,'Cecilia','Cruz','Cordero','doc_33004@esc.edu.mx'),(33005,'Fabiola','Martinez','Juarez','doc_33005@esc.edu.mx'),(33006,'Fernanda','Mino','Paredes','doc_33006@esc.edu.mx'),(33007,'Maria','Rojo','Fernandez','doc_33007@esc.edu.mx'),(33008,'Maria','Alonso','Lavernia','doc_33008@esc.edu.mx'),(33009,'Isaias','Perez','Perez','doc_33009@esc.edu.mx'),(33010,'Carmen','Vera','Carranza','doc_33010@esc.edu.mx'),(33011,'Sonia','German','Rivera','doc_33011@esc.edu.mx'),(33012,'Natalia','Meneses','Escamilla','doc_33012@esc.edu.mx'),(33013,'Mariano','Pozas','Gutierrez','doc_33013@esc.edu.mx'),(33014,'Teira','Irasema','Ventura','doc_33014@esc.edu.mx'),(33015,'Ismael','Sanchez','Roma','doc_33015@esc.edu.mx'),(33016,'Daniel','Carrera','Lopez','doc_33016@esc.edu.mx'),(33017,'Señora','Desconocida','Uno','doc_33017@esc.edu.mx'),(33018,'Kristell','Franco','Sanchez','doc_33018@esc.edu.mx'),(33019,'Norma','Salazar','Viveros','doc_33019@esc.edu.mx'),(33020,'Jahir','Monroy','Cedillo','doc_33020@esc.edu.mx'),(33021,'Vanessa','Ureña','Medina','doc_33021@esc.edu.mx'),(33022,'Karla','Lopez','de la Cruz','doc_33022@esc.edu.mx'),(33023,'Arturo','Curiel','Anaya','doc_33023@esc.edu.mx'),(33024,'Jose','Uribe','Mejia','doc_33024@esc.edu.mx'),(33025,'Martha','RIvera','Gonzalez','doc_33025@esc.edu.mx'),(33026,'Sandra','Pereira','Lagunez','doc_33026@esc.edu.mx'),(33027,'Victor','Martinez','Lopez','doc_33027@esc.edu.mx'),(33028,'Ana','Vargas','Ramirez','doc_33028@esc.edu.mx'),(33029,'Profea','Uno','Uno','doc_33029@esc.edu.mx'),(33030,'Profea','Dos','Dos','doc_33030@esc.edu.mx'),(33031,'Profea','Tres','Tres','doc_33031@esc.edu.mx'),(33032,'Profea','Cuatro','Cuatro','doc_33032@esc.edu.mx');
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-12 18:02:43
