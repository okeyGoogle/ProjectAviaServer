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
INSERT INTO `passenger` VALUES (7,'Иван','Иванович','Иванов','123456789','ivan@ivan.ivan','+987654321'),(8,'Петр','Петрович','Петров','87654321','petr@petr.petr','+123456789'),(9,'Николай','Николаевич','Николаев','123456789','nic@nic.nic','+987654321');
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
  `code` varchar(45) NOT NULL COMMENT 'уникальный номер после покупки',
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
INSERT INTO `reservation` VALUES (15,3,7,21,'С обедом!',1494287682914,'5512ec16-a121-4984-8c21-3380ca3fb632'),(16,1,8,6,'Без питания!',1494288017184,'05e0de69-6ecd-4d0d-b23f-36001c6b5c86'),(17,5,9,21,'С питанием.',1494335463627,'38fb51ff-1f8b-4efe-bc34-39856fd13df8');
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='таблица связывает самолет и его места (связь "много ко многим")';
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
INSERT INTO `spr_city` VALUES (1,'Москва','1','MOS',NULL),(2,'Лос-Анджелес','3','LA',NULL),(3,'Киев','2','KY',NULL),(6,'Сан-Хосе','3','SJ',NULL),(7,'Томск','1','TOM',NULL),(8,'Астана','4','AST',NULL);
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
INSERT INTO `spr_company` VALUES (1,'America Airlines',NULL),(2,'Аэрофлот',NULL);
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
  `code` varchar(45) NOT NULL COMMENT 'сокращенный код страны',
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
INSERT INTO `spr_country` VALUES (1,'Россия','RUS','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0?�j\0\0\0	pHYs\0\0�\0\0��\��e\0\0\0tIME\��k�G\0\0\0tEXtAuthor\0��\�H\0\0\0tEXtDescription\0	!#\0\0\0\ntEXtCopyright\0�\�:\0\0\0tEXtCreation time\05�	\0\0\0	tEXtSoftware\0]p�:\0\0\0tEXtDisclaimer\0����\0\0\0tEXtWarning\0�\�\0\0\0tEXtSource\0���\�\0\0\0tEXtComment\0�̖�\0\0\0tEXtTitle\0�\�\�\'\0\0\�IDATH�Ŕ?nQƿof,�M�9��`.\0A��D49@\n�\�\nt܀�2}ڈD�d\�}\��9�\�8q\�<i��\�\��f\�|;�\�篦\�\�;3s\0\��$�<�\�f�1\Z�\'�\�\�\�%s5��\0����aD�\��\��zp��텶>�X`�S=\���(\�8>Ni0X$w���m�p[\�\�u3�,+��Jqtd\�ﻹ;\�j�Ym\�\0�\Zv�te�\\U./\�\0)[\rʛsf\�6�C�q\�*\0`�k\�UՆ\�G�\�\0��D�5�܇ެޤ������榇�^\�;�%Il)87�,�-¸\�[�\��o���\�J�m+\�z\r\�T\�C����/��\�OL\0\�\��~Ԝ\\~������/�\�\�͖�l\�\�{�%<C�`\"X�րo��\Z�\��$�\"\�<0`\�\��\Z�s\�P\02\0	��?a���\�C�j^]��J\�S\"\���\Z;�\�\�\�&�U\�z2\�P����{�\�\�O-\�\\\�\�\�\�\�-4�|AK��_\�\�\�I������3&��\0\0\0\0IEND�B`�',NULL),(2,'Украина','UKR','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0���|\0\0\0	pHYs\0\0\r\�\0\0\r\�B(�x\0\0\0tIME\�9�i,\�\0\0\0tEXtAuthor\0��\�H\0\0\0tEXtDescription\0	!#\0\0\0\ntEXtCopyright\0�\�:\0\0\0tEXtCreation time\05�	\0\0\0	tEXtSoftware\0]p�:\0\0\0tEXtDisclaimer\0����\0\0\0tEXtWarning\0�\�\0\0\0tEXtSource\0���\�\0\0\0tEXtComment\0�̖�\0\0\0tEXtTitle\0�\�\�\'\0\0\03IDATH�c�*=�a\0\0\�@X:j�ţS��Y,\Z�\�-�F-�x\�b�\0\0��\�jyԞ\0\0\0\0IEND�B`�',NULL),(3,'США','USA','�\��\�\0JFIF\0\0,,\0\0��\0LEAD Technologies Inc. V1.01\0�\�\0�\0			\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\n\n\r\n\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r�\��\0\0\0\0\0\0\0\0\0\0	\n\0\0\0\0\0\0\0	\n\0\0\0}\0!1AQa\"q2���#B��R\��$3br�	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz�����������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�����������\0\0w\0!1AQaq\"2�B����	#3R�br\�\n$4\�%�\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz������������������������������������\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\�\������������\0\0\0\0�\�\0\0\0?\0�\�;H�ɍC\��V<\�<�O�����<$�j\rW\�\��\��\0�}��;��\���\0�\��R\�\�5H�\�i\�\�\�\�b�\�\�\�ۑj\ZB\��C\�#\��\�3��\�\�\�\���\�\��l{y_?\�?u\�y�e�)R���\�\��\�z�\���\�\�&��5�\�w\��?\�=��\0�7�DS[\�\�4>��u\�h\���t��\�m�;�\0\�ȧ��\�\�Qm��\0/�Ώ��c\��n\�?{͟v|���_�����\0�o\�˲>O�2��\��\0�?�����Z\�H�[\�8�\"��H�支�\�\�cw�\����l�$\�W:��r�J\���I\��gM\r,<�\�USF�j`1R��me�\�t\�}���\��ӿ��\�\�\��\0G�\�G�0��l\���\�\��\0Y��\�\�\r<��Q����p���o�6\�\�x\���\���i?�.��\0\�+��\�?�\n>\��.��\0�\0�U�� �\0��\��|���[�s�G�\0A����\0��\0ª\���\�}s�\0>ZO�����9���\0���ˇ��\0\��\0\�Uo�Hd�<�a��iC\�[���(�ȉe�K����*��\0\��\�',NULL),(4,'Казахстан','KAZ','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0=\0\0\0 \0\0\0�*p�\0\0\0sRGB\0�\�\�\0\0\0gAMA\0\0���a\0\0\0	pHYs\0\0\�\0\0\�\�o�d\0\0\0tEXtSoftware\0paint.net 4.0.16Di��\0\0\�IDATXG\�YitU\�~�&��R��l0���\�E鲕R骺t�\nZ( �I\�\�K�xӽoH���C D�\�v�\�%t\�ծ�Z\��\�~��9�a�\�/i�\�{�{\�=g\��\�\�\��\r����\�\��;]}���3�]��_�{\�\�)61\�\�E[\�\��걨�;j9n%U\�NG&ګ0��w\�\�\�\�YN�V\��\Zdl%�{���y�-��vgeT�o�乂\�kpWA-\�ʯ\�\�\�:\�!2I2\�\�Q$�e\�$��X�\�5\�\ZL\�TIՊW�F\�\��j?\�9v�F��lnķ��m\�!\�]�a�6EC�mH7v+\Z\�m\�PO�\�\r�c8\��\�V4\�۪\�d\�o�;0\�݁\�\�«\��H�\�G��\�}����M�w \�\�\���.\�o\�\�Ƒ���{�\Z�>�\�\�}��:\�� ���\�\�u\"\�߂\�\�u�\\�\�\"\�4xq_�sX|(�?\�\����H4!�8[\�l\��\�\�n\�2�χ��\�{5�z�\��uGa��^櫜#eM����\\\"�e\�\Z\�>�\�~��\�0�G\�(\�q\�\"�Q\���E\�8�\�\0\�\�\�\�݅[\���R�	�\�U\�G\�z�?V#\�� Q�\�Ҁ��T��\�\�hC\�!	\�	�O\�\�d�L��\�\��*H��,rb\0��\�o\�r��\�}��\�P1#\�{�\"-�:lF�݉	�ꁠs\n��ȶ�P�\�2��\�!��[�LoH)���)�=�\�EI�M\�\n�W��(�|\�\Z�\�\�\ZEbٯ\"AE�8d�\�c�V$\��֑��Ut\�JF��I\�^Z\�%��=\0�{!6�� |օڳ�Xb#FyMz\� 7�L=\�{��[��\�m������(,\�Q{�B������߻��K)i#�x	eC\�$5:�؇$\�R\�e�\"y�\\\�ϐq���A�ƚ\�\�4j���	^dI�Kq\0zʆB<Z�/^�\�㋰\�M\'n�5`R�\0�<\�?4u\�\"�Q�n=\�0����\�AJ\�ځ\�\�.k\�\�\�N1k��F��ErY3�\�m�y_A\Z�%zc9J0a�\�Z���Fy\��\�����\�%j�[?zZ���1\�3�ן\��~����D/���B8�_��R\\�r�8-*\�H�&EJ�W+\�܋A��\�z�\Z\�JW#3�f�����l�஝y�nE�z�\�\�Kr_\�z�r���Pip\�\�2\'��u\�(��Բr[\"\�-\�\�\0\�S\�%\���n̯\�*Ē�\�&��d��\'��j�27}Gu�S��AK�{^E*\�\�>��P��z�//C\�\�u����̙x�\�<�m\ZT΄\�7A\�\�{�G���jBzx�GO)�R\�b�E�6��1G\�<V��\0WQ�C^��\��y\�\��Ͽ\0\����\�\�)Xޛ����\n��`�\"9>Da$VN!%I\�rXs��c�\�1�P�ф��]X�6�\�^�\��❾\�\�w}��\�O&\�̥o\�8����Xy�כvě\r\"\�$Ѥ�)c�\�\�*�\�	h����@\��\Z;A8J?!�\�\0\�\��yp��Ɠ�,@��v,9�2:�\��\"�lC�فd�֡\��*g(��$EE\�\Z�g0ܼ�04Ҁ�\�K�\�/�\��,��\�\\�]\Z�%\0�\�p\�\�H|���\rw�\��\�\�\n -Z[����\�1C\0M��Z�\"A\�$�\�\�i\r�Aw|�t�9��\�v\�ņ7_�c\�0\�!Hz�9�H�j$H%�\�\�\'�\�\n\�\Ze)t��4��\n̬[K/?�\��2\�.����\���x�\rW.$\�\�\�L�w\�A�h��\�\�q\"\�WF�R\�ŐҠt��G1z�\�V\�\�Z\�c��XWu�\�9��!޽]7�\�B;\�\�n�ʓ��E(8aX�iíS1R^\�WA[�L�Jye?C^\�\��5��ld\�2�\�\�2\��<�����.�\�ä�\�\�\�q�\�._L\�\�/O\�\�m����Z\�Xf2m�#\�܍�ɁVmګZ{?\���R+\�8GtQ��\�6K\�>\0�4\�&\�\�6\�|%���\�Vb�$��A�2Å��\0TyKJ\�*dރ�,[�`���\�<|�_\�f\�6\�R,;���~�ӗg\�\�\�\�\�\0\���\��\�w?ܿ|kO��\�c\����\�\�cs+\�4\��L1	m�O��\�S���\�e}�\�\�ݭ\�r9\0:Ǳ߫Z�ͧ�\�\�6�߅�)�б�d�A�\�<��\�Y��y\�m\Z\�|��O�\���\����\��F�����H\�\��ۋ\��Q\�m8wn$�|2�F�g�~7\�_φ�l>�G\�ቶ�|\�	\�\�\�G��\n�\��сGYBX�K\"�\0R�-\�*�\� e�~�r!�\�\0\�\����^8�[\�/@\�{�4\�\Z�TA\�\�F\"H�2�\�)Az�\n\�L��\�R<u��\��\�zdGc���\�iD� ~yi>~�\�wp���p�o>���\0Vu\�â&x~\0\�\�3(|s1\�FzI\r\���&֓�tj\��ץ:9vM��\��0�v�\�^��m�\�9[���\�i���ӑ�&Ř��L`K)^W\�TF\����\��#h<\�\�o\�ybBuf\�X�ܟ�Ţ���\�9xq�L�휋\�g�1�mnt?��v��\�s�\�R&Uc0�9�-��5%\�\�\�s�x����^8�1+4;��	\�{~�Q�Ǫ���j��X\�\��� \�T��\�\\�/\�ˉ�\�ĳ�\�\�F<V�\0�\�T���RL�,\�W�+1�X�\���x��\�ځ\�/\�aLp%n���Ԫ\�~�\�h�G2��nQ2D���\�8��\�o�r�\��b\�G\�\�;�\�\�24��#�\�*�\nlFb�\���@��>\�`\��z��}D}:�\�*|\��#\�\�\0&�\�c��S�\�1.\�\�HW�\Zv0}�0����Nd���%��(Fݧ혱\�Y\\ڂĨPF��!n�8�R�W\0\�s��@\��`vm.mY�M�>�%��cd��@�N�$�YF\�	Q�U%u\����\�\�%a\�k\�#�̐�N�`Fk��\��\�\�g^\�0�#�ލY{k��-�ӻ��u\�-d��p�a�5�w����(=K�6�\n��\�*\�/zR�\�\�h��\�c(���g�\�bD�T��AI6�\�O��ZB	1	m*\';�{k��E1�|�\�?�\�P\�\�\�3�ᆉ�\�J��\�}[�\���5��\�\��\� n�\�8��\�\�v\����є,���\�OiM\�\�2YGX\�\�5���(HO�c�	�?�<�.\��@���x㑰&XutI���&\���\�RД\"l=H`X�J\�b\�\�ţc+j1޻�+\'�t��{�\��=���C�r}&���\�R4�\��Y۩A)yJ\���ɍ\';1o\�z�>�`q\�:�(Щ�\�+\�\"H5�n	\�\05sy�)!$W\�\�[UiQ\�3�N��21\��a���x�\"\�x�=�i\�*ް�X!̳?\�K\�b@ ���\'\�cq��5<�\�sP�QC\�\�\�\n:N*�x�\n\�ߺ��\�;�~��ga��RM\�au�\��-�\��l�y[�a[\�Az��G@w\\��\�p�g\�\�|\"C\0\�@Zd5#�>*�������\�\�\��#N,l��\�c߇�~	=\�DRp�_M�[\r���U?\�h\�\�TQS�u\�\'�sRG\rۘ\��>\�\�e\\�\�[\�y�`��\�Dj��J�\� �Dye\��\�l{.^<\�\�B6&N\�y\�?\nb������3\�V#_%\��\"@)C���Tt��-$�E\��S�\�\�$\�\�\�\�&�8	τ Ù^LcEN�p���x�P�t^˩�\�\��ArM���:��>\�	?��o�E\����X>�V�\�R���A\�F\�_H��\�\�,n�q��l#\��Ȱ�s����\�`\��	�\�\��b��\"��`�IY�u*i@:ܯt�Ç��{0qG�7bj}9�7i\�2ߨ�\�\�,к\�\�9�<�W,\nl� CP~݌su ��\�\�oG�Z\�C�� \� �_A\�H\�]�>y\nX��\0E������@߻�mbQ\0���q�����ps\�\�\�܅1�\r\�ܼ#\�/#\�]��%���$\�\�\�\�|ގ�Ŝ+n\"\�\"5X\�0��79w \�Մ��\�Ȋw`\�g�w\"�t\�mn\���\�\�l��\�\�ڎK�1�����\�\"\�E��\�0F��B\"GH�s��^��\�׫�\�\�\��\�!\��\r�۲;�Iq\0\0\0\0IEND�B`�',NULL);
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
INSERT INTO `spr_flight_class` VALUES (1,'Эконом','Без выбора меню'),(2,'Бизнес','Обед на выбор, больше места');
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
