-- MySQL Workbench Synchronization
-- Generated: 2021-03-07 15:30
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Ksammar

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `ecobank` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `ecobank`.`users` (
  `id_account` INT(10) UNSIGNED NULL DEFAULT NULL AUTO_INCREMENT,
  `phone` BIGINT(19) UNSIGNED NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `password_hash` CHAR(50) NOT NULL,
  PRIMARY KEY (`id_account`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `password_hash_UNIQUE` (`password_hash` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`client_profile` (
  `users_id_account` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(150) NOT NULL,
  `lastname` VARCHAR(150) NOT NULL,
  `passport` BIGINT(10) NOT NULL,
  `gender` ENUM('m', 'f') NULL DEFAULT NULL,
  `birthday` DATE NOT NULL,
  `address` VARCHAR(250) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `photo` BLOB NULL DEFAULT NULL,
  INDEX `fk_client_profile_users_idx` (`users_id_account` ASC) VISIBLE,
  PRIMARY KEY (`users_id_account`),
  UNIQUE INDEX `passport_UNIQUE` (`passport` ASC) VISIBLE,
  CONSTRAINT `fk_client_profile_users`
    FOREIGN KEY (`users_id_account`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`transactions` (
  `from_users_id` INT(10) UNSIGNED NOT NULL,
  `to_users_id` INT(10) UNSIGNED NOT NULL,
  `from_company_id` INT(11) NOT NULL,
  `to_company_id` INT(11) NOT NULL,
  INDEX `fk_transactions_users1_idx` (`from_users_id` ASC) VISIBLE,
  INDEX `fk_transactions_users2_idx` (`to_users_id` ASC) VISIBLE,
  INDEX `fk_transactions_Company1_idx` (`from_company_id` ASC) VISIBLE,
  INDEX `fk_transactions_Company2_idx` (`to_company_id` ASC) VISIBLE,
  CONSTRAINT `fk_transactions_users1`
    FOREIGN KEY (`from_users_id`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_users2`
    FOREIGN KEY (`to_users_id`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_Company1`
    FOREIGN KEY (`from_company_id`)
    REFERENCES `ecobank`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_Company2`
    FOREIGN KEY (`to_company_id`)
    REFERENCES `ecobank`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`company` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `order` DECIMAL(17,2) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`orders` (
  `users_id_account` INT(10) UNSIGNED NOT NULL,
  `orders_type_id` INT(10) UNSIGNED NOT NULL,
  `open_at` DATETIME NOT NULL DEFAULT NOW(),
  `persent` DECIMAL(5,2) UNSIGNED NOT NULL,
  `initial_sum` DECIMAL(17,2) NOT NULL,
  `interval` INT(10) NULL DEFAULT NULL,
  INDEX `fk_orders_users1_idx` (`users_id_account` ASC) VISIBLE,
  INDEX `fk_orders_orders_type1_idx` (`orders_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`users_id_account`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_orders_type1`
    FOREIGN KEY (`orders_type_id`)
    REFERENCES `ecobank`.`orders_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`orders_type` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`markets` (
  `users_id_account` INT(10) UNSIGNED NOT NULL,
  `order` VARCHAR(200) NOT NULL COMMENT 'содержание заказа',
  `price` DECIMAL(10,2) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `company_id` INT(11) NOT NULL,
  INDEX `fk_table1_users1_idx` (`users_id_account` ASC) VISIBLE,
  INDEX `fk_markets_company1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_table1_users1`
    FOREIGN KEY (`users_id_account`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_markets_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `ecobank`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`health` (
  `users_id_account` INT(10) UNSIGNED NOT NULL,
  `created_at` DATETIME NOT NULL,
  `health_types` INT(11) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `health_type_id_ht` INT(11) NOT NULL,
  INDEX `fk_table1_users2_idx` (`users_id_account` ASC) VISIBLE,
  INDEX `fk_health_health_type1_idx` (`health_type_id_ht` ASC) VISIBLE,
  CONSTRAINT `fk_table1_users2`
    FOREIGN KEY (`users_id_account`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_health_health_type1`
    FOREIGN KEY (`health_type_id_ht`)
    REFERENCES `ecobank`.`health_type` (`id_ht`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`health_type` (
  `id_ht` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_ht`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`drive` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `users_id_account` INT(10) UNSIGNED NOT NULL,
  `route` VARCHAR(150) NOT NULL COMMENT 'маршрут движения (работа - дом, дом - магазин, и т.д.)',
  `distance` FLOAT(11) NOT NULL COMMENT 'расстояние, км',
  `date_drive` DATETIME NOT NULL DEFAULT NOW(),
  `cost` DECIMAL(10,2) NULL DEFAULT NULL,
  `company_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_drive_users1_idx` (`users_id_account` ASC) VISIBLE,
  INDEX `fk_drive_company1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_drive_users1`
    FOREIGN KEY (`users_id_account`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_drive_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `ecobank`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`housing` (
  `users_id_account` INT(10) UNSIGNED NOT NULL,
  `housing_types_id` INT(11) NOT NULL,
  `cost` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `fk_housing_users1_idx` (`users_id_account` ASC) VISIBLE,
  INDEX `fk_housing_housing_types1_idx` (`housing_types_id` ASC) VISIBLE,
  CONSTRAINT `fk_housing_users1`
    FOREIGN KEY (`users_id_account`)
    REFERENCES `ecobank`.`users` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_housing_housing_types1`
    FOREIGN KEY (`housing_types_id`)
    REFERENCES `ecobank`.`housing_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecobank`.`housing_types` (
  `id` INT(11) NOT NULL,
  `type` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Покупка\nДолгосрочная аренда\nКраткосрочная аредна\nПродажа',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
