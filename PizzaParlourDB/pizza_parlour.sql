-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizza_parlour
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizza_parlour` ;

-- -----------------------------------------------------
-- Schema pizza_parlour
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizza_parlour` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizza_parlour` ;

-- -----------------------------------------------------
-- Table `pizza_parlour`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`province` (
  `province_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`province_id`),
  UNIQUE INDEX `province_id_UNIQUE` (`province_id` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`locality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`locality` (
  `locality_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`locality_id`),
  INDEX `fk_locality_province1_idx` (`province_id` ASC) VISIBLE,
  CONSTRAINT `fk_locality_province1`
    FOREIGN KEY (`province_id`)
    REFERENCES `pizza_parlour`.`province` (`province_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `surname` VARCHAR(60) NULL DEFAULT NULL,
  `address` VARCHAR(60) NOT NULL,
  `locality_id` INT NOT NULL,
  `province_id` INT NOT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `postal_code` INT NOT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `fk_client_locality_idx` (`locality_id` ASC) VISIBLE,
  INDEX `fk_client_province1_idx` (`province_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_locality`
    FOREIGN KEY (`locality_id`)
    REFERENCES `pizza_parlour`.`locality` (`locality_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_client_province1`
    FOREIGN KEY (`province_id`)
    REFERENCES `pizza_parlour`.`province` (`province_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`store` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `adress` VARCHAR(60) NOT NULL,
  `postal_code` INT NOT NULL,
  `locality_id` INT NOT NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `fk_store_locality1_idx` (`locality_id` ASC) VISIBLE,
  INDEX `fk_store_province1_idx` (`province_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_locality1`
    FOREIGN KEY (`locality_id`)
    REFERENCES `pizza_parlour`.`locality` (`locality_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_store_province1`
    FOREIGN KEY (`province_id`)
    REFERENCES `pizza_parlour`.`province` (`province_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `role` ENUM('cook', 'rider') NULL DEFAULT NULL,
  `store_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_store1_idx` (`store_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizza_parlour`.`store` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `date_time` TIMESTAMP NOT NULL,
  `delivery_type` ENUM('DELIVERY', 'PICKUP') NULL DEFAULT NULL,
  `client_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_order_client1_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_order_store1_idx` (`store_id` ASC) VISIBLE,
  INDEX `fk_order_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `pizza_parlour`.`client` (`client_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `pizza_parlour`.`employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `pizza_parlour`.`store` (`store_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`product_category` (
  `product_category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`product_category_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `description` VARCHAR(350) NULL DEFAULT NULL,
  `image` BLOB NULL DEFAULT NULL,
  `price` DECIMAL(4,2) NULL DEFAULT NULL,
  `order_id` INT NOT NULL,
  `product_category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_product_order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_product_product_category1_idx` (`product_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizza_parlour`.`order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_product_category1`
    FOREIGN KEY (`product_category_id`)
    REFERENCES `pizza_parlour`.`product_category` (`product_category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`order_line` (
  `order_line_id` INT NOT NULL AUTO_INCREMENT,
  `units` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`order_line_id`),
  INDEX `fk_order_line_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_line_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizza_parlour`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizza_parlour`.`order_has_order_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza_parlour`.`order_has_order_line` (
  `order_id` INT NOT NULL,
  `order_line_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `order_line_id`),
  INDEX `fk_order_has_order_line_order_line1_idx` (`order_line_id` ASC) VISIBLE,
  INDEX `fk_order_has_order_line_order1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_has_order_line_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizza_parlour`.`order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_has_order_line_order_line1`
    FOREIGN KEY (`order_line_id`)
    REFERENCES `pizza_parlour`.`order_line` (`order_line_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
