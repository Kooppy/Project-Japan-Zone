-- MySQL Script generated by MySQL Workbench
-- Tue Feb 22 09:35:32 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `test` ;

-- -----------------------------------------------------
-- Table `test`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`user` (
  `num_user` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(32) NOT NULL,
  `pseudo` VARCHAR(128) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `confirmation_date` DATETIME NULL,
  PRIMARY KEY (`num_user`),
  UNIQUE INDEX `pseudo_UNIQUE` (`pseudo` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `num_user_UNIQUE` (`num_user` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`blog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`blog` (
  `num_blog` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(32) NOT NULL,
  `description` VARCHAR(128) NOT NULL,
  `contents` LONGTEXT NOT NULL,
  `date` DATETIME NOT NULL,
  `num_user` INT NOT NULL,
  PRIMARY KEY (`num_blog`),
  INDEX `fk_blog_1_idx` (`num_user` ASC) VISIBLE,
  UNIQUE INDEX `num_blog_UNIQUE` (`num_blog` ASC) VISIBLE,
  CONSTRAINT `fk_blog_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`user_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`user_address` (
  `num_user` INT NOT NULL,
  `name` VARCHAR(32) NULL,
  `first_name` VARCHAR(32) NULL,
  `address` VARCHAR(32) NULL,
  `postal_code` VARCHAR(5) NULL,
  `city` VARCHAR(15) NULL,
  `phone` VARCHAR(10) NULL,
  PRIMARY KEY (`num_user`),
  UNIQUE INDEX `num_user_UNIQUE` (`num_user` ASC) VISIBLE,
  CONSTRAINT `fk_complementAdresse_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`user_profil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`user_profil` (
  `num_user` INT NOT NULL,
  `civility` CHAR(1) NULL,
  `description` VARCHAR(128) NULL,
  PRIMARY KEY (`num_user`),
  UNIQUE INDEX `num_user_UNIQUE` (`num_user` ASC) VISIBLE,
  CONSTRAINT `fk_complementProfil_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`pictureBank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`pictureBank` (
  `num_picture` INT NOT NULL AUTO_INCREMENT,
  `link_picture` VARCHAR(128) NOT NULL DEFAULT 'assets/images/avatar/1644325173801_user_avatar.jpg',
  `title_picture` VARCHAR(32) NULL,
  `description_picture` VARCHAR(128) NULL,
  `num_user` INT NOT NULL,
  `num_blog` INT NULL,
  PRIMARY KEY (`num_picture`),
  INDEX `pictureBanque_ibfk_1_idx` (`num_user` ASC) VISIBLE,
  UNIQUE INDEX `num_picture_UNIQUE` (`num_picture` ASC) VISIBLE,
  INDEX `fk_pictureBanque_2_idx` (`num_blog` ASC) VISIBLE,
  CONSTRAINT `fk_pictureBanque_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_pictureBanque_2`
    FOREIGN KEY (`num_blog`)
    REFERENCES `test`.`blog` (`num_blog`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`user_role` (
  `num_user` INT NOT NULL,
  `isVerify` TINYINT NOT NULL DEFAULT 0,
  `isAdmin` TINYINT NOT NULL DEFAULT 0,
  `isBan` TINYINT NOT NULL DEFAULT 0,
  `isArchiving` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`num_user`),
  UNIQUE INDEX `num_user_UNIQUE` (`num_user` ASC) VISIBLE,
  CONSTRAINT `fk_role_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`comment` (
  `num_comment` INT NOT NULL AUTO_INCREMENT,
  `contents` LONGTEXT NOT NULL,
  `date` DATETIME NOT NULL,
  `num_user` INT NOT NULL,
  `num_blog` INT NOT NULL,
  PRIMARY KEY (`num_comment`),
  INDEX `fk_comment_1_idx` (`num_user` ASC) VISIBLE,
  INDEX `fk_comment_2_idx` (`num_blog` ASC) VISIBLE,
  UNIQUE INDEX `num_comment_UNIQUE` (`num_comment` ASC) VISIBLE,
  CONSTRAINT `fk_comment_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_2`
    FOREIGN KEY (`num_blog`)
    REFERENCES `test`.`blog` (`num_blog`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test`.`diary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`diary` (
  `num_diary` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `contents` VARCHAR(128) NOT NULL,
  `num_user` INT NOT NULL,
  PRIMARY KEY (`num_diary`),
  INDEX `fk_agenda_1_idx` (`num_user` ASC) VISIBLE,
  UNIQUE INDEX `num_agenda_UNIQUE` (`num_diary` ASC) VISIBLE,
  CONSTRAINT `fk_agenda_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test`.`messagery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`messagery` (
  `num_messagery` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  `email` VARCHAR(32) NOT NULL,
  `subject` VARCHAR(32) NOT NULL,
  `message` VARCHAR(500) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`num_messagery`),
  UNIQUE INDEX `num_messaging_UNIQUE` (`num_messagery` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`category` (
  `num_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `num_picture` INT NULL,
  `num_blog` INT NULL,
  PRIMARY KEY (`num_category`),
  INDEX `fk_category_1_idx` (`num_blog` ASC) VISIBLE,
  INDEX `fk_category_2_idx` (`num_picture` ASC) VISIBLE,
  CONSTRAINT `fk_category_1`
    FOREIGN KEY (`num_blog`)
    REFERENCES `test`.`blog` (`num_blog`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_category_2`
    FOREIGN KEY (`num_picture`)
    REFERENCES `test`.`pictureBank` (`num_picture`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
