-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-06-2024 a las 07:39:49
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Kamiapp`
--
CREATE DATABASE IF NOT EXISTS `Kamiapp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Kamiapp`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Carritos`
--

DROP TABLE IF EXISTS `Carritos`;
CREATE TABLE IF NOT EXISTS `Carritos` (
  `idCarrito` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  `hora` time NOT NULL,
  `estado` varchar(100) NOT NULL,
  PRIMARY KEY (`idCarrito`),
  KEY `fk_Carritos_Usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Categorias`
--

DROP TABLE IF EXISTS `Categorias`;
CREATE TABLE IF NOT EXISTS `Categorias` (
  `idCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Chats`
--

DROP TABLE IF EXISTS `Chats`;
CREATE TABLE IF NOT EXISTS `Chats` (
  `idChat` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  `hora` time NOT NULL,
  `mensaje` text NOT NULL,
  `fotoProducto` mediumblob DEFAULT NULL,
  PRIMARY KEY (`idChat`),
  KEY `fk_Chats_Usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Comprobantes`
--

DROP TABLE IF EXISTS `Comprobantes`;
CREATE TABLE IF NOT EXISTS `Comprobantes` (
  `idComprobante` int(11) NOT NULL AUTO_INCREMENT,
  `idPedido` int(11) NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  `total` decimal(10,0) UNSIGNED NOT NULL,
  `detalles` text NOT NULL,
  `estadoPago` varchar(100) NOT NULL,
  PRIMARY KEY (`idComprobante`),
  KEY `fk_Comprobantes_Pedidos` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CuponesDescuento`
--

DROP TABLE IF EXISTS `CuponesDescuento`;
CREATE TABLE IF NOT EXISTS `CuponesDescuento` (
  `idCupon` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `descuento` decimal(10,0) UNSIGNED NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `estado` varchar(100) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idCupon`),
  KEY `fk_CuponesDescuento_Usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DetallesCarritos`
--

DROP TABLE IF EXISTS `DetallesCarritos`;
CREATE TABLE IF NOT EXISTS `DetallesCarritos` (
  `idDetalleCarrito` int(11) NOT NULL AUTO_INCREMENT,
  `idCarrito` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `precioUnitario` decimal(10,0) UNSIGNED NOT NULL,
  `subtotal` decimal(10,0) UNSIGNED NOT NULL,
  PRIMARY KEY (`idDetalleCarrito`),
  KEY `fk_DetallesCarritos_Carritos` (`idCarrito`),
  KEY `fk_DetallesCarritos_Productos` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DetallesFactura`
--

DROP TABLE IF EXISTS `DetallesFactura`;
CREATE TABLE IF NOT EXISTS `DetallesFactura` (
  `idDetalleFactura` int(11) NOT NULL AUTO_INCREMENT,
  `idFactura` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `precioUnitario` decimal(10,0) UNSIGNED NOT NULL,
  `subtotal` decimal(10,0) UNSIGNED NOT NULL,
  PRIMARY KEY (`idDetalleFactura`),
  KEY `fk_DetallesFactura_Facturas` (`idFactura`),
  KEY `fk_DetallesFactura_Productos` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DireccionesEnvio`
--

DROP TABLE IF EXISTS `DireccionesEnvio`;
CREATE TABLE IF NOT EXISTS `DireccionesEnvio` (
  `idDireccion` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `departamento` varchar(100) NOT NULL,
  `municipio` varchar(100) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  PRIMARY KEY (`idDireccion`),
  KEY `fk_DireccionesEnvio_Usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Facturas`
--

DROP TABLE IF EXISTS `Facturas`;
CREATE TABLE IF NOT EXISTS `Facturas` (
  `idFactura` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idMetodoPago` int(11) NOT NULL,
  `idPedido` int(11) NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  `hora` time NOT NULL DEFAULT curtime(),
  `total` decimal(10,0) UNSIGNED NOT NULL,
  `estadoPago` varchar(100) NOT NULL,
  PRIMARY KEY (`idFactura`),
  KEY `fk_Facturas_Usuarios` (`idUsuario`),
  KEY `fk_Facturas_MetodosPago` (`idMetodoPago`),
  KEY `fk_Facturas_Pedidos` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `FotosProductos`
--

DROP TABLE IF EXISTS `FotosProductos`;
CREATE TABLE IF NOT EXISTS `FotosProductos` (
  `idFotoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `idProducto` int(11) NOT NULL,
  `urlFoto` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`idFotoProducto`),
  KEY `fk_FotosProductos_Productos` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `HistorialesPago`
--

DROP TABLE IF EXISTS `HistorialesPago`;
CREATE TABLE IF NOT EXISTS `HistorialesPago` (
  `idHistorialPago` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idMetodoPago` int(11) NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  `hora` time NOT NULL,
  `monto` decimal(10,0) UNSIGNED NOT NULL,
  `estado` varchar(100) NOT NULL,
  PRIMARY KEY (`idHistorialPago`),
  KEY `fk_HistorialesPago_Usuarios` (`idUsuario`),
  KEY `fk_HistorialesPago_MetodosPago` (`idMetodoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `MetodosPago`
--

DROP TABLE IF EXISTS `MetodosPago`;
CREATE TABLE IF NOT EXISTS `MetodosPago` (
  `idMetodoPago` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`idMetodoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Notificaciones`
--

DROP TABLE IF EXISTS `Notificaciones`;
CREATE TABLE IF NOT EXISTS `Notificaciones` (
  `idNotificacion` int(11) NOT NULL AUTO_INCREMENT,
  `idPedido` int(11) NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  `hora` time NOT NULL,
  `notificacionPedido` text NOT NULL,
  PRIMARY KEY (`idNotificacion`),
  KEY `fk_Notificaciones_Pedidos` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pedidos`
--

DROP TABLE IF EXISTS `Pedidos`;
CREATE TABLE IF NOT EXISTS `Pedidos` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idCarrito` int(11) NOT NULL,
  `hora` time NOT NULL,
  `fechaPedido` date NOT NULL DEFAULT curdate(),
  `estado` varchar(100) NOT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `fk_Pedidos_Usuarios` (`idUsuario`),
  KEY `fk_Pedidos_Carritos` (`idCarrito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `PedidosProductos`
--

DROP TABLE IF EXISTS `PedidosProductos`;
CREATE TABLE IF NOT EXISTS `PedidosProductos` (
  `idPedidoProducto` int(11) NOT NULL AUTO_INCREMENT,
  `idPedido` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`idPedidoProducto`),
  KEY `fk_PedidosProductos_Pedidos` (`idPedido`),
  KEY `fk_PedidosProductos_Productos` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Productos`
--

DROP TABLE IF EXISTS `Productos`;
CREATE TABLE IF NOT EXISTS `Productos` (
  `idProducto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,0) UNSIGNED NOT NULL,
  `descripcion` text NOT NULL,
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ProductosCategorias`
--

DROP TABLE IF EXISTS `ProductosCategorias`;
CREATE TABLE IF NOT EXISTS `ProductosCategorias` (
  `idProducto` int(11) NOT NULL,
  `idCategoria` int(11) NOT NULL,
  PRIMARY KEY (`idProducto`,`idCategoria`),
  KEY `fk_ProductosCategorias_Categorias` (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ReviewsProductos`
--

DROP TABLE IF EXISTS `ReviewsProductos`;
CREATE TABLE IF NOT EXISTS `ReviewsProductos` (
  `idReview` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `calificacion` int(5) NOT NULL,
  `comentario` text NOT NULL,
  `fecha` date NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`idReview`),
  KEY `fk_ReviewsProductos_Usuarios` (`idUsuario`),
  KEY `fk_ReviewsProductos_Productos` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Roles`
--

DROP TABLE IF EXISTS `Roles`;
CREATE TABLE IF NOT EXISTS `Roles` (
  `idRol` int(11) NOT NULL AUTO_INCREMENT,
  `nombreRol` varchar(100) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Suscripciones`
--

DROP TABLE IF EXISTS `Suscripciones`;
CREATE TABLE IF NOT EXISTS `Suscripciones` (
  `idSuscripcion` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `tipoSuscripcion` varchar(255) NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `estado` varchar(100) NOT NULL,
  PRIMARY KEY (`idSuscripcion`),
  KEY `fk_Suscripciones_Usuarios` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

DROP TABLE IF EXISTS `Usuarios`;
CREATE TABLE IF NOT EXISTS `Usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `datoBancario` varchar(100) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `imagenPerfil` mediumblob DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `cedula` (`cedula`),
  UNIQUE KEY `correo` (`correo`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `UsuariosRoles`
--

DROP TABLE IF EXISTS `UsuariosRoles`;
CREATE TABLE IF NOT EXISTS `UsuariosRoles` (
  `idUsuario` int(11) NOT NULL,
  `idRol` int(11) NOT NULL,
  PRIMARY KEY (`idUsuario`,`idRol`),
  KEY `fk_UsuariosRoles_Roles` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Carritos`
--
ALTER TABLE `Carritos`
  ADD CONSTRAINT `fk_Carritos_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `Chats`
--
ALTER TABLE `Chats`
  ADD CONSTRAINT `fk_Chats_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `Comprobantes`
--
ALTER TABLE `Comprobantes`
  ADD CONSTRAINT `fk_Comprobantes_Pedidos` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos` (`idPedido`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `CuponesDescuento`
--
ALTER TABLE `CuponesDescuento`
  ADD CONSTRAINT `fk_CuponesDescuento_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `DetallesCarritos`
--
ALTER TABLE `DetallesCarritos`
  ADD CONSTRAINT `fk_DetallesCarritos_Carritos` FOREIGN KEY (`idCarrito`) REFERENCES `Carritos` (`idCarrito`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_DetallesCarritos_Productos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `DetallesFactura`
--
ALTER TABLE `DetallesFactura`
  ADD CONSTRAINT `fk_DetallesFactura_Facturas` FOREIGN KEY (`idFactura`) REFERENCES `Facturas` (`idFactura`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_DetallesFactura_Productos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `DireccionesEnvio`
--
ALTER TABLE `DireccionesEnvio`
  ADD CONSTRAINT `fk_DireccionesEnvio_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `Facturas`
--
ALTER TABLE `Facturas`
  ADD CONSTRAINT `fk_Facturas_MetodosPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `MetodosPago` (`idMetodoPago`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Facturas_Pedidos` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos` (`idPedido`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Facturas_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `FotosProductos`
--
ALTER TABLE `FotosProductos`
  ADD CONSTRAINT `fk_FotosProductos_Productos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `HistorialesPago`
--
ALTER TABLE `HistorialesPago`
  ADD CONSTRAINT `fk_HistorialesPago_MetodosPago` FOREIGN KEY (`idMetodoPago`) REFERENCES `MetodosPago` (`idMetodoPago`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_HistorialesPago_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `Notificaciones`
--
ALTER TABLE `Notificaciones`
  ADD CONSTRAINT `fk_Notificaciones_Pedidos` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos` (`idPedido`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `Pedidos`
--
ALTER TABLE `Pedidos`
  ADD CONSTRAINT `fk_Pedidos_Carritos` FOREIGN KEY (`idCarrito`) REFERENCES `Carritos` (`idCarrito`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Pedidos_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `PedidosProductos`
--
ALTER TABLE `PedidosProductos`
  ADD CONSTRAINT `fk_PedidosProductos_Pedidos` FOREIGN KEY (`idPedido`) REFERENCES `Pedidos` (`idPedido`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_PedidosProductos_Productos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ProductosCategorias`
--
ALTER TABLE `ProductosCategorias`
  ADD CONSTRAINT `fk_ProductosCategorias_Categorias` FOREIGN KEY (`idCategoria`) REFERENCES `Categorias` (`idCategoria`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ProductosCategorias_Productos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ReviewsProductos`
--
ALTER TABLE `ReviewsProductos`
  ADD CONSTRAINT `fk_ReviewsProductos_Productos` FOREIGN KEY (`idProducto`) REFERENCES `Productos` (`idProducto`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ReviewsProductos_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `Suscripciones`
--
ALTER TABLE `Suscripciones`
  ADD CONSTRAINT `fk_Suscripciones_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `UsuariosRoles`
--
ALTER TABLE `UsuariosRoles`
  ADD CONSTRAINT `fk_UsuariosRoles_Roles` FOREIGN KEY (`idRol`) REFERENCES `Roles` (`idRol`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_UsuariosRoles_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `Usuarios` (`idUsuario`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
