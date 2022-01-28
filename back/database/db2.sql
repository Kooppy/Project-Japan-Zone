-- MySQL Script generated by MySQL Workbench
-- mar. 25 janv. 2022 13:36:25
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
  `avatar` VARCHAR(255) NOT NULL,
  `pseudo` VARCHAR(128) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `confirmation_date` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`num_user`),
  UNIQUE INDEX `pseudo_UNIQUE` (`pseudo` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`blog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`blog` (
  `num_blog` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(32) NOT NULL,
  `tags` VARCHAR(32) NOT NULL,
  `picture` VARCHAR(255) NOT NULL,
  `alt` VARCHAR(255) NOT NULL,
  `description` VARCHAR(128) NOT NULL,
  `contents` LONGTEXT NOT NULL,
  `article_date` DATETIME NOT NULL,
  `num_user` INT NOT NULL,
  PRIMARY KEY (`num_blog`),
  INDEX `fk_blog_1_idx` (`num_user` ASC) VISIBLE,
  CONSTRAINT `fk_blog_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`complementAdresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`complementAdresse` (
  `num_user` INT NOT NULL,
  `name` VARCHAR(32) NULL,
  `first_name` VARCHAR(32) NULL,
  `address` VARCHAR(32) NULL,
  `postal_code` VARCHAR(5) NULL,
  `city` VARCHAR(15) NULL,
  `phone` VARCHAR(10) NULL,
  PRIMARY KEY (`num_user`),
  CONSTRAINT `fk_complementAdresse_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`complementProfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`complementProfil` (
  `num_user` INT NOT NULL,
  `civility` CHAR(1) NULL,
  `profil_info` VARCHAR(255) NULL,
  PRIMARY KEY (`num_user`),
  CONSTRAINT `fk_complementProfil_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`pictureBanque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`pictureBanque` (
  `num_picture` INT NOT NULL AUTO_INCREMENT,
  `link_picture` VARCHAR(255) NOT NULL,
  `title_picture` VARCHAR(32) NULL DEFAULT NULL,
  `description_picture` VARCHAR(128) NULL DEFAULT NULL,
  `num_user` INT NOT NULL,
  PRIMARY KEY (`num_picture`),
  INDEX `pictureBanque_ibfk_1_idx` (`num_user` ASC) VISIBLE,
  CONSTRAINT `fk_pictureBanque_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`role` (
  `num_user` INT NOT NULL,
  `isVerify` TINYINT NOT NULL,
  `isAdmin` TINYINT NOT NULL,
  `isBan` TINYINT NOT NULL,
  PRIMARY KEY (`num_user`),
  CONSTRAINT `fk_role_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `test`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`comment` (
  `num_comment` INT NOT NULL AUTO_INCREMENT,
  `contents` LONGTEXT NULL,
  `num_user` INT NOT NULL,
  `num_blog` INT NOT NULL,
  PRIMARY KEY (`num_comment`),
  INDEX `fk_comment_1_idx` (`num_user` ASC) VISIBLE,
  INDEX `fk_comment_2_idx` (`num_blog` ASC) VISIBLE,
  CONSTRAINT `fk_comment_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_comment_2`
    FOREIGN KEY (`num_blog`)
    REFERENCES `test`.`blog` (`num_blog`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test`.`agenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`agenda` (
  `num_agenda` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `contents` VARCHAR(255) NOT NULL,
  `num_user` INT NOT NULL,
  PRIMARY KEY (`num_agenda`),
  INDEX `fk_agenda_1_idx` (`num_user` ASC) VISIBLE,
  CONSTRAINT `fk_agenda_1`
    FOREIGN KEY (`num_user`)
    REFERENCES `test`.`user` (`num_user`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `test`.`messaging`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `test`.`messaging` (
  `num_messaging` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  `email` VARCHAR(32) NOT NULL,
  `subject` VARCHAR(32) NOT NULL,
  `message` VARCHAR(500) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`num_messaging`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;