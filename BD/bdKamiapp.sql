-- Tabla Roles
CREATE TABLE IF NOT EXISTS Roles (
    idRol INT PRIMARY KEY,
    nombreRol VARCHAR(255) NOT NULL
);

-- Tabla Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    idUsuario INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    cedula VARCHAR(20) NOT NULL ,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(255) NOT NULL,
    nickname VARCHAR(255) NOT NULL,
    imagenPerfil VARCHAR (255) NOT NULL
);

-- Tabla UsuariosRoles (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE IF NOT EXISTS UsuariosRoles (
    idUsuario INT NOT NULL,
    idRol INT NOT NULL,
    PRIMARY KEY (idUsuario, idRol),
    CONSTRAINT fk_UsuariosRoles_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_UsuariosRoles_Roles FOREIGN KEY (idRol) REFERENCES Roles(idRol) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla MetodosPago
CREATE TABLE IF NOT EXISTS MetodosPago (
    idMetodoPago INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL
);

-- Tabla Categorias
CREATE TABLE IF NOT EXISTS Categorias (
    idCategoria INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL
);

-- Tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
    idProducto INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    precio FLOAT NOT NULL,
    descripcion TEXT NOT NULL,
);

-- Tabla ProductosCategorias (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE IF NOT EXISTS ProductosCategorias (
    idProducto INT NOT NULL,
    idCategoria INT NOT NULL,
    PRIMARY KEY (idProducto, idCategoria),
    CONSTRAINT fk_ProductosCategorias_Productos FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ProductosCategorias_Categorias FOREIGN KEY (idCategoria) REFERENCES Categorias(idCategoria) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla Carritos
CREATE TABLE IF NOT EXISTS Carritos (
    idCarrito INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    estado VARCHAR(255) NOT NULL,
    CONSTRAINT fk_Carritos_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    idPedido INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    idCarrito INT NOT NULL,
    hora TIME NOT NULL,
    fechaPedido DATE DEFAULT CURRENT_DATE NOT NULL,
    estado VARCHAR(255) NOT NULL,
    CONSTRAINT fk_Pedidos_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Pedidos_Carritos FOREIGN KEY (idCarrito) REFERENCES Carritos(idCarrito) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla Suscripciones
CREATE TABLE IF NOT EXISTS Suscripciones (
    idSuscripcion INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    tipoSuscripcion VARCHAR(255) NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    estado VARCHAR(255) NOT NULL,
    CONSTRAINT fk_Suscripciones_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla Facturas
CREATE TABLE IF NOT EXISTS Facturas (
    idFactura INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    idMetodoPago INT NOT NULL,
    idPedido INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    total FLOAT NOT NULL,
    estadoPago VARCHAR(255) NOT NULL,
    CONSTRAINT fk_Facturas_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Facturas_MetodosPago FOREIGN KEY (idMetodoPago) REFERENCES MetodosPago(idMetodoPago) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Facturas_Pedidos FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla DetallesFactura
CREATE TABLE IF NOT EXISTS DetallesFactura (
    idDetalleFactura INT PRIMARY KEY,
    idFactura INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario FLOAT NOT NULL,
    subtotal FLOAT NOT NULL,
    CONSTRAINT fk_DetallesFactura_Facturas FOREIGN KEY (idFactura) REFERENCES Facturas(idFactura) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_DetallesFactura_Productos FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla Chats
CREATE TABLE IF NOT EXISTS Chats (
    idChat INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    mensaje TEXT NOT NULL,
    fotoProducto VARCHAR(255),
    CONSTRAINT fk_Chats_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla Notificaciones
CREATE TABLE IF NOT EXISTS Notificaciones (
    idNotificacion INT PRIMARY KEY,
    idPedido INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    notificacionPedido TEXT NOT NULL,
    CONSTRAINT fk_Notificaciones_Pedidos FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla Comprobantes
CREATE TABLE IF NOT EXISTS Comprobantes (
    idComprobante INT PRIMARY KEY,
    idPedido INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    total FLOAT NOT NULL,
    detalles TEXT NOT NULL,
    estadoPago VARCHAR(255) NOT NULL,
    CONSTRAINT fk_Comprobantes_Pedidos FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla DetallesCarritos
CREATE TABLE IF NOT EXISTS DetallesCarritos (
    idDetalleCarrito INT PRIMARY KEY,
    idCarrito INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    precioUnitario FLOAT NOT NULL,
    subtotal FLOAT NOT NULL,
    CONSTRAINT fk_DetallesCarritos_Carritos FOREIGN KEY (idCarrito) REFERENCES Carritos(idCarrito) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_DetallesCarritos_Productos FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla FotosProductos
CREATE TABLE IF NOT EXISTS FotosProductos (
    idFotoProducto INT PRIMARY KEY,
    idProducto INT NOT NULL,
    urlFoto VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    CONSTRAINT fk_FotosProductos_Productos FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla DireccionesEnvio
CREATE TABLE IF NOT EXISTS DireccionesEnvio (
    idDireccion INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    departamento VARCHAR(255) NOT NULL,
    municipio VARCHAR(255) NOT NULL,
    ciudad VARCHAR(255) NOT NULL,
    CONSTRAINT fk_DireccionesEnvio_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla ReviewsProductos
CREATE TABLE IF NOT EXISTS ReviewsProductos (
    idReview INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    idProducto INT NOT NULL,
    calificacion INT NOT NULL,
    comentario TEXT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT fk_ReviewsProductos_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ReviewsProductos_Productos FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla CuponesDescuento
CREATE TABLE IF NOT EXISTS CuponesDescuento (
    idCupon INT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    descuento FLOAT NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    estado VARCHAR(255) NOT NULL,
    idUsuario INT NOT NULL, -- Clave foránea que referencia al usuario
    CONSTRAINT fk_CuponesDescuento_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla HistorialesPago
CREATE TABLE IF NOT EXISTS HistorialesPago (
    idHistorialPago INT PRIMARY KEY,
    idUsuario INT NOT NULL,
    idMetodoPago INT NOT NULL,
    fecha DATE DEFAULT CURRENT_DATE NOT NULL,
    hora TIME NOT NULL,
    monto FLOAT NOT NULL,
    estado VARCHAR(255) NOT NULL,
    CONSTRAINT fk_HistorialesPago_Usuarios FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_HistorialesPago_MetodosPago FOREIGN KEY (idMetodoPago) REFERENCES MetodosPago(idMetodoPago) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabla intermedia PedidosProductos (Tabla intermedia para la relación muchos a muchos)
CREATE TABLE IF NOT EXISTS PedidosProductos (
    idPedidosProductos INT PRIMARY KEY,
    idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (idPedido, idProducto),
    CONSTRAINT fk_PedidosProductos_Pedidos FOREIGN KEY (idPedido) REFERENCES Pedidos(idPedido) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_PedidosProductos_Productos FOREIGN KEY (idProducto) REFERENCES Productos(idProducto) ON DELETE RESTRICT ON UPDATE CASCADE
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
