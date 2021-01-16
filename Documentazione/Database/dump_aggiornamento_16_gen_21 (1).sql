-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: wordpress
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aggrega`
--

DROP TABLE IF EXISTS `aggrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aggrega` (
  `argomento_idargomento` int NOT NULL,
  `contenuto_idcontenuto` int NOT NULL,
  PRIMARY KEY (`argomento_idargomento`,`contenuto_idcontenuto`),
  KEY `fk_argomento_has_contenuto_contenuto1_idx` (`contenuto_idcontenuto`),
  KEY `fk_argomento_has_contenuto_argomento_idx` (`argomento_idargomento`),
  CONSTRAINT `fk_argomento_has_contenuto_argomento` FOREIGN KEY (`argomento_idargomento`) REFERENCES `argomento` (`idargomento`),
  CONSTRAINT `fk_argomento_has_contenuto_contenuto1` FOREIGN KEY (`contenuto_idcontenuto`) REFERENCES `contenuto` (`idcontenuto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aggrega`
--

LOCK TABLES `aggrega` WRITE;
/*!40000 ALTER TABLE `aggrega` DISABLE KEYS */;
/*!40000 ALTER TABLE `aggrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alunno`
--

DROP TABLE IF EXISTS `alunno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunno` (
  `idalunno` int NOT NULL AUTO_INCREMENT,
  `utente_idutente` int NOT NULL,
  PRIMARY KEY (`idalunno`,`utente_idutente`),
  KEY `fk_alunno_utente1_idx` (`utente_idutente`),
  CONSTRAINT `fk_alunno_utente1` FOREIGN KEY (`utente_idutente`) REFERENCES `utente` (`idutente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunno`
--

LOCK TABLES `alunno` WRITE;
/*!40000 ALTER TABLE `alunno` DISABLE KEYS */;
/*!40000 ALTER TABLE `alunno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `argomento`
--

DROP TABLE IF EXISTS `argomento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `argomento` (
  `idargomento` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descrizione` varchar(300) NOT NULL,
  `anno_di_corso` int NOT NULL,
  `materia_idmateria` int NOT NULL,
  PRIMARY KEY (`idargomento`),
  KEY `fk_argomento_materia1_idx` (`materia_idmateria`),
  CONSTRAINT `fk_argomento_materia1` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `argomento`
--

