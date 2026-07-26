-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema glasses_optic
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `glasses_optic` ;

-- -----------------------------------------------------
-- Schema glasses_optic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `glasses_optic` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `glasses_optic` ;

-- -----------------------------------------------------
-- Table `glasses_optic`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(50) NOT NULL,
  `number` VARCHAR(10) NULL DEFAULT NULL,
  `floor` VARCHAR(10) NULL DEFAULT NULL,
  `door` VARCHAR(10) NULL DEFAULT NULL,
  `city` VARCHAR(50) NOT NULL,
  `pc` VARCHAR(10) NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_optic`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`provider` (
  `provider_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `fax` VARCHAR(15) NULL DEFAULT NULL,
  `nif` VARCHAR(9) NULL DEFAULT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE INDEX `nif` (`nif` ASC) VISIBLE,
  INDEX `fk_provider_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_provider_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `glasses_optic`.`address` (`address_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_optic`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`brand` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `provider_id` INT NOT NULL,
  PRIMARY KEY (`brand_id`),
  INDEX `fk_brand_provider1_idx` (`provider_id` ASC) VISIBLE,
  CONSTRAINT `fk_brand_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `glasses_optic`.`provider` (`provider_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_optic`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(40) NULL DEFAULT NULL,
  `registration` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recommended_by_id` INT NULL DEFAULT NULL,
  `address_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `fk_recommender_idx` (`recommended_by_id` ASC) VISIBLE,
  INDEX `fk_client_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `glasses_optic`.`address` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_recommender`
    FOREIGN KEY (`recommended_by_id`)
    REFERENCES `glasses_optic`.`client` (`client_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_optic`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_optic`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`glasses` (
  `glasses_id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(50) NOT NULL,
  `prescription_left` DECIMAL(4,2) NULL DEFAULT NULL,
  `prescription_right` DECIMAL(4,2) NULL DEFAULT NULL,
  `mount_color` VARCHAR(60) NULL,
  `colour_glassLeft` VARCHAR(30) NULL,
  `colour_glassRight` VARCHAR(30) NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `mount_type` ENUM('rimless', 'plastic', 'metal') NOT NULL,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`glasses_id`),
  INDEX `fk_glasses_brand1_idx` (`brand_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_brand1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `glasses_optic`.`brand` (`brand_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_optic`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`sale` (
  `sale_id` INT NOT NULL AUTO_INCREMENT,
  `sale_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `employee_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  PRIMARY KEY (`sale_id`),
  INDEX `fk_sale_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_sale_client1_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_sale_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_sale_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `glasses_optic`.`client` (`client_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sale_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `glasses_optic`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sale_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `glasses_optic`.`glasses` (`glasses_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
