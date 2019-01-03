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
-- Table `mydb`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Movie` (
  `MovieID` INT NOT NULL COMMENT '-Made the crew member a 1 to many relationship since a movie can have multiple crew members but the crew member doesnt have',
  `Name` CHAR(20) NOT NULL,
  `ReleaseDate` DATE NULL,
  `Length` TIME NULL,
  `Genre` VARCHAR(30) NULL,
  `Rating` INT NULL,
  `Budget` INT NULL,
  `Box Office` INT NULL,
  `Country` CHAR(40) NULL,
  `RottenTomatoeScore` INT NULL,
  `Synposis` CHAR(100) NULL,
  `Now Playing` TINYINT(1) NOT NULL COMMENT 'TINYINT = 0/1 (This is the alias of Boolean)',
  PRIMARY KEY (`MovieID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `ID` INT NOT NULL,
  `FirstName` CHAR(20) NULL,
  `LastName` CHAR(20) NULL,
  `Date of Birth` DATE NULL,
  `Biography` LONGTEXT NULL,
  `Filmography` LONGTEXT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Actor` (
  `Contract` CHAR(20) NULL,
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Person_ID`),
  INDEX `fk_Actor_Person1_idx` (`Person_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Actor_Person1`
    FOREIGN KEY (`Person_ID`)
    REFERENCES `mydb`.`Person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Director` (
  `Credentials` CHAR(50) NULL,
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Person_ID`),
  INDEX `fk_Director_Person1_idx` (`Person_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Director_Person1`
    FOREIGN KEY (`Person_ID`)
    REFERENCES `mydb`.`Person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producer` (
  `Producer/Production Company` CHAR(30) NOT NULL,
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Person_ID`),
  INDEX `fk_Producer_Person1_idx` (`Person_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Producer_Person1`
    FOREIGN KEY (`Person_ID`)
    REFERENCES `mydb`.`Person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Theater`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Theater` (
  `ID` INT NOT NULL COMMENT '-movies can be played in mulitple theaters and theaters can play multiple movies\n',
  `Name` CHAR(40) NOT NULL,
  `Address` VARCHAR(60) NOT NULL,
  `Box Office` INT NULL,
  `Format` CHAR(20) NULL,
  `Reserved Seating` TINYINT(1) NULL,
  `Close Captioning` TINYINT(1) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Award`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Award` (
  `ID` INT NOT NULL,
  `Name` CHAR(20) NOT NULL,
  `Year Recieved` YEAR(4) NULL,
  `AwardType` CHAR(20) NULL,
  `Person_ID` INT NULL,
  `Movie_MovieID` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Award_Person1_idx` (`Person_ID` ASC) VISIBLE,
  INDEX `fk_Award_Movie1_idx` (`Movie_MovieID` ASC) VISIBLE,
  CONSTRAINT `fk_Award_Person1`
    FOREIGN KEY (`Person_ID`)
    REFERENCES `mydb`.`Person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Award_Movie1`
    FOREIGN KEY (`Movie_MovieID`)
    REFERENCES `mydb`.`Movie` (`MovieID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Writer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Writer` (
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Person_ID`),
  INDEX `fk_Writer_Person1_idx` (`Person_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Writer_Person1`
    FOREIGN KEY (`Person_ID`)
    REFERENCES `mydb`.`Person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `Username` VARCHAR(20) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `FavoriteMovie` INT NULL,
  `fName` VARCHAR(45) NOT NULL,
  `lName` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Date of Birth` DATE NOT NULL,
  PRIMARY KEY (`Username`),
  INDEX `FavoriteMovie_idx` (`FavoriteMovie` ASC) VISIBLE,
  CONSTRAINT `FavoriteMovie`
    FOREIGN KEY (`FavoriteMovie`)
    REFERENCES `mydb`.`Movie` (`MovieID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
  `ID` INT NOT NULL,
  `Name` CHAR(20) NULL COMMENT 'Name of person reviewing (They can be anonymous)',
  `Rating` INT NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `Movie_MovieID` INT NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Review_Movie1_idx` (`Movie_MovieID` ASC) VISIBLE,
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Review_Movie1`
    FOREIGN KEY (`Movie_MovieID`)
    REFERENCES `mydb`.`Movie` (`MovieID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `mydb`.`User` (`FavoriteMovie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Showtime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Showtime` (
  `ID` INT NOT NULL,
  `Time` TIME NOT NULL COMMENT 'The time the movie is playing',
  `Date` DATE NOT NULL,
  `Movie_MovieID` INT NOT NULL,
  `Theater_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Showtime_Movie1_idx` (`Movie_MovieID` ASC) VISIBLE,
  INDEX `fk_Showtime_Theater1_idx` (`Theater_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Showtime_Movie1`
    FOREIGN KEY (`Movie_MovieID`)
    REFERENCES `mydb`.`Movie` (`MovieID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Showtime_Theater1`
    FOREIGN KEY (`Theater_ID`)
    REFERENCES `mydb`.`Theater` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crew Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crew Member` (
  `Title` VARCHAR(45) NULL COMMENT 'What they did that contributed to the movie.',
  `Person_ID` INT NOT NULL,
  PRIMARY KEY (`Person_ID`),
  CONSTRAINT `fk_Crew Member_Person1`
    FOREIGN KEY (`Person_ID`)
    REFERENCES `mydb`.`Person` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Movie_has_Theater`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Movie_has_Theater` (
  `Movie_MovieID` INT NOT NULL,
  `Movie_Award_ID` INT NOT NULL,
  `Theater_ID` INT NOT NULL,
  PRIMARY KEY (`Movie_MovieID`, `Movie_Award_ID`, `Theater_ID`),
  INDEX `fk_Movie_has_Theater_Theater1_idx` (`Theater_ID` ASC) VISIBLE,
  INDEX `fk_Movie_has_Theater_Movie1_idx` (`Movie_MovieID` ASC, `Movie_Award_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Movie_has_Theater_Movie1`
    FOREIGN KEY (`Movie_MovieID`)
    REFERENCES `mydb`.`Movie` (`MovieID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movie_has_Theater_Theater1`
    FOREIGN KEY (`Theater_ID`)
    REFERENCES `mydb`.`Theater` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crew` (
  `ID` INT NOT NULL,
  `CrewCount` INT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Movie_has_Crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Movie_has_Crew` (
  `Movie_MovieID` INT NOT NULL,
  `Movie_Award_ID` INT NOT NULL,
  `Movie_Showtime_ID` INT NOT NULL,
  `Movie_Review_ID` INT NOT NULL,
  `Crew_ID` INT NOT NULL,
  INDEX `fk_Movie_has_Crew_Crew1_idx` (`Crew_ID` ASC) VISIBLE,
  INDEX `fk_Movie_has_Crew_Movie1_idx` (`Movie_MovieID` ASC, `Movie_Award_ID` ASC, `Movie_Showtime_ID` ASC, `Movie_Review_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Movie_has_Crew_Movie1`
    FOREIGN KEY (`Movie_MovieID`)
    REFERENCES `mydb`.`Movie` (`MovieID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movie_has_Crew_Crew1`
    FOREIGN KEY (`Crew_ID`)
    REFERENCES `mydb`.`Crew` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crew_has_Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crew_has_Director` (
  `Crew_ID` INT NOT NULL,
  `Director_Person_ID` INT NOT NULL,
  INDEX `fk_Crew_has_Director_Director1_idx` (`Director_Person_ID` ASC) VISIBLE,
  INDEX `fk_Crew_has_Director_Crew1_idx` (`Crew_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Crew_has_Director_Crew1`
    FOREIGN KEY (`Crew_ID`)
    REFERENCES `mydb`.`Crew` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Crew_has_Director_Director1`
    FOREIGN KEY (`Director_Person_ID`)
    REFERENCES `mydb`.`Director` (`Person_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crew_has_Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crew_has_Actor` (
  `Crew_ID` INT NOT NULL,
  `Actor_Person_ID` INT NOT NULL,
  INDEX `fk_Crew_has_Actor_Actor1_idx` (`Actor_Person_ID` ASC) VISIBLE,
  INDEX `fk_Crew_has_Actor_Crew1_idx` (`Crew_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Crew_has_Actor_Crew1`
    FOREIGN KEY (`Crew_ID`)
    REFERENCES `mydb`.`Crew` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Crew_has_Actor_Actor1`
    FOREIGN KEY (`Actor_Person_ID`)
    REFERENCES `mydb`.`Actor` (`Person_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crew_has_Producer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crew_has_Producer` (
  `Crew_ID` INT NOT NULL,
  `Producer_Person_ID` INT NOT NULL,
  INDEX `fk_Crew_has_Producer_Producer1_idx` (`Producer_Person_ID` ASC) VISIBLE,
  INDEX `fk_Crew_has_Producer_Crew1_idx` (`Crew_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Crew_has_Producer_Crew1`
    FOREIGN KEY (`Crew_ID`)
    REFERENCES `mydb`.`Crew` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Crew_has_Producer_Producer1`
    FOREIGN KEY (`Producer_Person_ID`)
    REFERENCES `mydb`.`Producer` (`Person_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crew_has_Writer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crew_has_Writer` (
  `Crew_ID` INT NOT NULL,
  `Writer_Person_ID` INT NOT NULL,
  INDEX `fk_Crew_has_Writer_Writer1_idx` (`Writer_Person_ID` ASC) VISIBLE,
  INDEX `fk_Crew_has_Writer_Crew1_idx` (`Crew_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Crew_has_Writer_Crew1`
    FOREIGN KEY (`Crew_ID`)
    REFERENCES `mydb`.`Crew` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Crew_has_Writer_Writer1`
    FOREIGN KEY (`Writer_Person_ID`)
    REFERENCES `mydb`.`Writer` (`Person_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Crew_has_Crew Member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Crew_has_Crew Member` (
  `Crew_ID` INT NOT NULL,
  `Crew Member_Person_ID` INT NOT NULL,
  INDEX `fk_Crew_has_Crew Member_Crew Member1_idx` (`Crew Member_Person_ID` ASC) VISIBLE,
  INDEX `fk_Crew_has_Crew Member_Crew1_idx` (`Crew_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Crew_has_Crew Member_Crew1`
    FOREIGN KEY (`Crew_ID`)
    REFERENCES `mydb`.`Crew` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Crew_has_Crew Member_Crew Member1`
    FOREIGN KEY (`Crew Member_Person_ID`)
    REFERENCES `mydb`.`Crew Member` (`Person_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
