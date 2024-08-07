-- MySQL dump 10.13  Distrib 8.0.37, for Linux (aarch64)
--
-- Host: localhost    Database: myapp_development
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
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2024-07-29 05:12:25.615471','2024-07-29 05:23:03.386722'),('schema_sha1','1b47f324debb9fee5ae1d0e537d920955de29e02','2024-07-29 05:12:25.618517','2024-07-29 05:12:25.618517');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `choices`
--

DROP TABLE IF EXISTS `choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `choices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` bigint NOT NULL,
  `content` text,
  `is_correct` tinyint(1) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_choices_on_question_id` (`question_id`),
  CONSTRAINT `fk_rails_182ad7dfd9` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `choices`
--

LOCK TABLES `choices` WRITE;
/*!40000 ALTER TABLE `choices` DISABLE KEYS */;
INSERT INTO `choices` VALUES (1,1,'Ambulance',1,'2024-08-01 07:56:47.667350','2024-08-02 02:29:10.369425'),(2,1,'Fire truck',0,'2024-08-01 07:56:47.669058','2024-08-01 07:56:47.669058'),(3,1,'Police car',0,'2024-08-01 07:56:47.670098','2024-08-01 07:56:47.670098'),(100,2,'Yellow',1,'2024-08-02 06:31:14.295455','2024-08-02 07:25:41.960735'),(101,2,'Blue',0,'2024-08-02 06:31:14.297509','2024-08-02 06:31:14.297509'),(102,2,'Green',0,'2024-08-02 06:31:14.299120','2024-08-02 06:31:14.299120'),(103,3,'Police car',1,'2024-08-02 06:33:04.644450','2024-08-02 07:26:06.601189'),(104,3,'Bicycle',0,'2024-08-02 06:33:04.646163','2024-08-02 06:33:04.646163'),(105,3,'Motorcycle',0,'2024-08-02 06:33:04.647691','2024-08-02 06:33:04.647691'),(106,4,'Collects trash',1,'2024-08-02 07:01:24.515477','2024-08-02 07:26:22.117595'),(107,4,'Delivers mail',0,'2024-08-02 07:01:24.516724','2024-08-02 07:01:24.516724'),(108,4,'sell ice cream',0,'2024-08-02 07:01:24.518104','2024-08-02 07:01:24.518104'),(109,5,'Red',1,'2024-08-02 07:27:36.953784','2024-08-02 07:28:12.179623'),(110,5,'Blue',0,'2024-08-02 07:27:36.955482','2024-08-02 07:27:36.955482'),(111,5,'Green',0,'2024-08-02 07:27:36.956909','2024-08-02 07:27:36.956909'),(112,6,'Siren',1,'2024-08-02 07:29:15.032787','2024-08-02 07:29:21.749589'),(113,6,'Horn',0,'2024-08-02 07:29:15.034304','2024-08-02 07:29:15.034304'),(114,6,'Bell',0,'2024-08-02 07:29:15.035590','2024-08-02 07:29:15.035590'),(115,7,'Ambulance',1,'2024-08-02 07:35:29.223598','2024-08-02 07:38:19.766634'),(116,7,'School bus',0,'2024-08-02 07:35:29.225423','2024-08-02 07:35:29.225423'),(117,7,'Fire truck',0,'2024-08-02 07:35:29.226925','2024-08-02 07:35:29.226925'),(118,8,'Police car',1,'2024-08-02 07:39:14.270569','2024-08-02 07:39:14.270569'),(119,8,'Fire truck',0,'2024-08-02 07:39:14.272492','2024-08-02 07:39:14.272492'),(120,8,'Ambulance',0,'2024-08-02 07:39:14.273833','2024-08-02 07:39:14.273833');
/*!40000 ALTER TABLE `choices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `question_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'What is this?','2024-08-01 07:56:47.660159','2024-08-02 02:13:37.572843','DALL_E_2024-07-18_11.57.06_-_A_clear__high-quality_illustration_of_an_ambulance._The_image_should_show_the_ambulance_prominently_without_any_background__giving_a_clean_and_simple_.webp'),(2,'What color is the school bus?','2024-08-02 06:31:14.290607','2024-08-02 06:31:14.290607','DALL_E_2024-07-18_15.47.14_-_A_high-quality_illustration_of_a_yellow_school_bus_from_the_side._The_image_should_show_the_school_bus_prominently_without_any_background_color__givin.webp'),(3,'Which vehicle has a siren?','2024-08-02 06:33:04.641258','2024-08-02 06:33:04.641258','DALL_E_2024-07-18_15.47.29_-_A_high-quality_illustration_showing_three_equally_sized_vehicles_from_the_side__a_police_car__black_and_white_with_a_red_light_on_top___a_bicycle__yel.webp'),(4,'What does a garbage truck do?','2024-08-02 07:01:24.512111','2024-08-02 08:05:54.598912','DALL_E_2024-07-18_15.55.51_-_A_high-quality_illustration_showing_three_scenes__a_person_collecting_trash_with_a_garbage_can__a_person_delivering_mail_with_a_mail_bag__and_a_person.webp'),(5,'What color is the fire truck?','2024-08-02 07:27:36.948752','2024-08-02 08:01:05.903710','DALL_E_2024-07-18_11.12.00_-_A_clear__high-quality_illustration_of_a_fire_truck._The_image_should_show_the_fire_truck_prominently_without_any_background__giving_a_clean_and_simple.webp'),(6,'What sound does an ambulance make?','2024-08-02 07:29:15.029485','2024-08-02 07:29:15.029485','DALL_E_2024-07-19_11.00.37_-_A_high-quality_illustration_showing_three_images__a_single_siren_light__a_bell__and_a_whistle._The_images_should_be_clearly_visible_and_separated_from.webp'),(7,'Which vehicle carries people to the hospital?','2024-08-02 07:35:29.219333','2024-08-02 07:35:29.219333','DALL_E_2024-07-19_11.01.54_-_A_high-quality_illustration_showing_three_equally_sized_vehicles_from_the_side__an_ambulance__red_and_white___a_school_bus__yellow___and_a_fire_truck_.webp'),(8,'What is this?','2024-08-02 07:39:14.267277','2024-08-02 07:39:14.267277','DALL_E_2024-07-19_11.08.42_-_A_high-quality_illustration_of_a_police_car_from_the_side._The_image_should_show_the_police_car_prominently_without_any_background_color__giving_a_cle.webp');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('0'),('20240729042210'),('20240731053607'),('20240731053725'),('20240731064143'),('20240802013340'),('20240802013529');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `crypted_password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'alina172021@gmail.com','$2a$10$WngCQLhGy.VVblhCqq4z3.z6.BqYAD7cZroX5DiiHxO26ZtjjE/h.','rNsxJ69qztoMB5T9Vgsj','admin','2024-07-30 02:32:16.435171','2024-07-30 02:32:16.435171');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-06 16:06:56
