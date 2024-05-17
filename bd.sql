-- Crear la base de datos (si no existe)


-- Tabla de Usuarios
CREATE TABLE Usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Productos
CREATE TABLE Productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    usuario_id INT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
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
    usuario_id INT,
    total DECIMAL(10, 2) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('pendiente', 'pagado', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id)
);

-- Tabla de Detalles de Orden
CREATE TABLE DetallesFacrura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES Ordenes(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

-- Tabla de Pagos
CREATE TABLE Pagos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    orden_id INT,
    metodo_pago ENUM('tarjeta_credito', 'tarjeta_debito', 'paypal', 'transferencia') NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    monto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES Ordenes(id)
);

