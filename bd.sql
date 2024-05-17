-- Crear la base de datos (si no existe)


-- Tabla de Usuarios
CREATE TABLE Usuarios (
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
CREATE TABLE Productos (
   IdProducto INT AUTO_INCREMENT PRIMARY KEY,
    IdPedido INT,
    Nombre VARCHAR(100),
    Precio DECIMAL(10, 2),
    Categoria VARCHAR(50),
    Descripcion TEXT,
    FOREIGN KEY (IdPedido) REFERENCES Pedidos(IdPedido)
);

-- Tabla de Carritos
CREATE TABLE Carritos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla de Detalles del Carrito
CREATE TABLE Detalles_Carrito (
    id INT PRIMARY KEY AUTO_INCREMENT,
    carrito_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (carrito_id) REFERENCES Carritos(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

-- Tabla de Facturas
CREATE TABLE Facturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    total DECIMAL(10, 2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla de Detalles de Orden
CREATE TABLE DetallesFactura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES Facturas(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

-- Tabla de Pagos
CREATE TABLE Pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pagoId INT,
    metodo_pago ENUM('tarjeta_credito', 'tarjeta_debito', 'paypal', 'transferencia') NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pagoId) REFERENCES Facturas(id)
);

-- Tabla Notificaciones
CREATE TABLE IF NOT EXISTS Notificaciones (
    IdNotificacion INT AUTO_INCREMENT PRIMARY KEY,
    usuarioId int,
    tipoNotificacion varchar(100) NOT NULL,
    contenido TEXT,
    fechaEnvio TIMESTAMP,
    FOREIGN KEY (usuarioId) references Usuarios(IdUsuario)
);

--Tabla FotoProductos
CREATE TABLE IF NOT EXISTS FotoProductos (
   idFotoProductos INT PRIMARY KEY,
    
    FOREIGN KEY () references ()
);
