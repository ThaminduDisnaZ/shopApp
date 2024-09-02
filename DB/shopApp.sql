-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.31 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for shopapp
CREATE DATABASE IF NOT EXISTS `shopapp` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shopapp`;

-- Dumping structure for table shopapp.brand
CREATE TABLE IF NOT EXISTS `brand` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.brand: ~0 rows (approximately)

-- Dumping structure for table shopapp.city
CREATE TABLE IF NOT EXISTS `city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.city: ~0 rows (approximately)

-- Dumping structure for table shopapp.company
CREATE TABLE IF NOT EXISTS `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `hotline` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.company: ~0 rows (approximately)

-- Dumping structure for table shopapp.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `mobile` varchar(10) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `point` int NOT NULL,
  PRIMARY KEY (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.customer: ~0 rows (approximately)

-- Dumping structure for table shopapp.employee
CREATE TABLE IF NOT EXISTS `employee` (
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `nic` varchar(45) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `date_registered` date NOT NULL,
  `employee_type_id` int NOT NULL,
  `gender_id` int NOT NULL,
  PRIMARY KEY (`email`),
  KEY `fk_employee_employee_type1_idx` (`employee_type_id`),
  KEY `fk_employee_gender1_idx` (`gender_id`),
  CONSTRAINT `fk_employee_employee_type1` FOREIGN KEY (`employee_type_id`) REFERENCES `employee_type` (`id`),
  CONSTRAINT `fk_employee_gender1` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.employee: ~0 rows (approximately)
INSERT INTO `employee` (`email`, `password`, `first_name`, `last_name`, `nic`, `mobile`, `date_registered`, `employee_type_id`, `gender_id`) VALUES
	('disna@gmail.com', '12345678', 'Thamindu', 'Disna', '200533600241', '0768084855', '2024-08-29', 1, 1);

-- Dumping structure for table shopapp.employee_address
CREATE TABLE IF NOT EXISTS `employee_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `line1` varchar(45) NOT NULL,
  `line2` varchar(45) NOT NULL,
  `city_id` int NOT NULL,
  `employee_email` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employee_address_city1_idx` (`city_id`),
  KEY `fk_employee_address_employee1_idx` (`employee_email`),
  CONSTRAINT `fk_employee_address_city1` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`),
  CONSTRAINT `fk_employee_address_employee1` FOREIGN KEY (`employee_email`) REFERENCES `employee` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.employee_address: ~0 rows (approximately)

-- Dumping structure for table shopapp.employee_type
CREATE TABLE IF NOT EXISTS `employee_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.employee_type: ~0 rows (approximately)
INSERT INTO `employee_type` (`id`, `name`) VALUES
	(1, 'Admin'),
	(2, 'Cashier');

-- Dumping structure for table shopapp.gender
CREATE TABLE IF NOT EXISTS `gender` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.gender: ~0 rows (approximately)
INSERT INTO `gender` (`id`, `name`) VALUES
	(1, 'Male'),
	(2, 'Female');

-- Dumping structure for table shopapp.grn
CREATE TABLE IF NOT EXISTS `grn` (
  `id` int NOT NULL,
  `supplier_mobile` varchar(10) NOT NULL,
  `date` date NOT NULL,
  `employee_email` varchar(45) NOT NULL,
  `paid_amount` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grn_supplier1_idx` (`supplier_mobile`),
  KEY `fk_grn_employee1_idx` (`employee_email`),
  CONSTRAINT `fk_grn_employee1` FOREIGN KEY (`employee_email`) REFERENCES `employee` (`email`),
  CONSTRAINT `fk_grn_supplier1` FOREIGN KEY (`supplier_mobile`) REFERENCES `supplier` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.grn: ~0 rows (approximately)

-- Dumping structure for table shopapp.grn_item
CREATE TABLE IF NOT EXISTS `grn_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `qty` double NOT NULL,
  `price` double NOT NULL,
  `stock_id` int NOT NULL,
  `grn_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grn_item_stock1_idx` (`stock_id`),
  KEY `fk_grn_item_grn1_idx` (`grn_id`),
  CONSTRAINT `fk_grn_item_grn1` FOREIGN KEY (`grn_id`) REFERENCES `grn` (`id`),
  CONSTRAINT `fk_grn_item_stock1` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.grn_item: ~0 rows (approximately)

-- Dumping structure for table shopapp.invoice
CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_mobile` varchar(10) NOT NULL,
  `employee_email` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `paid_amount` double NOT NULL,
  `payment_method_id` int NOT NULL,
  `discount` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_invoice_customer1_idx` (`customer_mobile`),
  KEY `fk_invoice_employee1_idx` (`employee_email`),
  KEY `fk_invoice_payment_method1_idx` (`payment_method_id`),
  CONSTRAINT `fk_invoice_customer1` FOREIGN KEY (`customer_mobile`) REFERENCES `customer` (`mobile`),
  CONSTRAINT `fk_invoice_employee1` FOREIGN KEY (`employee_email`) REFERENCES `employee` (`email`),
  CONSTRAINT `fk_invoice_payment_method1` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.invoice: ~0 rows (approximately)

-- Dumping structure for table shopapp.invoice_item
CREATE TABLE IF NOT EXISTS `invoice_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_id` int NOT NULL,
  `qty` double NOT NULL,
  `invoice_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_invoice_item_stock1_idx` (`stock_id`),
  KEY `fk_invoice_item_invoice1_idx` (`invoice_id`),
  CONSTRAINT `fk_invoice_item_invoice1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`id`),
  CONSTRAINT `fk_invoice_item_stock1` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.invoice_item: ~0 rows (approximately)

-- Dumping structure for table shopapp.payment_method
CREATE TABLE IF NOT EXISTS `payment_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.payment_method: ~0 rows (approximately)

-- Dumping structure for table shopapp.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` varchar(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `brand_id` int NOT NULL,
  PRIMARY KEY (`id`,`brand_id`),
  KEY `fk_product_brand1_idx` (`brand_id`),
  CONSTRAINT `fk_product_brand1` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.product: ~0 rows (approximately)

-- Dumping structure for table shopapp.stock
CREATE TABLE IF NOT EXISTS `stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `qty` double NOT NULL,
  `mfd` date NOT NULL,
  `exp` date NOT NULL,
  `product_id` varchar(20) NOT NULL,
  `product_brand_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stock_product1_idx` (`product_id`,`product_brand_id`),
  CONSTRAINT `fk_stock_product1` FOREIGN KEY (`product_id`, `product_brand_id`) REFERENCES `product` (`id`, `brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.stock: ~0 rows (approximately)

-- Dumping structure for table shopapp.supplier
CREATE TABLE IF NOT EXISTS `supplier` (
  `mobile` varchar(10) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `company_id` int NOT NULL,
  PRIMARY KEY (`mobile`),
  KEY `fk_supplier_company_idx` (`company_id`),
  CONSTRAINT `fk_supplier_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Dumping data for table shopapp.supplier: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
