-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotifydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotifydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotifydb` DEFAULT CHARACTER SET utf8 ;
USE `spotifydb` ;

-- -----------------------------------------------------
-- Table `spotifydb`.`datosTarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`datosTarjeta` (
  `iddatosTarjeta` INT NOT NULL AUTO_INCREMENT,
  `numeroTarjeta` INT NOT NULL,
  `mesCaducidad` VARCHAR(15) NOT NULL,
  `añoCaducudad` YEAR NOT NULL,
  PRIMARY KEY (`iddatosTarjeta`),
  UNIQUE INDEX `iddatosTarjeta_UNIQUE` (`iddatosTarjeta` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`paypal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`paypal` (
  `idpaypal` INT NOT NULL,
  `fechaPago` DATE NOT NULL,
  `total` FLOAT NOT NULL,
  `numeroDeOrden` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idpaypal`),
  UNIQUE INDEX `numeroDeOrden_UNIQUE` (`numeroDeOrden` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`usuarioPremium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`usuarioPremium` (
  `idusuarioPremium` INT NOT NULL AUTO_INCREMENT,
  `datosTarjeta_iddatosTarjeta` INT NOT NULL,
  `paypal_idpaypal` INT NOT NULL,
  `fechaInicioSupscripcion` DATE NOT NULL,
  `fechaRenovacionServivio` DATE NOT NULL,
  PRIMARY KEY (`idusuarioPremium`),
  INDEX `fk_usuarioPremium_datosTarjeta1_idx` (`datosTarjeta_iddatosTarjeta` ASC) VISIBLE,
  INDEX `fk_usuarioPremium_paypal1_idx` (`paypal_idpaypal` ASC) VISIBLE,
  CONSTRAINT `fk_usuarioPremium_datosTarjeta1`
    FOREIGN KEY (`datosTarjeta_iddatosTarjeta`)
    REFERENCES `spotifydb`.`datosTarjeta` (`iddatosTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarioPremium_paypal1`
    FOREIGN KEY (`paypal_idpaypal`)
    REFERENCES `spotifydb`.`paypal` (`idpaypal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `usuarioPremium_idusuarioPremium` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
  `nombreUsuario` VARCHAR(45) NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `sexo` CHAR NOT NULL,
  `pais` VARCHAR(25) NOT NULL,
  `codigoPostal` INT(5) NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `idusuario_UNIQUE` (`idusuario` ASC) VISIBLE,
  INDEX `fk_usuario_usuarioPremium_idx` (`usuarioPremium_idusuarioPremium` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_usuarioPremium`
    FOREIGN KEY (`usuarioPremium_idusuarioPremium`)
    REFERENCES `spotifydb`.`usuarioPremium` (`idusuarioPremium`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`usuarioFree`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`usuarioFree` (
  `idusuarioFree` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idusuarioFree`),
  UNIQUE INDEX `idusuarioFree_UNIQUE` (`idusuarioFree` ASC) VISIBLE,
  INDEX `fk_usuarioFree_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarioFree_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `spotifydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`playlist` (
  `idplaylist` INT NOT NULL AUTO_INCREMENT,
  `usuario_idusuario` INT NOT NULL,
  `titulo` VARCHAR(25) NOT NULL,
  `numeroCanciones` INT NOT NULL,
  `fechaCreacion` DATE NOT NULL,
  PRIMARY KEY (`idplaylist`),
  UNIQUE INDEX `idplaylist_UNIQUE` (`idplaylist` ASC) VISIBLE,
  INDEX `fk_playlist_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `spotifydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`playlistBorrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`playlistBorrada` (
  `idplaylistBorrada` INT NOT NULL,
  `playlist_idplaylist` INT NOT NULL,
  `fechaBorrado` DATE NULL,
  PRIMARY KEY (`idplaylistBorrada`),
  INDEX `fk_playlistBorrada_playlist1_idx` (`playlist_idplaylist` ASC) VISIBLE,
  CONSTRAINT `fk_playlistBorrada_playlist1`
    FOREIGN KEY (`playlist_idplaylist`)
    REFERENCES `spotifydb`.`playlist` (`idplaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`playlistaActiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`playlistaActiva` (
  `idplaylistaActiva` INT NOT NULL,
  `playlist_idplaylist` INT NOT NULL,
  `fechaActivacion` DATE NULL,
  PRIMARY KEY (`idplaylistaActiva`),
  INDEX `fk_playlistaActiva_playlist1_idx` (`playlist_idplaylist` ASC) VISIBLE,
  CONSTRAINT `fk_playlistaActiva_playlist1`
    FOREIGN KEY (`playlist_idplaylist`)
    REFERENCES `spotifydb`.`playlist` (`idplaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`playlistCompartida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`playlistCompartida` (
  `usuario_idusuario` INT NOT NULL,
  `playlistaActiva_idplaylistaActiva` INT NOT NULL,
  `fechaHora` DATETIME NOT NULL,
  PRIMARY KEY (`usuario_idusuario`, `playlistaActiva_idplaylistaActiva`),
  INDEX `fk_usuario_has_playlistaActiva_playlistaActiva1_idx` (`playlistaActiva_idplaylistaActiva` ASC) VISIBLE,
  INDEX `fk_usuario_has_playlistaActiva_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_has_playlistaActiva_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `spotifydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_playlistaActiva_playlistaActiva1`
    FOREIGN KEY (`playlistaActiva_idplaylistaActiva`)
    REFERENCES `spotifydb`.`playlistaActiva` (`idplaylistaActiva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`artista` (
  `idartista` INT NOT NULL,
  `imagenArtista` BLOB NOT NULL,
  PRIMARY KEY (`idartista`),
  UNIQUE INDEX `idartista_UNIQUE` (`idartista` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`album` (
  `idalbum` INT NOT NULL,
  `artista_idartista` INT NOT NULL,
  `titulo` VARCHAR(25) NOT NULL,
  `añoPublicacion` YEAR NOT NULL,
  `portada` BLOB NOT NULL,
  PRIMARY KEY (`idalbum`),
  INDEX `fk_album_artista1_idx` (`artista_idartista` ASC) VISIBLE,
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`artista_idartista`)
    REFERENCES `spotifydb`.`artista` (`idartista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`cancion` (
  `idcancion` INT NOT NULL,
  `album_idalbum` INT NOT NULL,
  `playlist_idplaylist` INT NOT NULL,
  `titulo` VARCHAR(25) NOT NULL,
  `duracion` FLOAT NOT NULL,
  `numeroReproducciones` INT NOT NULL,
  PRIMARY KEY (`idcancion`),
  INDEX `fk_cancion_album1_idx` (`album_idalbum` ASC) VISIBLE,
  INDEX `fk_cancion_playlist1_idx` (`playlist_idplaylist` ASC) VISIBLE,
  CONSTRAINT `fk_cancion_album1`
    FOREIGN KEY (`album_idalbum`)
    REFERENCES `spotifydb`.`album` (`idalbum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cancion_playlist1`
    FOREIGN KEY (`playlist_idplaylist`)
    REFERENCES `spotifydb`.`playlist` (`idplaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotifydb`.`artista_has_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotifydb`.`artista_has_usuario` (
  `artista_idartista` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`artista_idartista`, `usuario_idusuario`),
  INDEX `fk_artista_has_usuario_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  INDEX `fk_artista_has_usuario_artista1_idx` (`artista_idartista` ASC) VISIBLE,
  CONSTRAINT `fk_artista_has_usuario_artista1`
    FOREIGN KEY (`artista_idartista`)
    REFERENCES `spotifydb`.`artista` (`idartista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artista_has_usuario_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `spotifydb`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
