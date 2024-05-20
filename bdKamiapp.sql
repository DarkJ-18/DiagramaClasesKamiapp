-- Tabla Usuario
CREATE TABLE Usuario (
    IdUsuario INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Cedula VARCHAR(20),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Correo VARCHAR(255),
    DatoBancario VARCHAR(255),
    Nickname VARCHAR(255)
);

-- Tabla Categorias
CREATE TABLE Categorias (
    IdCategoria INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);

-- Tabla Pedido
CREATE TABLE Pedido (
    IdPedido INT PRIMARY KEY,
    IdUsuario INT,
    Hora TIME,
    FechaPedido DATE,
    Estado VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Tabla Producto
CREATE TABLE Producto (
    IdProducto INT PRIMARY KEY,
    IdPedido INT,
    Nombre VARCHAR(255),
    Precio FLOAT,
    Categoria VARCHAR(255),
    Descripcion TEXT,
    Imagen VARCHAR(255),
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido)
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

-- Tabla Facturas
CREATE TABLE Facturas (
    IdFactura INT PRIMARY KEY,
    IdUsuario INT,
    Fecha DATE,
    Hora TIME,
    Total FLOAT,
    EstadoPago VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
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

-- Tabla MetodoPagos
CREATE TABLE MetodoPagos (
    IdMetodoPago INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);


-------------------------------------------------------------------------
-- Relaciones entre tablas
-- Usuario - Chat:

-- Relación: Un usuario puede tener varios chats.
-- Clave Foránea: Chat.IdUsuario referencia Usuario.IdUsuario.
-- Usuario - Pedido:

-- Relación: Un usuario puede realizar varios pedidos.
-- Clave Foránea: Pedido.IdUsuario referencia Usuario.IdUsuario.
-- Pedido - Producto:

-- Relación: Un pedido puede contener varios productos.
-- Clave Foránea: Producto.IdPedido referencia Pedido.IdPedido.
-- Pedido - Notificacion:

-- Relación: Un pedido puede tener varias notificaciones.
-- Clave Foránea: Notificacion.IdPedido referencia Pedido.IdPedido.
-- Pedido - Comprobante:

-- Relación: Un pedido puede tener un comprobante asociado.
-- Clave Foránea: Comprobante.IdPedido referencia Pedido.IdPedido.
-- Carritos - DetalleCarritos:

-- Relación: Un carrito puede tener varios detalles de carrito.
-- Clave Foránea: DetalleCarritos.IdCarrito referencia Carritos.IdCarrito.
-- Producto - DetalleCarritos:

-- Relación: Un producto puede estar en varios detalles de carrito.
-- Clave Foránea: DetalleCarritos.IdProducto referencia Producto.IdProducto.
-- Usuario - Carritos:

-- Relación: Un usuario puede tener varios carritos.
-- Clave Foránea: Carritos.IdUsuario referencia Usuario.IdUsuario.
-- Facturas - DetallesFactura:

-- Relación: Una factura puede tener varios detalles de factura.
-- Clave Foránea: DetallesFactura.IdFactura referencia Facturas.IdFactura.
-- Producto - FotoProductos:

-- Relación: Un producto puede tener varias fotos asociadas.
-- Clave Foránea: FotoProductos.IdProducto referencia Producto.IdProducto.