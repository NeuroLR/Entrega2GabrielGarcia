CREATE SCHEMA IF NOT EXISTS `cursosql` DEFAULT CHARACTER SET utf8 ;
USE `cursosql` ;

-- -----------------------------------------------------
-- Table `cursosql`.`CLIENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`CLIENTS` (
  `CLIENT_ID` INT NOT NULL AUTO_INCREMENT COMMENT 'ID DEL CLIENTE',
  `USERNAME` VARCHAR(50) NOT NULL COMMENT 'NOMBRE DE USUARIO DEL CLIENTE',
  `DOCUMENT_TYPE` INT NOT NULL COMMENT 'TIPO DEL DOCUMENTO',
  `DOCUMENT_NUMBER` VARCHAR(20) NOT NULL COMMENT 'NUMERO DE DOCUMENTO DEL CLIENTE',
  `FULLNAME` VARCHAR(255) NOT NULL COMMENT 'NOMBRE COMPLETO',
  `POSTAL_CODE` VARCHAR(10) NOT NULL COMMENT 'CODGIO POSTAL',
  `ADDRESS` VARCHAR(255) NOT NULL COMMENT 'DIRECCION',
  `EMAIL` VARCHAR(255) NOT NULL COMMENT 'EMAIL DEL CLIENTE',
  `PASSWORD` VARCHAR(50) NOT NULL COMMENT 'CONTRASEÑA DEL CLIENTE',
  PRIMARY KEY (`CLIENT_ID`),
  UNIQUE INDEX `CLIENT_ID_UNIQUE` (`CLIENT_ID` ASC),
  UNIQUE INDEX `DOCUMENT_NUMBER_UNIQUE` (`DOCUMENT_NUMBER` ASC),
  UNIQUE INDEX `USERNAME_UNIQUE` (`USERNAME` ASC),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursosql`.`CLIENT_CARD_INFORMATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`CLIENT_CARD_INFORMATION` (
    `CARD_ID` INT NOT NULL AUTO_INCREMENT COMMENT 'ID DE LA TARJETA',
    `CARD_NUMBER` VARCHAR(16) NOT NULL COMMENT 'NUMERO DE LA TARJETA',
    `CARD_EXPIRATION` DATE NOT NULL COMMENT 'VENCIMIENTO DE LA TARJETA',
    `CARD_NAME` VARCHAR(255) NOT NULL COMMENT 'NOMBRE DEL TITULAR DE LA TARJETA',
    `CLIENT_ID` INT NOT NULL,
    PRIMARY KEY (`CARD_ID`),
    UNIQUE INDEX `CARD_ID_UNIQUE` (`CARD_ID` ASC),
    UNIQUE INDEX `CLIENT_ID_UNIQUE` (`CLIENT_ID` ASC),
    CONSTRAINT `CLIENT_ID` FOREIGN KEY (`CLIENT_ID`)
        REFERENCES `cursosql`.`CLIENTS` (`CLIENT_ID`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB;


-- -----------------------------------------------------
-- Table `cursosql`.`SHOPPING_CART`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`SHOPPING_CART` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CLIENTS_CLIENT_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `CLIENTS_CLIENT_ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_SHOPPING CART_CLIENTS2_idx` (`CLIENTS_CLIENT_ID` ASC),
  CONSTRAINT `fk_SHOPPING CART_CLIENTS2`
    FOREIGN KEY (`CLIENTS_CLIENT_ID`)
    REFERENCES `cursosql`.`CLIENTS` (`CLIENT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursosql`.`SELLER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`SELLER` (
  `SELLER_ID` INT NOT NULL AUTO_INCREMENT,
  `USERNAME` VARCHAR(50) NOT NULL,
  `DOCUMENT_TYPE` INT NOT NULL,
  `DOCUMENT_NUMBER` VARCHAR(20) NOT NULL,
  `FULLNAME` VARCHAR(255) NOT NULL,
  `ADDRESS` VARCHAR(255) NOT NULL,
  `POSTAL_CODE` VARCHAR(10) NOT NULL,
  `EMAIL` VARCHAR(255) NOT NULL,
  `PASSWORD` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`SELLER_ID`),
  UNIQUE INDEX `SELLER_ID_UNIQUE` (`SELLER_ID` ASC),
  UNIQUE INDEX `USERNAME_UNIQUE` (`USERNAME` ASC),
  UNIQUE INDEX `DOCUMENT_NUMBER_UNIQUE` (`DOCUMENT_NUMBER` ASC),
  UNIQUE INDEX `EMAIL_UNIQUE` (`EMAIL` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursosql`.`POSTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`POSTS` (
  `POST_ID` INT NOT NULL AUTO_INCREMENT,
  `TITLE` VARCHAR(255) NOT NULL COMMENT 'TITULO DE LA PUBLICACION',
  `DESCRIPTION` VARCHAR(3000) NOT NULL COMMENT 'DESCRIPCION DE LA PUBLICACION',
  `PRICE` INT(20) NOT NULL,
  `SCORE` FLOAT(1) NOT NULL,
  `FEATURES` VARCHAR(1000) NOT NULL,
  `SELLER_ID` INT NOT NULL,
  PRIMARY KEY (`POST_ID`),
  UNIQUE INDEX `POST_ID_UNIQUE` (`POST_ID` ASC),
  INDEX `fk_POSTS_SELLER1_idx` (`SELLER_ID` ASC),
  CONSTRAINT `fk_POSTS_SELLER1`
    FOREIGN KEY (`SELLER_ID`)
    REFERENCES `cursosql`.`SELLER` (`SELLER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `cursosql`.`POST_has_SHOPPING_CART`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`POST_has_SHOPPING_CART` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `POST_ID` INT NOT NULL,
  `SHOPPING_CART_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `POST_ID`, `SHOPPING_CART_ID`),
  INDEX `fk_POST_has_SHOPPING CART_SHOPPING CART1_idx` (`SHOPPING_CART_ID` ASC),
  INDEX `fk_POST_has_SHOPPING CART_POST1_idx` (`POST_ID` ASC),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_POST_SHOPPING_CART`
    FOREIGN KEY (`POST_ID`)
    REFERENCES `cursosql`.`POSTS` (`POST_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_POST_has_SHOPPING_CART_SHOPPING_CART1`
    FOREIGN KEY (`SHOPPING_CART_ID`)
    REFERENCES `cursosql`.`SHOPPING_CART` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursosql`.`COMMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`COMMENT` (
  `COMMENT_ID` INT NOT NULL AUTO_INCREMENT,
  `TEXT` VARCHAR(3000) NOT NULL COMMENT 'COMENTARIO',
  `SCORE` FLOAT(1) NOT NULL COMMENT 'PUNTAJE DEL PRODUCTO',
  `DATE` DATE NOT NULL,
  `CLIENT_ID` INT NOT NULL,
  `POST_ID` INT NOT NULL,
  PRIMARY KEY (`COMMENT_ID`, `CLIENT_ID`, `POST_ID`),
  UNIQUE INDEX `COMMENT_ID_UNIQUE` (`COMMENT_ID` ASC),
  INDEX `fk_COMMENT_CLIENTS1_idx` (`CLIENT_ID` ASC),
  INDEX `fk_COMMENT_POSTS1_idx` (`POST_ID` ASC),
  CONSTRAINT `fk_COMMENT_CLIENTS1`
    FOREIGN KEY (`CLIENT_ID`)
    REFERENCES `cursosql`.`CLIENTS` (`CLIENT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMMENT_POSTS1`
    FOREIGN KEY (`POST_ID`)
    REFERENCES `cursosql`.`POSTS` (`POST_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursosql`.`SELLER_CARD_INFORMATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`SELLER_CARD_INFORMATION` (
  `CARD_ID` INT NOT NULL AUTO_INCREMENT COMMENT 'ID DE LA TARJETA',
  `CARD_NUMBER` VARCHAR(16) NOT NULL COMMENT 'NUMERO DE LA TARJETA',
  `CARD_EXPIRATION` DATE NOT NULL COMMENT 'VENCIMIENTO DE LA TARJETA',
  `CARD_NAME` VARCHAR(255) NOT NULL COMMENT 'NOMBRE DEL TITULAR DE LA TARJETA',
  `SELLER_ID` INT NOT NULL,
  PRIMARY KEY (`CARD_ID`, `SELLER_ID`),
  UNIQUE INDEX `CARD_ID_UNIQUE` (`CARD_ID` ASC),
  INDEX `fk_CLIENT_CARD_INFORMATION_copy1_SELLER1_idx` (`SELLER_ID` ASC),
  CONSTRAINT `fk_CLIENT_CARD_INFORMATION_copy1_SELLER1`
    FOREIGN KEY (`SELLER_ID`)
    REFERENCES `cursosql`.`SELLER` (`SELLER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursosql`.`SAVED_POSTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`SAVED_POSTS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `CLIENTS_CLIENT_ID` INT NOT NULL,
  `POSTS_POST_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_SAVED_POSTS_CLIENTS1_idx` (`CLIENTS_CLIENT_ID` ASC),
  CONSTRAINT `fk_SAVED_POSTS_CLIENTS1`
    FOREIGN KEY (`CLIENTS_CLIENT_ID`)
    REFERENCES `cursosql`.`CLIENTS` (`CLIENT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cursosql`.`SAVED_POSTS_has_POSTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cursosql`.`SAVED_POSTS_has_POSTS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `SAVED_POSTS_ID` INT NOT NULL,
  `POSTS_POST_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `SAVED_POSTS_ID`, `POSTS_POST_ID`),
  INDEX `fk_SAVED_POSTS_has_POSTS_POSTS1_idx` (`POSTS_POST_ID` ASC),
  INDEX `fk_SAVED_POSTS_has_POSTS_SAVED_POSTS1_idx` (`SAVED_POSTS_ID` ASC),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  CONSTRAINT `fk_SAVED_POSTS_has_POSTS_SAVED_POSTS1`
    FOREIGN KEY (`SAVED_POSTS_ID`)
    REFERENCES `cursosql`.`SAVED_POSTS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SAVED_POSTS_has_POSTS_POSTS1`
    FOREIGN KEY (`POSTS_POST_ID`)
    REFERENCES `cursosql`.`POSTS` (`POST_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO clients
(`USERNAME`,
`DOCUMENT_TYPE`,
`DOCUMENT_NUMBER`,
`FULLNAME`,
`POSTAL_CODE`,
`ADDRESS`,
`EMAIL`,
`PASSWORD`)
VALUES
 ("gabriel_garcia147",
 0,"43405039",
 "GABRIEL GARCIA",
 "1906", "Av. Corrientes 1592",
 "gabrielgarcia@gmail.com", 
 "contraseña123");

INSERT INTO client_card_information
(`CARD_NUMBER`,
`CARD_EXPIRATION`,
`CARD_NAME`,
`CLIENT_ID`)
VALUES
("8000456132149000",
"2029-09-1",
"Gabriel Garcia",
1);

INSERT INTO seller
(`USERNAME`,
`DOCUMENT_TYPE`,
`DOCUMENT_NUMBER`,
`FULLNAME`,
`ADDRESS`,
`POSTAL_CODE`,
`EMAIL`,
`PASSWORD`)
VALUES
("vendedor123",
0,
"42906030",
"matias perez",
"Calle falsa 123",
"1820",
"matiperez@hotmail.com",
"qaz741");

INSERT INTO seller_card_information
(`CARD_NUMBER`,
`CARD_EXPIRATION`,
`CARD_NAME`,
`SELLER_ID`)
VALUES
("1000200030004000",
"2030-04-1",
"Matias Perez",
1);

INSERT INTO posts
(`TITLE`,
`DESCRIPTION`,
`PRICE`,
`SCORE`,
`FEATURES`,
`SELLER_ID`)
VALUES
("VENDO PLAY 2 CHIPEADA",
"ps2 chipeada en perfecto estado",
3500,
4.6,
"memoria 32gb",
1);

INSERT INTO `cursosql`.`comment`
(`TEXT`,
`SCORE`,
`DATE`,
`CLIENT_ID`,
`POST_ID`)
VALUES
("muy buen producto, lo recomiendo",
5.0,
"2023-08-09",
1,
1);

INSERT INTO saved_posts
(`CLIENTS_CLIENT_ID`,
`POSTS_POST_ID`)
VALUES
(1,
1);

INSERT INTO saved_posts_has_posts
(`SAVED_POSTS_ID`,
`POSTS_POST_ID`)
VALUES
(1,
1);

INSERT INTO `shopping_cart`
(`CLIENTS_CLIENT_ID`)
VALUES
(1);

INSERT INTO `POST_HAS_SHOPPING_CART`
(`POST_ID`,
`SHOPPING_CART_ID`)
VALUES
(1,
1);

SELECT obtener_nombre_completo(43405039, true) AS nombreCompleto;

SELECT obtener_tarjeta(42906030, false) as tarjeta;

-- VISTAS DEL PROYECTO -- 
-- Vista "informacion_del_cliente"
-- Se encarga de obtener todos los datos necesarios para la compra de un producto
-- estos datos son:
-- nombre completo, dni, direccion, codigo postal, numero de tarjeta, fecha de vencimiento de la tarjeta.
-- esta vista utiliza las tablas clients y client_card_information
CREATE OR REPLACE VIEW informacion_del_cliente AS 
	SELECT c.FULLNAME as nombreCompleto, c.DOCUMENT_NUMBER as DNI, c.ADDRESS as direccion, 
    c.POSTAL_CODE as codigoPostal, card.CARD_NUMBER as numTarjeta, card.CARD_EXPIRATION as fechaVencimiento 
	FROM clients c INNER JOIN 
    client_card_information card ON 
    c.CLIENT_ID = card.CLIENT_ID;
    
SELECT * from informacion_del_cliente;

-- VISTA publicaciones_subidas --
-- Se encarga de recopilar todos las publicaciones y el usuario del vendedor
-- Obtiene informacion del vendedor relevante para el cliente como la direccion y el email
-- Obtiene todos los detalles de la publicacion a mostrar como el titulo, precio, puntuacion
-- esta vista utiliza las tablas seller y posts
CREATE OR REPLACE VIEW publicaciones_subidas AS
	SELECT s.USERNAME as nombreUsuario, s.ADDRESS as direccion, s.EMAIL as email, p.TITLE as tituloPost,
    p.DESCRIPTION as descripcionPost, p.PRICE as precio, p.SCORE as puntuacion, p.FEATURES as caracteristicas
    FROM seller s JOIN
    posts p ON 
    s.SELLER_ID = p.SELLER_ID;

SELECT * from publicaciones_subidas;

-- STORED PROCEDURES --
-- El SP "publicaciones_guardadas" se encarga de obtener todos los datos del cliente incluyendo las publicaciones
-- que tenga guardadas.
-- Necesita un solo parametro que es el ID del cliente
DELIMITER //
CREATE PROCEDURE publicaciones_guardadas(IN clientId INT)
BEGIN
	SELECT * FROM clients c INNER JOIN saved_posts s
    ON c.CLIENT_ID AND s.CLIENTS_CLIENT_ID = clientId
    INNER JOIN posts p ON p.POST_ID = s.POSTS_POST_ID;
END; //

CALL publicaciones_guardadas(1);

