CREATE DATABASE Figurama;
USE Figurama;


CREATE TABLE Serie (
id INT NOT NULL PRIMARY KEY,
nombre VARCHAR(70) NOT NULL
);

CREATE TABLE Rol (
id INT NOT NULL PRIMARY KEY,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE Material (
id INT NOT NULL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Proveedor (
id INT NOT NULL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Personaje (
id INT NOT NULL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
idSerie INT NOT NULL,
imagen VARCHAR(100),
FOREIGN KEY (idSerie) REFERENCES Serie(id)
);

CREATE TABLE Figura (
id INT NOT NULL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(255),
fechaSalida DATE NOT NULL,
precio DECIMAL(10,2) NOT NULL,
stock INT NOT NULL,
altura INT NOT NULL,
idPersonaje INT NOT NULL,
idProveedor INT NOT NULL,
FOREIGN KEY (idPersonaje) REFERENCES Personaje(id),
FOREIGN KEY (idProveedor) REFERENCES Proveedor(id)
);

CREATE TABLE Usuario (
id INT NOT NULL PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellidos VARCHAR (100) NOT NULL,
contrasena VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
direccion VARCHAR(50),
telefono VARCHAR(20) NOT NULL,
puntosSocio INT NOT NULL,
idRol INT NOT NULL,
esBaja INT NOT NULL,
FOREIGN KEY (idRol) REFERENCES Rol(id)
);

CREATE TABLE Pedido (
id INT NOT NULL PRIMARY KEY,
fecha DATE NOT NULL,
estado INT,
idUsuario INT NOT NULL,
FOREIGN KEY (idUsuario) REFERENCES Usuario(id)
);

CREATE TABLE Valoracion (
id INT NOT NULL PRIMARY KEY,
comentario TEXT,
puntuacion INT NOT NULL,
fecha DATE NOT NULL,
idUsuario INT NOT NULL,
idFigura INT NOT NULL,
FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE Factura (
id INT NOT NULL PRIMARY KEY,
fecha DATE NOT NULL,
direccion VARCHAR(50) NOT NULL
);

CREATE TABLE ArticulosCesta (
idUsuario INT NOT NULL,
idFigura INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (idUsuario, idFigura),
FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE ArticulosListaDeseos (
idUsuario INT NOT NULL,
idFigura INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (idUsuario, idFigura),
FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE DetallePedido (
id INT NOT NULL PRIMARY KEY,
cantidad INT NOT NULL,
idPedido INT NOT NULL,
idFigura INT NOT NULL,
FOREIGN KEY (idPedido) REFERENCES Pedido(id),
FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE CodigoDescuento (
  id INT NOT NULL PRIMARY KEY,
  codigo VARCHAR(50) NOT NULL,
  descuento DECIMAL(10,2) NOT NULL,
  fechaInicio DATE NOT NULL,
  fechaFin DATE NOT NULL,
  cantidadUsos INT NOT NULL,
  cantidadUsosRestantes INT NOT NULL
);

CREATE TABLE Imagen (
  id INT NOT NULL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  url VARCHAR(100) NOT NULL,
  idFigura INT NOT NULL,
  FOREIGN KEY (idFigura) REFERENCES Figura(id)
);

CREATE TABLE FiguraMaterial (
  idFigura INT NOT NULL,
  idMaterial INT NOT NULL,
  PRIMARY KEY (idFigura, idMaterial),
  FOREIGN KEY (idFigura) REFERENCES Figura(id),
  FOREIGN KEY (idMaterial) REFERENCES Material(id)
);

CREATE TABLE Venta (
  id INT NOT NULL PRIMARY KEY,
  fecha DATE NOT NULL,
  cantidad INT NOT NULL,
  precioUd DECIMAL(10,2) NOT NULL,
  idUsuario INT NOT NULL,
  idFigura INT NOT NULL,
  idFactura INT NOT NULL,
  FOREIGN KEY (idUsuario) REFERENCES Usuario(id),
  FOREIGN KEY (idFigura) REFERENCES Figura(id),
  FOREIGN KEY (idFactura) REFERENCES Factura(id)
);

