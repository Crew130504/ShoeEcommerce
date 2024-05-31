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
('Response Runner U', LOAD_FILE('path_to_images/response_runner_u.jpg'), 'Running, Gris, Sizes: 38, 39, 40, 41, 42', 199950, 1),
('Courtjam Control 3', LOAD_FILE('path_to_images/courtjam_control_3.jpg'), 'Tennis, Negro, Sizes: 40, 41, 42, 43, 44', 479950, 1),
('Grand Court TD', LOAD_FILE('path_to_images/grand_court_td.jpg'), 'Sportswear, Negro, Sizes: 36, 37, 38, 39, 40', 299950, 1),
('Response Low', LOAD_FILE('path_to_images/response_low.jpg'), 'Originals, Crema, Sizes: 38, 39, 40, 41, 42', 799950, 1),
('Forum Mid', LOAD_FILE('path_to_images/forum_mid.jpg'), 'Originals, Blanco, Amarillo, Sizes: 40, 41, 42, 43, 44', 599950, 1),
('Forum Low CL', LOAD_FILE('path_to_images/forum_low_cl.jpg'), 'Originals, Blanco, Verde, Sizes: 36, 37, 38, 39, 40', 599950, 1),
('Ozmillen', LOAD_FILE('path_to_images/ozmillen.jpg'), 'Originals, Gris, Sizes: 38, 39, 40, 41, 42', 599950, 1),
('Response CL', LOAD_FILE('path_to_images/response_cl.jpg'), 'Originals, Verde, Sizes: 38, 39, 40, 41, 42', 799950, 1),
('Ligthmotion Mid', LOAD_FILE('path_to_images/ligthmotion_mid.jpg'), 'Sportswear, Negro, Sizes: 38, 39, 40, 41, 42', 439950, 1),
('Eastrail 2.0', LOAD_FILE('path_to_images/eastrail_2.jpg'), 'Terrex, Verde, Sizes: 38, 39, 40, 41, 42', 429950, 1),
('X_PLR Phase', LOAD_FILE('path_to_images/x_plr_phase.jpg'), 'Sportswear, Azul, Sizes: 38, 39, 40, 41, 42', 629950, 1),
('Switch Run', LOAD_FILE('path_to_images/switch_run.jpg'), 'Running, Blanco, Sizes: 38, 39, 40, 41, 42', 499950, 1);