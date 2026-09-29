-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: pretestf
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `tb_commit`
--

DROP TABLE IF EXISTS `tb_commit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_commit` (
  `id_commit` int NOT NULL AUTO_INCREMENT,
  `id_member` int DEFAULT NULL,
  `id_eva` int DEFAULT NULL,
  `status_commit` varchar(1) DEFAULT NULL,
  `level_commit` varchar(100) DEFAULT NULL,
  `detail_commit` text,
  `signature` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_commit`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_commit`
--

LOCK TABLES `tb_commit` WRITE;
/*!40000 ALTER TABLE `tb_commit` DISABLE KEYS */;
INSERT INTO `tb_commit` VALUES (2,2,1,'y','ประธาน','ไม่มี',NULL);
/*!40000 ALTER TABLE `tb_commit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_eva`
--

DROP TABLE IF EXISTS `tb_eva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_eva` (
  `id_eva` int NOT NULL AUTO_INCREMENT,
  `id_member` int DEFAULT NULL,
  `id_sys` int DEFAULT NULL,
  `status_eva` int DEFAULT NULL,
  `day_eva` date DEFAULT NULL,
  `total_eva` double(10,2) DEFAULT NULL,
  `total_commit` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_eva`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_eva`
--

LOCK TABLES `tb_eva` WRITE;
/*!40000 ALTER TABLE `tb_eva` DISABLE KEYS */;
INSERT INTO `tb_eva` VALUES (1,1,1,2,'2026-05-06',18.00,25.00);
/*!40000 ALTER TABLE `tb_eva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_evadetail`
--

DROP TABLE IF EXISTS `tb_evadetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_evadetail` (
  `id_detail` int NOT NULL AUTO_INCREMENT,
  `id_eva` int DEFAULT NULL,
  `id_indicate` int DEFAULT NULL,
  `status_eva` int DEFAULT NULL,
  `detail_eva` text,
  `score_member` int DEFAULT NULL,
  `score_commit` int DEFAULT NULL,
  `file_eva` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_detail`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_evadetail`
--

LOCK TABLES `tb_evadetail` WRITE;
/*!40000 ALTER TABLE `tb_evadetail` DISABLE KEYS */;
INSERT INTO `tb_evadetail` VALUES (1,1,1,1,'test1',3,NULL,'1790666302127csbvm4ylb6b.png'),(2,1,2,1,'test4',1,NULL,'1790666302136hprmd7bnnpq.png'),(3,1,1,1,'test1',3,NULL,'179066632527827bg0r9i8cw.png'),(4,1,2,1,'test4',1,NULL,'1790666325280727wh5jphsp.png'),(5,1,1,2,NULL,NULL,2,NULL),(6,1,2,2,NULL,NULL,1,NULL),(7,1,1,2,NULL,NULL,3,NULL),(8,1,2,2,NULL,NULL,4,NULL);
/*!40000 ALTER TABLE `tb_evadetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_indicate`
--

DROP TABLE IF EXISTS `tb_indicate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_indicate` (
  `id_indicate` int NOT NULL AUTO_INCREMENT,
  `id_topic` int DEFAULT NULL,
  `name_indicate` varchar(100) DEFAULT NULL,
  `detail_indicate` text,
  `point_indicate` int DEFAULT NULL,
  `check_indicate` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_indicate`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_indicate`
--

LOCK TABLES `tb_indicate` WRITE;
/*!40000 ALTER TABLE `tb_indicate` DISABLE KEYS */;
INSERT INTO `tb_indicate` VALUES (1,1,'ตัวชี้วัดคอมพิวเตอร์','รายละเอียดของคอมพิวเตอร์',2,'y'),(2,1,'คะแนนคอมพิวเตอร์','ให้คะแนนสำหรับคุณภาพคอมพิวเตอร์',3,'n');
/*!40000 ALTER TABLE `tb_indicate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_member`
--

DROP TABLE IF EXISTS `tb_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_member` (
  `id_member` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('ฝ่ายบุคลากร','กรรมการประเมิน','ผู้รับการประเมินผล') DEFAULT NULL,
  `pic_user` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_member`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_member`
--

LOCK TABLES `tb_member` WRITE;
/*!40000 ALTER TABLE `tb_member` DISABLE KEYS */;
INSERT INTO `tb_member` VALUES (1,'sommai','painai','sommai','$2b$10$2whunYQbdQHiBX9gLRSPOu5Ns1hmCntyTrRinHPfrfs5BVKlkvmv.','sommai@gmail.com','ผู้รับการประเมินผล','1790659063453.png'),(2,'commit','committee','Commit','$2b$10$Tb7ID.q3ZgqFYE0ZFkabWOpaXn6QOsy9j6SUN2oQfokpfR1vrkrB.','c@gmail.com','กรรมการประเมิน',NULL);
/*!40000 ALTER TABLE `tb_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_system`
--

DROP TABLE IF EXISTS `tb_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_system` (
  `id_sys` int NOT NULL AUTO_INCREMENT,
  `day_open` date DEFAULT NULL,
  `day_out` date DEFAULT NULL,
  `round_sys` int DEFAULT NULL,
  `year_sys` int DEFAULT NULL,
  `status_sys` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_sys`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_system`
--

LOCK TABLES `tb_system` WRITE;
/*!40000 ALTER TABLE `tb_system` DISABLE KEYS */;
INSERT INTO `tb_system` VALUES (1,'2026-05-06','2090-06-05',1,2026,'y');
/*!40000 ALTER TABLE `tb_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_topic`
--

DROP TABLE IF EXISTS `tb_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_topic` (
  `id_topic` int NOT NULL AUTO_INCREMENT,
  `name_topic` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_topic`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_topic`
--

LOCK TABLES `tb_topic` WRITE;
/*!40000 ALTER TABLE `tb_topic` DISABLE KEYS */;
INSERT INTO `tb_topic` VALUES (1,'computer');
/*!40000 ALTER TABLE `tb_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'pretestf'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-29 17:26:20
