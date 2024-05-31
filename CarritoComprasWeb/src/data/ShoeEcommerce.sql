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