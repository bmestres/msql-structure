-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema YouTubeDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `YouTubeDB` ;

-- -----------------------------------------------------
-- Schema YouTubeDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `YouTubeDB` DEFAULT CHARACTER SET UTF8MB4;
USE `YouTubeDB` ;

-- -----------------------------------------------------
-- Table `YouTubeDB`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(60) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `username` VARCHAR(60) NOT NULL,
  `birth_date` DATE NULL,
  `gender` ENUM('MALE', 'FEMALE', 'NONBINARY') NULL,
  `country` VARCHAR(60) NULL,
  `postal_code` INT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`video` (
  `video_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `size` DECIMAL(8,2) NOT NULL,
  `file_name` VARCHAR(100) NOT NULL,
  `thumbnail` BLOB NULL,
  `views` INT NULL DEFAULT 0,
  `likes` INT NULL DEFAULT 0,
  `dislikes` INT NULL DEFAULT 0,
  `state` ENUM('PUBLIC', 'HIDDEN', 'PRIVATE') NULL,
  `publication_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`video_id`),
  INDEX `fk_video_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTubeDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`tag` (
  `tag_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`channel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`channel` (
  `channel_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `description` TEXT NULL,
  `creation_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`channel_id`),
  INDEX `fk_channel_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_channel_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTubeDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`playlist` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  `creation_date` DATETIME NULL,
  `state` ENUM('PUBLIC', 'PRIVATE') NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `fk_playlist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTubeDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`comment` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT NULL,
  `date_time` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `fk_comment_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_video1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_comment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTubeDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTubeDB`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`subscription` (
  `user_id` INT NOT NULL,
  `channel_id` INT NOT NULL,
  `date_time` DATETIME NULL,
  PRIMARY KEY (`user_id`, `channel_id`),
  INDEX `fk_user_has_channel_channel1_idx` (`channel_id` ASC) VISIBLE,
  INDEX `fk_user_has_channel_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_channel_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTubeDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_has_channel_channel1`
    FOREIGN KEY (`channel_id`)
    REFERENCES `YouTubeDB`.`channel` (`channel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`video_has_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`video_has_tag` (
  `video_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  PRIMARY KEY (`video_id`, `tag_id`),
  INDEX `fk_video_has_tag_tag1_idx` (`tag_id` ASC) VISIBLE,
  INDEX `fk_video_has_tag_video1_idx` (`video_id` ASC) VISIBLE,
  CONSTRAINT `fk_video_has_tag_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTubeDB`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_video_has_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `YouTubeDB`.`tag` (`tag_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`playlist_contains_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`playlist_contains_video` (
  `playlist_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `video_id`),
  INDEX `fk_playlist_has_video_video1_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_video_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_video_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `YouTubeDB`.`playlist` (`playlist_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_has_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTubeDB`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`user_interacts_with_video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`user_interacts_with_video` (
  `user_id` INT NOT NULL,
  `video_id` INT NOT NULL,
  `type` ENUM('LIKE', 'DISLIKE') NULL,
  `date_time` DATETIME NULL,
  PRIMARY KEY (`user_id`, `video_id`),
  INDEX `fk_user_has_video_video1_idx` (`video_id` ASC) VISIBLE,
  INDEX `fk_user_has_video_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_video_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTubeDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_has_video_video1`
    FOREIGN KEY (`video_id`)
    REFERENCES `YouTubeDB`.`video` (`video_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTubeDB`.`user_interacts_with_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTubeDB`.`user_interacts_with_comment` (
  `user_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  `date_time` DATETIME NULL,
  `type` ENUM('LIKE', 'DISLIKE') NULL,
  PRIMARY KEY (`user_id`, `comment_id`),
  INDEX `fk_user_has_comment_comment1_idx` (`comment_id` ASC) VISIBLE,
  INDEX `fk_user_has_comment_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `YouTubeDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_has_comment_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `YouTubeDB`.`comment` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
