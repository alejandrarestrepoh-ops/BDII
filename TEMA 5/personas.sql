-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: personas
-- ------------------------------------------------------
-- Server version	5.5.5-10.8.8-MariaDB-1:10.8.8+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditoria_usuarios`
--

DROP TABLE IF EXISTS `auditoria_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(2) NOT NULL,
  `accion` varchar(10) NOT NULL,
  `correo_anterior` varchar(50) DEFAULT NULL,
  `correo_nuevo` varchar(50) DEFAULT NULL,
  `saldo_anterior` decimal(10,2) DEFAULT NULL,
  `saldo_nuevo` decimal(10,2) DEFAULT NULL,
  `fecha_cambio` datetime NOT NULL,
  `usuario_bd` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_usuarios`
--

LOCK TABLES `auditoria_usuarios` WRITE;
/*!40000 ALTER TABLE `auditoria_usuarios` DISABLE KEYS */;
INSERT INTO `auditoria_usuarios` VALUES (1,5,'UPDATE','carlos@email.com','carlos.nuevo@email.com',300.00,300.00,'2026-09-16 00:08:46','root@172.18.0.1'),(2,6,'UPDATE','diana@email.com','diana@email.com',800.00,600.00,'2026-09-16 00:09:00','root@172.18.0.1');
/*!40000 ALTER TABLE `auditoria_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_usuarios`
--

DROP TABLE IF EXISTS `historico_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `edad` int(3) DEFAULT NULL,
  `fecha_actual` date DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_usuarios`
--

LOCK TABLES `historico_usuarios` WRITE;
/*!40000 ALTER TABLE `historico_usuarios` DISABLE KEYS */;
INSERT INTO `historico_usuarios` VALUES (4,'Ana',30,'2026-09-10',NULL),(5,'Carlos',28,'2026-09-16',NULL),(6,'Diana',35,'2026-09-16',NULL),(7,'Elena',22,'2026-09-16',NULL),(8,'Pedro',40,'2026-09-16',NULL),(9,'Ana',25,'2026-09-16',NULL);
/*!40000 ALTER TABLE `historico_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuarios` int(11) NOT NULL AUTO_INCREMENT,
  `edad` int(3) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `saldo` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id_usuarios`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,25,'Maria',NULL,0.00),(2,0,'Juan',NULL,0.00),(5,28,'Carlos','carlos.nuevo@email.com',300.00),(6,35,'Diana Marcela','diana@email.com',600.00),(8,40,'Pedro','pedro@email.com',1000.00);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_eliminados`
--

DROP TABLE IF EXISTS `usuarios_eliminados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios_eliminados` (
  `id_usuarios` int(11) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `edad` int(3) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `saldo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_eliminados`
--

LOCK TABLES `usuarios_eliminados` WRITE;
/*!40000 ALTER TABLE `usuarios_eliminados` DISABLE KEYS */;
INSERT INTO `usuarios_eliminados` VALUES (3,'Ana',30,NULL,0.00),(4,'Ana',30,NULL,0.00),(9,'Ana',25,'ana@email.com',200.00);
/*!40000 ALTER TABLE `usuarios_eliminados` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-15 21:38:36