LOCK TABLES `argomento` WRITE;
/*!40000 ALTER TABLE `argomento` DISABLE KEYS */;
INSERT INTO `argomento` VALUES (1,'derivate','lk',2,1),(2,'dfas','dfas',2,2),(3,'yteryetr','hgd',1,2);
/*!40000 ALTER TABLE `argomento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contenuto`
--

DROP TABLE IF EXISTS `contenuto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contenuto` (
  `idcontenuto` int NOT NULL AUTO_INCREMENT,
  `titolo` varchar(300) NOT NULL,
  `tipo` varchar(10) NOT NULL,
  `data_creazione` datetime NOT NULL,
  `percorso` mediumtext NOT NULL,
  `professore_idprofessore` int DEFAULT NULL,
  `data_accettazione` datetime DEFAULT NULL,
  `lezione_idlezione` int NOT NULL,
  PRIMARY KEY (`idcontenuto`),
  KEY `fk_contenuto_professore1_idx` (`professore_idprofessore`),
  KEY `fk_contenuto_lezione2_idx` (`lezione_idlezione`),
  CONSTRAINT `fk_contenuto_lezione2` FOREIGN KEY (`lezione_idlezione`) REFERENCES `lezione` (`idlezione`),
  CONSTRAINT `fk_contenuto_professore1` FOREIGN KEY (`professore_idprofessore`) REFERENCES `professore` (`idprofessore`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contenuto`
--

LOCK TABLES `contenuto` WRITE;
/*!40000 ALTER TABLE `contenuto` DISABLE KEYS */;
INSERT INTO `contenuto` VALUES (19,'BlaBlaCar: viaggia in Carpooling o in Autobus | BlaBlaCarwww.blablacar.it','link','2021-01-16 00:00:00','https://www.blablacar.it/',1,NULL,2),(20,'bla bla in Vocabolario - Treccaniwww.treccani.it › vocabolario › bla-bla','link','2021-01-16 00:00:00','https://www.treccani.it/vocabolario/bla-bla/',1,NULL,2),(21,'bla: definizioni, etimologia e citazioni nel Vocabolario Treccaniwww.treccani.it › vocabolario › ricerca › bla','link','2021-01-16 00:00:00','https://www.treccani.it/vocabolario/ricerca/bla/',1,NULL,2),(22,'ALEX PIZZUTI & ADALWOLF - Bla Bla Bla - YouTubewww.youtube.com › watch','video','2021-01-16 00:00:00','https://www.youtube.com/watch?v=EBumqseEx90',1,NULL,2),(23,'Bla Bla Bla - YouTubewww.youtube.com › watch','video','2021-01-16 00:00:00','https://www.youtube.com/watch?v=BnqVf8XAmMg',1,NULL,2),(24,'Gigi D\'Agostino Bla Bla Bla - YouTubewww.youtube.com › watch','video','2021-01-16 00:00:00','https://www.youtube.com/watch?v=Hrph2EW9VjY&list=PLa33_-AtN6xdZmHuokVWPDJmoZApGXMze&index=14&t=0s',1,NULL,2),(25,'TIZIO CV 2020 Bla Bla Bla Bla Bla Bla Blawww.minambiente.it › sites › default › files › locatelli','documento','2021-01-16 00:00:00','https://www.minambiente.it/sites/default/files/locatelli/tizio_cv_2020.pdf',1,NULL,2),(26,'Bla Bla Bla - Djeco - Brickonewww.brickone.it › Istruzioni-di-Gioco-Bla-Bla-Bla-Djeco','documento','2021-01-16 00:00:00','https://www.brickone.it/wp-content/uploads/2017/04/Istruzioni-di-Gioco-Bla-Bla-Bla-Djeco.pdf',1,NULL,2),(27,'17221/13 bla/BLA/bp/S 1 DG B 4A CONSIGLIO DELL\'UNIONE ...data.consilium.europa.eu › ST-17221-2013-INIT › pdf','documento','2021-01-16 00:00:00','https://data.consilium.europa.eu/doc/document/ST-17221-2013-INIT/it/pdf',1,NULL,2),(28,'Fare lezione a distanza: 5 buone pratiche per essere efficaciwww.miriambertoli.com › Blog','link','2021-01-16 11:40:31','https://www.miriambertoli.com/fare-lezione-a-distanza-5-buone-pratiche-per-essere-efficaci/',1,'2021-01-16 11:40:31',3),(29,'3. Le tecniche, la tecnica più praticata: la lezionewww.laboratorioformazione.it › ...','link','2021-01-16 11:40:31','http://www.laboratorioformazione.it/index.php?option=com_content&view=article&id=924&Itemid=608',1,'2021-01-16 11:40:31',3),(30,'Didattica a distanza: 5 corsi gratuiti, 29 guide su strumenti ...www.orizzontescuola.it › coronavirus-materiale-didattic...','link','2021-01-16 11:40:31','https://www.orizzontescuola.it/coronavirus-materiale-didattico-online-ce-sete-di-condivisione-invia-il-tuo/',1,'2021-01-16 11:40:31',3),(31,'GUIDA MEET','video','2021-01-16 11:40:31','https://www.youtube.com/watch?v=fHCPgniF7b0',1,'2021-01-16 11:40:31',3),(32,'Google Classroom Tutorial Italiano - VideoTutorial completo ...www.youtube.com › watch','video','2021-01-16 11:40:31','https://www.youtube.com/watch?v=3j1XiBE3b2c',1,'2021-01-16 11:40:31',3),(33,'Meet GSuite Tutorial Italiano - IMPORTANTI ... - YouTubewww.youtube.com › watch','video','2021-01-16 11:40:31','https://www.youtube.com/watch?v=17TFtxkd7xE',1,'2021-01-16 11:40:31',3),(34,'corso di formazione e aggiornamento per docenti di ... - Unimewww.unime.it › sites › default › files › Programma Cor...','documento','2021-01-16 11:40:31','https://www.unime.it/sites/default/files/Programma%20Corso%20formazione%20e%20aggiornamento%20Tecnologia%20e%20scienze%20umanistiche%20.pdf',1,'2021-01-16 11:40:31',3),(35,'corsi di formazione ed aggiornamento per docenti ... - Edscuolawww.edscuola.eu › wp-content › uploads › 2016/07','documento','2021-01-16 11:40:31','http://www.edscuola.eu/wordpress/wp-content/uploads/2016/07/Brouchure-presentazione-corsi-2016-17-si-carta-intestata.pdf',1,'2021-01-16 11:40:31',3),(36,'La SIREM per la didattica a distanza ai tempi del COVID-19www.liceoeconomicosociale.it › uploads › 2020/03 › S...','documento','2021-01-16 11:40:31','http://www.liceoeconomicosociale.it/wp-content/uploads/2020/03/Scuola-La-SIREM-per-la-didattica-a-distanza-ai-tempi-del-COVID-19.pdf',1,'2021-01-16 11:40:31',3),(37,'Bando bollo auto ibride - Mobilità - Regione Emilia Romagnamobilita.regione.emilia-romagna.it › bando_bollo_2020','link','2021-01-16 12:05:23','https://mobilita.regione.emilia-romagna.it/bandi/bando_bollo_2020',1,'2021-01-16 12:05:23',4),(38,'GU Parte Seconda n.78 del 4-7-2020 - GAZZETTA UFFICIALEwww.gazzettaufficiale.it › eli › 2020/07/04 › pdf','link','2021-01-16 12:05:23','http://www.gazzettaufficiale.it/eli/gu/2020/07/04/78/p2/pdf',1,'2021-01-16 12:05:23',4),(39,'GU Parte Seconda n.69 del 13-6-2020 - GAZZETTA UFFICIALEwww.gazzettaufficiale.it › eli › 2020/06/13 › pdf','link','2021-01-16 12:05:23','http://www.gazzettaufficiale.it/eli/gu/2020/06/13/69/p2/pdf',1,'2021-01-16 12:05:23',4),(40,'GU Parte Seconda n.78 del 4-7-2020 - GAZZETTA UFFICIALEwww.gazzettaufficiale.it › eli › 2020/07/04 › pdf','documento','2021-01-16 12:05:23','http://www.gazzettaufficiale.it/eli/gu/2020/07/04/78/p2/pdf',1,'2021-01-16 12:05:23',4),(41,'GU Parte Seconda n.69 del 13-6-2020 - GAZZETTA UFFICIALEwww.gazzettaufficiale.it › eli › 2020/06/13 › pdf','documento','2021-01-16 12:05:23','http://www.gazzettaufficiale.it/eli/gu/2020/06/13/69/p2/pdf',1,'2021-01-16 12:05:23',4),(42,'Bollettino di Numismatica on line Studi e Ricerche n. 3-2017www.bdnonline.numismaticadellostato.it › numero03 › pdf','documento','2021-01-16 12:05:23','https://www.bdnonline.numismaticadellostato.it/repository/numero03/pdf/BdNonline_Studi_3_2017.pdf',1,'2021-01-16 12:05:23',4),(43,'L\'ultima prova (il romanzo di Nisida) - I Nisidiani ... - Amazon.itwww.amazon.it › Lultima-prova-romanzo-Nisida-Nisidi...','link','2021-01-16 12:07:46','https://www.amazon.it/Lultima-prova-romanzo-Nisida-Nisidiani/dp/8868664100',1,'2021-01-16 12:07:46',5),(44,'L\'Ultima Prova: Amazon.it: Vinciguerra, Samuel: Libriwww.amazon.it › LUltima-Prova-Samuel-Vinciguerra','link','2021-01-16 12:07:46','https://www.amazon.it/LUltima-Prova-Samuel-Vinciguerra/dp/1686155492',1,'2021-01-16 12:07:46',5),(45,'ultima prova - Traduzione in inglese - esempi italiano ...context.reverso.net › traduzione › ultima+prova','link','2021-01-16 12:07:46','https://context.reverso.net/traduzione/italiano-inglese/ultima+prova',1,'2021-01-16 12:07:46',5),(46,'Renault Captur 2020: ecco la prova completa - YouTubewww.youtube.com › watch','video','2021-01-16 12:07:46','https://www.youtube.com/watch?v=fpZGlEaxjlA',1,'2021-01-16 12:07:46',5),(47,'MERCEDES CLASSE S 2020 | Prima prova su strada della ...www.youtube.com › watch','video','2021-01-16 12:07:46','https://www.youtube.com/watch?v=szed_nbMXRs',1,'2021-01-16 12:07:46',5),(48,'CUPRA FORMENTOR | Prova su strada con la prima ...www.youtube.com › watch','video','2021-01-16 12:07:46','https://www.youtube.com/watch?v=DAVxCoPsVv8&list=PLU45qKePwteye4EKvMqLOKuZIHNtib7jo',1,'2021-01-16 12:07:46',5),(49,'Allegato B PROGRAMMA DELLE PROVE DI CONCORSO 1 ...www.carabinieri.it › files','documento','2021-01-16 12:07:46','http://www.carabinieri.it/files/9420.pdf',1,'2021-01-16 12:07:46',5),(50,'Fascicolo 1 - Invalsiinvalsi-areaprove.cineca.it › docs › file › fascicolo1_8_ita','documento','2021-01-16 12:07:46','https://invalsi-areaprove.cineca.it/docs/file/fascicolo1_8_ita.pdf',1,'2021-01-16 12:07:46',5),(51,'LE PROVE COMPUTER BASED (CBT) ULTIMO ANNO ...invalsi-areaprove.cineca.it › docs › 2019-2020_Organi...','documento','2021-01-16 12:07:46','https://invalsi-areaprove.cineca.it/docs/2020/2019-2020_Organizzazione%20delle%20prove%20CBT_Grado_13.pdf',1,'2021-01-16 12:07:46',5),(52,'L\'ultima lezione. La vita spiegata da un uomo che muore ...www.amazon.it › Lultima-lezione-vita-spiegata-muore','link','2021-01-16 12:09:09','https://www.amazon.it/Lultima-lezione-vita-spiegata-muore/dp/8817023140',1,'2021-01-16 12:09:09',6),(53,'L\' Ultima lezione - Rizzoli Libribur.rizzolilibri.it › libri › l-ultima-lezione','link','2021-01-16 12:09:09','https://bur.rizzolilibri.it/libri/l-ultima-lezione/',1,'2021-01-16 12:09:09',6),(54,'L\' ultima lezione. La vita spiegata da un uomo che muore - Ibswww.ibs.it › ultima-lezione-vita-spiegata-da-libro-rand...','link','2021-01-16 12:09:09','https://www.ibs.it/ultima-lezione-vita-spiegata-da-libro-randy-pausch-jeffrey-zaslow/e/9788817031097',1,'2021-01-16 12:09:09',6),(55,'Randy Pausch L\'ultima lezione - YouTubewww.youtube.com › watch','video','2021-01-16 12:09:09','https://www.youtube.com/watch?v=YmV41wh42kw',1,'2021-01-16 12:09:09',6),(56,'L\'ultima grande lezione di Randy Pausch con traduzione in ...www.youtube.com › watch','video','2021-01-16 12:09:09','https://www.youtube.com/watch?v=bnX_i3d5F60',1,'2021-01-16 12:09:09',6),(57,'L\'ultima lezione... del prof. F. Caffè - YouTubewww.youtube.com › watch','video','2021-01-16 12:09:09','https://www.youtube.com/watch?v=rlAfeLdNvDE',1,'2021-01-16 12:09:09',6),(58,'L\'ultima lezione - Giurcost.orgwww.giurcost.org › studi › Sorrentino','documento','2021-01-16 12:09:09','http://www.giurcost.org/studi/Sorrentino.pdf',1,'2021-01-16 12:09:09',6),(59,'L\'ultima lezione napoletana di Giancarlo Mazzacuratiwww.progettoblio.com › files › Att8-32','documento','2021-01-16 12:09:09','http://www.progettoblio.com/files/Att8-32.pdf',1,'2021-01-16 12:09:09',6),(60,'l\'ultima lezione - Treditre Editoritreditreeditori.it › L ultima lezione Giuseppe Vaccaro','documento','2021-01-16 12:09:09','http://treditreeditori.it/sites/default/files/L%20ultima%20lezione%20Giuseppe%20Vaccaro.pdf',1,'2021-01-16 12:09:09',6);
/*!40000 ALTER TABLE `contenuto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dipendente`
--

DROP TABLE IF EXISTS `dipendente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dipendente` (
  `iddipendente` int NOT NULL AUTO_INCREMENT,
  `utente_idutente` int NOT NULL,
  PRIMARY KEY (`iddipendente`,`utente_idutente`),
  KEY `fk_dipendente_utente1_idx` (`utente_idutente`),
  CONSTRAINT `fk_dipendente_utente1` FOREIGN KEY (`utente_idutente`) REFERENCES `utente` (`idutente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dipendente`
--

LOCK TABLES `dipendente` WRITE;
/*!40000 ALTER TABLE `dipendente` DISABLE KEYS */;
/*!40000 ALTER TABLE `dipendente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `e_in`
--

DROP TABLE IF EXISTS `e_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `e_in` (
  `materia_idmateria` int NOT NULL,
  `tipo_di_scuola_idtipo_di_scuola` int NOT NULL,
  PRIMARY KEY (`materia_idmateria`,`tipo_di_scuola_idtipo_di_scuola`),
  KEY `fk_materia_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola`),
  KEY `fk_materia_has_tipo_di_scuola_materia1_idx` (`materia_idmateria`),
  CONSTRAINT `fk_materia_has_tipo_di_scuola_materia2` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`),
  CONSTRAINT `fk_materia_has_tipo_di_scuola_tipo_di_scuola2` FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`) REFERENCES `tipo_di_scuola` (`idtipo_di_scuola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `e_in`
--

LOCK TABLES `e_in` WRITE;
/*!40000 ALTER TABLE `e_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `e_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `e_tipo`
--

DROP TABLE IF EXISTS `e_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `e_tipo` (
  `scuola_idscuola` int NOT NULL,
  `tipo_di_scuola_idtipo_di_scuola` int NOT NULL,
  PRIMARY KEY (`scuola_idscuola`,`tipo_di_scuola_idtipo_di_scuola`),
  KEY `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1_idx` (`tipo_di_scuola_idtipo_di_scuola`),
  KEY `fk_scuola_has_tipo_di_scuola_scuola1_idx` (`scuola_idscuola`),
  CONSTRAINT `fk_scuola_has_tipo_di_scuola_scuola1` FOREIGN KEY (`scuola_idscuola`) REFERENCES `scuola` (`idscuola`),
  CONSTRAINT `fk_scuola_has_tipo_di_scuola_tipo_di_scuola1` FOREIGN KEY (`tipo_di_scuola_idtipo_di_scuola`) REFERENCES `tipo_di_scuola` (`idtipo_di_scuola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `e_tipo`
--

LOCK TABLES `e_tipo` WRITE;
/*!40000 ALTER TABLE `e_tipo` DISABLE KEYS */;
/*!40000 ALTER TABLE `e_tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `impiega`
--

DROP TABLE IF EXISTS `impiega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `impiega` (
  `dal` date NOT NULL,
  `fino_a` date NOT NULL,
  `scuola_idscuola` int NOT NULL,
  `professore_idprofessore` int NOT NULL,
  PRIMARY KEY (`scuola_idscuola`,`professore_idprofessore`),
  KEY `fk_impiega_scuola1_idx` (`scuola_idscuola`),
  KEY `fk_impiega_professore1_idx` (`professore_idprofessore`),
  CONSTRAINT `fk_impiega_professore1` FOREIGN KEY (`professore_idprofessore`) REFERENCES `professore` (`idprofessore`),
  CONSTRAINT `fk_impiega_scuola1` FOREIGN KEY (`scuola_idscuola`) REFERENCES `scuola` (`idscuola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impiega`
--

LOCK TABLES `impiega` WRITE;
/*!40000 ALTER TABLE `impiega` DISABLE KEYS */;
/*!40000 ALTER TABLE `impiega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `include`
--

DROP TABLE IF EXISTS `include`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `include` (
  `sezione_idsezione` int NOT NULL,
  `alunno_idalunno` int NOT NULL,
  `data_inizio` datetime DEFAULT NULL,
  `data_fine` datetime DEFAULT NULL,
  PRIMARY KEY (`sezione_idsezione`,`alunno_idalunno`),
  KEY `fk_sezione_has_alunno_alunno1_idx` (`alunno_idalunno`),
  KEY `fk_sezione_has_alunno_sezione1_idx` (`sezione_idsezione`),
  CONSTRAINT `fk_sezione_has_alunno_alunno1` FOREIGN KEY (`alunno_idalunno`) REFERENCES `alunno` (`idalunno`),
  CONSTRAINT `fk_sezione_has_alunno_sezione1` FOREIGN KEY (`sezione_idsezione`) REFERENCES `sezione` (`idsezione`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `include`
--

LOCK TABLES `include` WRITE;
/*!40000 ALTER TABLE `include` DISABLE KEYS */;
/*!40000 ALTER TABLE `include` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lezione`
--

DROP TABLE IF EXISTS `lezione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lezione` (
  `idlezione` int NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `professore_idprofessore` int NOT NULL,
  `sezione_idsezione` int NOT NULL,
  `titolo` varchar(45) DEFAULT NULL,
  `trascrizione` longtext,
  `wp_post_id` bigint unsigned DEFAULT NULL,
  `materia_idmateria` int NOT NULL,
  `argomento_idargomento` int NOT NULL,
  PRIMARY KEY (`idlezione`),
  KEY `fk_lezione_professore1_idx` (`professore_idprofessore`),
  KEY `fk_lezione_sezione1_idx` (`sezione_idsezione`),
  KEY `fk_wp_id1` (`wp_post_id`),
  KEY `fk_materia_idmateria1` (`materia_idmateria`),
  KEY `fk_argomento_idargomento` (`argomento_idargomento`),
  CONSTRAINT `fk_argomento_idargomento` FOREIGN KEY (`argomento_idargomento`) REFERENCES `argomento` (`idargomento`),
  CONSTRAINT `fk_lezione_professore1` FOREIGN KEY (`professore_idprofessore`) REFERENCES `professore` (`idprofessore`),
  CONSTRAINT `fk_lezione_sezione1` FOREIGN KEY (`sezione_idsezione`) REFERENCES `sezione` (`idsezione`),
  CONSTRAINT `fk_materia_idmateria1` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`),
  CONSTRAINT `fk_wp_id1` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lezione`
--

LOCK TABLES `lezione` WRITE;
/*!40000 ALTER TABLE `lezione` DISABLE KEYS */;
INSERT INTO `lezione` VALUES (2,'2021-01-16',1,1,'Titolo di prova','bla bla bla bla ',279,1,1),(3,'2021-01-16',1,1,'Titolo di prova','Questa è una lezione presentare la aggiornamento dei contenuti si EBBENE QUINDI ALLORA ',280,1,1),(4,'2021-01-16',1,1,'Titolo di prova','quindi questa è una lezione nuova di zecca Per testare anche l\'inserimento di contenuti con la data di accettazione  Emil  Emilia  automobili  automobili automobili automobili automobili  automobili ',281,1,1),(5,'2021-01-16',1,1,'Titolo di prova','ultima prova per adesso ',282,1,1),(6,'2021-01-16',1,1,'Titolo di prova','ultima lezione per adesso ',283,1,1);
/*!40000 ALTER TABLE `lezione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materia`
--

DROP TABLE IF EXISTS `materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materia` (
  `idmateria` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`idmateria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materia`
--

LOCK TABLES `materia` WRITE;
/*!40000 ALTER TABLE `materia` DISABLE KEYS */;
INSERT INTO `materia` VALUES (1,'matematica'),(2,'fisica'),(3,'geometria');
/*!40000 ALTER TABLE `materia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professore`
--

DROP TABLE IF EXISTS `professore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professore` (
  `idprofessore` int NOT NULL AUTO_INCREMENT,
  `utente_idutente` int NOT NULL,
  PRIMARY KEY (`idprofessore`,`utente_idutente`),
  KEY `fk_professore_utente1_idx` (`utente_idutente`),
  CONSTRAINT `fk_professore_utente1` FOREIGN KEY (`utente_idutente`) REFERENCES `utente` (`idutente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professore`
--

LOCK TABLES `professore` WRITE;
/*!40000 ALTER TABLE `professore` DISABLE KEYS */;
INSERT INTO `professore` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `professore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scuola`
--

