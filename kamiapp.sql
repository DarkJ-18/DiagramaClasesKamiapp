-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS TuBaseDeDatos;

-- Usar la base de datos creada
USE TuBaseDeDatos;

-- Tabla Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    IdUsuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Cedula VARCHAR(20),
    Direccion VARCHAR(100),
    Telefono VARCHAR(15),
    Correo VARCHAR(100),
    Datobancario VARCHAR(50),
    Nickname VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS RolUsuarios (
    idRolUsuario INT AUTO_INCREMENT PRIMARY KEY,
    Nickname VARCHAR(50),
    
);


-- Tabla Chats
CREATE TABLE IF NOT EXISTS Chats (
    IdChat INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuario INT,
    Fecha DATE,
    Hora TIME,
    Mensaje TEXT,
    Foto_Producto VARCHAR(100), 
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

-- Tabla Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    IdPedido INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuario INT,
    Hora TIME,
    FechaPedido DATE,
    Estado VARCHAR(20),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario)
);

-- Tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
    IdProducto INT AUTO_INCREMENT PRIMARY KEY,
    IdPedido INT,
    Nombre VARCHAR(100),
    Precio DECIMAL(10, 2),
    Categoria VARCHAR(50),
    Descripcion TEXT,
    Imagen VARCHAR(100),  -- Se almacena la ruta de la imagen
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido)
);

-- Tabla Notificaciones
CREATE TABLE IF NOT EXISTS Notificaciones (
    IdNotificacion INT AUTO_INCREMENT PRIMARY KEY,
    IdPedido INT,
    Fecha DATE,
    Hora TIME,
    NotificacionPedido TEXT,
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido)
);

-- Tabla Comprobantes
CREATE TABLE IF NOT EXISTS Comprobantes (
    IdComprobante INT AUTO_INCREMENT PRIMARY KEY,
    IdPedido INT,
    Fecha DATE,
    Total DECIMAL(10, 2),
    Detalles TEXT,
    EstadoPago VARCHAR(20),
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido)
);

 
