-- MariaDB dump 10.19-11.3.2-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'사슴','dddd@naver.com','1234','오류동\n',30,NULL,'user',NULL,NULL,2),
(3,'바보','choco@naver.com','1234','오류동\n\n',14,NULL,'user',NULL,NULL,0),
(4,'돼지\n','milk@google.com',NULL,NULL,30,NULL,'user',NULL,NULL,0),
(5,'cake','cake@navr.com',NULL,NULL,25,NULL,'admin',NULL,NULL,0),
(6,NULL,'yahoo@gmail.com',NULL,'탄현동',24,NULL,'user',NULL,'2024-05-17 07:14:48',0),
(7,'고양이','cat@googl.com',NULL,NULL,28,NULL,'user',NULL,'2024-05-20 06:38:17',0),
(24,'홍길동','hong@gmail.com',NULL,'대방동',26,NULL,'user',NULL,'2024-05-20 08:40:29',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello world','bye',1,1000.000,NULL,'51f274a5-138b-11ef-9cb5-0242ac110002'),
(2,'smile2','kill',NULL,1500.000,NULL,'51f27b63-138b-11ef-9cb5-0242ac110002'),
(3,'hello java',NULL,3,1234.100,'2014-04-17 03:35:13','51f27bf3-138b-11ef-9cb5-0242ac110002'),
(4,'good',NULL,NULL,2000.000,'1999-01-01 12:01:00','51f27c3b-138b-11ef-9cb5-0242ac110002'),
(5,'good',NULL,4,4000.000,'2021-06-17 03:35:13','51f27c7b-138b-11ef-9cb5-0242ac110002'),
(6,'abc',NULL,NULL,60000.000,'2024-05-17 07:28:28','59b47097-138b-11ef-9cb5-0242ac110002'),
(7,'hello world',NULL,1,1500.000,'2024-11-20 05:25:23','5653b189-13c2-11ef-9cb5-0242ac110002'),
(8,'hello world java',NULL,5,NULL,'2024-05-20 05:33:56','88244e48-13c3-11ef-9cb5-0242ac110002');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22  7:39:51
