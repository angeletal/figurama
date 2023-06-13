DROP DATABASE IF EXISTS figurama;

CREATE DATABASE figurama;
USE figurama;


CREATE TABLE Serie (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
imagenUrl VARCHAR(100) NOT NULL,
nombre VARCHAR(70) NOT NULL
);

CREATE TABLE Material (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Proveedor (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
imagenUrl VARCHAR(100)

);

CREATE TABLE Personaje (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
idSerie INT NOT NULL,
imagenUrl VARCHAR(100),
FOREIGN KEY (idSerie) REFERENCES Serie(id)
);

CREATE TABLE Figura (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
descripcion TEXT NOT NULL,
fechaSalida DATE NOT NULL,
precio DECIMAL(10,2) NOT NULL,
stock INT NOT NULL,
altura INT NOT NULL,
descuento INT NOT NULL,
idPersonaje INT NOT NULL,
idProveedor INT NOT NULL,
idMaterial INT NOT NULL,
FOREIGN KEY (idPersonaje) REFERENCES Personaje(id),
FOREIGN KEY (idProveedor) REFERENCES Proveedor(id),
FOREIGN KEY (idMaterial) REFERENCES Material(id)

);

CREATE TABLE Usuario (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
apellidos VARCHAR (100) NOT NULL,
contrasena VARCHAR(30) NOT NULL,
email VARCHAR(50) NOT NULL,
direccion VARCHAR(150) ,
telefono VARCHAR(20) NOT NULL,
rol VARCHAR(20) NOT NULL
);

CREATE TABLE Pedido (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
fecha DATE NOT NULL,
estado VARCHAR(60),
idUsuario INT NOT NULL,
direccion VARCHAR(150) NOT NULL,
FOREIGN KEY (idUsuario) REFERENCES Usuario(id)
);

CREATE TABLE Cesta (
idUsuario INT NOT NULL,
idFigura INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (idUsuario, idFigura),
FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE ListaDeseos (
idUsuario INT NOT NULL,
idFigura INT NOT NULL,
PRIMARY KEY (idUsuario, idFigura),
FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE Venta (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
cantidad INT NOT NULL,
precioUd DECIMAL(10,2) NOT NULL,
idPedido INT NOT NULL,
idFigura INT NOT NULL,
FOREIGN KEY (idPedido) REFERENCES Pedido(id),
FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE Imagen (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  url VARCHAR(100) NOT NULL,
  idFigura INT NOT NULL,
  FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

INSERT INTO `usuario`(`nombre`, `apellidos`, `contrasena`, `email`, `telefono`, `rol`) VALUES ('anonmo', ' anonimo', 'anonimo', 'anonimo', 777777777,'comun');

INSERT INTO `usuario`(`nombre`, `apellidos`, `contrasena`, `email`, `telefono`, `rol`) VALUES ('Miguel', ' Ruiz', 'Miguel1', 'miguel@gmail.com', 677375777,'comun');

INSERT INTO `usuario`(`nombre`, `apellidos`, `contrasena`, `email`, `telefono`, `rol`) VALUES ('Pepe', ' Pérez', 'Pepe1', 'pepe@gmail.com', 772334777,'comun');

INSERT INTO `usuario`(`nombre`, `apellidos`, `contrasena`, `email`, `telefono`, `rol`) VALUES ('Guillermo', ' Hernández', 'Guillermo1', 'guillermo@gmail.com', 777777777,'Admin');

INSERT INTO `usuario`(`nombre`, `apellidos`, `contrasena`, `email`, `telefono`, `rol`) VALUES ('José', ' Fontana', 'Jose1', 'jose@gmail.com', 777777777, 'comun');

INSERT INTO `usuario`(`nombre`, `apellidos`, `contrasena`, `email`, `telefono`, `rol`) VALUES ('Francisco', 'Rivera', 'Francisco1', 'francisco@gmail.com', 777777777,'Admin');



INSERT INTO `serie`(`imagenUrl`, `nombre`) VALUES ('one_piece.png','One Piece');

INSERT INTO `serie`(`imagenUrl`, `nombre`) VALUES ('dragon_ball_z.png', 'Dragon Ball Z');

INSERT INTO `serie`(`imagenUrl`, `nombre`) VALUES ('kimetsu_no_yaiba.png', 'Kimetsu No Yaiba');




INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Luffy', 1, 'luffy.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Goku', 2, 'goku.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Giyu', 3, 'giyu.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Piccolo', 2, 'piccolo.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Rengoku', 3, 'rengoku.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Zoro', 1, 'zoro.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Shinobu', 3, 'shinobu.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Vegeta', 2, 'vegeta.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Yamato', 1, 'yamato.png');




INSERT INTO `material`(`nombre`) VALUES ('PVC');

INSERT INTO `proveedor`(`nombre`,`imagenUrl`) VALUES ('Banpresto', 'banpresto.jpg');

INSERT INTO `proveedor`(`nombre`,`imagenUrl`) VALUES ('Kotobukiya', 'kotobukiya.jpg');

INSERT INTO `proveedor`(`nombre`,`imagenUrl`) VALUES ('Ichibansho', 'ichibansho.jpg');



INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`,`idMaterial`) VALUES ('Figura Monkey D. Luffy One Piece – Banpresto Chronicle King Of Artist 18cm','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','59.99','50','18','1','1','1');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Monkey D. Luffy One Piece Banpresto Chronicle King Of Artist 18cm_1.jpg','1');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Monkey D. Luffy One Piece Banpresto Chronicle King Of Artist 18cm_2.jpg','1');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Monkey D. Luffy One Piece Banpresto Chronicle King Of Artist 18cm_3.jpg','1');


INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`, `idMaterial`) VALUES ('Figura Goku Super Saiyan Dragon Ball Super – Super Zenkai Solid Vol. 1 19cm','¡Añade la figura de Goku Super Saiyan a tu colección de figuras de Dragon Ball Super!

Banpresto presenta la figura de Super Saiyan Son Goku de la popular serie de anime “Dragon Ball Super”. Esta figura está hecha en PVC, mide unos 19 cm de alto e incluye una base soporte para exposición.','2023-05-12',30.99,'40',19,2,1,1);

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Goku Super Saiyan Dragon Ball Super – Super Zenkai Solid Vol. 1 19cm_1.jpg',2);
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Goku Super Saiyan Dragon Ball Super – Super Zenkai Solid Vol. 1 19cm_2.jpg',2);
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Goku Super Saiyan Dragon Ball Super – Super Zenkai Solid Vol. 1 19cm_3.jpg',2);




INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`, `idMaterial`) VALUES ('Figura Monkey D. Luffy One Piece – Banpresto Chronicle King Of Artist 18cm','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','43.99','20','18','1','1',1);


INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Monkey D. Luffyy One Piece – Kotobukiya Chronicle King Of Artist 18cm_1.jpg','3');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Monkey D. Luffyy One Piece – Kotobukiya Chronicle King Of Artist 18cm_2.jpg','3');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Monkey D. Luffyy One Piece – Kotobukiya Chronicle King Of Artist 18cm.jpg','3');

	




INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`, `idMaterial`) VALUES ('Figura Giyu Ichibansho Chronicle King Of Artist 18cm','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','45.99','20','18','3','2',1);


INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Giyu Ichibansho Chronicle King Of Artist 18cm_1.jpg','4');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Giyu Ichibansho Chronicle King Of Artist 18cm_2.jpg','4');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Giyu Ichibansho Chronicle King Of Artist 18cm_3.jpg','4');



INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`, `descuento`, `idMaterial`) VALUES ('Figura Piccolo King Of Artist 18cm','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','51.99','20','18','4','1',15,1);


INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Piccolo King Of Artist 18cm_1.jpg','5');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Piccolo King Of Artist 18cm_2.jpg','5');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Piccolo King Of Artist 18cm_3.jpg','5');




INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`, `descuento`, `idMaterial`) VALUES ('Figura Vegeta Ichibansho Chronicle King Of Artist 18cm','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2022-05-12','51.99','20','18','8','3','27',1);


INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Vegeta Ichibansho Chronicle King Of Artist 18cm_1.jpg','6');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Vegeta Ichibansho Chronicle King Of Artist 18cm_2.jpg','6');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Vegeta Ichibansho Chronicle King Of Artist 18cm_3.jpg','6');




INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`, `descuento`, `idMaterial`) VALUES ('Figura Rengoku Ichibansho Chronicle King Of Artist 18cm','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','51.99','20','18','5','2','25',1);


INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Rengoku Ichibansho Chronicle King Of Artist 18cm_1.jpg','7');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Rengoku Ichibansho Chronicle King Of Artist 18cm_2.jpg','7');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('Figura Rengoku Ichibansho Chronicle King Of Artist 18cm_3.jpg','7');




INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`,`idMaterial`) VALUES ('FIGURA MONKEY D. LUFFY ONE PIECE – GRANDISTA NERO','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','89.99','50','18','1','1','1');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA MONKEY D. LUFFY ONE PIECE – GRANDISTA NERO_1.jpg','8');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA MONKEY D. LUFFY ONE PIECE – GRANDISTA NERO_2.jpg','8');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA MONKEY D. LUFFY ONE PIECE – GRANDISTA NERO_3.jpg','8');



INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`,`idMaterial`) VALUES ('FIGURA LUFFY ONE PIECE – SCULTURES BIG COLOSSEUM VI VOL.3 8CM','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','89.99','50','18','1','1','1');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA LUFFY ONE PIECE – SCULTURES BIG COLOSSEUM VI VOL.3 8CM_1.jpg','9');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA LUFFY ONE PIECE – SCULTURES BIG COLOSSEUM VI VOL.3 8CM_2.jpg','9');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA LUFFY ONE PIECE – SCULTURES BIG COLOSSEUM VI VOL.3 8CM_3.jpg','9');





INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`,`idMaterial`) VALUES ('FIGURA MONKEY D. LUFFY II ONE PIECE – BATTLE RECORD COLLECTION 15CM','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','89.99','50','18','1','1','1');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA MONKEY D. LUFFY II ONE PIECE – BATTLE RECORD COLLECTION 15CM_1.jpg','10');

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA MONKEY D. LUFFY II ONE PIECE – BATTLE RECORD COLLECTION 15CM_2.jpg','10');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('FIGURA MONKEY D. LUFFY II ONE PIECE – BATTLE RECORD COLLECTION 15CM_3.jpg','10');


