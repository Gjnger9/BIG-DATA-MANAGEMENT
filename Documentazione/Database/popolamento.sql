INSERT INTO `wordpress`.`materia` (`nome`) VALUES ('matematica');
INSERT INTO `wordpress`.`materia` (`nome`) VALUES ('fisica');
INSERT INTO `wordpress`.`materia` (`nome`) VALUES ('geometria');
INSERT INTO `wordpress`.`utente` (`nome`, `cognome`, `cf`, `email`, `indirizzo`, `wp_id`) VALUES ('anto', 'mo', 'fsda', 'mail', 'fa', '1');
INSERT INTO `wordpress`.`utente` (`nome`, `cognome`, `cf`, `email`, `indirizzo`, `wp_id`) VALUES ('fads', 'fasd', 'dsaf', 'fdas', 'fdas', '2');
INSERT INTO `wordpress`.`professore` (`utente_idutente`) VALUES ('1');
INSERT INTO `wordpress`.`professore` (`utente_idutente`) VALUES ('2');
INSERT INTO `wordpress`.`argomento` (`nome`, `descrizione`, `anno_di_corso`, `materia_idmateria`) VALUES ('derivate', 'lk', '2', '1');
INSERT INTO `wordpress`.`argomento` (`nome`, `descrizione`, `anno_di_corso`, `materia_idmateria`) VALUES ('dfas', 'dfas', '2', '2');
INSERT INTO `wordpress`.`argomento` (`idargomento`, `nome`, `descrizione`, `anno_di_corso`, `materia_idmateria`) VALUES (NULL, 'yteryetr', 'hgd', '1', '2');

INSERT INTO `wordpress`.`scuola` (`nome`, `indirizzo`, `codice`) VALUES ('scuola1', 'si', 'no');
