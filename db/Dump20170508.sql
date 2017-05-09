-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: avia
-- ------------------------------------------------------
-- Server version	5.7.17-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `date_depart` bigint(20) NOT NULL,
  `date_come` bigint(20) NOT NULL,
  `aircraft_id` bigint(20) NOT NULL,
  `city_from_id` bigint(20) NOT NULL,
  `city_to_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_UNIQUE` (`code`),
  KEY `fk_aircraft_idx` (`aircraft_id`),
  KEY `fk_city_idx` (`city_from_id`),
  KEY `fk_city_to_idx` (`city_to_id`),
  CONSTRAINT `fk_aircraft` FOREIGN KEY (`aircraft_id`) REFERENCES `spr_aircraft` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_city_from` FOREIGN KEY (`city_from_id`) REFERENCES `spr_city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_city_to` FOREIGN KEY (`city_to_id`) REFERENCES `spr_city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (1,'SO-329',1488445500000,1488455400000,1,1,2),(2,'RFF-96',1488418500000,1488423900000,2,1,2),(3,'DV-723',1488375900000,1488390600000,3,8,6),(4,'ZA-2110',1488330600000,1488339000000,1,8,6),(5,'WSA-55',1488445800000,1488453900000,3,1,2);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `passenger` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `given_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `family_name` varchar(255) NOT NULL,
  `document_number` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (7,'–ò–≤–∞–Ω','–ò–≤–∞–Ω–æ–≤–∏—á','–ò–≤–∞–Ω–æ–≤','123456789','ivan@ivan.ivan','+987654321'),(8,'–ü–µ—Ç—Ä','–ü–µ—Ç—Ä–æ–≤–∏—á','–ü–µ—Ç—Ä–æ–≤','87654321','petr@petr.petr','+123456789'),(9,'–ù–∏–∫–æ–ª–∞–π','–ù–∏–∫–æ–ª–∞–µ–≤–∏—á','–ù–∏–∫–æ–ª–∞–µ–≤','123456789','nic@nic.nic','+987654321');
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flight_id` bigint(20) NOT NULL,
  `passenger_id` bigint(20) NOT NULL,
  `place_id` bigint(20) NOT NULL,
  `add_info` varchar(100) DEFAULT NULL,
  `reserve_datetime` bigint(20) NOT NULL,
  `code` varchar(45) NOT NULL COMMENT '—É–Ω–∏–∫–∞–ª—å–Ω—ã–π –Ω–æ–º–µ—Ä –ø–æ—Å–ª–µ –ø–æ–∫—É–ø–∫–∏',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  UNIQUE KEY `idx_reserve` (`flight_id`,`passenger_id`),
  KEY `fk_passenger_idx` (`passenger_id`),
  KEY `fk_place_idx` (`place_id`),
  CONSTRAINT `fk_flight` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_passenger` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_place` FOREIGN KEY (`place_id`) REFERENCES `spr_place` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (15,3,7,21,'–° –æ–±–µ–¥–æ–º!',1494287682914,'5512ec16-a121-4984-8c21-3380ca3fb632'),(16,1,8,6,'–ë–µ–∑ –ø–∏—Ç–∞–Ω–∏—è!',1494288017184,'05e0de69-6ecd-4d0d-b23f-36001c6b5c86'),(17,5,9,21,'–° –ø–∏—Ç–∞–Ω–∏–µ–º.',1494335463627,'38fb51ff-1f8b-4efe-bc34-39856fd13df8');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spr_aircraft`
--

DROP TABLE IF EXISTS `spr_aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spr_aircraft` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `company_id` bigint(20) NOT NULL,
  `desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_company_idx` (`company_id`),
  CONSTRAINT `fk_company` FOREIGN KEY (`company_id`) REFERENCES `spr_company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spr_aircraft`
--

LOCK TABLES `spr_aircraft` WRITE;
/*!40000 ALTER TABLE `spr_aircraft` DISABLE KEYS */;
INSERT INTO `spr_aircraft` VALUES (1,'AN-124',1,NULL),(2,'Boeing 757',1,NULL),(3,'Airbus A320',2,NULL);
/*!40000 ALTER TABLE `spr_aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spr_aircraft_place`
--

DROP TABLE IF EXISTS `spr_aircraft_place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spr_aircraft_place` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `aircraft_id` bigint(20) NOT NULL,
  `place_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_aircraft_id_idx` (`aircraft_id`),
  KEY `fk_place_id_idx` (`place_id`),
  CONSTRAINT `fk_aircraft_id` FOREIGN KEY (`aircraft_id`) REFERENCES `spr_aircraft` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_place_id` FOREIGN KEY (`place_id`) REFERENCES `spr_place` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='—Ç–∞–±–ª–∏—Ü–∞ —Å–≤—è–∑—ã–≤–∞–µ—Ç —Å–∞–º–æ–ª–µ—Ç –∏ –µ–≥–æ –º–µ—Å—Ç–∞ (—Å–≤—è–∑—å "–º–Ω–æ–≥–æ –∫–æ –º–Ω–æ–≥–∏–º")';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spr_aircraft_place`
--

LOCK TABLES `spr_aircraft_place` WRITE;
/*!40000 ALTER TABLE `spr_aircraft_place` DISABLE KEYS */;
INSERT INTO `spr_aircraft_place` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,2,1),(22,2,2),(23,2,3),(24,2,4),(25,2,5),(26,2,6),(27,2,7),(28,2,8),(29,2,9),(30,2,10),(31,2,11),(32,2,12),(33,2,13),(34,2,14),(35,2,15),(36,2,16),(37,2,17),(38,2,18),(39,2,19),(40,2,20),(41,2,21),(42,2,22),(43,2,23),(44,2,24),(45,3,1),(46,3,2),(47,3,3),(48,3,4),(49,3,5),(50,3,6),(51,3,7),(52,3,8),(53,3,9),(54,3,10),(55,3,11),(56,3,12),(57,3,13),(58,3,14),(59,3,15),(60,3,16),(61,3,17),(62,3,18),(63,3,19),(64,3,20),(65,3,21),(66,3,22),(67,3,23),(68,3,24);
/*!40000 ALTER TABLE `spr_aircraft_place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spr_city`
--

DROP TABLE IF EXISTS `spr_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spr_city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `country_id` varchar(45) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `UNIQUE1` (`name`,`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spr_city`
--

LOCK TABLES `spr_city` WRITE;
/*!40000 ALTER TABLE `spr_city` DISABLE KEYS */;
INSERT INTO `spr_city` VALUES (1,'–ú–æ—Å–∫–≤–∞','1','MOS',NULL),(2,'–õ–æ—Å-–ê–Ω–¥–∂–µ–ª–µ—Å','3','LA',NULL),(3,'–ö–∏–µ–≤','2','KY',NULL),(6,'–°–∞–Ω-–•–æ—Å–µ','3','SJ',NULL),(7,'–¢–æ–º—Å–∫','1','TOM',NULL),(8,'–ê—Å—Ç–∞–Ω–∞','4','AST',NULL);
/*!40000 ALTER TABLE `spr_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spr_company`
--

DROP TABLE IF EXISTS `spr_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spr_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spr_company`
--

LOCK TABLES `spr_company` WRITE;
/*!40000 ALTER TABLE `spr_company` DISABLE KEYS */;
INSERT INTO `spr_company` VALUES (1,'America Airlines',NULL),(2,'–ê—ç—Ä–æ—Ñ–ª–æ—Ç',NULL);
/*!40000 ALTER TABLE `spr_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spr_country`
--

DROP TABLE IF EXISTS `spr_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spr_country` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `code` varchar(45) NOT NULL COMMENT '—Å–æ–∫—Ä–∞—â–µ–Ω–Ω—ã–π –∫–æ–¥ —Å—Ç—Ä–∞–Ω—ã',
  `flag` blob,
  `desc` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spr_country`
--

LOCK TABLES `spr_country` WRITE;
/*!40000 ALTER TABLE `spr_country` DISABLE KEYS */;
INSERT INTO `spr_country` VALUES (1,'–†–æ—Å—Å–∏—è','RUS','âPNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0?ˇj\0\0\0	pHYs\0\0á\0\0áè\ÂÒe\0\0\0tIME\ﬁûkîG\0\0\0tEXtAuthor\0©Æ\ÃH\0\0\0tEXtDescription\0	!#\0\0\0\ntEXtCopyright\0¨\Ã:\0\0\0tEXtCreation time\05˜	\0\0\0	tEXtSoftware\0]pˇ:\0\0\0tEXtDisclaimer\0∑¿¥è\0\0\0tEXtWarning\0¿\Êá\0\0\0tEXtSource\0ıˇÉ\Î\0\0\0tEXtComment\0ˆÃñø\0\0\0tEXtTitle\0®\Ó\“\'\0\0\ÿIDATHâ≈î?nQ∆øof,åMñ9ÑØ`.\0A¢£D49@\n∑\‚\nt‹ÄÜ2}⁄àD±d\„}\≈˙9ª\ÎÑ8q\Ï<i¥ª\Ô\œ¸f\ﬁ|;ú\œÁØ¶\”\È;3s\0\ƒá$ë<õ\Õfá1\Zç\'ì\…\Îà\ÿ%s5ä¢\0ÄìààaD¿\›˜\Óızp˜ÅÌÖ∂>¯X`πS=\›ñÙ(\‡8>Ni0X$w°ô¸mëp[\Ã\›u3†,+úûJqtd\÷Ôªπ;\Ãj†Ym\Õ\0§\Zv†te˘\\U./\…\0)[\r õsf\Ÿ6ïCˆq\√*\0`≠k\‰U’Ü\›GÉ\Õ\0∫¡DÜ5≥‹áﬁ¨ﬁ§Üõéˇ˘±Ê¶áÇ^\Á£;Ä%Il)87ñ,∏-¬∏\Ê[ä\œÒoûºó\ÎJ∂m+\Êz\r\ÀT\·CıÒºˇá/áÛ\ÊOL\0\‡\’Û~‘ú\\~ë˙ãí¡°/´\Ó\—Õñ¨l\ \œ{•%<Cà`\"X¬û˚÷Äoï±\Z•\Õ$Ç\"\Ï<0`\Ï\Îı\Zªs\€P\02\0	êÅ?aå£ì\ÈCÄj^]ªÅJ\‡S\"\Œˆ∑\Z;Ñ\Œ\Îû\–&ºU\Îz2\…PòïÒÒ{Ò\È\€O-\‹\\\¬\Î\“\÷\‘-4Ω|AKëù_\Ë\Ï\ÀI˘ıòÙ˙Æ3&©≠\0\0\0\0IENDÆB`Ç',NULL),(2,'–£–∫—Ä–∞–∏–Ω–∞','UKR','âPNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0áÆΩ|\0\0\0	pHYs\0\0\r\◊\0\0\r\◊B(õx\0\0\0tIME\ﬁ9∂i,\Ÿ\0\0\0tEXtAuthor\0©Æ\ÃH\0\0\0tEXtDescription\0	!#\0\0\0\ntEXtCopyright\0¨\Ã:\0\0\0tEXtCreation time\05˜	\0\0\0	tEXtSoftware\0]pˇ:\0\0\0tEXtDisclaimer\0∑¿¥è\0\0\0tEXtWarning\0¿\Êá\0\0\0tEXtSource\0ıˇÉ\Î\0\0\0tEXtComment\0ˆÃñø\0\0\0tEXtTitle\0®\Ó\“\'\0\0\03IDATHâc¥*=Úüa\0\0\”@X:jÒ®≈£S∞§Y,\Zã\ﬁ-πF-µx\‘b≤\0\0Òˇ\ƒjy‘û\0\0\0\0IENDÆB`Ç',NULL),(3,'–°–®–ê','USA','ˇ\ÿˇ\‡\0JFIF\0\0,,\0\0ˇ˛\0LEAD Technologies Inc. V1.01\0ˇ\€\0Ñ\0			\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\n\n\r\n\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rˇ\ƒ¢\0\0\0\0\0\0\0\0\0\0	\n\0\0\0\0\0\0\0	\n\0\0\0}\0!1AQa\"q2Åë°#B±¡R\—$3brÇ	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzÉÑÖÜáàâäíìîïñóòôö¢£§•¶ß®©™≤≥¥µ∂∑∏π∫\¬\√\ƒ\≈\∆\«\»\…\ \“\”\‘\’\÷\◊\ÿ\Ÿ\⁄\·\‚\„\‰\Â\Ê\Á\Ë\È\ÍÒÚÛÙıˆ˜¯˘˙\0\0w\0!1AQaq\"2ÅBë°±¡	#3Rbr\—\n$4\·%Ò\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzÇÉÑÖÜáàâäíìîïñóòôö¢£§•¶ß®©™≤≥¥µ∂∑∏π∫\¬\√\ƒ\≈\∆\«\»\…\ \“\”\‘\’\÷\◊\ÿ\Ÿ\⁄\‚\„\‰\Â\Ê\Á\Ë\È\ÍÚÛÙıˆ˜¯˘˙ˇ¿\0\0\0\0ˇ\⁄\0\0\0?\0Ò\À;Hö…çC\ íV<\À<íOóèêì∫<$æj\rW\Î\Ô˙\Ôˇ\0Ø}¨˘;øØ\Î˙ˇ\0Å\—¯R\⁄\—5HÑ\…i\Â\Â\œ\⁄bù\·\Œ\’€ëj\ZB\ÿ¡C\Ê#\Ê˝\Íë3˘∏\ﬂ\‡ª\€\‚é˜Û\ÌØ\·˜l{y_?\÷?u\Ìyπe¸)Rå˛˙\ﬁ\Âªı\Ïz˜\ŸÙ˘\Á°\‡&±˛5Ú\⁄w\Óë˜?\Ì=Òˇ\0¯7˛DS[\È\·4>Ω≠u\Íh\”˚øtàó\÷mæ;ˇ\0\‡»ßÄ¥\ÿ\—QmÆ®\0/ˆŒèååc\…¡n\»?{Õüv|˘∑˚_©¸±˚ˇ\0˚o\ÍÀ≤>O˚2ó˝\œˇ\0Ò?¸â£¶¯Z\ﬂH∏[\À8Ø\"ùîH∫ÊîØá\∆\·πcwñ\…˘òñl±$\„W:±ˆräJ\È˚≤I\ÈÛgM\r,<˘\›USFπj`1RéΩme™\Ët\ﬁ}˜¸Ù\‘°”ø¯ö\‡\◊\œˇ\0Gß\…G˘0ø¯l\≈ôÛ\ﬁ\Ìˇ\0Y®ı\Ô\‚\r<˙˚QØü˛âp£¸òo¸6\‚ó\Íx\–Òı\œ¸˘i?¯.∂ˇ\0\‚+üü\ ?¯\n>\„˚.Ûˇ\0ˇ\0ÖUø˘ ˇ\0Ñ˙\Á˛|¥ü¸[Òs˘Gˇ\0A˝ó˘ˇ\0ãˇ\0¬™\ﬂ¸ê\¬}sˇ\0>ZO˛≠ø¯ä9¸£ˇ\0Ä†˛Àá¸ˇ\0\≈ˇ\0\·Uo˛Hdû<πaè±iC\Èß[˝íé(˝»âeêK¯¯ø¸*≠ˇ\0\…ˇ\Ÿ',NULL),(4,'–ö–∞–∑–∞—Ö—Å—Ç–∞–Ω','KAZ','âPNG\r\n\Z\n\0\0\0\rIHDR\0\0\0=\0\0\0 \0\0\0°*p¨\0\0\0sRGB\0Æ\Œ\È\0\0\0gAMA\0\0±è¸a\0\0\0	pHYs\0\0\√\0\0\√\«o®d\0\0\0tEXtSoftware\0paint.net 4.0.16DiØı\0\0\„IDATXG\ÂYitU\’~ô&±âRáàl0Äñ™\≈EÈ≤ïRÈ™∫tµ\nZ( àI\ﬁ\ÀKÚx”ΩoHàÅêC D•\’vπ\ƒ%t\€’Æ∂Z\À∞\ÿ~˝ˆ9˜a≤\Ï/iˇ\‘{ù{\œ=g\Ô˝\Ì\È\ÏÛû\r¿óé˛\„\‰ˇ;]}ò±∫3Û]òí_Ç{\Ï•\»)61\…\¬E[\›\ÓäÍ±®∑;j9n%U\·NG&⁄´0©†w\⁄\Îê\≈\ÔYN˘V\√˜\Zdl%Ò{°¨ïy˝-∂ˇvgeT®oö‰πÇ\ÎkpWA-\Ó Ø\√\ƒ\¬:\‹!2I2\ﬁ\·®Q$¸e\›$ÆõX®\Á5\Ô\ZL\ÿTI’äWˆF\ﬂ\ŒÛj?\–9v˜FÇòlnƒ∑™Úêm\‰!\”]Öaû6ECΩmH7v+\Z\Ím\«PO˘\⁄\rÛ¥c8\◊˜\ÏV4\Ã€™\Êd\›oü;0\‹›Å\Î\›¬´\Èæ˝Hı\ÔG∫ü\ﬂ}≠ä˜ÆMıw \≈\ÿ\À˘ı.\Îo\ÿ\‹∆ë¸π∏{Ø\Zµ>≠\‹\À}§˛:\ ˚ øØÛ\Ì\≈u\"\ﬂﬂÇ\Ã\Õuò\\˙\Ó\"\Ê4xq_ısX|(õ?\Ï\∆ı˛≠H4!¡8[\‡l\·ä\‚\Ãn\ﬂ2òœáπÜ\Î{5ôzç\⁄îuGaã≠^Ê´ú#eM∑ö∑ô\\\"Öe\‰\Z\Ó>â\Ê~é≤\Ê0˝G\’(\Ôq\Í\"˚Q\ﬂıúE\‰8õ\Á\0\‚\√\›\Ï›Ö[\ÀÇûR∏	˘\ÔU\‚ßG\√zå?V#\√• Qí\–“ÄµÚTêÄ\‚\◊hC\ƒ!	\Ë	ÆO\‡\⁄dÚLˆ≤\ \—ˇ*Höü,rb\0ÑØ\Êo\ÈrïØ\»}¥Ñ\ƒP1#\≈{è\"-Ù:lFΩ›â	ˆÍÅ†s\nÛ»∂ßP¸\Œ2º∏\Ô!îæ[åLoH)¶ïà)¢=£\ÊEIíM\“\nıWö£(ÛÄ|\„\Zú\‚\Ôæ\ZEbŸØ\"AEà8dë\‚cÒV$\ÔüÒ÷ëßüUt\›JF≤ßI\ﬁ^Z\“%ã˘=\0Ù{!6úå |÷Ö⁄≥πXb#FyMz\‡ 7ëL=\ {íØ[ëç\Ãm¢§ˇàˆÇ(,\ÏQ{íB˚˘≠ù¥óﬂª∏æK)i#Øx	eC\Ê$5:êÿá$\ R\‡eü\"yæ\\\€œêqÅ˝âAπ∆ö\‡\…4jäè¿	^dIûKq\0z ÜB<Z∑/^É\‚„ã∞\ÈM\'n5`Rº\0∂<\‹?4u\Ëâ\"±Q¨n=\”0âúè˜\ÔAJ\‰⁄Å\‘\».k\ƒ\‡\ËN1kÒïÚFÆ©ErY3í\¬m∞y_A\ZÅ%zc9J0aÚ\ÍZá±µFy\›˙\∆ı˝Åã\◊%j˘[?zZ°≥´1\”3é◊ü\≈õ~Ç°Å®D/™ú≤B8ñ_íãR\\¥r¥8-*\∆Hı&EJ†W+\—‹ãAÅù\»zπ\Z\√JW#3¯f∂¯Ò˝ÆlÒ‡ÆùyënE´zí\“\»Kr_\ÂzêrÖ¨ÙPip\’\Ë2\'ÖÒu\Â(˙™‘≤r[\"\∆-\«\ÿ\0\–S\Ì%\ÿ¯ˆnÃØ\’*ƒíû\’&†Éd¢º\'§ÖjØ27}Gu°S˘ßAK§{^E*\…\Ê>àîPè¢zå//C\Œ\÷u®˙§≥Ãôx¢\·<µm\ZTŒÑ\„7A\‹\Ï{ÜGéáÜjBzxçGO)˛R\‡b¿E∂6∏Æ1G\Á<Và£\0WQ°C^•ë\›ˆy\–\”∏œø\0\€˙¢¯\·\÷)Xﬁõãëæà\nè∏`á\"9>Da$VN!%I\«rX¬äsâæcÙ\–1•Pí—ÑØ¯]XÛõ6¨\Ó^â\Ëè‚ùæ\Ô\‚w}ìÒ\«O&\„Ã•o\√8ÚºßúXy∫◊õvƒõ\r\"\È$—§¡)cã\√\‹*û\ 	hì†É˝@\ÀÒ\Z;A8J?!ç\Õ\0\–\Ÿ˘ypûÆ∆ìØ,@ıáv,9Ù2:Ö\·ñ¿\"îlC≤ŸÅdÇ÷°\≈Ä*g(ú˘$EE\Â\ZΩg0‹ºá04“Äª\ÎK≥\„/°\‰¿,¸˙\‚\\Ù]\ZÙ%\0ó\‚p\·\¬H|¿πı\rw¢\‡ù\Ã\Ó\n -Z[ôÑ≥Æ\Ê1C\0M¿±Z¢\"A\‰ô$â\Â\Ìi\r˙Aw|ÙtØ9°ï\»v\œ≈Ü7_¿c\Ì´0\¬!Hzó9ôH¿j$H%û\‘\·\'ñ\÷\n\ \Ze)tÙê4©û\nÃ¨[K/?Ç\◊ˇ2\Á.è¡ïÛ\È¿˘xí\rW.$\·\‚\≈Lºw\ÓA¨hõã\Ô\Ïq\"\ﬁWFûR\È≈ê“†t®¶G1zü\∆V\∆\ÁúZ\ﬁc§ÛXWuı\Ã9âí!ﬁΩ]7Ù\ƒB;\Ê\‘n¿ ì≥ûE(8aXπi√≠S1R^\∆WA[ÖLÚJye?C^\⁄\Ãˆ5≥ùld\—2∞\Í\Ì2\‰˜<Ñ≥ˇºó.•\—√§ø\«\—\€q¯\◊._L\≈\Ô/O\√\¬mì∞ˆΩZ\‹Xf2m∂#\’‹ç≥…ÅVm⁄´Z{?\÷ä§R+\‚≥8GtQ¢æ\“6K\œ>\0Ù4\«&\ÿ\ﬂ6\—|%å¶è\ﬁVbî$ûìA±2√Öáº\0TyKJ\·ª*dﬁÉ¥,[æ`ØÚÙ\ﬂ<|∞_\ﬂf\‡6\ﬂR,;∫°∑~Ñ”óg\·\„æ\Ì\Èã\…\0\ Ò¸\Âº\€w?‹ø|kO˘ë\Âc\‹˘∏°\ÿ\≈cs+\Â4\“L1	mèOÜ∞\»SµÖé\Ëe}å\≈\Íã›≠\Ór9\0:«±ﬂ´ZÄÕßû\«\ 6ñﬂÖë)û–±¡d≥A´\È<ìÖ\’YÄ´y\…m\Z\ƒ|ôÜOø\—˜ü\€Òıí\Ÿ¯Fîˇ¡ÅH\Ô\◊€ã\”ÒQ\ﬂm8wn$Æ|2öF∏g˛~7\ _œÜˇl>¶G\Á·â∂•|\ÿ	\Á\ﬂ\ﬁGÜø\nÉ\ËÒ—ÅGYBXåK\"Òº\0RÄ-\–*˜\È eê~Ûr!ë\‹\0\–\”ë˜´^8æ[\ﬁ/@\—{å4\¬\Z¥TA\Î\ÏF\"H∫2©\‡)AzÄ\n\ŸL°ù\ÌR<u¢Ú\¬Û\ÓzdGc¡¡¨\ÌiDÒ ~yi>~˚\Èwp˙¸∑p™o>∂æı\0Vu\Õ√¢&x~\0\„\Ã3(|s1\Ó®FzI\r\“ùå&÷ìÄtj\‘¡◊•:9vM†ß\⁄Û0∑vû\Ì^Ü•mÛ\·9[Öë¶\Âi©Ç™”ëº&≈ò±çL`K)^W\·TF\ÔóÒöÆ¿\√˚#h<\Á\∆o\∆ybBuf\ÔXé‹üØ≈¢¶˚Ò≥\›9xq˜L¨Ìúã\ÕgÚ1ømnt?áávΩà\¬s∞\ÎR&Uc0Û9û-™ç5%\ƒ\–\Êsäxõ≤ØÙ^8¶1+4;˛∫	\À{~äQ¶«™ööâj§ÄX\Ã\Ë˝¯ \€T∂å\¬\\∫/\ÔÀâÆ\‹ƒ≥π\‰\‘F<V˜\0æ\ŸTÑ±°RL¨,\≈WΩ+1¡XÅ\ÎÛÒxèü\’⁄Å\…/\ÁaLp%näÆ¡‘™\√~Ú\«h¸G2åÚnQ2Dñç˜\Ô8Çñ\¬oˆrº\∆ûb\œG\Ó\€;±\Ë\‡24ü∑#˜\ƒ*å\nlFb∞\”Ú∞¨@ìë>\Œ`\„ïzçπ}D}:Ü\·æ*|\Õ˚#\‘\‚\0&ï\Ác§ßSõ\Î1.\‰\√HWæ\Zv0}Ú0æ™££Ndòπ∏%≤è(F›ßÌò±\ÂY\\⁄Çƒ®PFõó!n8åR∂W\0\Ès˙ö@\Áó`vm.mYåMØ>ç%˚ócd¿ß@´Nå$ïYF\›	Q®U%u\Ô˚ö™\Ó\Í%a\Ëk\ƒ#ÑÃêÛNÙ`FkΩÚ\‹˝\Ã\”g^\«0∂#ªﬁçY{k∞-∏”ª∑¡u\·-dïπpùaî5ìwßä†¥(=Kæ6°\nú∑\Î*\»/zRû\À\ﬁh¡å\»c(˚¿Ög∫\÷bD¿T†•AI6Ù\’OºÆZB	1	m*\'Õæ¡{kà†E1π|Ñ\ÿ?˜\—P\Õ\ÍØ\ƒ3å·Üâú\ÊJÇÆ\¬}[ó\‚ñ¿Û∏5º˜\’\ÿÒΩ\÷ nÛ¨\¬8≥î\›\”v\’®£í—î,ùòá\◊OiM\Â\ÿ2YGX\‘\ÿ5Åæß(HOóc≤	û?¯<¥.\«@à¿∫x„ë∞&XutIèÖ∑&\’´Ö\œR–î\"l=H`X¶J\√b\Ï\Ê≈£c+j1ﬁª°+\'ºtûè{Ò\‰Ò=∏£≤Cçr}&´º•\“R4≠\¬˘Y€©A)yJ\÷ùΩ…ç\';1o\ÁzÑ>`q\œ:Ç(–©º\‰+\–\"H5Ún	\–\05syè)!$W\√\‘[UiQ\≈3æN§Û21\¬a¨±∑xñ\"\ÀxÅ=æi\Ó*ﬁ∞ˆX!Ã≥?\‘K\ﬁb@ Ú˛†\'\‰cqóè5<Å\Â≠sP˛QC\“\≈\Ì∏\n:N*πxõ\n\Ëﬂ∫∫ë\Í;†~˙ëgaÆîRM\√aué\«Ûª-¿\–ÛlÉy[ëa[\ÈØAzêçG@w\\©ú\ pég\Œ\⁄|\"C\0\ƒ@Zd5#í>*Ö§¶˝Éû\‚\»\√Ú#N,lôá\‚cﬂá˘~	=\‚DRp˚_M´[\rææÚU?\«h\’\ÔíTQS†u\Œ\'≥sRG\r€ò\ﬂÚ´§>\‚ò\Ôe\\£\⁄[\·yÄ`ªê\ƒDjáÚ∂JÒ\“ ÑDye\ÿˇ\Ël{.^<\È\√B6&N\ﬁy\À?\nbîøòÖ®˝3\–V#_%\Ã¢\"@)CÅ´πTtÜ≥-$çE\‚£ÚìSó\Í\‡$\‰\„\Ÿ\¬&∞8	œÑ √ô^LcENópéàÒx¡P¿t^À©ë\‚\◊éArM†ßñ:¯>\Ó	?ÇıoÆE\Ë¸ıôX>âVó\‹RøìëA\ÏF\”_H¥¶\Ó\”,nÚìqîÛl#\√ë»∞çs±£íê\‘`\œª	â\‚\…Çbã©\"É¸`πIY†u*i@:‹Øt∂√áπù{0qGé7bj}9Ô†çß7i\Î2ﬂ®å\Í\Ã,–∫\ÿ\Ë9•<ãW,\nl¢ CP~›åsu ç≠\„\‡oG™Z\ﬁC˙é \… ©_A\≈H\Ã]Ò>y\nXµé\0E•è∂Ú˚ö@ﬂªémbQ\0∑î¯q´≥∑ó¯ps\—\À\Ô‹Ö1•\r\»‹º#\‹/#\√]á±%ı∏â$\„\ÿ\“\Ì|ﬁéÒ≈ú+n\"\Ì\"5X\ﬂ0Æ¥79w \À’Ñõù\Ï»äw`\◊g∫w\"£t\∆mn\¬¯í\›\Ál¶ú\Ì\Ì⁄éKö1∫∏˘™å\—\"\ﬂEûä\Áö0FàÛB\"GHøsΩ´^çü\Õ◊´ˇ\◊\Ó\Õ˝\Â!\ÿ˛\rû€≤;ÜIq\0\0\0\0IENDÆB`Ç',NULL);
/*!40000 ALTER TABLE `spr_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spr_flight_class`
--

DROP TABLE IF EXISTS `spr_flight_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spr_flight_class` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spr_flight_class`
--

LOCK TABLES `spr_flight_class` WRITE;
/*!40000 ALTER TABLE `spr_flight_class` DISABLE KEYS */;
INSERT INTO `spr_flight_class` VALUES (1,'–≠–∫–æ–Ω–æ–º','–ë–µ–∑ –≤—ã–±–æ—Ä–∞ –º–µ–Ω—é'),(2,'–ë–∏–∑–Ω–µ—Å','–û–±–µ–¥ –Ω–∞ –≤—ã–±–æ—Ä, –±–æ–ª—å—à–µ –º–µ—Å—Ç–∞');
/*!40000 ALTER TABLE `spr_flight_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spr_place`
--

DROP TABLE IF EXISTS `spr_place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spr_place` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `seat_letter` char(1) NOT NULL,
  `seat_number` int(100) NOT NULL,
  `flight_class_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_uniq1` (`seat_letter`,`seat_number`,`flight_class_id`),
  KEY `fk_flight_class_idx` (`flight_class_id`),
  CONSTRAINT `fk_flight_class` FOREIGN KEY (`flight_class_id`) REFERENCES `spr_flight_class` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spr_place`
--

LOCK TABLES `spr_place` WRITE;
/*!40000 ALTER TABLE `spr_place` DISABLE KEYS */;
INSERT INTO `spr_place` VALUES (1,'A',1,1),(2,'A',2,1),(3,'A',3,1),(4,'A',4,1),(5,'B',1,1),(6,'B',2,1),(7,'B',3,1),(8,'B',4,1),(9,'C',1,1),(10,'C',2,1),(11,'C',3,1),(12,'C',4,1),(13,'D',1,1),(14,'D',2,1),(15,'D',3,1),(16,'D',4,1),(17,'E',1,1),(18,'E',2,1),(19,'E',3,1),(20,'E',4,1),(21,'F',1,2),(22,'F',2,2),(23,'F',3,2),(24,'F',4,2);
/*!40000 ALTER TABLE `spr_place` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-09 23:22:32
