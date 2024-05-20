-- Tabla Usuario
CREATE TABLE Usuario (
    IdUsuario INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Cedula VARCHAR(20),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Correo VARCHAR(255),
    Nickname VARCHAR(255)
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

-------------------------------------------------------------------------
-- Relaciones entre tablas
-- Usuario:

-- Relación con Pedido: Un usuario puede realizar varios pedidos.
-- Relación con Carritos: Un usuario puede tener varios carritos.
-- Relación con Facturas: Un usuario puede tener varias facturas.
-- Relación con Chat: Un usuario puede enviar varios mensajes en el chat.
-- Relación con Notificacion: Un usuario puede recibir varias notificaciones.
-- MetodoPagos:

-- Relación con Facturas: Cada factura está asociada a un método de pago específico.
-- Categorias:

-- Relación con Producto: Cada producto pertenece a una categoría.
-- Carritos:

-- Relación con Pedido: Un carrito se asocia con un pedido.
-- Pedido:

-- Relación con Carritos: Un pedido se origina a partir de un carrito.
-- Relación con Producto: Un pedido puede contener varios productos.
-- Relación con Facturas: Un pedido puede estar asociado con una factura.
-- Relación con Notificacion: Un pedido puede generar varias notificaciones.
-- Producto:

-- Relación con Pedido: Un producto puede estar presente en varios pedidos.
-- Relación con Categorias: Cada producto pertenece a una categoría.
-- Facturas:

-- Relación con Usuario: Cada factura pertenece a un usuario.
-- Relación con Pedido: Cada factura está asociada a un pedido.
-- Relación con MetodoPagos: Cada factura utiliza un método de pago específico.
-- DetallesFactura:

-- Relación con Facturas: Cada detalle de factura está asociado a una factura.
-- Relación con Producto: Cada detalle de factura está asociado a un producto.
-- Chat:

-- Relación con Usuario: Cada mensaje en el chat es enviado por un usuario.
-- Notificacion:

-- Relación con Usuario: Cada notificación está dirigida a un usuario.
-- Relación con Pedido: Cada notificación está asociada a un pedido.
-- Comprobante:

-- Relación con Pedido: Cada comprobante está asociado a un pedido.
-- DetalleCarritos:

-- Relación con Carritos: Cada detalle de carrito está asociado a un carrito.
-- Relación con Producto: Cada detalle de carrito está asociado a un producto.
-- FotoProductos:

-- Relación con Producto: Cada foto de producto está asociada a un producto.