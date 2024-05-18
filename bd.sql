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
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2),
    categoria VARCHAR(50),
    descripcion TEXT
);

-- Tabla de Carritos
CREATE TABLE IF NOT EXISTS Carritos (
    idCarrito INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(IdUsuario)
);

-- Tabla de Detalles del Carrito
CREATE TABLE IF NOT EXISTS Detalles_Carrito (
    idDetallesCarrito INT PRIMARY KEY AUTO_INCREMENT,
    carrito_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (carrito_id) REFERENCES Carritos(idCarrito),
    FOREIGN KEY (producto_id) REFERENCES Productos(IdProducto)
);

-- Tabla de Facturas
CREATE TABLE IF NOT EXISTS Facturas (
    idFactura INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    total DECIMAL(10, 2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla de Detalles de Factura
CREATE TABLE IF NOT EXISTS Detalles_Factura (
    idDetallesFactura INT PRIMARY KEY AUTO_INCREMENT,
    factura_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES Facturas(idFactura),
    FOREIGN KEY (producto_id) REFERENCES Productos(idProducto)
);

-- Tabla de Pagos
CREATE TABLE IF NOT EXISTS Pagos (
    idPago INT PRIMARY KEY AUTO_INCREMENT,
    factura_id INT,
    metodo_pago ENUM('tarjeta_credito', 'tarjeta_debito', 'paypal', 'transferencia') NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES Facturas(idFactura)
);

-- Tabla de Notificaciones
CREATE TABLE IF NOT EXISTS Notificaciones (
    idNotificacion INT AUTO_INCREMENT PRIMARY KEY,
    usuarioId INT,
    tipoNotificacion VARCHAR(100) NOT NULL,
    contenido TEXT,
    fechaEnvio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuarioId) REFERENCES Usuarios(idUsuario)
);

-- Tabla de FotoProductos
CREATE TABLE IF NOT EXISTS FotoProductos (
    idFotoProducto INT AUTO_INCREMENT PRIMARY KEY,
    idProducto INT,
    urlImagen VARCHAR(255) NOT NULL,
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);
