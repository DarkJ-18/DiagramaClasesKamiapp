CREATE DATABASE IF NOT EXISTS Kamiapp; USE
    Kamiapp;
CREATE DATABASE IF NOT EXISTS Kamiapp; USE
    Kamiapp;
    -- Tabla Roles
CREATE TABLE IF NOT EXISTS Roles(
    idRol INT PRIMARY KEY AUTO_INCREMENT,
    nombreRol VARCHAR(100) NOT NULL
);
-- Tabla Usuarios
CREATE TABLE IF NOT EXISTS Usuarios(
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cedula VARCHAR(20) NOT NULL UNIQUE,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(255) NOT NULL UNIQUE,
    datoBancario VARCHAR(100) NOT NULL,
    nickname VARCHAR(20) NOT NULL UNIQUE,
    imagenPerfil MEDIUMBLOB
);
-- Tabla UsuariosRoles (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE IF NOT EXISTS UsuariosRoles(
    idUsuario INT NOT NULL,
    idRol INT NOT NULL,
    PRIMARY KEY(idUsuario, idRol),
    CONSTRAINT fk_UsuariosRoles_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_UsuariosRoles_Roles FOREIGN KEY(idRol) REFERENCES Roles(idRol) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla MetodosPago
CREATE TABLE IF NOT EXISTS MetodosPago(
    idMetodoPago INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);
-- Tabla Categorias
CREATE TABLE IF NOT EXISTS Categorias(
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);
-- Tabla Productos
CREATE TABLE IF NOT EXISTS Productos(
    idProducto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL UNSIGNED NOT NULL,
    descripcion TEXT NOT NULL
);
-- Tabla ProductosCategorias (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE IF NOT EXISTS ProductosCategorias(
    idProducto INT NOT NULL,
    idCategoria INT NOT NULL,
    PRIMARY KEY(idProducto, idCategoria),
    CONSTRAINT fk_ProductosCategorias_Productos FOREIGN KEY(idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ProductosCategorias_Categorias FOREIGN KEY(idCategoria) REFERENCES Categorias(idCategoria) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla Carritos
CREATE TABLE IF NOT EXISTS Carritos(
    idCarrito INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(100) NOT NULL,
    CONSTRAINT fk_Carritos_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla Pedidos
CREATE TABLE IF NOT EXISTS Pedidos(
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idCarrito INT NOT NULL,
    hora TIME NOT NULL,
    fechaPedido DATE DEFAULT CURRENT_DATE NOT NULL,
    estado VARCHAR(100) NOT NULL,
    CONSTRAINT fk_Pedidos_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Pedidos_Carritos FOREIGN KEY(idCarrito) REFERENCES Carritos(idCarrito) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla Suscripciones
CREATE TABLE IF NOT EXISTS Suscripciones(
    idSuscripcion INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    tipoSuscripcion VARCHAR(255) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    estado VARCHAR(100) NOT NULL,
    CONSTRAINT fk_Suscripciones_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla Facturas
CREATE TABLE IF NOT EXISTS Facturas(
    idFactura INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idMetodoPago INT NOT NULL,
    idPedido INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL DEFAULT CURRENT_TIME,
    total DECIMAL UNSIGNED NOT NULL,
    estadoPago VARCHAR(100) NOT NULL,
    CONSTRAINT fk_Facturas_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Facturas_MetodosPago FOREIGN KEY(idMetodoPago) REFERENCES MetodosPago(idMetodoPago) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Facturas_Pedidos FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla DetallesFactura
CREATE TABLE IF NOT EXISTS DetallesFactura(
    idDetalleFactura INT PRIMARY KEY AUTO_INCREMENT,
    idFactura INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT UNSIGNED NOT NULL,
    precioUnitario DECIMAL UNSIGNED NOT NULL,
    subtotal DECIMAL UNSIGNED NOT NULL,
    CONSTRAINT fk_DetallesFactura_Facturas FOREIGN KEY(idFactura) REFERENCES Facturas(idFactura) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_DetallesFactura_Productos FOREIGN KEY(idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla Chats
CREATE TABLE IF NOT EXISTS Chats(
    idChat INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    mensaje TEXT NOT NULL,
    fotoProducto MEDIUMBLOB,
    CONSTRAINT fk_Chats_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla Notificaciones
CREATE TABLE IF NOT EXISTS Notificaciones(
    idNotificacion INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    notificacionPedido TEXT NOT NULL,
    CONSTRAINT fk_Notificaciones_Pedidos FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla Comprobantes
CREATE TABLE IF NOT EXISTS Comprobantes(
    idComprobante INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    total DECIMAL UNSIGNED NOT NULL,
    detalles TEXT NOT NULL,
    estadoPago VARCHAR(100) NOT NULL,
    CONSTRAINT fk_Comprobantes_Pedidos FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla DetallesCarritos
CREATE TABLE IF NOT EXISTS DetallesCarritos(
    idDetalleCarrito INT PRIMARY KEY AUTO_INCREMENT,
    idCarrito INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT UNSIGNED NOT NULL,
    precioUnitario DECIMAL UNSIGNED NOT NULL,
    subtotal DECIMAL UNSIGNED NOT NULL,
    CONSTRAINT fk_DetallesCarritos_Carritos FOREIGN KEY(idCarrito) REFERENCES Carritos(idCarrito) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_DetallesCarritos_Productos FOREIGN KEY(idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla FotosProductos
CREATE TABLE IF NOT EXISTS FotosProductos(
    idFotoProducto INT PRIMARY KEY AUTO_INCREMENT,
    idProducto INT NOT NULL,
    urlFoto VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    CONSTRAINT fk_FotosProductos_Productos FOREIGN KEY(idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla DireccionesEnvio
CREATE TABLE IF NOT EXISTS DireccionesEnvio(
    idDireccion INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    municipio VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    CONSTRAINT fk_DireccionesEnvio_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla ReviewsProductos
CREATE TABLE IF NOT EXISTS ReviewsProductos(
    idReview INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idProducto INT NOT NULL,
    calificacion INT(5) NOT NULL,
    comentario TEXT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT fk_ReviewsProductos_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ReviewsProductos_Productos FOREIGN KEY(idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla CuponesDescuento
CREATE TABLE IF NOT EXISTS CuponesDescuento(
    idCupon INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(20) NOT NULL,
    descuento DECIMAL UNSIGNED NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    estado VARCHAR(100) NOT NULL,
    idUsuario INT NOT NULL,
    -- Clave foránea que referencia al usuario
    CONSTRAINT fk_CuponesDescuento_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla HistorialesPago
CREATE TABLE IF NOT EXISTS HistorialesPago(
    idHistorialPago INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idMetodoPago INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    monto DECIMAL UNSIGNED NOT NULL,
    estado VARCHAR(100) NOT NULL,
    CONSTRAINT fk_HistorialesPago_Usuarios FOREIGN KEY(idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_HistorialesPago_MetodosPago FOREIGN KEY(idMetodoPago) REFERENCES MetodosPago(idMetodoPago) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- Tabla intermedia PedidosProductos (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE IF NOT EXISTS PedidosProductos(
    idPedidoProducto INT PRIMARY KEY AUTO_INCREMENT,
    idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT UNSIGNED NOT NULL, 
    CONSTRAINT fk_PedidosProductos_Pedidos FOREIGN KEY(idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_PedidosProductos_Productos FOREIGN KEY(idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);
