-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: spring_security_custom_user_demo
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `days_remaining` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `due_date` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_details`
--

DROP TABLE IF EXISTS `assignment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assignment_id` int DEFAULT NULL,
  `is_done` int DEFAULT NULL,
  `student_course_details_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfcdla3wfj98w2g0ofil5bwoyp` (`assignment_id`),
  KEY `FKbxwi5sxerlpei1okpm0k9wdg3` (`student_course_details_id`),
  CONSTRAINT `FKbxwi5sxerlpei1okpm0k9wdg3` FOREIGN KEY (`student_course_details_id`) REFERENCES `student_course_details` (`id`),
  CONSTRAINT `FKfcdla3wfj98w2g0ofil5bwoyp` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_details`
--

LOCK TABLES `assignment_details` WRITE;
/*!40000 ALTER TABLE `assignment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `teacher_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKsybhlxoejr4j3teomm5u2bx1n` (`teacher_id`),
  CONSTRAINT `FKsybhlxoejr4j3teomm5u2bx1n` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (2,'01','Biology',3);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade_details`
--

DROP TABLE IF EXISTS `grade_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `grade_one` int DEFAULT NULL,
  `grade_three` int DEFAULT NULL,
  `grade_two` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade_details`
--

LOCK TABLES `grade_details` WRITE;
/*!40000 ALTER TABLE `grade_details` DISABLE KEYS */;
INSERT INTO `grade_details` VALUES (1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `grade_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ROLE_TEACHER'),(2,'ROLE_APG'),(3,'ROLE_STUDENT');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKe4f8c4nag6ggefun7fh9yy30k` (`role_id`),
  CONSTRAINT `FKe4f8c4nag6ggefun7fh9yy30k` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (2,'maxwell@gmail.com','max','m','$2a$10$QNeQaoSimdGqpH4EcdzVe.E5onXN5dpsT3SS7sHAXgLPQzrBU5OGO','maxwell',NULL),(3,'barak@gmail.com','barak','b','$2a$10$7vG/..6PUbluBDsnWKrNaeD/bOCylUEj.ptS0o8LeoHe4.5PYCCuu','barak',3),(4,'peru@gmail.com','peru','p','$2a$10$xtQHtuiiB9JpRK.CnmfQfe9T8Eg5OvUIbHJEX4ZHPeeHtZEKG83hG','peru',3),(5,'guru@gmail.com','guru','g','$2a$10$lKzPHRq0Mq1nU/krNp1k6OTh0PVhP91eNNwuYpbVYE4yak3hMj.kO','guru',3),(6,'stud@gmail.com','stud','s','$2a$10$shu5abmeHX4tmvEFdOK0WeTq.ec58Tdm3r3H2K44sRSe9Vroyr22O','stud',3),(7,'aqil@gmail.com','aqil','l','$2a$10$Jkt78rMcG03LvuxcQ96rs.ezll4SkmMoza7P0It7.FmoPWhF8AWMm','aqil',3),(8,'prasad@gmail.com','prasad','p','$2a$10$0tjmiaIXzy8KQvGK88Vf7euYfSnkPBtgQC6FOLoVCQCODy25TFyey','prasad',3);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_course_details`
--

DROP TABLE IF EXISTS `student_course_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_course_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `grade_details_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtfsk8s2q1uacwxbmyxaknmx3a` (`grade_details_id`),
  KEY `FK62h321gqmj4338mqhcg0qngd0` (`course_id`),
  KEY `FKolbit51em28kujcat5kcftvar` (`student_id`),
  CONSTRAINT `FK62h321gqmj4338mqhcg0qngd0` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `FKolbit51em28kujcat5kcftvar` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  CONSTRAINT `FKtfsk8s2q1uacwxbmyxaknmx3a` FOREIGN KEY (`grade_details_id`) REFERENCES `grade_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_course_details`
--

LOCK TABLES `student_course_details` WRITE;
/*!40000 ALTER TABLE `student_course_details` DISABLE KEYS */;
INSERT INTO `student_course_details` VALUES (1,2,7,1);
/*!40000 ALTER TABLE `student_course_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7g0kf85wsla22mvk53xdi6aea` (`role_id`),
  CONSTRAINT `FK7g0kf85wsla22mvk53xdi6aea` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (1,'martin@gmail.com','martin','M','$2a$10$L3hEoAmsa1.IVM4KHxPG0u/Rz7PZXCUy/idZdleUWyNjI1yCKguvG','martin',NULL),(2,'abb@gmail.com','abb','a','$2a$10$X9IKX.J67tsRCuBIU33B1OCdFK3FGsayp8WzqMcTvzHhh47YIHc/q','abb',1),(3,'abk@gmail.com','abk','k','$2a$10$bGabAmAnSP8oLGiBMJBSpe6f.Dsk/HiFL/Q97DzPaiYoHHZeQrgb6','abk',1),(4,'pla@gmail.com','pla','p','$2a$10$e/R5jNOgf0IfWGLb7HMkxelMVzE36SDsGLtziMsFpdlxoyCjxM6jS','pla',1),(5,'pandi@gmail.com','pandi','p','$2a$10$epkI8Gr6Sl5Q5nt8xNeLoeu1O6gHANRaNzA1FA6c2F43/igxcQRIi','pandi',1),(6,'azc@gmail.com','azc','a','$2a$10$tgvsIgTg2k0YHDdkieUInOehu02oRk5ncR7oULU0wiCBx1asaDLMW','azc',1),(7,'will@gmail.com','will','w','$2a$10$K51ircSOtkLcSd9Dqcb1X.ILco6DDw9y8h2fxQNZ09e6xgYD0PUh6','will',1);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-31 13:39:39
