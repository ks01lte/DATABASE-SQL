-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`departments` (
  `dpid` INT NOT NULL,
  `dpname` VARCHAR(45) NULL,
  PRIMARY KEY (`dpid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employees` (
  `eid` INT NOT NULL,
  `ename` VARCHAR(45) NULL,
  `erank` VARCHAR(45) NULL,
  `edid` INT NOT NULL,
  PRIMARY KEY (`eid`),
  INDEX `fk_employees_departments_idx` (`edid` ASC) VISIBLE,
  CONSTRAINT `fk_employees_departments`
    FOREIGN KEY (`edid`)
    REFERENCES `mydb`.`departments` (`dpid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`workhistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`workhistory` (
  `workstartday` DATE NULL,
  `workendday` DATE NULL,
  `workhrank` VARCHAR(45) NULL,
  `wheid` INT NOT NULL,
  PRIMARY KEY (`wheid`),
  CONSTRAINT `fk_workhistory_employees1`
    FOREIGN KEY (`wheid`)
    REFERENCES `mydb`.`employees` (`eid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`family`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`family` (
  `fname` VARCHAR(45) NOT NULL,
  `frelationship` VARCHAR(45) NULL,
  `feid` INT NOT NULL,
  PRIMARY KEY (`fname`, `feid`),
  INDEX `fk_family_employees1_idx` (`feid` ASC) VISIBLE,
  CONSTRAINT `fk_family_employees1`
    FOREIGN KEY (`feid`)
    REFERENCES `mydb`.`employees` (`eid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`hobby`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`hobby` (
  `hname` VARCHAR(45) NOT NULL,
  `heid` INT NOT NULL,
  PRIMARY KEY (`hname`, `heid`),
  INDEX `fk_hobby_employees1_idx` (`heid` ASC) VISIBLE,
  CONSTRAINT `fk_hobby_employees1`
    FOREIGN KEY (`heid`)
    REFERENCES `mydb`.`employees` (`eid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
