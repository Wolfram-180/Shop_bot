-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: icecream_sales
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `phone` varchar(45) COLLATE utf32_bin DEFAULT 'не указан',
  `pd_accept` varchar(3) COLLATE utf32_bin DEFAULT 'нет',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `chat_id_UNIQUE` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf32 COLLATE=utf32_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (7,229793913,'89251720126','да'),(8,490928190,'не указан','нет');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(300) COLLATE utf32_bin DEFAULT NULL,
  `art` varchar(45) COLLATE utf32_bin DEFAULT NULL,
  `name` varchar(300) COLLATE utf32_bin DEFAULT NULL,
  `menuid` int DEFAULT NULL,
  `update_datetime_msk` datetime DEFAULT NULL,
  `cost_text` varchar(45) COLLATE utf32_bin DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=867 DEFAULT CHARSET=utf32 COLLATE=utf32_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (865,'https://shop.froneri.ru/catalog/eskimo/m_venpick/m_venpick_shokolad_gorkiy_apelsin_27x90ml.html','31008603','MÖVENPICK Шоколад Горький Апельсин 27x90мл',8,'2020-11-29 22:15:53','1 694.68 руб. за короб',NULL),(866,'https://shop.froneri.ru/catalog/eskimo/m_venpick/eskimo_m_venpick_gretskiy_orekh_klenovyy_sirop.html','31008602','MÖVENPICK Грецкий Орех Кленовый Сироп 27x90мл',8,'2020-11-29 22:15:56','1 694.68 руб. за короб',NULL),(863,'https://shop.froneri.ru/catalog/eskimo/48_kopeek/eskimo_48_kopeek_plombir_klyukvennyy_mors.html','31015659','48 КОПЕЕК Эскимо Пломбир Морс 36х80мл',8,'2020-11-29 22:15:48','1 275.52 руб. за короб',NULL),(864,'https://shop.froneri.ru/catalog/eskimo/milka/milka_morozhenoe_eskimo_slivochnoe_vanilnoe_s_shokoladnym_sousom_pokrytoe_molochnym_shokoladom_milka.html','31015672','MILKA Эскимо 27х90мл',8,'2020-11-29 22:15:51','1 436.59 руб. за короб',NULL),(862,'https://shop.froneri.ru/catalog/eskimo/bon_pari/eskimo_bon_pari_koshmariki.html','31008608','БОН ПАРИ Ягодное пюре и палочка-жевательная резинка. Эскимо 32x66мл',8,'2020-11-29 22:15:46','1 405.82 руб. за короб',NULL),(860,'https://shop.froneri.ru/catalog/eskimo/oreo/eskimo_oreo.html','31015673','OREO Эскимо 27х90мл',8,'2020-11-29 22:15:43','1 310.96 руб. за короб',NULL),(861,'https://shop.froneri.ru/catalog/eskimo/kit_kat/kit_kat_eskimo_27x90ml.html','31014736','KITKAT Эскимо 27x90мл',8,'2020-11-29 22:15:44','1 332.34 руб. за короб',NULL),(859,'https://shop.froneri.ru/catalog/eskimo/alpen_gold/eskimo_alpen_gold.html','31014763','ALPEN GOLD Эскимо 27х90мл',8,'2020-11-29 22:15:41','1 305.91 руб. за короб',NULL),(858,'https://shop.froneri.ru/catalog/eskimo/bon_pari/eskimo_bon_pari_drakula.html','31011873','БОН ПАРИ Фруктовый лед с клубничным соусом. Эскимо 44x54мл',8,'2020-11-29 22:15:39','1 297.82 руб. за короб',NULL),(857,'https://shop.froneri.ru/catalog/eskimo/bon_pari/eskimo_bon_pari_vzryvnoy_uragan.html','31008582','БОН ПАРИ Фруктовый лед с взрывной карамелью. Эскимо 44x54мл',8,'2020-11-29 22:15:37','1 297.82 руб. за короб',NULL),(854,'https://shop.froneri.ru/catalog/eskimo/nestle/eskimo_nestle_mindal_.html','31014724','NESTLE Миндаль Эскимо 27x90мл',8,'2020-11-29 22:15:31','1 247.10 руб. за короб',NULL),(855,'https://shop.froneri.ru/catalog/eskimo/48_kopeek/eskimo_48_kopeek_plombir_v_shokolade.html','31015674','48 КОПЕЕК Эскимо Пломбир в темном шоколаде 27х90мл',8,'2020-11-29 22:15:33','1 287.50 руб. за короб',NULL),(856,'https://shop.froneri.ru/catalog/eskimo/48_kopeek/eskimo_48_kopeek_plombir_malina.html','31015675','48 КОПЕЕК Эскимо Пломбир с малиной и малиновым вареньем 27х90мл',8,'2020-11-29 22:15:35','1 287.50 руб. за короб',NULL),(853,'https://shop.froneri.ru/catalog/eskimo/bon_pari/eskimo_bon_pari_dzhangli.html','31008589','БОН ПАРИ Банановое пюре внутри желе снаружи. Эскимо 36x47мл',8,'2020-11-29 22:15:29','818.21 руб. за короб',NULL),(851,'https://shop.froneri.ru/catalog/sendvich/oreo/morozhenoe_oreo_sendvich.html','31014700','OREO Сендвич 24х130мл',7,'2020-11-29 22:15:25','1 125.96 руб. за короб',NULL),(852,'https://shop.froneri.ru/catalog/eskimo/pochemuchka/eskimo_pochemuchka_vinograd_i_ananas.html','31016631','ПОЧЕМУЧКА®. Виноград и ананас. Фруктовый лед. Эскимо 36x36мл',8,'2020-11-29 22:15:27','379.12 руб. за короб',NULL),(850,'https://shop.froneri.ru/catalog/sendvich/maxibon/morozhenoe_maxibon_strachatella.html','31015848','MAXIBON Страчателла 18x140мл',7,'2020-11-29 22:15:23','968.62 руб. за короб',NULL),(849,'https://shop.froneri.ru/catalog/stakanchik/m_venpick/morozhenoe_m_venpick_shokoladnoe_165ml.html','31008710','MÖVENPICK Шоколадное 16x165мл',6,'2020-11-29 22:15:21','2 493.04 руб. за короб',NULL),(847,'https://shop.froneri.ru/catalog/stakanchik/m_venpick/morozhenoe_m_venpick_vanilnoe_165ml.html','31010030','MÖVENPICK Ванильное 16x165мл',6,'2020-11-29 22:15:17','2 493.04 руб. за короб',NULL),(848,'https://shop.froneri.ru/catalog/stakanchik/m_venpick/morozhenoe_m_venpick_gretskiy_orekh_klenovyy_sirop_165_ml.html','31008712','MÖVENPICK Грецкий Орех Кленовый Сироп 16x165мл',6,'2020-11-29 22:15:19','2 493.04 руб. за короб',NULL),(846,'https://shop.froneri.ru/catalog/stakanchik/m_venpick/m_venpick_sorbet_malina_kusochki_klubniki_165ml.html','31008711','MÖVENPICK Малина Клубника сорбет 16x165мл',6,'2020-11-29 22:15:15','2 487.74 руб. за короб',NULL),(845,'https://shop.froneri.ru/catalog/stakanchik/m_venpick/m_venpick_vanilnoe_18x100ml.html','31013978','MÖVENPICK Ванильное 18x100мл',6,'2020-11-29 22:15:13','1 371 руб. за короб',NULL),(844,'https://shop.froneri.ru/catalog/stakanchik/48_kopeek/48_kopeek_stakan_abrikos_apelsin_30kh160ml.html','31016769','48 КОПЕЕК Стакан Абрикос-апельсин 30х160мл',6,'2020-11-29 22:15:11','1 349.70 руб. за короб',NULL),(843,'https://shop.froneri.ru/catalog/stakanchik/48_kopeek/morozhenoe_48_kopeek_vafelnyy_stakanchik_s_malinoy_.html','31015682','48 КОПЕЕК Стакан Пломбир с малиной 30х160мл',6,'2020-11-29 22:15:09','1 349.70 руб. за короб',NULL),(841,'https://shop.froneri.ru/catalog/stakanchik/48_kopeek/morozhenoe_48_kopeek_vafelnyy_stakanchik_shokoladnyy.html','31015679','48 КОПЕЕК Стакан Шоколадный 30х160мл',6,'2020-11-29 22:15:05','1 096.26 руб. за короб',NULL),(842,'https://shop.froneri.ru/catalog/stakanchik/48_kopeek/morozhenoe_48_kopeek_plombir_s_khrustyashchimi_khlopyami_i_solenym_arakhisom_vafelnyy_stakanchik.html','31015677','48 КОПЕЕК Стакан Пломбир с арахисом 30х160мл',6,'2020-11-29 22:15:07','1 218.69 руб. за короб',NULL),(840,'https://shop.froneri.ru/catalog/stakanchik/48_kopeek/morozhenoe_48_kopeek_plombir_vafelnyy_stakanchik.html','31015678','48 КОПЕЕК Стакан Пломбир 30х160мл',6,'2020-11-29 22:15:01','1 044.12 руб. за короб',NULL),(839,'https://shop.froneri.ru/catalog/rozhki/kit_kat/kitkat_rozhok_24x120ml.html','31014732','KITKAT Рожок 24x120мл',5,'2020-11-29 22:14:58','1 380.46 руб. за короб',NULL),(838,'https://shop.froneri.ru/catalog/rozhki/48_kopeek/48_kopeek_rozhok_plombir_s_varenem_iz_chernoy_smorodiny_18kh200ml.html','31016848','48 КОПЕЕК Рожок Пломбир с вареньем из черной смородины 18х200мл',5,'2020-11-29 22:14:56','1 095.53 руб. за короб',NULL),(837,'https://shop.froneri.ru/catalog/rozhki/oreo/morozhenoe_oreo_rozhok.html','31015669','OREO Рожок 24х120мл',5,'2020-11-29 22:14:54','1 165.30 руб. за короб',NULL),(836,'https://shop.froneri.ru/catalog/rozhki/extreme/morozhenoe_extreme_intriga_shokoladnyy_tryufel.html','31011877','EXTREME. Вкус шоколадный трюфель 24х120мл',5,'2020-11-29 22:14:53','1 157.90 руб. за короб',NULL),(834,'https://shop.froneri.ru/catalog/rozhki/extreme/morozhenoe_extreme_intriga_klubnika_so_slivkami.html','31008605','EXTREME INTRIGA Клубника со сливками 24x120мл',5,'2020-11-29 22:14:48','1 157.90 руб. за короб',NULL),(835,'https://shop.froneri.ru/catalog/rozhki/extreme/extreme_intriga_vkus_chizkeyka_i_lavandy_24kh120ml.html','31008611','EXTREME INTRIGA Вкус чизкейка и лаванды 24х120мл',5,'2020-11-29 22:14:51','1 157.90 руб. за короб',NULL),(833,'https://shop.froneri.ru/catalog/rozhki/extreme/extreme_madagaskarskaya_vanil_24x120ml.html','31015713','EXTREME INTRIGA Мадагаскарская ваниль 24x120мл',5,'2020-11-29 22:14:46','1 157.90 руб. за короб',NULL),(832,'https://shop.froneri.ru/catalog/rozhki/48_kopeek/morozhenoe_48_kopeek_shokoladnyy_vafelnyy_rozhok.html','31015681','48 КОПЕЕК Рожок Шоколадный 18х200мл',5,'2020-11-29 22:14:44','1 043.46 руб. за короб',NULL),(831,'https://shop.froneri.ru/catalog/rozhki/48_kopeek/morozhenoe_48_kopeek_plombir_vafelnyy_rozhok.html','31015676','48 КОПЕЕК Рожок Пломбир 18х200мл',5,'2020-11-29 22:14:43','1 043.46 руб. за короб',NULL),(830,'https://shop.froneri.ru/catalog/rozhki/extreme/extreme_intriga_malina_banan_12x120ml.html','31014720','EXTREME INTRIGA Малина-Банан 12x120мл',5,'2020-11-29 22:14:41','594.26 руб. за короб',NULL),(829,'https://shop.froneri.ru/catalog/pitstsa/buitoni/pitstsa_buitoni_pikolini_3_syra.html','34001421','BUITONI Пиколини 3 Сыра 10шт.',4,'2020-11-29 22:14:38','2 146.43 руб. за короб',NULL),(828,'https://shop.froneri.ru/catalog/pitstsa/buitoni/pitstsa_buitoni_pikkolini_salyami.html','34000569','BUITONI Пикколини Салями 10шт.',4,'2020-11-29 22:14:37','2 146.43 руб. за короб',NULL),(827,'https://shop.froneri.ru/catalog/pitstsa/buitoni/pitstsa_buitoni_4_sezona.html','34000679','BUITONI Пицца 4 Сезона 10шт.',4,'2020-11-29 22:14:35','1 736.24 руб. за короб',NULL),(826,'https://shop.froneri.ru/catalog/keytering/m_venpick/sorbet_m_venpick_malina_klubnika.html','31007551','MÖVENPICK Малина Клубника сорбет 2x2400мл',3,'2020-11-29 22:14:32','2 096.23 руб. за короб',NULL),(824,'https://shop.froneri.ru/catalog/keytering/m_venpick/m_venpick_pechene_karamel_2x2400ml.html','31013383','MÖVENPICK Печенье Карамель 2x2400мл',3,'2020-11-29 22:14:28','1 968.03 руб. за короб',NULL),(825,'https://shop.froneri.ru/catalog/keytering/m_venpick/sorbet_m_venpick_laym_limon.html','31007039','MÖVENPICK Лайм Лимон сорбет 2x2400мл',3,'2020-11-29 22:14:30','2 096.23 руб. за короб',NULL),(823,'https://shop.froneri.ru/catalog/keytering/m_venpick/m_venpick_morozhenon_fistashkovoe_.html','31007036','MÖVENPICK Фисташковое 2x2400мл',3,'2020-11-29 22:14:26','1 968.03 руб. за короб',NULL),(822,'https://shop.froneri.ru/catalog/keytering/m_venpick/m_venpick_chizkeyk_chernika_2x2400ml.html','31007063','MÖVENPICK Чизкейк черника 2x2400мл',3,'2020-11-29 22:14:24','1 968.03 руб. за короб',NULL),(821,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_tiramisu_2400ml.html','31006607','MÖVENPICK Тирамису 2x2400мл',3,'2020-11-29 22:14:22','1 968.03 руб. за короб',NULL),(820,'https://shop.froneri.ru/catalog/keytering/m_venpick/sorbet_m_venpick_chernaya_smorodina.html','31007030','MÖVENPICK Черная cмородина cорбет 2x2400мл',3,'2020-11-29 22:14:21','1 864.90 руб. за короб',NULL),(819,'https://shop.froneri.ru/catalog/keytering/m_venpick/sorbet_m_venpick_marakuyya_mango.html','31007035','MÖVENPICK Маракуйя Манго сорбет 2x2400мл',3,'2020-11-29 22:14:19','1 864.90 руб. за короб',NULL),(817,'https://shop.froneri.ru/catalog/keytering/m_venpick/sorbet_m_venpick_mango_2400_ml.html','31008362','MÖVENPICK Манго cо сливками 2x2400мл',3,'2020-11-29 22:14:15','1 792.38 руб. за короб',NULL),(818,'https://shop.froneri.ru/catalog/keytering/m_venpick/sorbet_m_venpick_mango.html','31007054','MÖVENPICK Манго сорбет 2x2400мл',3,'2020-11-29 22:14:17','1 864.90 руб. за короб',NULL),(816,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_kokos_shokolad.html','31008361','MÖVENPICK Кокос Шоколад 2x2400мл',3,'2020-11-29 22:14:13','1 792.38 руб. за короб',NULL),(815,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_klubnichnoe_5000ml.html','31008317','MÖVENPICK Клубничное 1x5000мл',3,'2020-11-29 22:14:11','1 763.71 руб. за короб',NULL),(814,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_panna_kotta.html','31007554','MÖVENPICK Панна Котта 2x2400мл',3,'2020-11-29 22:14:09','1 743.43 руб. за короб',NULL),(812,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_krem_bryule.html','31007038','MÖVENPICK Крем-Брюле 2x2400мл',3,'2020-11-29 22:14:05','1 743.43 руб. за короб',NULL),(813,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_myata_shokolad.html','31007549','MÖVENPICK Мята шоколад 2x2400мл',3,'2020-11-29 22:14:07','1 743.43 руб. за короб',NULL),(811,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_karamelnoe.html','31007028','MÖVENPICK Карамельное 2x2400мл',3,'2020-11-29 22:14:03','1 743.43 руб. за короб',NULL),(810,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_gretskiy_orekh_klenovyy_sirop_2400ml.html','31007025','MÖVENPICK Грецкий Орех Кленовый Сироп 2x2400мл',3,'2020-11-29 22:14:01','1 743.43 руб. за короб',NULL),(809,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_klubnichnoe_2400ml.html','31007032','MÖVENPICK Клубничное 2x2400мл',3,'2020-11-29 22:13:59','1 727.81 руб. за короб',NULL),(808,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_shokoladnoe.html','31008316','MÖVENPICK Шоколадное 1x5000мл',3,'2020-11-29 22:13:57','1 682.97 руб. за короб',NULL),(807,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_vanilnoe-5000.html','31007037','MÖVENPICK Ванильное 1x5000мл',3,'2020-11-29 22:13:55','1 682.97 руб. за короб',NULL),(806,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_shokoladnoe_2400ml.html','31007027','MÖVENPICK Шоколадное 2x2400мл',3,'2020-11-29 22:13:53','1 649.01 руб. за короб',NULL),(804,'https://shop.froneri.ru/catalog/keytering/nestle/morozhenoe_nestle_deluxe_plombir.html','31008390','NESTLE®. Мороженое пломбир. Кейтеринг 2x3500мл',3,'2020-11-29 22:13:49','1 293.69 руб. за короб',NULL),(805,'https://shop.froneri.ru/catalog/keytering/m_venpick/morozhenoe_m_venpick_vanilnoe.html','31007031','MÖVENPICK Ванильное 2x2400мл',3,'2020-11-29 22:13:51','1 649.01 руб. за короб',NULL),(803,'https://shop.froneri.ru/catalog/keytering/nestle/shcherbet_nestle_deluxe_vishnevyy.html','31008392','NESTLE®. DE LUXE. Десерт замороженный вишневый щербет. Кейтеринг 3500мл',3,'2020-11-29 22:13:48','1 221.86 руб. за короб',NULL),(802,'https://shop.froneri.ru/catalog/keytering/nestle/morozhenoe_nestle_deluxe_krem_bryule.html','31008395','NESTLE®. Крем-брюле. Мороженое с заменителем молочного жира крем-брюле. Кейтеринг 2x3500мл',3,'2020-11-29 22:13:46','1 120.04 руб. за короб',NULL),(799,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_klubnichnoe.html','31007044','MÖVENPICK Клубничное 4x900мл',2,'2020-11-29 22:13:40','2 327.25 руб. за короб',NULL),(800,'https://shop.froneri.ru/catalog/keytering/nestle/morozhenoe_nestle_deluxe_sadovaya_klubnika.html','31008354','NESTLE®. Садовая клубника. Мороженое с заменителем молочного жира клубничное. Кейтеринг 2x3500мл',3,'2020-11-29 22:13:42','965.27 руб. за короб',NULL),(801,'https://shop.froneri.ru/catalog/keytering/nestle/morozhenoe_nestle_deluxe_shokoladnoe.html','31008353','NESTLE®. Шоколадное. Мороженое с заменителем молочного жира шоколадное. Кейтеринг 2x3500мл',3,'2020-11-29 22:13:44','965.27 руб. за короб',NULL),(798,'https://shop.froneri.ru/catalog/vederki/m_venpick/m_venpick_plombir_s_old_barrel_rum_4x900ml.html','31015175','MÖVENPICK Пломбир с Old Barrel Rum 4x900мл',2,'2020-11-29 22:13:38','2 327.25 руб. за короб',NULL),(797,'https://shop.froneri.ru/catalog/vederki/m_venpick/m_venpick_plombir_brauni_4x900ml.html','31015080','MÖVENPICK Пломбир брауни 4x900мл',2,'2020-11-29 22:13:36','2 327.25 руб. за короб',NULL),(796,'https://shop.froneri.ru/catalog/vederki/m_venpick/m_venpick_kold_bryu_kofe_i_shokola_4x900ml.html','31014919','MÖVENPICK Колд брю кофе и шоколад 4x900мл',2,'2020-11-29 22:13:34','2 327.25 руб. за короб',NULL),(795,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_karamelnoe_900ml.html','31005932','MÖVENPICK Карамельное 4x900мл',2,'2020-11-29 22:13:32','2 327.25 руб. за короб',NULL),(794,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_fistashkovoe.html','31008344','MÖVENPICK Фисташковое 4x900мл',2,'2020-11-29 22:13:30','2 327.25 руб. за короб',NULL),(793,'https://shop.froneri.ru/catalog/vederki/m_venpick/m_venpick_tiramisu_4x810ml.html','31007052','MÖVENPICK Тирамису 4x810мл',2,'2020-11-29 22:13:28','2 327.25 руб. за короб',NULL),(792,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_gretskiy_orekh_klenovyy_sirop_900ml.html','31007042','MÖVENPICK Грецкий Орех Кленовый Сироп 4x900мл',2,'2020-11-29 22:13:26','2 327.25 руб. за короб',NULL),(791,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_shokoladnoe_900ml.html','31007041','MÖVENPICK Швейцарский шоколад 4x900мл',2,'2020-11-29 22:13:24','2 327.25 руб. за короб',NULL),(790,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_vanilnoe_900ml.html','31007046','MÖVENPICK Ванильное 4x900мл',2,'2020-11-29 22:13:22','2 327.25 руб. за короб',NULL),(789,'https://shop.froneri.ru/catalog/vederki/m_venpick/sorbet_m_venpick_malina_kusochki_klubniki_900ml.html','31008341','MÖVENPICK Малина Клубника сорбет 4x900мл',2,'2020-11-29 22:13:20','2 322.38 руб. за короб',NULL),(788,'https://shop.froneri.ru/catalog/vederki/m_venpick/sorbet_m_venpick_marakuya_kusochki_mango_900ml.html','31007045','MÖVENPICK Маракуйя Манго сорбет 4x900мл',2,'2020-11-29 22:13:18','2 322.38 руб. за короб',NULL),(787,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_gretskiy_orekh_klenovyy_sirop.html','31007060','MÖVENPICK Грецкий Орех Кленовый Сироп 6x500мл',2,'2020-11-29 22:13:16','2 311.32 руб. за короб',NULL),(786,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_tiramisu_450ml.html','31007062','MÖVENPICK Тирамису 6x450мл',2,'2020-11-29 22:13:14','2 311.32 руб. за короб',NULL),(785,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_shokoladnoe_500_ml.html','31007059','MÖVENPICK Швейцарский шоколад 6x500мл',2,'2020-11-29 22:13:12','2 311.32 руб. за короб',NULL),(782,'https://shop.froneri.ru/catalog/vederki/m_venpick/m_venpick_sorbet_malina_kusochki_klubniki_500ml.html','31008389','MÖVENPICK Малина Клубника сорбет 6x500мл',2,'2020-11-29 22:13:06','2 306.45 руб. за короб',NULL),(783,'https://shop.froneri.ru/catalog/vederki/m_venpick/sorbet_m_venpick_marakuya_kusochki_mango_500ml.html','31007066','MÖVENPICK Маракуйя Манго сорбет 6x500мл',2,'2020-11-29 22:13:08','2 306.45 руб. за короб',NULL),(784,'https://shop.froneri.ru/catalog/vederki/m_venpick/morozhenoe_m_venpick_vanilnoe_250g.html','31007058','MÖVENPICK Ванильное 6x500мл',2,'2020-11-29 22:13:10','2 311.32 руб. за короб',NULL),(781,'https://shop.froneri.ru/catalog/vederki/kit_kat/kit_kat_vederko.html','31015665','KIT KAT Ведерко 8x480мл',2,'2020-11-29 22:13:04','1 738.70 руб. за короб',NULL),(780,'https://shop.froneri.ru/catalog/vederki/oreo/oreo_vederko_8kh480ml.html','31011163','OREO Ведерко 8х480мл',2,'2020-11-29 22:13:02','1 711.07 руб. за короб',NULL),(779,'https://shop.froneri.ru/catalog/vannochki/48_kopeek/morozhenoe_48_kopeek_shokoladnaya_praga_vanna.html','31015661','48 КОПЕЕК Ванна Шоколадная Прага 8х800мл',1,'2020-11-29 22:12:58','2 200.18 руб. за короб',NULL),(778,'https://shop.froneri.ru/catalog/vannochki/48_kopeek/morozhenoe_48_kopeek_s_malinoy_biskvitami_i_malinovym_varenem_vanna.html','31015664','48 КОПЕЕК Ванна с Малиной и малиновым вареньем 8х800мл',1,'2020-11-29 22:12:56','2 200.18 руб. за короб',NULL),(777,'https://shop.froneri.ru/catalog/vannochki/48_kopeek/morozhenoe_48_kopeek_vanna_plombir.html','31015662','48 КОПЕЕК Ванна Пломбир 8х800мл',1,'2020-11-29 22:12:54','1 659.15 руб. за короб',NULL),(776,'https://shop.froneri.ru/catalog/vannochki/48_kopeek/morozhenoe_i_klubnichnyy_desert_48_kopeek_vanna.html','31015663','48 КОПЕЕК Ванна Клубничный десерт 8х800мл',1,'2020-11-29 22:12:52','1 466.08 руб. за короб',NULL),(774,'https://shop.froneri.ru/catalog/brikety/48_kopeek/48_kopeek_briket_plombir_s_varenem_iz_chernoy_smorodiny_25kh400ml.html','31016849','48 КОПЕЕК Брикет Пломбир с вареньем из черной смородины 25х400мл',0,'2020-11-29 22:12:48','2 342.18 руб. за короб',NULL),(775,'https://shop.froneri.ru/catalog/brikety/48_kopeek/48_kopeek_briket_plombir_s_malinoy_i_malinovym_varenem_25kh400ml.html','31015657','48 КОПЕЕК Брикет Пломбир с малиной и малиновым вареньем 25х400мл',0,'2020-11-29 22:12:50','2 342.18 руб. за короб',NULL),(770,'https://shop.froneri.ru/catalog/brikety/48_kopeek/48_kopeek_bolshoy_briket_plombir.html','31015656','48 КОПЕЕК Большой Брикет Пломбир 12х663мл',0,'2020-11-29 22:12:39','1 446.59 руб. за короб',NULL),(771,'https://shop.froneri.ru/catalog/brikety/48_kopeek/morozhenoe_48_kopeek_bolshoy_briket_plombir_s_malinoy.html','31015655','48 КОПЕЕК Большой Брикет Пломбир с малиной и малиновым вареньем 12х626мл',0,'2020-11-29 22:12:41','1 735.93 руб. за короб',NULL),(773,'https://shop.froneri.ru/catalog/brikety/48_kopeek/morozhenoe_48_kopeek_plombir_briket_25_sht.html','31015650','48 КОПЕЕК Брикет Пломбир 25х400мл',0,'2020-11-29 22:12:46','1 951.95 руб. за короб',NULL),(772,'https://shop.froneri.ru/catalog/brikety/48_kopeek/morozhenoe_48_kopeek_briket_shokoladnyy_s_shokoladnym_sousom.html','31015652','48 КОПЕЕК Брикет Шоколадный с шоколадным соусом 25х400мл',0,'2020-11-29 22:12:44','1 869.73 руб. за короб',NULL);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chat_id` int DEFAULT NULL,
  `log_string` varchar(145) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `severity` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentid` int DEFAULT '0',
  `menuid` int DEFAULT '0',
  `text` varchar(45) COLLATE utf32_bin DEFAULT '',
  `url` varchar(200) COLLATE utf32_bin DEFAULT '',
  `update_datetime_msk` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=137 DEFAULT CHARSET=utf32 COLLATE=utf32_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (136,0,8,'Эскимо','https://shop.froneri.ru/catalog/eskimo/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:37'),(135,0,7,'Сэндвич','https://shop.froneri.ru/catalog/sendvich/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:37'),(128,0,0,'Брикеты','https://shop.froneri.ru/catalog/brikety/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:36'),(129,0,1,'Ванночки','https://shop.froneri.ru/catalog/vannochki/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:36'),(130,0,2,'Ведерки','https://shop.froneri.ru/catalog/vederki/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:36'),(131,0,3,'Кейтеринг','https://shop.froneri.ru/catalog/keytering/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:36'),(132,0,4,'Пицца','https://shop.froneri.ru/catalog/pitstsa/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:36'),(134,0,6,'Стаканчик','https://shop.froneri.ru/catalog/stakanchik/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:36'),(133,0,5,'Рожки','https://shop.froneri.ru/catalog/rozhki/?PAGE_EL_COUNT=ALL','2020-11-29 22:12:36');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `order_datetime_msk` datetime DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `status_text` varchar(45) DEFAULT NULL,
  `update_datetime_msk` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (62,229793913,'2020-08-02 21:43:20','P','передан в службу доставки','2020-08-02 21:43:20'),(63,229793913,'2020-08-02 23:15:33','P','передан в службу доставки','2020-08-02 23:15:33'),(64,229793913,'2020-08-04 14:47:48','P','передан в службу доставки','2020-08-04 14:47:48'),(65,229793913,'2020-08-04 16:25:04','P','передан в службу доставки','2020-08-04 16:25:04'),(66,229793913,'2020-08-05 21:43:14','P','передан в службу доставки','2020-08-05 21:43:14'),(67,229793913,'2020-08-05 21:49:47','P','передан в службу доставки','2020-08-05 21:49:47'),(68,229793913,'2020-08-05 21:56:01','P','передан в службу доставки','2020-08-05 21:56:01'),(69,229793913,'2020-08-07 15:31:06','P','передан в службу доставки','2020-08-07 15:31:06'),(70,229793913,'2020-08-07 17:17:48','P','передан в службу доставки','2020-08-07 17:17:48'),(71,229793913,'2020-08-30 19:45:24','P','передан в службу доставки','2020-08-30 19:45:24'),(72,229793913,'2020-09-21 12:22:37','P','передан в службу доставки','2020-09-21 12:22:37'),(73,229793913,'2021-11-01 14:59:12','I','заполняется пользователем','2021-11-01 14:59:12');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_sku`
--

DROP TABLE IF EXISTS `orders_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_sku` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_orders` int DEFAULT NULL,
  `art_goods` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=utf32;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_sku`
--

LOCK TABLES `orders_sku` WRITE;
/*!40000 ALTER TABLE `orders_sku` DISABLE KEYS */;
INSERT INTO `orders_sku` VALUES (102,64,'31008389'),(97,63,'31007066'),(94,62,'31015663'),(98,63,'31007066'),(96,62,'31015661'),(112,66,'31014919'),(100,63,'31014984'),(103,64,'31015664'),(104,64,'31014700'),(106,65,'31008353'),(107,65,'31007027'),(108,65,'31007551'),(113,66,'31008389'),(110,65,'31014724'),(111,65,'31015672'),(114,67,'31008389'),(115,68,'31015655'),(116,68,'31016849'),(117,69,'31015655'),(118,69,'31015655'),(119,69,'31008353'),(120,69,'31015681'),(121,69,'31015713'),(122,70,'31015678'),(123,70,'31008712'),(124,70,'31014763'),(126,71,'31008389'),(127,71,'31008389'),(128,71,'31007045'),(129,71,'31014700'),(130,72,'31015655'),(131,72,'31008389');
/*!40000 ALTER TABLE `orders_sku` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-01 15:02:54
