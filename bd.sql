-- Creación de la tabla Usuario
CREATE TABLE Usuario (
    IdUsuario INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Apellido VARCHAR(255),
    Cedula INT(20),
    Direccion VARCHAR(255),
    Telefono INT(20),
    Correo VARCHAR(255),
    DatoBancario VARCHAR(255),
    Nickname VARCHAR(255)
);

-- Creación de la tabla Chat
CREATE TABLE Chat (
    IdChat INT PRIMARY KEY,
    IdUsuario INT,
    Fecha DATE,
    Hora TIME,
    Mensaje TEXT,
    FotoProducto VARCHAR(255), --Se puede cambiar por un campo de tipo BLOB -- PREGUNTAR!
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Creación de la tabla Pedido
CREATE TABLE Pedido (
    IdPedido INT PRIMARY KEY,
    IdUsuario INT,
    Hora TIME,
    FechaPedido DATE,
    Estado VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Creación de la tabla Producto
CREATE TABLE Producto (
    IdProducto INT PRIMARY KEY,
    IdPedido INT,
    Nombre VARCHAR(255),
    Precio FLOAT,
    Categoria VARCHAR(255),
    Descripcion TEXT,
    Imagen VARCHAR(255), --Se puede cambiar por un campo de tipo BLOB -- PREGUNTAR!
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido)
);

-- Creación de la tabla Notificacion
CREATE TABLE Notificacion (
    IdNotificacion INT PRIMARY KEY,
    IdPedido INT,
    Fecha DATE,
    Hora TIME,
    NotificacionPedido TEXT,
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido)
);

-- Creación de la tabla Comprobante
CREATE TABLE Comprobante (
    IdComprobante INT PRIMARY KEY,
    IdPedido INT,
    Fecha DATE,
    Total FLOAT,
    Detalles TEXT,
    EstadoPago VARCHAR(255),
    FOREIGN KEY (IdPedido) REFERENCES Pedido(IdPedido)
);

-- Creación de la tabla DetalleCarritos
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

-- Creación de la tabla Carritos
CREATE TABLE Carritos (
    IdCarrito INT PRIMARY KEY,
    IdUsuario INT,
    Fecha DATE,
    Hora TIME,
    Estado VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Creación de la tabla DetallesFactura
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

-- Creación de la tabla FotoProductos
CREATE TABLE FotoProductos (
    IdFotoProducto INT PRIMARY KEY,
    IdProducto INT,
    UrlFoto VARCHAR(255),
    Descripcion TEXT,
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Creación de la tabla Categorias
CREATE TABLE Categorias (
    IdCategoria INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);

-- Creación de la tabla Facturas
CREATE TABLE Facturas (
    IdFactura INT PRIMARY KEY,
    IdUsuario INT,
    Fecha DATE,
    Hora TIME,
    Total FLOAT,
    EstadoPago VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

-- Creación de la tabla MetodoPagos
CREATE TABLE MetodoPagos (
    IdMetodoPago INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Descripcion TEXT
);
