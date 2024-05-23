-- Tabla Usuario
CREATE TABLE Usuario (
    IdUsuario INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Cedula VARCHAR(20),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Correo VARCHAR(255),
    Nickname VARCHAR(255),
    IdRol INT,
    FOREIGN KEY (IdRol) REFERENCES RolesUsuarios(IdRol)
);

-- Tabla RolesUsuarios
CREATE TABLE RolesUsuarios (
    IdRol INT PRIMARY KEY,
    NombreRol VARCHAR(255)
);

-- Tabla MetodoPagos
CREATE TABLE MetodoPagos (
    IdMetodoPago INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);

-- Tabla Categorias
CREATE TABLE Categorias (
    IdCategoria INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);

-- Tabla Carritos
CREATE TABLE Carritos (
    IdCarrito INT PRIMARY KEY,
    IdUsuario INT,
    Fecha DATE,
    Hora TIME,
    Estado VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    IdPedido INT PRIMARY KEY,
    IdUsuario INT,
    IdCarrito INT,  -- Relación con Carrito
    Hora TIME,
    FechaPedido DATE,
    Estado VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdCarrito) REFERENCES Carritos(IdCarrito)  -- Clave foránea a Carritos
);

-- Tabla Producto
CREATE TABLE Producto (
    IdProducto INT PRIMARY KEY,
    IdPedido INT,
    IdCategoria INT,
    Nombre VARCHAR(255),
    Precio FLOAT,
    Descripcion TEXT,
    Imagen VARCHAR(255),
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido),
    FOREIGN KEY (IdCategoria) REFERENCES Categorias(IdCategoria)
);

-- Tabla Suscripciones
CREATE TABLE Suscripciones (
    IdSuscripcion INT PRIMARY KEY,
    IdUsuario INT,
    TipoSuscripcion VARCHAR(255),
    FechaInicio DATE,
    FechaFin DATE,
    Estado VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Tabla Facturas
CREATE TABLE Facturas (
    IdFactura INT PRIMARY KEY,
    IdUsuario INT,
    IdMetodoPago INT,
    IdPedido INT,  -- Relación con Pedido
    Fecha DATE,
    Hora TIME,
    Total FLOAT,
    EstadoPago VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdMetodoPago) REFERENCES MetodoPagos(IdMetodoPago),
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido)  -- Clave foránea a Pedido
);

-- Tabla DetallesFactura
CREATE TABLE DetallesFactura (
    IdDetalleFactura INT PRIMARY KEY,
    IdFactura INT,
    IdProducto INT,
    Cantidad INT,
    PrecioUnitario FLOAT,
    Subtotal FLOAT,
    FOREIGN KEY (IdFactura) REFERENCES Facturas(IdFactura),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla Chat
CREATE TABLE Chat (
    IdChat INT PRIMARY KEY,
    IdUsuario INT,
    Fecha DATE,
    Hora TIME,
    Mensaje TEXT,
    FotoProducto VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Tabla Notificacion
CREATE TABLE Notificacion (
    IdNotificacion INT PRIMARY KEY,
    IdPedido INT,
    Fecha DATE,
    Hora TIME,
    NotificacionPedido TEXT,
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido)
);

-- Tabla Comprobante
CREATE TABLE Comprobante (
    IdComprobante INT PRIMARY KEY,
    IdPedido INT,
    Fecha DATE,
    Total FLOAT,
    Detalles TEXT,
    EstadoPago VARCHAR(255),
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido)
);

-- Tabla DetalleCarritos
CREATE TABLE DetalleCarritos (
    IdDetalleCarrito INT PRIMARY KEY,
    IdCarrito INT,
    IdProducto INT,
    Cantidad INT,
    PrecioUnitario FLOAT,
    Subtotal FLOAT,
    FOREIGN KEY (IdCarrito) REFERENCES Carritos(IdCarrito),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla FotoProductos
CREATE TABLE FotoProductos (
    IdFotoProducto INT PRIMARY KEY,
    IdProducto INT,
    UrlFoto VARCHAR(255),
    Descripcion TEXT,
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla DireccionesEnvio
CREATE TABLE DireccionesEnvio (
    IdDireccion INT PRIMARY KEY,
    IdUsuario INT,
    Direccion VARCHAR(255),
    Ciudad VARCHAR(255),
    Provincia VARCHAR(255),
    Pais VARCHAR(255),
    CodigoPostal VARCHAR(20),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Tabla ReviewsProductos
CREATE TABLE ReviewsProductos (
    IdReview INT PRIMARY KEY,
    IdUsuario INT,
    IdProducto INT,
    Calificacion INT,
    Comentario TEXT,
    Fecha DATE,
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla CuponesDescuento
CREATE TABLE CuponesDescuento (
    IdCupon INT PRIMARY KEY,
    Codigo VARCHAR(50),
    Descuento FLOAT,
    FechaInicio DATE,
    FechaFin DATE,
    Estado VARCHAR(255)
);

-- Tabla HistorialPagos
CREATE TABLE HistorialPagos (
    IdHistorialPago INT PRIMARY KEY,
    IdUsuario INT,
    IdMetodoPago INT,
    Fecha DATE,
    Hora TIME,
    Monto FLOAT,
    Estado VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario),
    FOREIGN KEY (IdMetodoPago) REFERENCES MetodoPagos(IdMetodoPago)
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
-- RolesUsuarios:

-- Relación con Usuario: Un rol puede ser asignado a varios usuarios (Usuario.IdRol).
-- MetodoPagos:

-- Relación con Facturas: Cada factura está asociada a un método de pago específico (Facturas.IdMetodoPago).
-- Relación con HistorialPagos: Cada registro de pago utiliza un método de pago específico (HistorialPagos.IdMetodoPago).
-- Categorias:

-- Relación con Producto: Cada producto pertenece a una categoría (Producto.IdCategoria).
-- Carritos:

-- Relación con Pedido: Un carrito se asocia con un pedido (Pedido.IdCarrito).
-- Pedido:

-- Relación con Carritos: Un pedido se origina a partir de un carrito (Pedido.IdCarrito).
-- Relación con Producto: Un pedido puede contener varios productos (Producto.IdPedido).
-- Relación con Facturas: Un pedido puede estar asociado con una factura (Facturas.IdPedido).
-- Relación con Notificacion: Un pedido puede generar varias notificaciones (Notificacion.IdPedido).
-- Relación con Comprobante: Un pedido puede tener varios comprobantes (Comprobante.IdPedido).
-- Suscripciones:

-- Relación con Usuario: Cada suscripción pertenece a un usuario (Suscripciones.IdUsuario).
-- Producto:

-- Relación con Pedido: Un producto puede estar presente en varios pedidos (Producto.IdPedido).
-- Relación con Categorias: Cada producto pertenece a una categoría (Producto.IdCategoria).
-- Relación con DetallesFactura: Cada detalle de factura está asociado a un producto (DetallesFactura.IdProducto).
-- Relación con DetalleCarritos: Cada detalle de carrito está asociado a un producto (DetalleCarritos.IdProducto).
-- Relación con FotoProductos: Cada foto de producto está asociada a un producto (FotoProductos.IdProducto).
-- Relación con ReviewsProductos: Cada review de producto está asociado a un producto (ReviewsProductos.IdProducto).
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