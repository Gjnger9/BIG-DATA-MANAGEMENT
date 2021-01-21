<?php
function create_db_wpdb () {
	GLOBAL $wpdb;
	// procedure
	$sql  = file_get_contents (ABSPATH."wp-content/plugins/test/create_procedure.sql"  );
	$wpdb->query("DROP procedure IF EXISTS `sync_lesson_to_post`;");
	$wpdb->query($sql);

	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`materia` (
          `idmateria` INT NOT NULL AUTO_INCREMENT,
          `nome` VARCHAR(45) NOT NULL,
          PRIMARY KEY (`idmateria`))
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`argomento` (
          `idargomento` INT NOT NULL AUTO_INCREMENT,
          `nome` VARCHAR(100) NOT NULL,
          `descrizione` VARCHAR(300) NOT NULL,
          `anno_di_corso` INT NOT NULL,
          `materia_idmateria` INT NOT NULL,
          PRIMARY KEY (`idargomento`),
          INDEX `fk_argomento_materia1_idx` (`materia_idmateria` ASC),
          CONSTRAINT `fk_argomento_materia1`
            FOREIGN KEY (`materia_idmateria`)
            REFERENCES `wordpress`.`materia` (`idmateria`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`utente` (
          `idutente` INT NOT NULL AUTO_INCREMENT,
          `nome` VARCHAR(100) NOT NULL,
          `cognome` VARCHAR(100) NOT NULL,
          `cf` VARCHAR(16) NOT NULL,
          `email` VARCHAR(200) NOT NULL,
          `indirizzo` VARCHAR(500) NOT NULL,
          `wp_id` BIGINT UNSIGNED UNIQUE NULL,
          PRIMARY KEY (`idutente`),
          INDEX `fk_wp_id1_idx` (`wp_id` ASC),
          CONSTRAINT `fk_wp_id`
            FOREIGN KEY (`wp_id`)
            REFERENCES `wordpress`.`wp_users` (`ID`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`professore` (
          `idprofessore` INT NOT NULL AUTO_INCREMENT,
          `utente_idutente` INT NOT NULL,
          PRIMARY KEY (`idprofessore`, `utente_idutente`),
          INDEX `fk_professore_utente1_idx` (`utente_idutente` ASC),
          CONSTRAINT `fk_professore_utente1`
            FOREIGN KEY (`utente_idutente`)
            REFERENCES `wordpress`.`utente` (`idutente`))
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`dipendente` (
          `iddipendente` INT NOT NULL AUTO_INCREMENT,
          `utente_idutente` INT NOT NULL,
          PRIMARY KEY (`iddipendente`, `utente_idutente`),
          INDEX `fk_dipendente_utente1_idx` (`utente_idutente` ASC),
          CONSTRAINT `fk_dipendente_utente1`
            FOREIGN KEY (`utente_idutente`)
            REFERENCES `wordpress`.`utente` (`idutente`))
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`scuola` (
          `idscuola` INT NOT NULL AUTO_INCREMENT,
          `nome` VARCHAR(200) NOT NULL,
          `indirizzo` VARCHAR(500) NOT NULL,
          `codice` VARCHAR(12) NOT NULL,
          PRIMARY KEY (`idscuola`))
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`sezione` (
          `idsezione` INT NOT NULL AUTO_INCREMENT,
          `lettera` VARCHAR(2) NOT NULL,
          `anno` INT NOT NULL,
          `persorso_di_studi` VARCHAR(200) NOT NULL,
          `scuola_idscuola` INT NOT NULL,
          PRIMARY KEY (`idsezione`),
          INDEX `fk_sezione_scuola1_idx` (`scuola_idscuola` ASC),
          CONSTRAINT `fk_sezione_scuola1`
            FOREIGN KEY (`scuola_idscuola`)
            REFERENCES `wordpress`.`scuola` (`idscuola`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`lezione` (
          `idlezione` INT NOT NULL AUTO_INCREMENT,
          `data` DATE NOT NULL,
          `professore_idprofessore` INT NOT NULL,
          `sezione_idsezione` INT NOT NULL,
          `file_audio_path` TEXT NULL,           
          `titolo` VARCHAR(45) NULL,
          `trascrizione` LONGTEXT NULL,
          `wp_post_id` BIGINT UNSIGNED NULL,
          `materia_idmateria` INT NOT NULL,
          `argomento_idargomento` INT NOT NULL,
          PRIMARY KEY (`idlezione`),
          INDEX `fk_lezione_professore1_idx` (`professore_idprofessore` ASC),
          INDEX `fk_lezione_sezione1_idx` (`sezione_idsezione` ASC),
          CONSTRAINT `fk_lezione_professore1`
            FOREIGN KEY (`professore_idprofessore`)
            REFERENCES `wordpress`.`professore` (`idprofessore`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_lezione_sezione1`
            FOREIGN KEY (`sezione_idsezione`)
            REFERENCES `wordpress`.`sezione` (`idsezione`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_wp_id1`
            FOREIGN KEY (`wp_post_id`)
            REFERENCES `wordpress`.`wp_posts` (`ID`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_materia_idmateria1`
            FOREIGN KEY (`materia_idmateria`)
            REFERENCES `wordpress`.`materia` (`idmateria`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_argomento_idargomento`
            FOREIGN KEY (`argomento_idargomento`)
            REFERENCES `wordpress`.`argomento` (`idargomento`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
            )
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`contenuto` (
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
          CONSTRAINT `fk_contenuto_professore1`
            FOREIGN KEY (`professore_idprofessore`)
            REFERENCES `wordpress`.`professore` (`idprofessore`),
          CONSTRAINT `fk_contenuto_lezione2`
            FOREIGN KEY (`lezione_idlezione`)
            REFERENCES `wordpress`.`lezione` (`idlezione`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`aggrega` (
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
        DEFAULT CHARACTER SET = utf8;");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`alunno` (
          `idalunno` INT NOT NULL AUTO_INCREMENT,
          `utente_idutente` INT NOT NULL,
          PRIMARY KEY (`idalunno`, `utente_idutente`),
          INDEX `fk_alunno_utente1_idx` (`utente_idutente` ASC),
          CONSTRAINT `fk_alunno_utente1`
            FOREIGN KEY (`utente_idutente`)
            REFERENCES `wordpress`.`utente` (`idutente`))
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;
");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`impiega` (
          `dal` DATE NOT NULL,
          `fino_a` DATE NOT NULL,
          `scuola_idscuola` INT NOT NULL,
          `professore_idprofessore` INT NOT NULL,
          PRIMARY KEY (`scuola_idscuola`, `professore_idprofessore`),
          INDEX `fk_impiega_scuola1_idx` (`scuola_idscuola` ASC),
          INDEX `fk_impiega_professore1_idx` (`professore_idprofessore` ASC),
          CONSTRAINT `fk_impiega_scuola1`
            FOREIGN KEY (`scuola_idscuola`)
            REFERENCES `wordpress`.`scuola` (`idscuola`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_impiega_professore1`
            FOREIGN KEY (`professore_idprofessore` )
            REFERENCES `wordpress`.`professore` (`idprofessore`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;
");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`tipo_di_scuola` (
          `idtipo_di_scuola` INT NOT NULL AUTO_INCREMENT,
          `nome` VARCHAR(200) NOT NULL,
          PRIMARY KEY (`idtipo_di_scuola`))
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;
");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`include` (
          `sezione_idsezione` INT NOT NULL,
          `alunno_idalunno` INT NOT NULL,
          `data_inizio` DATETIME NULL,
          `data_fine` DATETIME NULL,
          PRIMARY KEY (`sezione_idsezione`, `alunno_idalunno`),
          INDEX `fk_sezione_has_alunno_alunno1_idx` (`alunno_idalunno` ASC),
          INDEX `fk_sezione_has_alunno_sezione1_idx` (`sezione_idsezione` ASC),
          CONSTRAINT `fk_sezione_has_alunno_sezione1`
            FOREIGN KEY (`sezione_idsezione`)
            REFERENCES `wordpress`.`sezione` (`idsezione`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_sezione_has_alunno_alunno1`
            FOREIGN KEY (`alunno_idalunno` )
            REFERENCES `wordpress`.`alunno` (`idalunno` )
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");

	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`e_in` (
          `materia_idmateria` INT NOT NULL ,
          `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
          PRIMARY KEY (`materia_idmateria`, `tipo_di_scuola_idtipo_di_scuola`),
          INDEX `fk_materia_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC),
          INDEX `fk_materia_has_tipo_di_scuola_materia1_idx` (`materia_idmateria` ASC),
          CONSTRAINT `fk_materia_has_tipo_di_scuola_materia2`
            FOREIGN KEY (`materia_idmateria`)
            REFERENCES `wordpress`.`materia` (`idmateria`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_materia_has_tipo_di_scuola_tipo_di_scuola2`
            FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
            REFERENCES `wordpress`.`tipo_di_scuola` (`idtipo_di_scuola`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;

");
	$wpdb->query("        CREATE TABLE IF NOT EXISTS `wordpress`.`e_tipo` (
          `scuola_idscuola` INT NOT NULL,
          `tipo_di_scuola_idtipo_di_scuola` INT NOT NULL,
          PRIMARY KEY (`scuola_idscuola`, `tipo_di_scuola_idtipo_di_scuola`),
          INDEX `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola` ASC),
          INDEX `fk_scuola_has_tipo_di_scuola_scuola1_idx` (`scuola_idscuola` ASC),
          CONSTRAINT `fk_scuola_has_tipo_di_scuola_scuola1`
            FOREIGN KEY (`scuola_idscuola`)
            REFERENCES `wordpress`.`scuola` (`idscuola`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
          CONSTRAINT `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1`
            FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`)
            REFERENCES `wordpress`.`tipo_di_scuola` (`idtipo_di_scuola`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION)
        ENGINE = InnoDB
        DEFAULT CHARACTER SET = utf8;");
	}