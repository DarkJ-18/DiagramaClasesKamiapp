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
/* Usuario:

Usuario no tiene relaciones entrantes pero es referenciado por muchas tablas.
MetodoPagos:

MetodoPagos no tiene relaciones entrantes pero es referenciado por la tabla Facturas.
Categorias:

Categorias no tiene relaciones entrantes pero es referenciado por la tabla Producto.
Carritos:

Carritos:
IdUsuario (foránea) → Usuario(IdUsuario)
Carritos es referenciado por Pedido y DetalleCarritos.
Pedido:

Pedido:
IdUsuario (foránea) → Usuario(IdUsuario)
IdCarrito (foránea) → Carritos(IdCarrito)
Pedido es referenciado por Producto, Notificacion, Comprobante, y Facturas.
Producto:

Producto:
IdPedido (foránea) → Pedido(IdPedido)
IdCategoria (foránea) → Categorias(IdCategoria)
Producto es referenciado por DetallesFactura, DetalleCarritos, y FotoProductos.
Facturas:

Facturas:
IdUsuario (foránea) → Usuario(IdUsuario)
IdMetodoPago (foránea) → MetodoPagos(IdMetodoPago)
IdPedido (foránea) → Pedido(IdPedido)
Facturas es referenciado por DetallesFactura.
DetallesFactura:

DetallesFactura:
IdFactura (foránea) → Facturas(IdFactura)
IdProducto (foránea) → Producto(IdProducto)
Chat:

Chat:
IdUsuario (foránea) → Usuario(IdUsuario)
Notificacion:

Notificacion:
IdPedido (foránea) → Pedido(IdPedido)
Comprobante:

Comprobante:
IdPedido (foránea) → Pedido(IdPedido)
DetalleCarritos:

DetalleCarritos:
IdCarrito (foránea) → Carritos(IdCarrito)
IdProducto (foránea) → Producto(IdProducto)
FotoProductos:

FotoProductos:
IdProducto (foránea) → Producto(IdProducto)
Estas son las relaciones claves:

Usuario se relaciona con:

Carritos a través de IdUsuario
Pedido a través de IdUsuario
Facturas a través de IdUsuario
Chat a través de IdUsuario
MetodoPagos se relaciona con:

Facturas a través de IdMetodoPago
Categorias se relaciona con:

Producto a través de IdCategoria
Carritos se relaciona con:

Pedido a través de IdCarrito
DetalleCarritos a través de IdCarrito
Pedido se relaciona con:

Producto a través de IdPedido
Notificacion a través de IdPedido
Comprobante a través de IdPedido
Facturas a través de IdPedido
Producto se relaciona con:

DetallesFactura a través de IdProducto
DetalleCarritos a través de IdProducto
FotoProductos a través de IdProducto
Facturas se relaciona con:

DetallesFactura a través de IdFactura */