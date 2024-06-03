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

-- 1. **Usuarios y UsuariosRoles** (Relación muchos a muchos)

--    - **Descripción**: Un usuario puede tener múltiples roles y un rol puede ser asignado a múltiples usuarios. Esto se maneja a través de la tabla intermedia UsuariosRoles.

-- 2. **Productos y ProductosCategorias** (Relación muchos a muchos)
--    - **Descripción**: Un producto puede pertenecer a múltiples categorías y una categoría puede incluir múltiples productos. Esto se maneja a través de la tabla intermedia ProductosCategorias.

-- 3. **Usuarios y Carritos** (Relación uno a muchos)
--    - **Descripción**: Un usuario puede tener múltiples carritos, pero un carrito pertenece a un solo usuario.

-- 4. **Usuarios y Pedidos** (Relación uno a muchos)
--    - **Descripción**: Un usuario puede hacer múltiples pedidos, pero cada pedido es realizado por un solo usuario. Además, un carrito puede estar relacionado con múltiples pedidos, pero cada pedido se relaciona con un solo carrito.

-- 5. **Usuarios y Suscripciones** (Relación uno a muchos)
--    - **Descripción**: Un usuario puede tener múltiples suscripciones, pero cada suscripción pertenece a un solo usuario.

-- 6. **Usuarios y Facturas** (Relación uno a muchos)
--    - **Descripción**: Un usuario puede tener múltiples facturas, pero cada factura pertenece a un solo usuario. Cada factura se paga con un método de pago específico y se asocia a un único pedido.

-- 7. **Facturas y DetallesFactura** (Relación uno a muchos)
--    - **Descripción**: Una factura puede tener múltiples detalles, pero cada detalle pertenece a una sola factura. Cada detalle está relacionado con un único producto.

-- 8. **Usuarios y Chats** (Relación uno a muchos)
--    - **Descripción**: Un usuario puede tener múltiples chats, pero cada chat pertenece a un solo usuario.

-- 9. **Pedidos y Notificaciones** (Relación uno a muchos)
--    - **Descripción**: Un pedido puede tener múltiples notificaciones, pero cada notificación está asociada a un solo pedido.

-- 10. **Pedidos y Comprobantes** (Relación uno a uno)
--     - **Descripción**: Un pedido tiene un único comprobante y cada comprobante está asociado a un solo pedido.

-- 11. **Carritos y DetallesCarritos** (Relación uno a muchos)
--     - **Descripción**: Un carrito puede tener múltiples detalles, pero cada detalle pertenece a un solo carrito. Cada detalle del carrito está relacionado con un único producto.

-- 12. **Productos y FotosProductos** (Relación uno a muchos)
--     - **Descripción**: Un producto puede tener múltiples fotos, pero cada foto pertenece a un solo producto.

-- 13. **Usuarios y DireccionesEnvio** (Relación uno a muchos)
--     - **Descripción**: Un usuario puede tener múltiples direcciones de envío, pero cada dirección de envío pertenece a un solo usuario.

-- 14. **Usuarios y ReviewsProductos** (Relación uno a muchos)
--     - **Descripción**: Un usuario puede hacer múltiples reseñas, pero cada reseña pertenece a un solo usuario. Cada reseña está relacionada con un único producto.

-- 15. **Usuarios y HistorialesPago** (Relación uno a muchos)    - **Descripción**: Un usuario puede tener múltiples registros en el historial de pagos, pero cada registro pertenece a un solo usuario. Cada registro está relacionado con un único método de pago.

-- 16. **Pedidos y PedidosProductos** (Relación muchos a muchos)
--     - **Descripción**: Un pedido puede incluir múltiples productos y un producto puede estar en múltiples pedidos. Esto se maneja a través de la tabla intermedia PedidosProductos.
