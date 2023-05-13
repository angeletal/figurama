INSERT INTO `usuario`(`nombre`, `apellidos`, `contrasena`, `email`, `telefono`, `puntosSocio`, `rol`, `esBaja`) VALUES ('José','Sánchez Viyuela','a','a@a.a','777777777',0, 'Admin',0);

INSERT INTO `serie`(`imagen`, `nombre`, `descripcion`) VALUES ('one_piece.png','One Piece', 'One Piece es el manga más vendido en Japón, superando incluso a Dragon Ball Z y eso es porque son muchos los fanáticos que adoran esta trama y por supuesto a sus personajes. Por eso ¿qué mejor forma que seguir disfrutando de ellos que con sus personajes, los sombreros de paja?
 
A nosotros nos encantan por eso en Banpresto puedes te ofrecemos las figuras de toda la tripulación de los Sombrero de Paja para que elijas tu personaje favorito o mejor aun te hagas con toda la tripulación pirata.');


INSERT INTO `serie`(`imagen`, `nombre`, `descripcion`) VALUES ('dragon_ball_z.png', 'Dragon Ball Z', 'Porque si estás aquí es que te encanta Dragon Ball y lo sabes, bien porque te recuerda a tu infancia, en la que fantaseabas con ser uno de los personajes de aquella fantástica serie de los años 90 o para recrear esas batallas espectaculares, de Goku, Krilin y todos sus amigos, vivirlas y elegir el final. O también te puede apetecer mostrar a tus hijos una parte de ti. Sea cual sea tu motivación, has llegado al sitio indicado ¡Busca, encuentra y disfruta!');


INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Goku', 2, 'goku.png');

INSERT INTO `personaje`(`nombre`, `idSerie`, `imagenUrl`) VALUES ('Luffy', 1, 'luffy.png');

INSERT INTO `material`(`nombre`) VALUES ('PVC');

INSERT INTO `proveedor`(`nombre`) VALUES ('Banpresto');


INSERT INTO `figura`(`nombre`, `descripcion`, `fechaSalida`, `precio`, `stock`, `altura`, `idPersonaje`, `idProveedor`) VALUES ('Figura Monkey D. Luffy One Piece – Banpresto Chronicle King Of Artist 18cm','¡Añade la figura de The Monkey D. Luffy de la colección Banpresto Chronicle King Of Artist de figuras de One Piece!

Banpresto para la colección Banpresto Chronicle King Of Artist presenta la figura de The Monkey D. Luffy, del popular manga y anime “One Piece”. Esta figura está hecha en PVC mide unos 18 cm de alto e incluye una base soporte especial para exposición.','2023-05-12','59.99','50','18','2','1');

INSERT INTO `figuramaterial`(`idFigura`, `idMaterial`) VALUES (1,1);

INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('luffy_chronicle_1.jpg','1');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('luffy_chronicle_2.jpg','1');
INSERT INTO `imagen`(`url`, `idFigura`) VALUES ('luffy_chronicle_3.jpg','1');
