-- Crear la base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS nombre_base_de_datos;

-- Seleccionar la base de datos
USE nombre_base_de_datos;

-- Tabla de Usuarios
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

-- Tabla de Productos
CREATE TABLE IF NOT EXISTS Productos (
    IdProducto INT AUTO_INCREMENT PRIMARY KEY,
    IdPedido INT,
    Nombre VARCHAR(100),
    Precio DECIMAL(10, 2),
    Categoria VARCHAR(50),
    Descripcion TEXT,
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido)
);

-- Tabla de Carritos
CREATE TABLE IF NOT EXISTS Carritos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(IdUsuario)
);

-- Tabla de Detalles del Carrito
CREATE TABLE IF NOT EXISTS Detalles_Carrito (
    id INT PRIMARY KEY AUTO_INCREMENT,
    carrito_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (carrito_id) REFERENCES Carritos(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(IdProducto)
);

-- Tabla de Facturas
CREATE TABLE IF NOT EXISTS Facturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    total DECIMAL(10, 2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(IdUsuario)
);

-- Tabla de Detalles de Orden
CREATE TABLE IF NOT EXISTS DetallesFactura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES Facturas(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(IdProducto)
);

-- Tabla de Pagos
CREATE TABLE IF NOT EXISTS Pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pagoId INT,
    metodo_pago ENUM('tarjeta_credito', 'tarjeta_debito', 'paypal', 'transferencia') NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pagoId) REFERENCES Facturas(id)
);

-- Tabla de Notificaciones
CREATE TABLE IF NOT EXISTS Notificaciones (
    IdNotificacion INT AUTO_INCREMENT PRIMARY KEY,
    usuarioId INT,
    tipoNotificacion VARCHAR(100) NOT NULL,
    contenido TEXT,
    fechaEnvio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuarioId) REFERENCES Usuarios(IdUsuario)
);

-- Tabla de FotoProductos
CREATE TABLE IF NOT EXISTS FotoProductos (
    IdFotoProducto INT AUTO_INCREMENT PRIMARY KEY,
    IdProducto INT,
    Url VARCHAR(255) NOT NULL,
    FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);
