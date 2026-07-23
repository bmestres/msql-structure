SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `glasses_optic` ;

CREATE SCHEMA IF NOT EXISTS `glasses_optic` DEFAULT CHARACTER SET UTF8MB4 ;
USE `glasses_optic`;

-- -----------------------------------------------------
-- Table `glasses_optic`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(50) NOT NULL,
  `number` VARCHAR(10) NULL,
  `floor` VARCHAR(10) NULL,
  `door` VARCHAR(10) NULL,
  `city` VARCHAR(50) NOT NULL,
  `pc` VARCHAR(10) NOT NULL,
  `country` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = INNODB;

INSERT INTO address(street, number, floor, door, city, pc, country)
VALUES('Balmes', '120', '3', '2', 'Barcelona', '08008', 'Spain'),
('Atocha', '27', '2', '7', 'Madrid', '08001', 'Spain'),
('Diagonal', '512', '5', '1', 'Barcelona', '08006', 'Spain'),
('Sants', '85', '1', 'C', 'Barcelona', '08014', 'Spain');

-- -----------------------------------------------------
-- Table `glasses_optic`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`provider` (
  `provider_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NULL,
  `fax` VARCHAR(15) NULL,
  `nif` VARCHAR(9) UNIQUE NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`provider_id`),
  INDEX `fk_provider_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_provider_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `glasses_optic`.`address` (`address_id`)
    ON UPDATE CASCADE)
ENGINE = INNODB;

INSERT INTO provider(name, phone, fax, nif, address_id)
VALUES('Gloaria', '934578692', '934568791', 'B1257897', 1),
('TechGlass BCN', '935578468', '935578567', 'E4896533', 2),
('Mediterraneo', '933334476', '933334577', 'N9862568', 3);

-- -----------------------------------------------------
-- Table `glasses_optic`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`brand` (
  `brand_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `provider_id` INT NOT NULL,
  PRIMARY KEY (`brand_id`),
  INDEX `fk_brand_provider1_idx` (`provider_id` ASC),
  CONSTRAINT `fk_brand_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `glasses_optic`.`provider` (`provider_id`)
    ON UPDATE CASCADE)
ENGINE = INNODB;

INSERT INTO brand(name, provider_id)
VALUES ('Xavier Garcia', 1),
('Kaleos', 3),
('Maller', 2),
('Kimze', 2);

-- -----------------------------------------------------
-- Table `glasses_optic`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`glasses` (
  `glasses_id` INT NOT NULL AUTO_INCREMENT,
  `prescription_left` DECIMAL(4,2) NULL,
  `prescription_right` DECIMAL(4,2) NULL,
  `mount_color` VARCHAR(60) NOT NULL,
  `colour_glassLeft` VARCHAR(30) NOT NULL,
  `colour_glassRight` VARCHAR(30) NOT NULL,
  `price` DECIMAL(6,3) NOT NULL,
  `mount_type` ENUM('rimless', 'plastic', 'metal') NOT NULL,
  `brand_id` INT NOT NULL,
  PRIMARY KEY (`glasses_id`),
  INDEX `fk_glasses_brand1_idx` (`brand_id` ASC),
  CONSTRAINT `fk_glasses_brand1`
    FOREIGN KEY (`brand_id`)
    REFERENCES `glasses_optic`.`brand` (`brand_id`)
    ON UPDATE CASCADE)
ENGINE = INNODB;

INSERT INTO glasses(prescription_left, prescription_right, mount_color, colour_glassLeft, colour_glassRight, price, mount_type, brand_id)
VALUES (1.25, 1.00, 'Black', 'Clear', 'Clear', 159.990, 'plastic', 1),
(2.50, 2.25, 'Matte Silver', 'Blue', 'Blue', 189.500, 'metal', 2),
(0.75, 0.50, 'Tortoiseshell', 'Green', 'Green', 220.000, 'plastic', 3),
(3.00, 3.25, 'Gold', 'Brown', 'Brown', 275.750, 'rimless', 4);

-- -----------------------------------------------------
-- Table `glasses_optic`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `phone` VARCHAR(15) NULL,
  `email` VARCHAR(40) NULL,
  `registration` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recommended_by_id` INT NULL,
  `address_id` INT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `fk_recommender_idx` (`recommended_by_id` ASC),
  INDEX `fk_client_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_recommender`
    FOREIGN KEY (`recommended_by_id`)
    REFERENCES `glasses_optic`.`client` (`client_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_client_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `glasses_optic`.`address` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = INNODB;

INSERT INTO `glasses_optic`.`client` (`name`, `phone`, `email`, `registration`, `recommended_by_id`, `address_id`) 
VALUES ('Rodrigo Perez', '+346768729', 'rodrigo_p_casanov225@gmail.com', '2023-05-10', NULL, 1);

-- -----------------------------------------------------
-- Table `glasses_optic`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_optic`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = INNODB;

INSERT INTO `employee` (`name`) VALUES 
('Mario Garcia'),
('Laura Martinez');

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
  INDEX `fk_sale_employee1_idx` (`employee_id` ASC),
  INDEX `fk_sale_client1_idx` (`client_id` ASC),
  INDEX `fk_sale_glasses1_idx` (`glasses_id` ASC),
  CONSTRAINT `fk_sale_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `glasses_optic`.`employee` (`employee_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sale_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `glasses_optic`.`client` (`client_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sale_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `glasses_optic`.`glasses` (`glasses_id`)
    ON UPDATE CASCADE)
ENGINE = INNODB;

INSERT INTO `sale` (`employee_id`, `client_id`, `glasses_id`) VALUES 
(1, 1, 1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
