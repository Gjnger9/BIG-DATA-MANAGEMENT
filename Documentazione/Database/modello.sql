-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`materia` (
  `idmateria` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmateria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`argomento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`argomento` (
  `idargomento` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `descrizione` VARCHAR(300) NOT NULL,
  `anno_di_corso` INT NOT NULL,
  `materia_idmateria` INT NOT NULL,
  PRIMARY KEY (`idargomento`),
  INDEX `fk_argomento_materia1_idx` (`materia_idmateria` ASC),
  CONSTRAINT `fk_argomento_materia1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `mydb`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`utente` (
  `idutente` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `cognome` VARCHAR(100) NOT NULL,
  `cf` VARCHAR(16) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `password` BINARY(200) NOT NULL,
  `indirizzo` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`idutente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`professore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professore` (
  `idprofessore` INT NOT NULL,
  `utente_idutente` INT NOT NULL,
  PRIMARY KEY (`idprofessore`, `utente_idutente`),
  INDEX `fk_professore_utente1_idx` (`utente_idutente` ASC),
  CONSTRAINT `fk_professore_utente1`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `mydb`.`utente` (`idutente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`scuola` (
  `idscuola` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `indirizzo` VARCHAR(500) NOT NULL,
  `codice` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idscuola`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`sezione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sezione` (
  `idsezione` INT NOT NULL,
  `lettera` VARCHAR(2) NOT NULL,
  `anno` INT NOT NULL,
  `persorso_di_studi` VARCHAR(200) NOT NULL,
  `scuola_idscuola` INT NOT NULL,
  PRIMARY KEY (`idsezione`),
  INDEX `fk_sezione_scuola1_idx` (`scuola_idscuola` ASC),
  CONSTRAINT `fk_sezione_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `mydb`.`scuola` (`idscuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`lezione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lezione` (
  `idlezione` INT NOT NULL,
  `data` DATE NOT NULL,
  `professore_idprofessore` INT NOT NULL,
  `professore_utente_idutente` INT NOT NULL,
  `sezione_idsezione` INT NOT NULL,
  `titolo` VARCHAR(45) NULL,
  `trascrizione` LONGTEXT NULL,
  PRIMARY KEY (`idlezione`),
  INDEX `fk_lezione_professore1_idx` (`professore_idprofessore` ASC, `professore_utente_idutente` ASC),
  INDEX `fk_lezione_sezione1_idx` (`sezione_idsezione` ASC),
  CONSTRAINT `fk_lezione_professore1`
    FOREIGN KEY (`professore_idprofessore` , `professore_utente_idutente`)
    REFERENCES `mydb`.`professore` (`idprofessore` , `utente_idutente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lezione_sezione1`
    FOREIGN KEY (`sezione_idsezione`)
    REFERENCES `mydb`.`sezione` (`idsezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`contenuto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contenuto` (
  `idcontenuto` INT NOT NULL,
  `titolo` VARCHAR(300) NOT NULL,
  `data_creazione` DATETIME NOT NULL,
  `percorso` MEDIUMTEXT NOT NULL,
  `professore_idprofessore` INT NULL DEFAULT NULL,
  `data_accettazione` DATETIME NULL DEFAULT NULL,
  `lezione_idlezione1` INT NOT NULL,
  PRIMARY KEY (`idcontenuto`),
  INDEX `fk_contenuto_professore1_idx` (`professore_idprofessore` ASC),
  INDEX `fk_contenuto_lezione2_idx` (`lezione_idlezione1` ASC),
  CONSTRAINT `fk_contenuto_professore1`
    FOREIGN KEY (`professore_idprofessore`)
    REFERENCES `mydb`.`professore` (`idprofessore`),
  CONSTRAINT `fk_contenuto_lezione2`
    FOREIGN KEY (`lezione_idlezione1`)
    REFERENCES `mydb`.`lezione` (`idlezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`aggrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aggrega` (
  `argomento_idargomento` INT NOT NULL,
  `contenuto_idcontenuto` INT NOT NULL,
  PRIMARY KEY (`argomento_idargomento`, `contenuto_idcontenuto`),
  INDEX `fk_argomento_has_contenuto_contenuto1_idx` (`contenuto_idcontenuto` ASC),
  INDEX `fk_argomento_has_contenuto_argomento_idx` (`argomento_idargomento` ASC),
  CONSTRAINT `fk_argomento_has_contenuto_argomento`
    FOREIGN KEY (`argomento_idargomento`)
    REFERENCES `mydb`.`argomento` (`idargomento`),
  CONSTRAINT `fk_argomento_has_contenuto_contenuto1`
    FOREIGN KEY (`contenuto_idcontenuto`)
    REFERENCES `mydb`.`contenuto` (`idcontenuto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`alunno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alunno` (
  `idalunno` INT NOT NULL,
  `utente_idutente` INT NOT NULL,
  PRIMARY KEY (`idalunno`, `utente_idutente`),
  INDEX `fk_alunno_utente1_idx` (`utente_idutente` ASC),
  CONSTRAINT `fk_alunno_utente1`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `mydb`.`utente` (`idutente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`impiega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`impiega` (
  `dal` DATE NOT NULL,
  `fino_a` DATE NULL DEFAULT NULL,
  `scuola_idscuola` INT NOT NULL,
  `professore_idprofessore` INT NOT NULL,
  `professore_utente_idutente` INT NOT NULL,
  INDEX `fk_impiega_scuola1_idx` (`scuola_idscuola` ASC),
  INDEX `fk_impiega_professore1_idx` (`professore_idprofessore` ASC, `professore_utente_idutente` ASC),
  CONSTRAINT `fk_impiega_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `mydb`.`scuola` (`idscuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_impiega_professore1`
    FOREIGN KEY (`professore_idprofessore` , `professore_utente_idutente`)
    REFERENCES `mydb`.`professore` (`idprofessore` , `utente_idutente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_di_scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_di_scuola` (
  `idtipo_di_scuola` INT NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idtipo_di_scuola`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`sezione_has_alunno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sezione_has_alunno` (
  `sezione_idsezione` INT NOT NULL,
  `alunno_idalunno` INT NOT NULL,
  `alunno_utente_idutente` INT NOT NULL,
  `data_inizio` DATETIME NULL,
  `data_fine` DATETIME NULL,
  PRIMARY KEY (`sezione_idsezione`, `alunno_idalunno`, `alunno_utente_idutente`),
  INDEX `fk_sezione_has_alunno_alunno1_idx` (`alunno_idalunno` ASC, `alunno_utente_idutente` ASC),
  INDEX `fk_sezione_has_alunno_sezione1_idx` (`sezione_idsezione` ASC),
  CONSTRAINT `fk_sezione_has_alunno_sezione1`
    FOREIGN KEY (`sezione_idsezione`)
    REFERENCES `mydb`.`sezione` (`idsezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sezione_has_alunno_alunno1`
    FOREIGN KEY (`alunno_idalunno` , `alunno_utente_idutente`)
    REFERENCES `mydb`.`alunno` (`idalunno` , `utente_idutente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`e_trattato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`e_trattato` (
  `sezione_idsezione` INT NOT NULL,
  `contenuto_idcontenuto` INT NOT NULL,
  `data` DATETIME NULL,
  PRIMARY KEY (`sezione_idsezione`, `contenuto_idcontenuto`),
  INDEX `fk_sezione_has_contenuto_contenuto1_idx` (`contenuto_idcontenuto` ASC),
  INDEX `fk_sezione_has_contenuto_sezione1_idx` (`sezione_idsezione` ASC),
  CONSTRAINT `fk_sezione_has_contenuto_sezione1`
    FOREIGN KEY (`sezione_idsezione`)
    REFERENCES `mydb`.`sezione` (`idsezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sezione_has_contenuto_contenuto1`
    FOREIGN KEY (`contenuto_idcontenuto`)
    REFERENCES `mydb`.`contenuto` (`idcontenuto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`e_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`e_in` (
  `materia_idmateria` INT NOT NULL,
  `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
  PRIMARY KEY (`materia_idmateria`, `tipo_di_scuola_idtipo_di_scuola`),
  INDEX `fk_materia_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC),
  INDEX `fk_materia_has_tipo_di_scuola_materia1_idx` (`materia_idmateria` ASC),
  CONSTRAINT `fk_materia_has_tipo_di_scuola_materia2`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `mydb`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_has_tipo_di_scuola_tipo_di_scuola2`
    FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
    REFERENCES `mydb`.`tipo_di_scuola` (`idtipo_di_scuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`e_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`e_tipo` (
  `scuola_idscuola` INT NOT NULL,
  `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
  PRIMARY KEY (`scuola_idscuola`, `tipo_di_scuola_idtipo_di_scuola`),
  INDEX `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC),
  INDEX `fk_scuola_has_tipo_di_scuola_scuola1_idx` (`scuola_idscuola` ASC),
  CONSTRAINT `fk_scuola_has_tipo_di_scuola_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `mydb`.`scuola` (`idscuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1`
    FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
    REFERENCES `mydb`.`tipo_di_scuola` (`idtipo_di_scuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
