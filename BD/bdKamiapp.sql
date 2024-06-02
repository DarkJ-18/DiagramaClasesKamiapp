-- Tabla Roles
CREATE TABLE Roles (
    idRol INT PRIMARY KEY,
    nombreRol VARCHAR(255)
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    cedula VARCHAR(20),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    correo VARCHAR(255),
    nickname VARCHAR(255)
);

-- Tabla UsuariosRoles (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE UsuariosRoles (
    idUsuario INT,
    idRol INT,
    PRIMARY KEY (idUsuario, idRol),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idRol) REFERENCES Roles(idRol)
);

-- Tabla MetodosPago
CREATE TABLE MetodosPago (
    idMetodoPago INT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion TEXT
);

-- Tabla Categorias
CREATE TABLE Categorias (
    idCategoria INT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion TEXT
);

-- Tabla Productos
CREATE TABLE Productos (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(255),
    precio FLOAT,
    descripcion TEXT,
    imagen VARCHAR(255)
);

-- Tabla ProductosCategorias (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE ProductosCategorias (
    idProducto INT,
    idCategoria INT,
    PRIMARY KEY (idProducto, idCategoria),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto),
    FOREIGN KEY (idCategoria) REFERENCES Categorias(idCategoria)
);  

-- Tabla Carritos
CREATE TABLE Carritos (
    idCarrito INT PRIMARY KEY,
    idUsuario INT,
    fecha DATE,
    hora TIME,
    estado VARCHAR(255),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla Pedidos
CREATE TABLE Pedidos (
    idPedido INT PRIMARY KEY,
    idUsuario INT,
    idCarrito INT,
    hora TIME,
    fechaPedido DATE,
    estado VARCHAR(255),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idCarrito) REFERENCES Carritos(idCarrito)
);

-- Tabla Suscripciones
CREATE TABLE Suscripciones (
    idSuscripcion INT PRIMARY KEY,
    idUsuario INT,
    tipoSuscripcion VARCHAR(255),
    fechaInicio DATE,
    fechaFin DATE,
    estado VARCHAR(255),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla Facturas
CREATE TABLE Facturas (
    idFactura INT PRIMARY KEY,
    idUsuario INT,
    idMetodoPago INT,
    idPedido INT,
    fecha DATE,
    hora TIME,
    total FLOAT,
    estadoPago VARCHAR(255),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idMetodoPago) REFERENCES MetodosPago(idMetodoPago),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido)
);

-- Tabla DetallesFactura
CREATE TABLE DetallesFactura (
    idDetalleFactura INT PRIMARY KEY,
    idFactura INT,
    idProducto INT,
    cantidad INT,
    precioUnitario FLOAT,
    subtotal FLOAT,
    FOREIGN KEY (idFactura) REFERENCES Facturas(idFactura),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- Tabla Chats
CREATE TABLE Chats (
    idChat INT PRIMARY KEY,
    idUsuario INT,
    fecha DATE,
    hora TIME,
    mensaje TEXT,
    fotoProducto VARCHAR(255),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla Notificaciones
CREATE TABLE Notificaciones (
    idNotificacion INT PRIMARY KEY,
    idPedido INT,
    fecha DATE,
    hora TIME,
    notificacionPedido TEXT,
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido)
);

-- Tabla Comprobantes
CREATE TABLE Comprobantes (
    idComprobante INT PRIMARY KEY,
    idPedido INT,
    fecha DATE,
    total FLOAT,
    detalles TEXT,
    estadoPago VARCHAR(255),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido)
);

