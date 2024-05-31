-- Drop the existing database if it exists
DROP DATABASE IF EXISTS shoeEcommerce;

-- Create the database
CREATE DATABASE shoeEcommerce;
USE shoeEcommerce;

-- Create the `cliente` table
CREATE TABLE `cliente` (
  `idCliente` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Dni` VARCHAR(9) DEFAULT NULL,
  `Nombres` VARCHAR(255) DEFAULT NULL,
  `Direccion` VARCHAR(255) DEFAULT NULL,
  `Email` VARCHAR(255) DEFAULT NULL,
  `Password` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create the `pago` table
CREATE TABLE `pago` (
  `idPago` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Monto` DOUBLE DEFAULT NULL,
  PRIMARY KEY (`idPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create the `producto` table
CREATE TABLE `producto` (
  `idProducto` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(255) DEFAULT NULL,
  `Foto` LONGBLOB,
  `Descripcion` VARCHAR(255) DEFAULT NULL,
  `Precio` DOUBLE DEFAULT NULL,
  `Stock` INT(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create the `compras` table
CREATE TABLE `compras` (
  `idCompras` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCliente` INT(11) UNSIGNED NOT NULL,
  `idPago` INT(11) UNSIGNED NOT NULL,
  `FechaCompras` VARCHAR(11) DEFAULT NULL,
  `Monto` DOUBLE DEFAULT NULL,
  `Estado` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`idCompras`),
  KEY `Compras_FKIndex1` (`idPago`),
  KEY `Compras_FKIndex2` (`idCliente`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`idPago`) REFERENCES `pago` (`idPago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create the `detalle_compras` table
CREATE TABLE `detalle_compras` (
  `idDetalle` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idProducto` INT(11) UNSIGNED NOT NULL,
  `idCompras` INT(11) UNSIGNED NOT NULL,
  `Cantidad` INT(11) UNSIGNED DEFAULT NULL,
  `PrecioCompra` DOUBLE DEFAULT NULL,
  PRIMARY KEY (`idDetalle`, `idProducto`, `idCompras`),
  KEY `Producto_has_Compras_FKIndex1` (`idProducto`),
  KEY `Producto_has_Compras_FKIndex2` (`idCompras`),
  CONSTRAINT `detalle_compras_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `detalle_compras_ibfk_2` FOREIGN KEY (`idCompras`) REFERENCES `compras` (`idCompras`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insert data into the `producto` table
INSERT INTO `producto` (`Nombres`, `Foto`, `Descripcion`, `Precio`, `Stock`)
VALUES
('Response Runner U', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/86d116aad38341069b9a8a9c00f149ab_9366/RESPONSE_RUNNER_U_Gris_IH3578_01_standard.jpg'), 'Running, Gris, Sizes: 38, 39, 40, 41, 42', 199950, 1),
('Courtjam Control 3', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/0def145450e54b68afc289c2754a09d9_9366/Tenis_Courtjam_Control_3_para_Tenis_Negro_IF0458_01_standard.jpg'), 'Tennis, Negro, Sizes: 40, 41, 42, 43, 44', 479950, 1),
('Grand Court TD', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/ead11436ee0c431f9c17ae2e010caa60_9366/Tenis_adidas_Grand_Court_TD_Lifestyle_Court_Casual_Negro_GW9262_01_standard.jpg'), 'Sportswear, Negro, Sizes: 36, 37, 38, 39, 40', 299950, 1),
('Response Low', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/3348010b6d7b4a059cb41ed7e95352ba_9366/Tenis_Response_Low_Blanco_IF5857_01_standard.jpg'), 'Originals, Crema, Sizes: 38, 39, 40, 41, 42', 799950, 1),
('Forum Mid', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/aeef24e818ce466e9987afcb011b9444_9366/Tenis_Forum_Mid_Blanco_IE7181_01_standard.jpg'), 'Originals, Blanco, Amarillo, Sizes: 40, 41, 42, 43, 44', 599950, 1),
('Forum Low CL', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/8b18a7bd4ad249b68939140a279f34bf_9366/Tenis_Forum_Low_CL_Blanco_IG3778_01_standard.jpg'), 'Originals, Blanco, Verde, Sizes: 36, 37, 38, 39, 40', 599950, 1),
('Ozmillen', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/4b0aa0a7d8844a599137e9bc57b5a8c4_9366/Tenis_OZMILLEN_Gris_IF9111_01_standard.jpg'), 'Originals, Gris, Sizes: 38, 39, 40, 41, 42', 599950, 1),
('Response CL', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/c2dddc6943004690b187379401de455a_9366/Tenis_Response_CL_Verde_IG3391_01_standard.jpg'), 'Originals, Verde, Sizes: 38, 39, 40, 41, 42', 799950, 1),
('Ligthmotion Mid', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/f5d0ebdda06c40d4a2e0aeaf002fb0f6_9366/Tenis_de_Basquet_Own_the_Game_2.0_Lightmotion_Mid_Negro_GY9696_01_standard.jpg'), 'Sportswear, Negro, Sizes: 38, 39, 40, 41, 42', 439950, 1),
('Eastrail 2.0', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/7e7c954812ce4ec2af2eae9401284e54_9366/Tenis_de_Senderismo_Eastrail_2.0_Verde_GY9217_01_standard.jpg'), 'Terrex, Verde, Sizes: 38, 39, 40, 41, 42', 429950, 1),
('X_PLR Phase', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/6a8a850bba8145c89f17c565d540e846_9366/Tenis_X_PLR_Phase_Azul_IG4783_01_standard.jpg'), 'Sportswear, Azul, Sizes: 38, 39, 40, 41, 42', 629950, 1),
('Switch Run', LOAD_FILE('https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/88da71a5db1d46618dd4881dcce14878_9366/Tenin_Running_Switch_Run_Blanco_IF5719_01_standard.jpg'), 'Running, Blanco, Sizes: 38, 39, 40, 41, 42', 499950, 1);