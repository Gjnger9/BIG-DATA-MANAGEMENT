-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema wp_plugin_db
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`scuola` (
  `idscuola` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `indirizzo` VARCHAR(45) NOT NULL,
  `citta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idscuola`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sezione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sezione` (
  `idsezione` INT NOT NULL,
  `lettera` VARCHAR(45) NOT NULL,
  `anno` INT NOT NULL,
  `persorso_di_studi` VARCHAR(45) NOT NULL,
  `scuola_idscuola` INT NOT NULL,
  PRIMARY KEY (`idsezione`, `scuola_idscuola`),
  INDEX `fk_sezione_scuola1_idx` (`scuola_idscuola` ASC) VISIBLE,
  CONSTRAINT `fk_sezione_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `mydb`.`scuola` (`idscuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`utente` (
  `idutente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `cf` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` BINARY(128) NOT NULL,
  `indirizzo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idutente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professore` (
  `idprofessore` INT NOT NULL,
  `utente_idutente` INT NOT NULL,
  PRIMARY KEY (`idprofessore`, `utente_idutente`),
  INDEX `fk_professore_utente1_idx` (`utente_idutente` ASC) VISIBLE,
  CONSTRAINT `fk_professore_utente1`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `mydb`.`utente` (`idutente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lezione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lezione` (
  `idlezione` INT NOT NULL,
  `data` DATE NOT NULL,
  `sezione_idsezione` INT NOT NULL,
  `professore_idprofessore` INT NOT NULL,
  PRIMARY KEY (`idlezione`, `sezione_idsezione`, `professore_idprofessore`),
  INDEX `fk_lezione_sezione1_idx` (`sezione_idsezione` ASC) VISIBLE,
  INDEX `fk_lezione_professore1_idx` (`professore_idprofessore` ASC) VISIBLE,
  CONSTRAINT `fk_lezione_sezione1`
    FOREIGN KEY (`sezione_idsezione`)
    REFERENCES `mydb`.`sezione` (`idsezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lezione_professore1`
    FOREIGN KEY (`professore_idprofessore`)
    REFERENCES `mydb`.`professore` (`idprofessore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`contenuto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contenuto` (
  `idcontenuto` INT NOT NULL,
  `titolo` VARCHAR(45) NOT NULL,
  `data_creazione` DATE NOT NULL,
  `percorso` VARCHAR(45) NOT NULL,
  `lezione_idlezione` INT NOT NULL,
  `professore_idprofessore` INT NULL,
  `data_accettazione` DATE NULL,
  PRIMARY KEY (`idcontenuto`, `lezione_idlezione`),
  INDEX `fk_contenuto_lezione1_idx` (`lezione_idlezione` ASC) VISIBLE,
  INDEX `fk_contenuto_professore1_idx` (`professore_idprofessore` ASC) VISIBLE,
  CONSTRAINT `fk_contenuto_lezione1`
    FOREIGN KEY (`lezione_idlezione`)
    REFERENCES `mydb`.`lezione` (`idlezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contenuto_professore1`
    FOREIGN KEY (`professore_idprofessore`)
    REFERENCES `mydb`.`professore` (`idprofessore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`materia` (
  `idmateria` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmateria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`argomento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`argomento` (
  `idargomento` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(45) NOT NULL,
  `idmateria` INT NOT NULL,
  `anno_di_corso` INT NOT NULL,
  PRIMARY KEY (`idargomento`, `idmateria`),
  INDEX `fk_argomento_materie1_idx` (`idmateria` ASC) VISIBLE,
  CONSTRAINT `fk_argomento_materie1`
    FOREIGN KEY (`idmateria`)
    REFERENCES `mydb`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aggrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aggrega` (
  `argomento_idargomento` INT NOT NULL,
  `contenuto_idcontenuto` INT NOT NULL,
  PRIMARY KEY (`argomento_idargomento`, `contenuto_idcontenuto`),
  INDEX `fk_argomento_has_contenuto_contenuto1_idx` (`contenuto_idcontenuto` ASC) VISIBLE,
  INDEX `fk_argomento_has_contenuto_argomento_idx` (`argomento_idargomento` ASC) VISIBLE,
  CONSTRAINT `fk_argomento_has_contenuto_argomento`
    FOREIGN KEY (`argomento_idargomento`)
    REFERENCES `mydb`.`argomento` (`idargomento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_argomento_has_contenuto_contenuto1`
    FOREIGN KEY (`contenuto_idcontenuto`)
    REFERENCES `mydb`.`contenuto` (`idcontenuto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_di_scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_di_scuola` (
  `idtipo_di_scuola` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo_di_scuola`, `nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`materia_has_tipo_di_scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`materia_has_tipo_di_scuola` (
  `materia_idmateria` INT NOT NULL,
  `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
  PRIMARY KEY (`materia_idmateria`, `tipo_di_scuola_idtipo_di_scuola`),
  INDEX `fk_materia_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC) VISIBLE,
  INDEX `fk_materia_has_tipo_di_scuola_materia1_idx` (`materia_idmateria` ASC) VISIBLE,
  CONSTRAINT `fk_materia_has_tipo_di_scuola_materia1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `mydb`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_has_tipo_di_scuola_tipo_di_scuola1`
    FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
    REFERENCES `mydb`.`tipo_di_scuola` (`idtipo_di_scuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`blocco_di_trascrizione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`blocco_di_trascrizione` (
  `idblocco_di_trascrizione` INT NOT NULL,
  `testo` VARCHAR(45) NOT NULL,
  `file` VARCHAR(45) NOT NULL,
  `numero_di_blocco` INT NOT NULL,
  `lezione_idlezione` INT NOT NULL,
  PRIMARY KEY (`idblocco_di_trascrizione`, `lezione_idlezione`),
  INDEX `fk_blocco_di_trascrizione_lezione1_idx` (`lezione_idlezione` ASC) VISIBLE,
  CONSTRAINT `fk_blocco_di_trascrizione_lezione1`
    FOREIGN KEY (`lezione_idlezione`)
    REFERENCES `mydb`.`lezione` (`idlezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_di_scuola_has_scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_di_scuola_has_scuola` (
  `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
  `scuola_idscuola` INT NOT NULL,
  PRIMARY KEY (`tipo_di_scuola_idtipo_di_scuola`, `scuola_idscuola`),
  INDEX `fk_tipo_di_scuola_has_scuola_scuola1_idx` (`scuola_idscuola` ASC) VISIBLE,
  INDEX `fk_tipo_di_scuola_has_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_di_scuola_has_scuola_tipo_di_scuola1`
    FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
    REFERENCES `mydb`.`tipo_di_scuola` (`idtipo_di_scuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_di_scuola_has_scuola_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `mydb`.`scuola` (`idscuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`alunno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`alunno` (
  `idalunno` INT NOT NULL,
  `utente_idutente` INT NOT NULL,
  `sezione_idsezione` INT NOT NULL,
  PRIMARY KEY (`idalunno`, `utente_idutente`, `sezione_idsezione`),
  INDEX `fk_alunno_utente1_idx` (`utente_idutente` ASC) VISIBLE,
  INDEX `fk_alunno_sezione1_idx` (`sezione_idsezione` ASC) VISIBLE,
  CONSTRAINT `fk_alunno_utente1`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `mydb`.`utente` (`idutente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alunno_sezione1`
    FOREIGN KEY (`sezione_idsezione`)
    REFERENCES `mydb`.`sezione` (`idsezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`impiega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`impiega` (
  `professore_idprofessore` INT NOT NULL,
  `scuola_idscuola` INT NOT NULL,
  `dal` DATE NOT NULL,
  `fino_a` DATE NULL,
  PRIMARY KEY (`professore_idprofessore`, `scuola_idscuola`),
  INDEX `fk_professore_has_scuola_scuola1_idx` (`scuola_idscuola` ASC) VISIBLE,
  INDEX `fk_professore_has_scuola_professore1_idx` (`professore_idprofessore` ASC) VISIBLE,
  CONSTRAINT `fk_professore_has_scuola_professore1`
    FOREIGN KEY (`professore_idprofessore`)
    REFERENCES `mydb`.`professore` (`idprofessore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professore_has_scuola_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `mydb`.`scuola` (`idscuola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
