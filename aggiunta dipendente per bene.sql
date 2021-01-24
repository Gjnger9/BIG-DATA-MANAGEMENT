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
-- -----------------------------------------------------
-- Schema wordpress
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wordpress
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wordpress` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `wordpress`.`wp_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_users` (
  `ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_login` VARCHAR(60) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `user_pass` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `user_nicename` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `user_email` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `user_url` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `user_registered` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `user_status` INT NOT NULL DEFAULT '0',
  `display_name` VARCHAR(250) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  INDEX `user_login_key` (`user_login` ASC),
  INDEX `user_nicename` (`user_nicename` ASC),
  INDEX `user_email` (`user_email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`utente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`utente` (
  `idutente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cognome` VARCHAR(100) NOT NULL,
  `cf` VARCHAR(16) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `indirizzo` VARCHAR(500) NOT NULL,
  `wp_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `dipendente_idDipendente` INT NOT NULL,
  PRIMARY KEY (`idutente`),
  UNIQUE INDEX `wp_id` (`wp_id` ASC),
  INDEX `fk_wp_id1_idx` (`wp_id` ASC),
  INDEX `fk_utente_dipendente1_idx` (`dipendente_idDipendente` ASC),
  CONSTRAINT `fk_wp_id`
    FOREIGN KEY (`wp_id`)
    REFERENCES `wordpress`.`wp_users` (`ID`),
  CONSTRAINT `fk_utente_dipendente1`
    FOREIGN KEY (`dipendente_idDipendente`)
    REFERENCES `mydb`.`dipendente` (`idDipendente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`dipendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dipendente` (
  `idDipendente` INT NOT NULL,
  `utente_idutente` INT NOT NULL,
  PRIMARY KEY (`idDipendente`, `utente_idutente`),
  INDEX `fk_dipendente_utente_idx` (`utente_idutente` ASC),
  CONSTRAINT `fk_dipendente_utente`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `wordpress`.`utente` (`idutente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `wordpress` ;

-- -----------------------------------------------------
-- Table `wordpress`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`materia` (
  `idmateria` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmateria`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`argomento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`argomento` (
  `idargomento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descrizione` VARCHAR(300) NOT NULL,
  `anno_di_corso` INT NOT NULL,
  `materia_idmateria` INT NOT NULL,
  PRIMARY KEY (`idargomento`),
  INDEX `fk_argomento_materia1_idx` (`materia_idmateria` ASC),
  CONSTRAINT `fk_argomento_materia1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `wordpress`.`materia` (`idmateria`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`professore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`professore` (
  `idprofessore` INT NOT NULL AUTO_INCREMENT,
  `utente_idutente` INT NOT NULL,
  PRIMARY KEY (`idprofessore`, `utente_idutente`),
  INDEX `fk_professore_utente1_idx` (`utente_idutente` ASC),
  CONSTRAINT `fk_professore_utente1`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `wordpress`.`utente` (`idutente`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_posts` (
  `ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_author` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `post_date` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `post_title` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `post_excerpt` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `post_status` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT 'publish',
  `comment_status` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT 'open',
  `ping_status` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT 'open',
  `post_password` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `post_name` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `to_ping` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `pinged` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `post_modified` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `post_parent` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `guid` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `menu_order` INT NOT NULL DEFAULT '0',
  `post_type` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT 'post',
  `post_mime_type` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `comment_count` BIGINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  INDEX `post_name` (`post_name`(191) ASC),
  INDEX `type_status_date` (`post_type` ASC, `post_status` ASC, `post_date` ASC, `ID` ASC),
  INDEX `post_parent` (`post_parent` ASC),
  INDEX `post_author` (`post_author` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 360
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`lezione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`lezione` (
  `idlezione` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `professore_idprofessore` INT NOT NULL,
  `sezione_idsezione` INT NOT NULL,
  `titolo` VARCHAR(45) NULL DEFAULT NULL,
  `trascrizione` LONGTEXT NULL DEFAULT NULL,
  `wp_post_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `materia_idmateria` INT NOT NULL,
  `argomento_idargomento` INT NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idlezione`),
  INDEX `fk_lezione_professore1_idx` (`professore_idprofessore` ASC),
  INDEX `fk_wp_id1` (`wp_post_id` ASC),
  INDEX `fk_materia_idmateria1` (`materia_idmateria` ASC),
  INDEX `fk_argomento_idargomento` (`argomento_idargomento` ASC),
  CONSTRAINT `fk_argomento_idargomento`
    FOREIGN KEY (`argomento_idargomento`)
    REFERENCES `wordpress`.`argomento` (`idargomento`),
  CONSTRAINT `fk_lezione_professore1`
    FOREIGN KEY (`professore_idprofessore`)
    REFERENCES `wordpress`.`professore` (`idprofessore`),
  CONSTRAINT `fk_materia_idmateria1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `wordpress`.`materia` (`idmateria`),
  CONSTRAINT `fk_wp_id1`
    FOREIGN KEY (`wp_post_id`)
    REFERENCES `wordpress`.`wp_posts` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 30
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`contenuto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`contenuto` (
  `idcontenuto` INT NOT NULL AUTO_INCREMENT,
  `titolo` VARCHAR(300) NOT NULL,
  `tipo` VARCHAR(10) NOT NULL,
  `data_creazione` DATETIME NOT NULL,
  `percorso` MEDIUMTEXT NOT NULL,
  `professore_idprofessore` INT NULL DEFAULT NULL,
  `data_accettazione` DATETIME NULL DEFAULT NULL,
  `lezione_idlezione` INT NOT NULL,
  PRIMARY KEY (`idcontenuto`),
  INDEX `fk_contenuto_professore1_idx` (`professore_idprofessore` ASC),
  INDEX `fk_contenuto_lezione2_idx` (`lezione_idlezione` ASC),
  CONSTRAINT `fk_contenuto_lezione2`
    FOREIGN KEY (`lezione_idlezione`)
    REFERENCES `wordpress`.`lezione` (`idlezione`),
  CONSTRAINT `fk_contenuto_professore1`
    FOREIGN KEY (`professore_idprofessore`)
    REFERENCES `wordpress`.`professore` (`idprofessore`))
ENGINE = InnoDB
AUTO_INCREMENT = 193
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`aggrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`aggrega` (
  `argomento_idargomento` INT NOT NULL,
  `contenuto_idcontenuto` INT NOT NULL,
  PRIMARY KEY (`argomento_idargomento`, `contenuto_idcontenuto`),
  INDEX `fk_argomento_has_contenuto_contenuto1_idx` (`contenuto_idcontenuto` ASC),
  INDEX `fk_argomento_has_contenuto_argomento_idx` (`argomento_idargomento` ASC),
  CONSTRAINT `fk_argomento_has_contenuto_argomento`
    FOREIGN KEY (`argomento_idargomento`)
    REFERENCES `wordpress`.`argomento` (`idargomento`),
  CONSTRAINT `fk_argomento_has_contenuto_contenuto1`
    FOREIGN KEY (`contenuto_idcontenuto`)
    REFERENCES `wordpress`.`contenuto` (`idcontenuto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`alunno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`alunno` (
  `idalunno` INT NOT NULL AUTO_INCREMENT,
  `utente_idutente` INT NOT NULL,
  PRIMARY KEY (`idalunno`, `utente_idutente`),
  INDEX `fk_alunno_utente1_idx` (`utente_idutente` ASC),
  CONSTRAINT `fk_alunno_utente1`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `wordpress`.`utente` (`idutente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`dipendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`dipendente` (
  `iddipendente` INT NOT NULL AUTO_INCREMENT,
  `utente_idutente` INT NOT NULL,
  PRIMARY KEY (`iddipendente`, `utente_idutente`),
  INDEX `fk_dipendente_utente1_idx` (`utente_idutente` ASC),
  CONSTRAINT `fk_dipendente_utente1`
    FOREIGN KEY (`utente_idutente`)
    REFERENCES `wordpress`.`utente` (`idutente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`tipo_di_scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`tipo_di_scuola` (
  `idtipo_di_scuola` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `dipendente_idDipendente` INT NOT NULL,
  PRIMARY KEY (`idtipo_di_scuola`),
  INDEX `fk_tipo_di_scuola_dipendente1_idx` (`dipendente_idDipendente` ASC),
  CONSTRAINT `fk_tipo_di_scuola_dipendente1`
    FOREIGN KEY (`dipendente_idDipendente`)
    REFERENCES `mydb`.`dipendente` (`idDipendente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`e_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`e_in` (
  `materia_idmateria` INT NOT NULL,
  `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
  PRIMARY KEY (`materia_idmateria`, `tipo_di_scuola_idtipo_di_scuola`),
  INDEX `fk_materia_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC),
  INDEX `fk_materia_has_tipo_di_scuola_materia1_idx` (`materia_idmateria` ASC),
  CONSTRAINT `fk_materia_has_tipo_di_scuola_materia2`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `wordpress`.`materia` (`idmateria`),
  CONSTRAINT `fk_materia_has_tipo_di_scuola_tipo_di_scuola2`
    FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
    REFERENCES `wordpress`.`tipo_di_scuola` (`idtipo_di_scuola`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`scuola`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`scuola` (
  `idscuola` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `indirizzo` VARCHAR(500) NOT NULL,
  `codice` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`idscuola`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`e_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`e_tipo` (
  `scuola_idscuola` INT NOT NULL,
  `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
  PRIMARY KEY (`scuola_idscuola`, `tipo_di_scuola_idtipo_di_scuola`),
  INDEX `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC),
  INDEX `fk_scuola_has_tipo_di_scuola_scuola1_idx` (`scuola_idscuola` ASC),
  CONSTRAINT `fk_scuola_has_tipo_di_scuola_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `wordpress`.`scuola` (`idscuola`),
  CONSTRAINT `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1`
    FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
    REFERENCES `wordpress`.`tipo_di_scuola` (`idtipo_di_scuola`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`impiega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`impiega` (
  `dal` DATE NOT NULL,
  `fino_a` DATE NOT NULL,
  `scuola_idscuola` INT NOT NULL,
  `professore_idprofessore` INT NOT NULL,
  PRIMARY KEY (`scuola_idscuola`, `professore_idprofessore`),
  INDEX `fk_impiega_scuola1_idx` (`scuola_idscuola` ASC),
  INDEX `fk_impiega_professore1_idx` (`professore_idprofessore` ASC),
  CONSTRAINT `fk_impiega_professore1`
    FOREIGN KEY (`professore_idprofessore`)
    REFERENCES `wordpress`.`professore` (`idprofessore`),
  CONSTRAINT `fk_impiega_scuola1`
    FOREIGN KEY (`scuola_idscuola`)
    REFERENCES `wordpress`.`scuola` (`idscuola`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`include`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`include` (
  `sezione_idsezione` INT NOT NULL,
  `alunno_idalunno` INT NOT NULL,
  `data_inizio` DATETIME NULL DEFAULT NULL,
  `data_fine` DATETIME NULL DEFAULT NULL,
  INDEX `fk_sezione_has_alunno_alunno1_idx` (`alunno_idalunno` ASC),
  INDEX `fk_sezione_has_alunno_sezione1_idx` (`sezione_idsezione` ASC),
  CONSTRAINT `fk_sezione_has_alunno_alunno1`
    FOREIGN KEY (`alunno_idalunno`)
    REFERENCES `wordpress`.`alunno` (`idalunno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_actionscheduler_actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_actionscheduler_actions` (
  `action_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `hook` VARCHAR(191) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `status` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `scheduled_date_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `args` VARCHAR(191) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `schedule` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `group_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `attempts` INT NOT NULL DEFAULT '0',
  `last_attempt_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `claim_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `extended_args` VARCHAR(8000) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `hook` (`hook` ASC),
  INDEX `status` (`status` ASC),
  INDEX `scheduled_date_gmt` (`scheduled_date_gmt` ASC),
  INDEX `args` (`args` ASC),
  INDEX `group_id` (`group_id` ASC),
  INDEX `last_attempt_gmt` (`last_attempt_gmt` ASC),
  INDEX `claim_id` (`claim_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 128
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_actionscheduler_claims`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_actionscheduler_claims` (
  `claim_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date_created_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`claim_id`),
  INDEX `date_created_gmt` (`date_created_gmt` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1371
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_actionscheduler_groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_actionscheduler_groups` (
  `group_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  PRIMARY KEY (`group_id`),
  INDEX `slug` (`slug`(191) ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_actionscheduler_logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_actionscheduler_logs` (
  `log_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `action_id` BIGINT UNSIGNED NOT NULL,
  `message` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `log_date_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_date_local` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`log_id`),
  INDEX `action_id` (`action_id` ASC),
  INDEX `log_date_gmt` (`log_date_gmt` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 343
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_commentmeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_commentmeta` (
  `meta_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `meta_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  INDEX `comment_id` (`comment_id` ASC),
  INDEX `meta_key` (`meta_key`(191) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_comments` (
  `comment_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment_post_ID` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `comment_author` TINYTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `comment_author_email` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `comment_author_url` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `comment_author_IP` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `comment_date` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `comment_karma` INT NOT NULL DEFAULT '0',
  `comment_approved` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '1',
  `comment_agent` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `comment_type` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT 'comment',
  `comment_parent` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  INDEX `comment_post_ID` (`comment_post_ID` ASC),
  INDEX `comment_approved_date_gmt` (`comment_approved` ASC, `comment_date_gmt` ASC),
  INDEX `comment_date_gmt` (`comment_date_gmt` ASC),
  INDEX `comment_parent` (`comment_parent` ASC),
  INDEX `comment_author_email` (`comment_author_email`(10) ASC),
  INDEX `woo_idx_comment_type` (`comment_type` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_links`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_links` (
  `link_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `link_url` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `link_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `link_image` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `link_target` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `link_description` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `link_visible` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT 'Y',
  `link_owner` BIGINT UNSIGNED NOT NULL DEFAULT '1',
  `link_rating` INT NOT NULL DEFAULT '0',
  `link_updated` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `link_notes` MEDIUMTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `link_rss` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  INDEX `link_visible` (`link_visible` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_options`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_options` (
  `option_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `option_name` VARCHAR(191) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `option_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `autoload` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE INDEX `option_name` (`option_name` ASC),
  INDEX `autoload` (`autoload` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 2958
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_postmeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_postmeta` (
  `meta_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `meta_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  INDEX `post_id` (`post_id` ASC),
  INDEX `meta_key` (`meta_key`(191) ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 420
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_term_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_term_relationships` (
  `object_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `term_taxonomy_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `term_order` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`, `term_taxonomy_id`),
  INDEX `term_taxonomy_id` (`term_taxonomy_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_term_taxonomy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_term_taxonomy` (
  `term_taxonomy_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `taxonomy` VARCHAR(32) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `description` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `parent` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `count` BIGINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE INDEX `term_id_taxonomy` (`term_id` ASC, `taxonomy` ASC),
  INDEX `taxonomy` (`taxonomy` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_termmeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_termmeta` (
  `meta_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `term_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `meta_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  INDEX `term_id` (`term_id` ASC),
  INDEX `meta_key` (`meta_key`(191) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_terms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_terms` (
  `term_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `slug` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `term_group` BIGINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  INDEX `slug` (`slug`(191) ASC),
  INDEX `name` (`name`(191) ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_usermeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_usermeta` (
  `umeta_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `meta_key` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `meta_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`umeta_id`),
  INDEX `user_id` (`user_id` ASC),
  INDEX `meta_key` (`meta_key`(191) ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 188
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_downloadable_product_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_downloadable_product_permissions` (
  `permission_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `download_id` VARCHAR(36) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `product_id` BIGINT UNSIGNED NOT NULL,
  `order_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `order_key` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `user_email` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `user_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `downloads_remaining` VARCHAR(9) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `access_granted` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_expires` DATETIME NULL DEFAULT NULL,
  `download_count` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`permission_id`),
  INDEX `download_order_key_product` (`product_id` ASC, `order_id` ASC, `order_key`(16) ASC, `download_id` ASC),
  INDEX `download_order_product` (`download_id` ASC, `order_id` ASC, `product_id` ASC),
  INDEX `order_id` (`order_id` ASC),
  INDEX `user_order_remaining_expires` (`user_id` ASC, `order_id` ASC, `downloads_remaining` ASC, `access_expires` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_wc_download_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_wc_download_log` (
  `download_log_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `timestamp` DATETIME NOT NULL,
  `permission_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NULL DEFAULT NULL,
  `user_ip_address` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT '',
  PRIMARY KEY (`download_log_id`),
  INDEX `permission_id` (`permission_id` ASC),
  INDEX `timestamp` (`timestamp` ASC),
  CONSTRAINT `fk_wp_wc_download_log_permission_id`
    FOREIGN KEY (`permission_id`)
    REFERENCES `wordpress`.`wp_woocommerce_downloadable_product_permissions` (`permission_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_wc_product_meta_lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_wc_product_meta_lookup` (
  `product_id` BIGINT NOT NULL,
  `sku` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT '',
  `virtual` TINYINT(1) NULL DEFAULT '0',
  `downloadable` TINYINT(1) NULL DEFAULT '0',
  `min_price` DECIMAL(19,4) NULL DEFAULT NULL,
  `max_price` DECIMAL(19,4) NULL DEFAULT NULL,
  `onsale` TINYINT(1) NULL DEFAULT '0',
  `stock_quantity` DOUBLE NULL DEFAULT NULL,
  `stock_status` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT 'instock',
  `rating_count` BIGINT NULL DEFAULT '0',
  `average_rating` DECIMAL(3,2) NULL DEFAULT '0.00',
  `total_sales` BIGINT NULL DEFAULT '0',
  `tax_status` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT 'taxable',
  `tax_class` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT '',
  PRIMARY KEY (`product_id`),
  INDEX `virtual` (`virtual` ASC),
  INDEX `downloadable` (`downloadable` ASC),
  INDEX `stock_status` (`stock_status` ASC),
  INDEX `stock_quantity` (`stock_quantity` ASC),
  INDEX `onsale` (`onsale` ASC),
  INDEX `min_max_price` (`min_price` ASC, `max_price` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_wc_reserved_stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_wc_reserved_stock` (
  `order_id` BIGINT NOT NULL,
  `product_id` BIGINT NOT NULL,
  `stock_quantity` DOUBLE NOT NULL DEFAULT '0',
  `timestamp` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expires` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`order_id`, `product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_wc_tax_rate_classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_wc_tax_rate_classes` (
  `tax_rate_class_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `slug` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_rate_class_id`),
  UNIQUE INDEX `slug` (`slug`(191) ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_wc_webhooks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_wc_webhooks` (
  `webhook_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `name` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `delivery_url` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `secret` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `topic` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `date_created` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified_gmt` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `api_version` SMALLINT NOT NULL,
  `failure_count` SMALLINT NOT NULL DEFAULT '0',
  `pending_delivery` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`webhook_id`),
  INDEX `user_id` (`user_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_api_keys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_api_keys` (
  `key_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `description` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `permissions` VARCHAR(10) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `consumer_key` CHAR(64) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `consumer_secret` CHAR(43) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `nonces` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `truncated_key` CHAR(7) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `last_access` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`key_id`),
  INDEX `consumer_key` (`consumer_key` ASC),
  INDEX `consumer_secret` (`consumer_secret` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_attribute_taxonomies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_attribute_taxonomies` (
  `attribute_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `attribute_name` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `attribute_label` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `attribute_type` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `attribute_orderby` VARCHAR(20) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `attribute_public` INT NOT NULL DEFAULT '1',
  PRIMARY KEY (`attribute_id`),
  INDEX `attribute_name` (`attribute_name`(20) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_log` (
  `log_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `timestamp` DATETIME NOT NULL,
  `level` SMALLINT NOT NULL,
  `source` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `message` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `context` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  INDEX `level` (`level` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_order_itemmeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_order_itemmeta` (
  `meta_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_item_id` BIGINT UNSIGNED NOT NULL,
  `meta_key` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `meta_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  INDEX `order_item_id` (`order_item_id` ASC),
  INDEX `meta_key` (`meta_key`(32) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_order_items` (
  `order_item_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_item_name` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `order_item_type` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `order_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `order_id` (`order_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_payment_tokenmeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_payment_tokenmeta` (
  `meta_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_token_id` BIGINT UNSIGNED NOT NULL,
  `meta_key` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  `meta_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`meta_id`),
  INDEX `payment_token_id` (`payment_token_id` ASC),
  INDEX `meta_key` (`meta_key`(32) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_payment_tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_payment_tokens` (
  `token_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gateway_id` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `token` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL DEFAULT '0',
  `type` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `is_default` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`token_id`),
  INDEX `user_id` (`user_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_sessions` (
  `session_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `session_key` CHAR(32) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `session_value` LONGTEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `session_expiry` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`session_id`),
  UNIQUE INDEX `session_key` (`session_key` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 56
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_shipping_zone_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_shipping_zone_locations` (
  `location_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `zone_id` BIGINT UNSIGNED NOT NULL,
  `location_code` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `location_type` VARCHAR(40) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `location_id` (`location_id` ASC),
  INDEX `location_type_code` (`location_type`(10) ASC, `location_code`(20) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_shipping_zone_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_shipping_zone_methods` (
  `zone_id` BIGINT UNSIGNED NOT NULL,
  `instance_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `method_id` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `method_order` BIGINT UNSIGNED NOT NULL,
  `is_enabled` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`instance_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_shipping_zones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_shipping_zones` (
  `zone_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `zone_name` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `zone_order` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`zone_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_tax_rate_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_tax_rate_locations` (
  `location_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `location_code` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  `tax_rate_id` BIGINT UNSIGNED NOT NULL,
  `location_type` VARCHAR(40) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `tax_rate_id` (`tax_rate_id` ASC),
  INDEX `location_type_code` (`location_type`(10) ASC, `location_code`(20) ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;


-- -----------------------------------------------------
-- Table `wordpress`.`wp_woocommerce_tax_rates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`wp_woocommerce_tax_rates` (
  `tax_rate_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tax_rate_country` VARCHAR(2) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `tax_rate_state` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `tax_rate` VARCHAR(8) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `tax_rate_name` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  `tax_rate_priority` BIGINT UNSIGNED NOT NULL,
  `tax_rate_compound` INT NOT NULL DEFAULT '0',
  `tax_rate_shipping` INT NOT NULL DEFAULT '1',
  `tax_rate_order` BIGINT UNSIGNED NOT NULL,
  `tax_rate_class` VARCHAR(200) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_520_ci' NOT NULL DEFAULT '',
  PRIMARY KEY (`tax_rate_id`),
  INDEX `tax_rate_country` (`tax_rate_country` ASC),
  INDEX `tax_rate_state` (`tax_rate_state`(2) ASC),
  INDEX `tax_rate_class` (`tax_rate_class`(10) ASC),
  INDEX `tax_rate_priority` (`tax_rate_priority` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_520_ci;

USE `wordpress` ;

-- -----------------------------------------------------
-- Placeholder table for view `wordpress`.`lesson_to_be_filtered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`lesson_to_be_filtered` (`idlezione` INT, `data` INT, `professore_idprofessore` INT, `sezione_idsezione` INT, `titolo` INT, `trascrizione` INT, `wp_post_id` INT, `materia_idmateria` INT, `argomento_idargomento` INT, `status` INT, `materia` INT, `scuola` INT, `argomento` INT);

-- -----------------------------------------------------
-- Placeholder table for view `wordpress`.`professors_id_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`professors_id_view` (`pid` INT, `wpid` INT);

-- -----------------------------------------------------
-- Placeholder table for view `wordpress`.`professors_lessons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wordpress`.`professors_lessons` (`idlezione` INT, `wp_id` INT);

-- -----------------------------------------------------
-- procedure lesson_with_content
-- -----------------------------------------------------

DELIMITER $$
USE `wordpress`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `lesson_with_content`(
	in idlezione int
)
BEGIN
	select * from 
    lezione as l  join contenuto as c on c.lezione_idlezione=l.idlezione
    where l.idlezione=idlezione;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure test_procedure
-- -----------------------------------------------------

DELIMITER $$
USE `wordpress`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_procedure`(
in intero int,
in intero2 int
)
BEGIN
	select *, intero2 as intero 
    from lezione
    where idlezione= intero;
    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure trash_lesson_and_post
-- -----------------------------------------------------

DELIMITER $$
USE `wordpress`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `trash_lesson_and_post`(
			in idlezione int
		)
BEGIN
			UPDATE lezione set `status`='trash'
		    where lezione.idlezione=idlezione;
		    UPDATE wp_posts set `post_status`='trash'
		    where wp_posts.ID = (SELECT l.wp_post_id 
						from lezione as l 
						where l.idlezione=idlezione);
		END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_lezione
-- -----------------------------------------------------

DELIMITER $$
USE `wordpress`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_lezione`()
BEGIN

END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `wordpress`.`lesson_to_be_filtered`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordpress`.`lesson_to_be_filtered`;
USE `wordpress`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wordpress`.`lesson_to_be_filtered` AS select `lez`.`idlezione` AS `idlezione`,`lez`.`data` AS `data`,`lez`.`professore_idprofessore` AS `professore_idprofessore`,`lez`.`sezione_idsezione` AS `sezione_idsezione`,`lez`.`titolo` AS `titolo`,`lez`.`trascrizione` AS `trascrizione`,`lez`.`wp_post_id` AS `wp_post_id`,`lez`.`materia_idmateria` AS `materia_idmateria`,`lez`.`argomento_idargomento` AS `argomento_idargomento`,`lez`.`status` AS `status`,`m`.`nome` AS `materia`,`sc`.`nome` AS `scuola`,`arg`.`nome` AS `argomento` from (((((`wordpress`.`lezione` `lez` join `wordpress`.`materia` `m` on((`m`.`idmateria` = `lez`.`materia_idmateria`))) join `wordpress`.`argomento` `arg` on((`arg`.`materia_idmateria` = `m`.`idmateria`))) join `wordpress`.`professore` `pr` on((`pr`.`idprofessore` = `lez`.`professore_idprofessore`))) join `wordpress`.`sezione` `se` on((`se`.`idsezione` = `lez`.`sezione_idsezione`))) join `wordpress`.`scuola` `sc` on((`sc`.`idscuola` = `se`.`scuola_idscuola`)));

-- -----------------------------------------------------
-- View `wordpress`.`professors_id_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordpress`.`professors_id_view`;
USE `wordpress`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wordpress`.`professors_id_view` AS select `p`.`idprofessore` AS `pid`,`wpu`.`ID` AS `wpid` from ((`wordpress`.`professore` `p` join `wordpress`.`utente` `u` on((`u`.`idutente` = `p`.`utente_idutente`))) join `wordpress`.`wp_users` `wpu` on((`wpu`.`ID` = `u`.`wp_id`)));

-- -----------------------------------------------------
-- View `wordpress`.`professors_lessons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `wordpress`.`professors_lessons`;
USE `wordpress`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `wordpress`.`professors_lessons` AS select `l`.`idlezione` AS `idlezione`,`u`.`wp_id` AS `wp_id` from ((`wordpress`.`lezione` `l` join `wordpress`.`professore` `p` on((`l`.`professore_idprofessore` = `p`.`idprofessore`))) join `wordpress`.`utente` `u` on((`u`.`idutente` = `p`.`utente_idutente`)));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