DROP TABLE IF EXISTS `scuola`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scuola` (
  `idscuola` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `indirizzo` varchar(500) NOT NULL,
  `codice` varchar(12) NOT NULL,
  PRIMARY KEY (`idscuola`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scuola`
--

LOCK TABLES `scuola` WRITE;
/*!40000 ALTER TABLE `scuola` DISABLE KEYS */;
INSERT INTO `scuola` VALUES (1,'scuola1','si','no');
/*!40000 ALTER TABLE `scuola` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sezione`
--

DROP TABLE IF EXISTS `sezione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sezione` (
  `idsezione` int NOT NULL AUTO_INCREMENT,
  `lettera` varchar(2) NOT NULL,
  `anno` int NOT NULL,
  `persorso_di_studi` varchar(200) NOT NULL,
  `scuola_idscuola` int NOT NULL,
  PRIMARY KEY (`idsezione`),
  KEY `fk_sezione_scuola1_idx` (`scuola_idscuola`),
  CONSTRAINT `fk_sezione_scuola1` FOREIGN KEY (`scuola_idscuola`) REFERENCES `scuola` (`idscuola`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sezione`
--

LOCK TABLES `sezione` WRITE;
/*!40000 ALTER TABLE `sezione` DISABLE KEYS */;
INSERT INTO `sezione` VALUES (1,'O',5,'no',1),(2,'F',2,'si',1);
/*!40000 ALTER TABLE `sezione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_di_scuola`
--

DROP TABLE IF EXISTS `tipo_di_scuola`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_di_scuola` (
  `idtipo_di_scuola` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  PRIMARY KEY (`idtipo_di_scuola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_di_scuola`
--

LOCK TABLES `tipo_di_scuola` WRITE;
/*!40000 ALTER TABLE `tipo_di_scuola` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_di_scuola` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `idutente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `cf` varchar(16) NOT NULL,
  `email` varchar(200) NOT NULL,
  `indirizzo` varchar(500) NOT NULL,
  `wp_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`idutente`),
  UNIQUE KEY `wp_id` (`wp_id`),
  KEY `fk_wp_id1_idx` (`wp_id`),
  CONSTRAINT `fk_wp_id` FOREIGN KEY (`wp_id`) REFERENCES `wp_users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES (1,'anto','mo','fsda','mail','fa',1),(2,'fads','fasd','dsaf','fdas','fdas',2);
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-16 15:58:40
