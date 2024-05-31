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
    estado VARCHAR(255)
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

-- Usuario:

-- Relación con Pedido: Un usuario puede realizar varios pedidos (Pedido.IdUsuario).
-- Relación con Carritos: Un usuario puede tener varios carritos (Carritos.IdUsuario).
-- Relación con Facturas: Un usuario puede tener varias facturas (Facturas.IdUsuario).
-- Relación con Chat: Un usuario puede enviar varios mensajes en el chat (Chat.IdUsuario).
-- Relación con Notificacion: Un usuario puede recibir varias notificaciones (Notificacion.IdUsuario).
-- Relación con Suscripciones: Un usuario puede tener varias suscripciones (Suscripciones.IdUsuario).
-- Relación con DireccionesEnvio: Un usuario puede tener múltiples direcciones de envío (DireccionesEnvio.IdUsuario).
-- Relación con ReviewsProductos: Un usuario puede dejar varias reseñas de productos (ReviewsProductos.IdUsuario).
-- Relación con HistorialPagos: Un usuario puede tener múltiples registros en el historial de pagos (HistorialPagos.IdUsuario).
-- Relación con RolesUsuarios: Cada usuario tiene un rol específico (Usuario.IdRol).
-- Relación de muchos a muchos con RolesUsuarios a través de la tabla intermedia UsuarioRoles.
-- RolesUsuarios:

-- Relación con Usuario: Un rol puede ser asignado a varios usuarios (Usuario.IdRol).
-- Relación de muchos a muchos con Usuario a través de la tabla intermedia UsuarioRoles.
-- MetodoPagos:

-- Relación con Facturas: Cada factura está asociada a un método de pago específico (Facturas.IdMetodoPago).
-- Relación con HistorialPagos: Cada registro de pago utiliza un método de pago específico (HistorialPagos.IdMetodoPago).
-- Categorias:

-- Relación con Producto: Cada producto pertenece a una categoría (Producto.IdCategoria).
-- Relación de muchos a muchos con Producto a través de la tabla intermedia ProductoCategorias.
-- Carritos:

-- Relación con Pedido: Un carrito se asocia con un pedido (Pedido.IdCarrito).
-- Pedido:

-- Relación con Carritos: Un pedido se origina a partir de un carrito (Pedido.IdCarrito).
-- Relación con Producto: Un pedido puede contener varios productos (Producto.IdPedido).
-- Relación con Facturas: Un pedido puede estar asociado con una factura (Facturas.IdPedido).
-- Relación con Notificacion: Un pedido puede generar varias notificaciones (Notificacion.IdPedido).
-- Relación con Comprobante: Un pedido puede tener varios comprobantes (Comprobante.IdPedido).
-- Relación de muchos a muchos con Producto a través de la tabla intermedia PedidoProductos.
-- Suscripciones:

-- Relación con Usuario: Cada suscripción pertenece a un usuario (Suscripciones.IdUsuario).
-- Producto:

-- Relación con Pedido: Un producto puede estar presente en varios pedidos (Producto.IdPedido).
-- Relación con Categorias: Cada producto pertenece a una categoría (Producto.IdCategoria).
-- Relación con DetallesFactura: Cada detalle de factura está asociado a un producto (DetallesFactura.IdProducto).
-- Relación con DetalleCarritos: Cada detalle de carrito está asociado a un producto (DetalleCarritos.IdProducto).
-- Relación con FotoProductos: Cada foto de producto está asociada a un producto (FotoProductos.IdProducto).
-- Relación con ReviewsProductos: Cada review de producto está asociado a un producto (ReviewsProductos.IdProducto).
-- Relación de muchos a muchos con Pedido a través de la tabla intermedia PedidoProductos.
-- Relación de muchos a muchos con Categorias a través de la tabla intermedia ProductoCategorias.
-- Facturas:

-- Relación con Usuario: Cada factura pertenece a un usuario (Facturas.IdUsuario).
-- Relación con MetodoPagos: Cada factura utiliza un método de pago específico (Facturas.IdMetodoPago).
-- Relación con Pedido: Cada factura está asociada a un pedido (Facturas.IdPedido).
-- Relación con DetallesFactura: Cada detalle de factura está asociado a una factura (DetallesFactura.IdFactura).
-- DetallesFactura:

-- Relación con Facturas: Cada detalle de factura está asociado a una factura (DetallesFactura.IdFactura).
-- Relación con Producto: Cada detalle de factura está asociado a un producto (DetallesFactura.IdProducto).
-- Chat:

-- Relación con Usuario: Cada mensaje en el chat es enviado por un usuario (Chat.IdUsuario).
-- Notificacion:

-- Relación con Usuario: Cada notificación está dirigida a un usuario (Notificacion.IdUsuario).
-- Relación con Pedido: Cada notificación está asociada a un pedido (Notificacion.IdPedido).
-- Comprobante:

-- Relación con Pedido: Cada comprobante está asociado a un pedido (Comprobante.IdPedido).
-- DetalleCarritos:

-- Relación con Carritos: Cada detalle de carrito está asociado a un carrito (DetalleCarritos.IdCarrito).
-- Relación con Producto: Cada detalle de carrito está asociado a un producto (DetalleCarritos.IdProducto).
-- FotoProductos:

-- Relación con Producto: Cada foto de producto está asociada a un producto (FotoProductos.IdProducto).
-- DireccionesEnvio:

-- Relación con Usuario: Cada dirección de envío está asociada a un usuario (DireccionesEnvio.IdUsuario).
-- ReviewsProductos:

-- Relación con Usuario: Cada review de producto está asociado a un usuario (ReviewsProductos.IdUsuario).
-- Relación con Producto: Cada review de producto está asociado a un producto (ReviewsProductos.IdProducto).
-- HistorialPagos:

-- Relación con Usuario: Cada registro de pago pertenece a un usuario (HistorialPagos.IdUsuario).
-- Relación con MetodoPagos: Cada registro de pago utiliza un método de pago específico (HistorialPagos.IdMetodoPago).
-- UsuarioRoles:

-- Relación con Usuario: Cada registro en la tabla intermedia UsuarioRoles asocia un usuario con un rol (UsuarioRoles.IdUsuario).
-- Relación con RolesUsuarios: Cada registro en la tabla intermedia UsuarioRoles asocia un rol con un usuario (UsuarioRoles.IdRol).
-- PedidoProductos:

-- Relación con Pedido: Cada registro en la tabla intermedia PedidoProductos asocia un pedido con un producto (PedidoProductos.IdPedido).
-- Relación con Producto: Cada registro en la tabla intermedia PedidoProductos asocia un producto con un pedido (PedidoProductos.IdProducto).
-- ProductoCategorias:

-- Relación con Producto: Cada registro en la tabla intermedia ProductoCategorias asocia un producto con una categoría (ProductoCategorias.IdProducto).
-- Relación con Categorias: Cada registro en la tabla intermedia ProductoCategorias asocia una categoría con un producto (ProductoCategorias.IdCategoria).