-- Tabla DetallesCarritos
CREATE TABLE DetallesCarritos (
    idDetalleCarrito INT PRIMARY KEY,
    idCarrito INT,
    idProducto INT,
    cantidad INT,
    precioUnitario FLOAT,
    subtotal FLOAT,
    FOREIGN KEY (idCarrito) REFERENCES Carritos(idCarrito),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- Tabla FotosProductos
CREATE TABLE FotosProductos (
    idFotoProducto INT PRIMARY KEY,
    idProducto INT,
    urlFoto VARCHAR(255),
    descripcion TEXT,
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- Tabla DireccionesEnvio
CREATE TABLE DireccionesEnvio (
    idDireccion INT PRIMARY KEY,
    idUsuario INT,
    direccion VARCHAR(255),
    department VARCHAR(255),
    municipality VARCHAR(255),
    city VARCHAR(255),
    street VARCHAR(255),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

-- Tabla ReviewsProductos
CREATE TABLE ReviewsProductos (
    idReview INT PRIMARY KEY,
    idUsuario INT,
    idProducto INT,
    calificacion INT,
    comentario TEXT,
    fecha DATE,
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);

-- Tabla CuponesDescuento
CREATE TABLE CuponesDescuento (
    idCupon INT PRIMARY KEY,
    codigo VARCHAR(50),
    descuento FLOAT,
    fechaInicio DATE,
    fechaFin DATE,
    estado VARCHAR(255),
    idUsuario INT, -- Clave foránea que referencia al usuario
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);


-- Tabla HistorialesPago
CREATE TABLE HistorialesPago (
    idHistorialPago INT PRIMARY KEY,
    idUsuario INT,
    idMetodoPago INT,
    fecha DATE,
    hora TIME,
    monto FLOAT,
    estado VARCHAR(255),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idMetodoPago) REFERENCES MetodosPago(idMetodoPago)
);

-- Tabla intermedia PedidosProductos (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE PedidosProductos (
    idPedido INT,
    idProducto INT,
    cantidad INT,
    PRIMARY KEY (idPedido, idProducto),
    FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido),
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
);


-------------------------------------------------------------------------
-- Relaciones entre tablas

-- Usuarios y UsuariosRoles (Relación muchos a muchos)


-- Usuarios.idUsuario ↔ UsuariosRoles.idUsuario
-- Roles.idRol ↔ UsuariosRoles.idRol
-- Productos y ProductosCategorias (Relación muchos a muchos)

-- Productos.idProducto ↔ ProductosCategorias.idProducto
-- Categorias.idCategoria ↔ ProductosCategorias.idCategoria
-- Usuarios y Carritos (Relación uno a muchos)

-- Usuarios.idUsuario ↔ Carritos.idUsuario
-- Usuarios y Pedidos (Relación uno a muchos)

-- Usuarios.idUsuario ↔ Pedidos.idUsuario
-- Carritos.idCarrito ↔ Pedidos.idCarrito (Relación uno a muchos)
-- Usuarios y Suscripciones (Relación uno a muchos)

-- Usuarios.idUsuario ↔ Suscripciones.idUsuario
-- Usuarios y Facturas (Relación uno a muchos)

-- Usuarios.idUsuario ↔ Facturas.idUsuario
-- MetodosPago.idMetodoPago ↔ Facturas.idMetodoPago (Relación uno a muchos)
-- Pedidos.idPedido ↔ Facturas.idPedido (Relación uno a uno)
-- Facturas y DetallesFactura (Relación uno a muchos)

-- Facturas.idFactura ↔ DetallesFactura.idFactura
-- Productos.idProducto ↔ DetallesFactura.idProducto (Relación uno a muchos)
-- Usuarios y Chats (Relación uno a muchos)

-- Usuarios.idUsuario ↔ Chats.idUsuario
-- Pedidos y Notificaciones (Relación uno a muchos)

-- Pedidos.idPedido ↔ Notificaciones.idPedido
-- Pedidos y Comprobantes (Relación uno a uno)

-- Pedidos.idPedido ↔ Comprobantes.idPedido
-- Carritos y DetallesCarritos (Relación uno a muchos)

-- Carritos.idCarrito ↔ DetallesCarritos.idCarrito
-- Productos.idProducto ↔ DetallesCarritos.idProducto (Relación uno a muchos)
-- Productos y FotosProductos (Relación uno a muchos)

-- Productos.idProducto ↔ FotosProductos.idProducto
-- Usuarios y DireccionesEnvio (Relación uno a muchos)

-- Usuarios.idUsuario ↔ DireccionesEnvio.idUsuario
-- Usuarios y ReviewsProductos (Relación uno a muchos)

-- Usuarios.idUsuario ↔ ReviewsProductos.idUsuario
-- Productos.idProducto ↔ ReviewsProductos.idProducto (Relación uno a muchos)
-- Usuarios y HistorialesPago (Relación uno a muchos)

-- Usuarios.idUsuario ↔ HistorialesPago.idUsuario
-- MetodosPago.idMetodoPago ↔ HistorialesPago.idMetodoPago (Relación uno a muchos)
-- Pedidos y PedidosProductos (Relación muchos a muchos)

-- Pedidos.idPedido ↔ PedidosProductos.idPedido
-- Productos.idProducto ↔ PedidosProductos.idProducto