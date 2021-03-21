-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: ecobank
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `client_profile`
--

DROP TABLE IF EXISTS `client_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_profile` (
  `users_id_account` int unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `passport` bigint NOT NULL,
  `gender` enum('m','f') DEFAULT NULL,
  `birthday` date NOT NULL,
  `address` varchar(250) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `photo` blob,
  PRIMARY KEY (`users_id_account`),
  UNIQUE KEY `passport_UNIQUE` (`passport`),
  KEY `fk_client_profile_users_idx` (`users_id_account`),
  CONSTRAINT `fk_client_profile_users` FOREIGN KEY (`users_id_account`) REFERENCES `users` (`id_account`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `clients_health_types`
--

DROP TABLE IF EXISTS `clients_health_types`;
/*!50001 DROP VIEW IF EXISTS `clients_health_types`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `clients_health_types` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `address`,
 1 AS `health_types`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `clients_housing`
--

DROP TABLE IF EXISTS `clients_housing`;
/*!50001 DROP VIEW IF EXISTS `clients_housing`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `clients_housing` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `address`,
 1 AS `housing_type`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `order` decimal(17,2) NOT NULL,
  `address` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drive`
--

DROP TABLE IF EXISTS `drive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drive` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id_account` int unsigned NOT NULL,
  `route` varchar(150) NOT NULL COMMENT 'маршрут движения (работа - дом, дом - магазин, и т.д.)',
  `distance` float NOT NULL COMMENT 'расстояние, км',
  `date_drive` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cost` decimal(10,2) DEFAULT NULL,
  `company_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_drive_users1_idx` (`users_id_account`),
  KEY `fk_drive_company1_idx` (`company_id`),
  CONSTRAINT `fk_drive_company1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `fk_drive_users1` FOREIGN KEY (`users_id_account`) REFERENCES `users` (`id_account`)
) ENGINE=InnoDB AUTO_INCREMENT=1351 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `health`
--

DROP TABLE IF EXISTS `health`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health` (
  `users_id_account` int unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `health_types` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `health_type_id_ht` int NOT NULL,
  KEY `fk_table1_users2_idx` (`users_id_account`),
  KEY `fk_health_health_type1_idx` (`health_type_id_ht`),
  CONSTRAINT `fk_health_health_type1` FOREIGN KEY (`health_type_id_ht`) REFERENCES `health_type` (`id_ht`),
  CONSTRAINT `fk_table1_users2` FOREIGN KEY (`users_id_account`) REFERENCES `users` (`id_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `health_type`
--

DROP TABLE IF EXISTS `health_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `health_type` (
  `id_ht` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id_ht`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `housing`
--

DROP TABLE IF EXISTS `housing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housing` (
  `users_id_account` int unsigned NOT NULL,
  `housing_types_id` int NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  KEY `fk_housing_users1_idx` (`users_id_account`),
  KEY `fk_housing_housing_types1_idx` (`housing_types_id`),
  CONSTRAINT `fk_housing_housing_types1` FOREIGN KEY (`housing_types_id`) REFERENCES `housing_types` (`id`),
  CONSTRAINT `fk_housing_users1` FOREIGN KEY (`users_id_account`) REFERENCES `users` (`id_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `housing_types`
--

DROP TABLE IF EXISTS `housing_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housing_types` (
  `id` int NOT NULL,
  `type` varchar(45) DEFAULT NULL COMMENT 'Покупка\nДолгосрочная аренда\nКраткосрочная аредна\nПродажа',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `markets`
--

DROP TABLE IF EXISTS `markets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `markets` (
  `users_id_account` int unsigned NOT NULL,
  `order` varchar(200) NOT NULL COMMENT 'содержание заказа',
  `price` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `company_id` int NOT NULL,
  KEY `fk_table1_users1_idx` (`users_id_account`),
  KEY `fk_markets_company1_idx` (`company_id`),
  CONSTRAINT `fk_markets_company1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `fk_table1_users1` FOREIGN KEY (`users_id_account`) REFERENCES `users` (`id_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `users_id_account` int unsigned NOT NULL,
  `orders_type_id` int unsigned NOT NULL,
  `open_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `persent` decimal(5,2) unsigned NOT NULL,
  `initial_sum` decimal(17,2) NOT NULL,
  `interval` int DEFAULT NULL,
  KEY `fk_orders_users1_idx` (`users_id_account`),
  KEY `fk_orders_orders_type1_idx` (`orders_type_id`),
  CONSTRAINT `fk_orders_orders_type1` FOREIGN KEY (`orders_type_id`) REFERENCES `orders_type` (`id`),
  CONSTRAINT `fk_orders_users1` FOREIGN KEY (`users_id_account`) REFERENCES `users` (`id_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_type`
--

DROP TABLE IF EXISTS `orders_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_type` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `from_users_id` int unsigned NOT NULL,
  `to_users_id` int unsigned NOT NULL,
  `from_company_id` int NOT NULL,
  `to_company_id` int NOT NULL,
  KEY `fk_transactions_users1_idx` (`from_users_id`),
  KEY `fk_transactions_users2_idx` (`to_users_id`),
  KEY `fk_transactions_Company1_idx` (`from_company_id`),
  KEY `fk_transactions_Company2_idx` (`to_company_id`),
  CONSTRAINT `fk_transactions_Company1` FOREIGN KEY (`from_company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `fk_transactions_Company2` FOREIGN KEY (`to_company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `fk_transactions_users1` FOREIGN KEY (`from_users_id`) REFERENCES `users` (`id_account`),
  CONSTRAINT `fk_transactions_users2` FOREIGN KEY (`to_users_id`) REFERENCES `users` (`id_account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!50001 DROP VIEW IF EXISTS `user_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_info` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `email`,
 1 AS `gender`,
 1 AS `birthday`,
 1 AS `address`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_account` int unsigned NOT NULL AUTO_INCREMENT,
  `phone` bigint unsigned NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` char(50) NOT NULL,
  PRIMARY KEY (`id_account`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `password_hash_UNIQUE` (`password_hash`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `clients_health_types`
--

/*!50001 DROP VIEW IF EXISTS `clients_health_types`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clients_health_types` AS select `u`.`id_account` AS `id`,concat(`p`.`firstname`,' ',`p`.`lastname`) AS `name`,`p`.`address` AS `address`,`ht`.`type` AS `health_types` from (((`users` `u` join `client_profile` `p` on((`p`.`users_id_account` = `u`.`id_account`))) join `health` `h` on((`u`.`id_account` = `h`.`users_id_account`))) join `health_type` `ht` on((`h`.`health_types` = `ht`.`id_ht`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `clients_housing`
--

/*!50001 DROP VIEW IF EXISTS `clients_housing`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clients_housing` AS select `u`.`id_account` AS `id`,concat(`p`.`firstname`,' ',`p`.`lastname`) AS `name`,`p`.`address` AS `address`,`ht`.`type` AS `housing_type` from (((`users` `u` join `client_profile` `p` on((`p`.`users_id_account` = `u`.`id_account`))) join `housing` `h` on((`u`.`id_account` = `h`.`users_id_account`))) join `housing_types` `ht` on((`h`.`housing_types_id` = `ht`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_info`
--

/*!50001 DROP VIEW IF EXISTS `user_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_info` AS select `u`.`id_account` AS `id`,concat(`p`.`firstname`,' ',`p`.`lastname`) AS `name`,`u`.`email` AS `email`,`p`.`gender` AS `gender`,`p`.`birthday` AS `birthday`,`p`.`address` AS `address` from (`users` `u` join `client_profile` `p` on((`p`.`users_id_account` = `u`.`id_account`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 16:19:59
