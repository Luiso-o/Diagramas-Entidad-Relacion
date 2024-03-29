-- MySQL Script generated by MySQL Workbench
-- Mon Jun 12 19:47:53 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeriadb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeriadb` ;

-- -----------------------------------------------------
-- Schema pizzeriadb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeriadb` DEFAULT CHARACTER SET utf8 ;
USE `pizzeriadb` ;

-- -----------------------------------------------------
-- Table `pizzeriadb`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`provincia` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT,
  `nombreProvincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idProvincia_UNIQUE` ON `pizzeriadb`.`provincia` (`idProvincia` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`localidad` (
  `idlocalidad` INT NOT NULL,
  `provincia_idProvincia` INT NOT NULL,
  `nombreLocalidad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idlocalidad`),
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_idProvincia`)
    REFERENCES `pizzeriadb`.`provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_localidad_provincia1_idx` ON `pizzeriadb`.`localidad` (`provincia_idProvincia` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `localidad_idlocalidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `dirección` VARCHAR(50) NOT NULL,
  `codigoPostal` INT(5) NOT NULL,
  `telefono` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  CONSTRAINT `fk_cliente_localidad1`
    FOREIGN KEY (`localidad_idlocalidad`)
    REFERENCES `pizzeriadb`.`localidad` (`idlocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idcliente_UNIQUE` ON `pizzeriadb`.`cliente` (`idcliente` ASC) VISIBLE;

CREATE INDEX `fk_cliente_localidad1_idx` ON `pizzeriadb`.`cliente` (`localidad_idlocalidad` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`tienda` (
  `idtienda` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigoPostal` INT(5) NOT NULL,
  `Localidad` VARCHAR(25) NOT NULL,
  `provincia` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`idtienda`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idtienda_UNIQUE` ON `pizzeriadb`.`tienda` (`idtienda` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`pedido` (
  `idpedido` INT NOT NULL AUTO_INCREMENT,
  `cliente_idcliente` INT NOT NULL,
  `tienda_idtienda` INT NOT NULL,
  `fechaHora` DATETIME NOT NULL,
  `totalProductos` INT NOT NULL,
  `precioTotal` INT NOT NULL,
  `parallevar` TINYINT NOT NULL,
  PRIMARY KEY (`idpedido`),
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `pizzeriadb`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `pizzeriadb`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `idpedido_UNIQUE` ON `pizzeriadb`.`pedido` (`idpedido` ASC) VISIBLE;

CREATE INDEX `fk_pedido_cliente1_idx` ON `pizzeriadb`.`pedido` (`cliente_idcliente` ASC) VISIBLE;

CREATE INDEX `fk_pedido_tienda1_idx` ON `pizzeriadb`.`pedido` (`tienda_idtienda` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `pedido_idpedido` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `imagen` BLOB NOT NULL,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`idproductos`),
  CONSTRAINT `fk_productos_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `pizzeriadb`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_productos_pedido1_idx` ON `pizzeriadb`.`productos` (`pedido_idpedido` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`categoriaPizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`categoriaPizza` (
  `idcategoriaPizza` INT NOT NULL,
  `productos_idproductos` INT NOT NULL,
  `nombreCategoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategoriaPizza`),
  CONSTRAINT `fk_categoriaPizza_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `pizzeriadb`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_categoriaPizza_productos1_idx` ON `pizzeriadb`.`categoriaPizza` (`productos_idproductos` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`cocineroQueLibra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`cocineroQueLibra` (
  `idcocineroQueLibra` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `fechaHora` DATETIME NULL,
  PRIMARY KEY (`idcocineroQueLibra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`repartidorQueLibra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`repartidorQueLibra` (
  `idrepartidorQueLibra` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `fechaHora` DATETIME NULL,
  PRIMARY KEY (`idrepartidorQueLibra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeriadb`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeriadb`.`empleados` (
  `idempleados` INT NOT NULL AUTO_INCREMENT,
  `tienda_idtienda` INT NOT NULL,
  `cocineroQueLibra_idcocineroQueLibra` INT NOT NULL,
  `repartidorQueLibra_idrepartidorQueLibra` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  `telefono` INT(9) NOT NULL,
  PRIMARY KEY (`idempleados`),
  CONSTRAINT `fk_empleados_tienda1`
    FOREIGN KEY (`tienda_idtienda`)
    REFERENCES `pizzeriadb`.`tienda` (`idtienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_cocineroQueLibra1`
    FOREIGN KEY (`cocineroQueLibra_idcocineroQueLibra`)
    REFERENCES `pizzeriadb`.`cocineroQueLibra` (`idcocineroQueLibra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_repartidorQueLibra1`
    FOREIGN KEY (`repartidorQueLibra_idrepartidorQueLibra`)
    REFERENCES `pizzeriadb`.`repartidorQueLibra` (`idrepartidorQueLibra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_empleados_tienda1_idx` ON `pizzeriadb`.`empleados` (`tienda_idtienda` ASC) VISIBLE;

CREATE INDEX `fk_empleados_cocineroQueLibra1_idx` ON `pizzeriadb`.`empleados` (`cocineroQueLibra_idcocineroQueLibra` ASC) VISIBLE;

CREATE INDEX `fk_empleados_repartidorQueLibra1_idx` ON `pizzeriadb`.`empleados` (`repartidorQueLibra_idrepartidorQueLibra` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
