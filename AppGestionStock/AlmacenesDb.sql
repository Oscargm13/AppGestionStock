USE [master]
GO
/****** Object:  Database [Almacenes]    Script Date: 13/03/2025 14:02:52 ******/
CREATE DATABASE [Almacenes]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Almacenes', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Almacenes.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Almacenes_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Almacenes_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Almacenes] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Almacenes].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Almacenes] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Almacenes] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Almacenes] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Almacenes] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Almacenes] SET ARITHABORT OFF 
GO
ALTER DATABASE [Almacenes] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Almacenes] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Almacenes] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Almacenes] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Almacenes] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Almacenes] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Almacenes] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Almacenes] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Almacenes] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Almacenes] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Almacenes] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Almacenes] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Almacenes] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Almacenes] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Almacenes] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Almacenes] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Almacenes] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Almacenes] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Almacenes] SET  MULTI_USER 
GO
ALTER DATABASE [Almacenes] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Almacenes] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Almacenes] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Almacenes] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Almacenes] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Almacenes] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Almacenes] SET QUERY_STORE = ON
GO
ALTER DATABASE [Almacenes] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Almacenes]
GO
/****** Object:  UserDefinedTableType [dbo].[DetallesVentaType]    Script Date: 13/03/2025 14:02:52 ******/
CREATE TYPE [dbo].[DetallesVentaType] AS TABLE(
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL,
	[PrecioUnidad] [decimal](18, 0) NULL
)
GO
/****** Object:  Table [dbo].[ProductosTienda]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosTienda](
	[IdProducto] [int] NOT NULL,
	[IdTienda] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC,
	[IdTienda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tiendas]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tiendas](
	[IdTienda] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Direccion] [varchar](255) NOT NULL,
	[Telefono] [varchar](20) NULL,
	[Email] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTienda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[Coste] [decimal](10, 2) NOT NULL,
	[IdCategoria] [int] NOT NULL,
	[Imagen] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaProductosTienda]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaProductosTienda] AS
SELECT
    p.IdProducto,
    p.Nombre,
    p.Precio,
    p.Coste,
    p.IdCategoria,
    p.Imagen,
    pt.IdTienda,
    t.Nombre AS NombreTienda,
    pt.Cantidad AS StockTienda
FROM
    Productos p
JOIN
    ProductosTienda pt ON p.IdProducto = pt.IdProducto
JOIN
    Tiendas t ON pt.IdTienda = t.IdTienda;
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[IdRol] [int] NOT NULL,
	[Imagen] [varchar](100) NULL,
	[nombre_empresa] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManagersTiendas]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManagersTiendas](
	[IdUsuario] [int] NOT NULL,
	[IdTienda] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC,
	[IdTienda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[IdProveedor] [int] IDENTITY(1,1) NOT NULL,
	[NombreEmpresa] [varchar](100) NOT NULL,
	[Telefono] [varchar](20) NULL,
	[Email] [varchar](100) NULL,
	[NombreContacto] [varchar](100) NULL,
	[Direccion] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductosProveedores]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductosProveedores](
	[IdProducto] [int] NOT NULL,
	[IdProveedor] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC,
	[IdProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaProductosGerente]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaProductosGerente] AS
SELECT
    p.IdProducto,
    p.Nombre AS NombreProducto,
    p.Precio,
    p.Coste,
    p.IdCategoria,
    p.Imagen,
    t.IdTienda,
    t.Nombre AS NombreTienda,
    pt.Cantidad AS StockTienda,
    mt.IdUsuario AS IdGerente,
    prov.IdProveedor,
    prov.NombreEmpresa,
    u.nombre_empresa AS NombreEmpresaGerente -- Agregamos el nombre de empresa del usuario
FROM
    Productos p
JOIN
    ProductosTienda pt ON p.IdProducto = pt.IdProducto
JOIN
    Tiendas t ON pt.IdTienda = t.IdTienda
JOIN
    ManagersTiendas mt ON t.IdTienda = mt.IdTienda
LEFT JOIN
    ProductosProveedores pp ON p.IdProducto = pp.IdProducto
LEFT JOIN
    Proveedores prov ON pp.IdProveedor = prov.IdProveedor
JOIN
    Usuarios u ON mt.IdUsuario = u.IdUsuario;
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[IdVenta] [int] IDENTITY(1,1) NOT NULL,
	[FechaVenta] [datetime] NOT NULL,
	[IdTienda] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[ImporteTotal] [decimal](10, 2) NOT NULL,
	[IdCliente] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compras](
	[IdCompra] [int] IDENTITY(1,1) NOT NULL,
	[FechaCompra] [datetime] NOT NULL,
	[IdProveedor] [int] NOT NULL,
	[IdTienda] [int] NOT NULL,
	[ImporteTotal] [decimal](10, 2) NOT NULL,
	[IdUsuario] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[IdInventario] [int] IDENTITY(1,1) NOT NULL,
	[IdProducto] [int] NOT NULL,
	[FechaMovimiento] [datetime] NOT NULL,
	[TipoMovimiento] [varchar](10) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[IdMovimiento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdInventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Direccion] [varchar](255) NULL,
	[Telefono] [varchar](20) NULL,
	[FechaNacimiento] [date] NULL,
	[Genero] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaInventarioDetallado]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaInventarioDetallado] AS
SELECT
    i.IdInventario,
    i.IdProducto,
    p.Nombre AS NombreProducto,
    p.Imagen AS ImagenProducto,
    i.FechaMovimiento,
    i.TipoMovimiento,
    i.Cantidad,
    i.IdMovimiento,
    v.IdCliente,
    c.Nombre AS NombreCliente,
    v.IdTienda,
    t.Nombre AS NombreTienda,
    co.IdProveedor,
    pr.NombreEmpresa as NombreProveedor,
    co.IdTienda as IdTiendaCompra,
    ti.Nombre as NombreTiendaCompra
FROM
    Inventario i
LEFT JOIN
    Productos p ON i.IdProducto = p.IdProducto
LEFT JOIN
    Ventas v ON i.IdMovimiento = v.IdVenta
LEFT JOIN
    Clientes c ON v.IdCliente = c.IdCliente
LEFT JOIN
    Tiendas t ON v.IdTienda = t.IdTienda
LEFT JOIN
    Compras co ON i.IdMovimiento = co.IdCompra
LEFT JOIN
    Proveedores pr ON co.IdProveedor = pr.IdProveedor
LEFT JOIN
    Tiendas ti ON co.IdTienda = ti.IdTienda;
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[IdCategoriaPadre] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallesCompra]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesCompra](
	[IdDetallesCompra] [int] IDENTITY(1,1) NOT NULL,
	[IdCompra] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnidad] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetallesCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallesVenta]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesVenta](
	[IdDetallesVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnidad] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetallesVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificaciones]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificaciones](
	[IdNotificacion] [int] IDENTITY(1,1) NOT NULL,
	[Mensaje] [nvarchar](max) NULL,
	[Fecha] [datetime] NULL,
	[IdProducto] [int] NULL,
	[IdTienda] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdNotificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[IdRol] [int] IDENTITY(1,1) NOT NULL,
	[Rol] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (0, N'CategoríasPrincipales', NULL)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (1, N'Frutas y Verduras', 0)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (2, N'Carnes y Pescados', 0)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (3, N'Lácteos', 0)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (4, N'Panadería', 0)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (5, N'Bebidas', 0)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (6, N'Frutas', 1)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (7, N'Verduras', 1)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (8, N'Carnes', 2)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (9, N'Pescados', 2)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (10, N'Leche', 3)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (11, N'Quesos', 3)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (12, N'Pan', 4)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (13, N'Bollería', 4)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (14, N'Refrescos', 5)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (15, N'Aguas', 5)
INSERT [dbo].[Categorias] ([IdCategoria], [Nombre], [IdCategoriaPadre]) VALUES (16, N'Cereales', 0)
SET IDENTITY_INSERT [dbo].[Categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 

INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (1, N'Ana', N'García', N'ana.garcia@email.com', N'Calle Mayor 123, Madrid', N'612345678', CAST(N'1990-05-15' AS Date), N'Femenino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (2, N'Luis', N'Martínez', N'luis.martinez@email.com', N'Avenida Central 45, Barcelona', N'698765432', CAST(N'1985-11-20' AS Date), N'Masculino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (3, N'Sofía', N'Pérez', N'sofia.perez@email.com', N'Plaza del Sol 7, Valencia', N'655555555', CAST(N'1995-03-01' AS Date), N'Femenino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (4, N'Javier', N'Rodríguez', N'javier.rodriguez@email.com', N'Ronda de Toledo 89, Sevilla', N'677777777', CAST(N'1980-09-10' AS Date), N'Masculino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (5, N'Carmen', N'López', N'carmen.lopez@email.com', N'Gran Vía 22, Bilbao', N'633333333', CAST(N'2000-07-25' AS Date), N'Femenino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (6, N'Manuel', N'Sánchez', N'manuel.sanchez@email.com', N'Paseo de Gracia 56, Málaga', N'688888888', CAST(N'1975-01-05' AS Date), N'Masculino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (7, N'Laura', N'Ruiz', N'laura.ruiz@email.com', N'Calle Alcalá 34, Zaragoza', N'622222222', CAST(N'1998-04-18' AS Date), N'Femenino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (8, N'Pedro', N'Díaz', N'pedro.diaz@email.com', N'Calle Colón 15, Granada', N'644444444', CAST(N'1987-12-03' AS Date), N'Masculino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (9, N'Marta', N'Jiménez', N'marta.jimenez@email.com', N'Calle Serrano 67, Alicante', N'666666666', CAST(N'1993-06-22' AS Date), N'Femenino')
INSERT [dbo].[Clientes] ([IdCliente], [Nombre], [Apellido], [Email], [Direccion], [Telefono], [FechaNacimiento], [Genero]) VALUES (10, N'David', N'Moreno', N'david.moreno@email.com', N'Calle Bailén 90, Valladolid', N'600000000', CAST(N'1982-08-28' AS Date), N'Masculino')
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[Compras] ON 

INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (18, CAST(N'2024-01-03T00:00:00.000' AS DateTime), 1, 1, CAST(2500.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (19, CAST(N'2024-03-03T00:00:00.000' AS DateTime), 2, 1, CAST(1800.50 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (20, CAST(N'2024-05-03T00:00:00.000' AS DateTime), 1, 2, CAST(3200.75 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (21, CAST(N'2024-07-03T00:00:00.000' AS DateTime), 3, 3, CAST(950.25 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (22, CAST(N'2024-10-03T00:00:00.000' AS DateTime), 2, 2, CAST(1650.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (25, CAST(N'2025-03-12T18:49:00.000' AS DateTime), 1, 1, CAST(300.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (26, CAST(N'2025-03-12T18:50:00.000' AS DateTime), 1, 1, CAST(51.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (27, CAST(N'2025-03-12T19:34:00.000' AS DateTime), 1, 1, CAST(30.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (28, CAST(N'2025-03-12T19:52:00.000' AS DateTime), 1, 1, CAST(32.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (29, CAST(N'2025-03-12T20:05:00.000' AS DateTime), 1, 1, CAST(8.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (30, CAST(N'2025-03-12T20:05:00.000' AS DateTime), 2, 2, CAST(82.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (34, CAST(N'2025-01-15T00:00:00.000' AS DateTime), 1, 1, CAST(2800.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (35, CAST(N'2025-02-20T00:00:00.000' AS DateTime), 2, 2, CAST(2100.50 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (36, CAST(N'2025-03-10T00:00:00.000' AS DateTime), 3, 3, CAST(1200.75 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (37, CAST(N'2025-04-05T00:00:00.000' AS DateTime), 1, 1, CAST(3500.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (38, CAST(N'2025-05-18T00:00:00.000' AS DateTime), 2, 2, CAST(2500.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (39, CAST(N'2025-06-25T00:00:00.000' AS DateTime), 3, 3, CAST(1800.25 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (40, CAST(N'2025-01-15T00:00:00.000' AS DateTime), 1, 1, CAST(2800.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (41, CAST(N'2025-02-20T00:00:00.000' AS DateTime), 2, 2, CAST(2100.50 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (42, CAST(N'2025-03-10T00:00:00.000' AS DateTime), 3, 3, CAST(1200.75 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (43, CAST(N'2025-04-05T00:00:00.000' AS DateTime), 1, 1, CAST(3500.00 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (44, CAST(N'2025-05-18T00:00:00.000' AS DateTime), 2, 2, CAST(2500.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (45, CAST(N'2025-06-25T00:00:00.000' AS DateTime), 3, 3, CAST(1800.25 AS Decimal(10, 2)), 4)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (46, CAST(N'2025-03-13T09:04:00.000' AS DateTime), 2, 1, CAST(24.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Compras] ([IdCompra], [FechaCompra], [IdProveedor], [IdTienda], [ImporteTotal], [IdUsuario]) VALUES (47, CAST(N'2025-03-16T09:37:00.000' AS DateTime), 2, 2, CAST(210.00 AS Decimal(10, 2)), 3)
SET IDENTITY_INSERT [dbo].[Compras] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallesCompra] ON 

INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (16, 18, 1, 20, CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (17, 18, 2, 15, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (18, 19, 3, 30, CAST(40.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (19, 19, 4, 10, CAST(60.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (20, 20, 1, 25, CAST(48.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (21, 20, 5, 15, CAST(120.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (22, 21, 6, 40, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (23, 21, 7, 25, CAST(14.01 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (24, 22, 2, 10, CAST(105.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (25, 22, 8, 10, CAST(60.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (28, 25, 1, 20, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (29, 26, 1, 1, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (30, 26, 2, 3, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (31, 27, 1, 2, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (32, 28, 1, 4, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (33, 29, 1, 1, CAST(8.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (34, 30, 6, 10, CAST(7.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (35, 30, 5, 2, CAST(6.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (39, 46, 5, 4, CAST(6.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesCompra] ([IdDetallesCompra], [IdCompra], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (40, 47, 6, 30, CAST(7.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DetallesCompra] OFF
GO
SET IDENTITY_INSERT [dbo].[DetallesVenta] ON 

INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (4, 8, 1, 16, CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (5, 8, 2, 24, CAST(30.50 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (6, 9, 3, 100, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (7, 10, 1, 160, CAST(120.75 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (8, 12, 11, 30, CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (9, 13, 4, 10, CAST(11.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (10, 13, 1, 10, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (11, 14, 2, 1, CAST(12.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (12, 15, 1, 6, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (13, 16, 1, 3, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (14, 17, 1, 2, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (15, 17, 11, 4, CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (16, 18, 11, 6, CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (17, 18, 1, 2, CAST(1.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (20, 20, 2, 6, CAST(120.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (21, 21, 5, 1, CAST(850.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (30, 29, 6, 1, CAST(920.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (31, 30, 6, 1, CAST(920.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (32, 31, 6, 1, CAST(920.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (35, 34, 6, 1, CAST(920.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (38, 37, 1, 1, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (39, 38, 6, 1, CAST(920.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (43, 40, 1, 10, CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (44, 40, 2, 15, CAST(110.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (45, 41, 3, 20, CAST(75.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (46, 41, 4, 25, CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (47, 42, 1, 30, CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (48, 42, 5, 5, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (49, 46, 6, 7, CAST(920.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (50, 47, 7, 30, CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (51, 47, 12, 22, CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (52, 48, 1, 3, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[DetallesVenta] ([IdDetallesVenta], [IdVenta], [IdProducto], [Cantidad], [PrecioUnidad]) VALUES (53, 49, 6, 2, CAST(920.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[DetallesVenta] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventario] ON 

INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (23, 11, CAST(N'2025-03-08T13:33:00.000' AS DateTime), N'Salida', 6, 18)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (24, 1, CAST(N'2025-03-08T13:33:00.000' AS DateTime), N'Salida', 2, 18)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (27, 2, CAST(N'2025-03-09T10:33:00.000' AS DateTime), N'Salida', 6, 20)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (28, 5, CAST(N'2025-03-09T10:40:00.000' AS DateTime), N'Salida', 1, 21)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (41, 1, CAST(N'2024-01-03T00:00:00.000' AS DateTime), N'Entrada', 20, 18)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (42, 2, CAST(N'2024-01-03T00:00:00.000' AS DateTime), N'Entrada', 15, 18)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (45, 1, CAST(N'2024-05-03T00:00:00.000' AS DateTime), N'Entrada', 25, 20)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (46, 5, CAST(N'2024-05-03T00:00:00.000' AS DateTime), N'Entrada', 15, 20)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (47, 6, CAST(N'2024-07-03T00:00:00.000' AS DateTime), N'Entrada', 40, 21)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (48, 7, CAST(N'2024-07-03T00:00:00.000' AS DateTime), N'Entrada', 25, 21)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (59, 6, CAST(N'2025-03-11T21:04:00.000' AS DateTime), N'Salida', 1, 29)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (60, 6, CAST(N'2025-03-11T21:09:00.000' AS DateTime), N'Salida', 1, 30)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (61, 6, CAST(N'2025-03-11T21:17:00.000' AS DateTime), N'Salida', 1, 31)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (64, 6, CAST(N'2025-03-11T21:45:00.000' AS DateTime), N'Salida', 1, 34)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (67, 1, CAST(N'2025-03-12T17:41:00.000' AS DateTime), N'Salida', 1, 37)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (68, 6, CAST(N'2025-03-12T17:42:00.000' AS DateTime), N'Salida', 1, 38)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (74, 1, CAST(N'2025-03-12T20:05:00.000' AS DateTime), N'Entrada', 1, 29)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (75, 6, CAST(N'2025-03-12T20:05:00.000' AS DateTime), N'Entrada', 10, 30)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (76, 5, CAST(N'2025-03-12T20:05:00.000' AS DateTime), N'Entrada', 2, 30)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (80, 1, CAST(N'2025-01-20T00:00:00.000' AS DateTime), N'Salida', 10, 40)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (81, 2, CAST(N'2025-01-20T00:00:00.000' AS DateTime), N'Salida', 15, 40)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (82, 3, CAST(N'2025-02-25T00:00:00.000' AS DateTime), N'Salida', 20, 41)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (83, 4, CAST(N'2025-02-25T00:00:00.000' AS DateTime), N'Salida', 25, 41)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (84, 1, CAST(N'2025-03-15T00:00:00.000' AS DateTime), N'Salida', 30, 42)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (85, 5, CAST(N'2025-03-15T00:00:00.000' AS DateTime), N'Salida', 5, 42)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (87, 6, CAST(N'2025-02-12T09:20:00.000' AS DateTime), N'Salida', 7, 46)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (88, 7, CAST(N'2025-02-13T09:36:00.000' AS DateTime), N'Salida', 30, 47)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (89, 12, CAST(N'2025-02-13T09:36:00.000' AS DateTime), N'Salida', 22, 47)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (90, 6, CAST(N'2025-03-16T09:37:00.000' AS DateTime), N'Entrada', 30, 47)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (91, 1, CAST(N'2025-03-13T10:09:00.000' AS DateTime), N'Salida', 3, 48)
INSERT [dbo].[Inventario] ([IdInventario], [IdProducto], [FechaMovimiento], [TipoMovimiento], [Cantidad], [IdMovimiento]) VALUES (92, 6, CAST(N'2025-03-13T10:10:00.000' AS DateTime), N'Salida', 2, 49)
SET IDENTITY_INSERT [dbo].[Inventario] OFF
GO
INSERT [dbo].[ManagersTiendas] ([IdUsuario], [IdTienda]) VALUES (3, 1)
INSERT [dbo].[ManagersTiendas] ([IdUsuario], [IdTienda]) VALUES (3, 2)
INSERT [dbo].[ManagersTiendas] ([IdUsuario], [IdTienda]) VALUES (3, 3)
GO
SET IDENTITY_INSERT [dbo].[Notificaciones] ON 

INSERT [dbo].[Notificaciones] ([IdNotificacion], [Mensaje], [Fecha], [IdProducto], [IdTienda]) VALUES (6, N'Stock bajo para el producto Filete de ternera en la tienda Supermercado Madrid Centro', CAST(N'2025-03-13T09:04:48.790' AS DateTime), 5, 1)
SET IDENTITY_INSERT [dbo].[Notificaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Productos] ON 

INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (1, N'Manzanas', CAST(1.50 AS Decimal(10, 2)), CAST(0.80 AS Decimal(10, 2)), 6, N'manzanas.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (2, N'Plátanos', CAST(1.20 AS Decimal(10, 2)), CAST(0.60 AS Decimal(10, 2)), 6, N'platanos.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (3, N'Lechuga', CAST(0.90 AS Decimal(10, 2)), CAST(0.40 AS Decimal(10, 2)), 7, N'lechuga.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (4, N'Tomates', CAST(1.10 AS Decimal(10, 2)), CAST(0.50 AS Decimal(10, 2)), 7, N'tomates.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (5, N'Filete de ternera', CAST(8.50 AS Decimal(10, 2)), CAST(6.00 AS Decimal(10, 2)), 8, N'filete.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (6, N'Salmón fresco', CAST(9.20 AS Decimal(10, 2)), CAST(7.00 AS Decimal(10, 2)), 9, N'salmon.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (7, N'Leche entera', CAST(0.80 AS Decimal(10, 2)), CAST(0.50 AS Decimal(10, 2)), 10, N'leche.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (8, N'Queso manchego', CAST(4.50 AS Decimal(10, 2)), CAST(3.00 AS Decimal(10, 2)), 11, N'queso.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (9, N'Pan de barra', CAST(0.60 AS Decimal(10, 2)), CAST(0.30 AS Decimal(10, 2)), 12, N'pan.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (10, N'Croissant', CAST(0.95 AS Decimal(10, 2)), CAST(0.50 AS Decimal(10, 2)), 13, N'croissant.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (11, N'Refresco de cola', CAST(1.00 AS Decimal(10, 2)), CAST(0.40 AS Decimal(10, 2)), 14, N'cola.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (12, N'Agua mineral', CAST(0.50 AS Decimal(10, 2)), CAST(0.20 AS Decimal(10, 2)), 15, N'agua.jpg')
INSERT [dbo].[Productos] ([IdProducto], [Nombre], [Precio], [Coste], [IdCategoria], [Imagen]) VALUES (21, N'Cereales', CAST(3.00 AS Decimal(10, 2)), CAST(1.00 AS Decimal(10, 2)), 16, N'Cereales.jpg')
SET IDENTITY_INSERT [dbo].[Productos] OFF
GO
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (1, 1)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (2, 1)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (3, 1)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (4, 1)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (5, 2)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (6, 2)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (7, 3)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (8, 3)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (9, 4)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (10, 4)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (11, 5)
INSERT [dbo].[ProductosProveedores] ([IdProducto], [IdProveedor]) VALUES (12, 5)
GO
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (1, 1, 32)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (1, 3, 50)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (2, 1, 141)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (2, 3, 75)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (3, 1, 82)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (4, 1, 107)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (5, 1, 4)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (5, 2, 51)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (6, 2, 34)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (7, 2, 70)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (7, 3, 200)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (8, 3, 57)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (9, 2, 90)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (9, 3, 176)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (10, 3, 100)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (11, 1, 240)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (12, 1, 300)
INSERT [dbo].[ProductosTienda] ([IdProducto], [IdTienda], [Cantidad]) VALUES (12, 2, 128)
GO
SET IDENTITY_INSERT [dbo].[Proveedores] ON 

INSERT [dbo].[Proveedores] ([IdProveedor], [NombreEmpresa], [Telefono], [Email], [NombreContacto], [Direccion]) VALUES (1, N'Frutas del Campo S.A.', N'911234567', N'info@frutasdelcampo.com', N'Juan Pérez', N'Calle Frutal 10, Madrid')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreEmpresa], [Telefono], [Email], [NombreContacto], [Direccion]) VALUES (2, N'Carnes Selectas S.L.', N'939876543', N'ventas@carnesselectas.es', N'María García', N'Avenida Carnívora 22, Barcelona')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreEmpresa], [Telefono], [Email], [NombreContacto], [Direccion]) VALUES (3, N'Lácteos La Vaca Feliz', N'961112233', N'pedidos@lavacafeliz.com', N'Pedro Sánchez', N'Carretera Láctea 5, Valencia')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreEmpresa], [Telefono], [Email], [NombreContacto], [Direccion]) VALUES (4, N'Panes Artesanos S.A.', N'987445566', N'contacto@panesartesanos.com', N'Laura Ruiz', N'Plaza Panadera 1, Sevilla')
INSERT [dbo].[Proveedores] ([IdProveedor], [NombreEmpresa], [Telefono], [Email], [NombreContacto], [Direccion]) VALUES (5, N'Bebidas Refrescantes S.L.', N'955667788', N'distribucion@bebidasrefrescantes.es', N'David López', N'Calle Sedienta 33, Málaga')
SET IDENTITY_INSERT [dbo].[Proveedores] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([IdRol], [Rol]) VALUES (1, N'Administrador')
INSERT [dbo].[Roles] ([IdRol], [Rol]) VALUES (2, N'Gerente')
INSERT [dbo].[Roles] ([IdRol], [Rol]) VALUES (3, N'Empleado')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Tiendas] ON 

INSERT [dbo].[Tiendas] ([IdTienda], [Nombre], [Direccion], [Telefono], [Email]) VALUES (1, N'Supermercado Madrid Centro', N'Calle Gran Vía 10', N'919998877', N'madrid@supermercado.com')
INSERT [dbo].[Tiendas] ([IdTienda], [Nombre], [Direccion], [Telefono], [Email]) VALUES (2, N'Supermercado Barcelona Norte', N'Avenida Diagonal 25', N'938887766', N'barcelona@supermercado.com')
INSERT [dbo].[Tiendas] ([IdTienda], [Nombre], [Direccion], [Telefono], [Email]) VALUES (3, N'Supermercado Valencia Sur', N'Calle Colón 50', N'967776655', N'valencia@supermercado.com')
SET IDENTITY_INSERT [dbo].[Tiendas] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([IdUsuario], [Nombre], [Password], [Email], [IdRol], [Imagen], [nombre_empresa]) VALUES (2, N'AdminSuper', N'contrasenaAdmin', N'admin@supermercado.com', 1, N'admin.jpg', N'Empresa Alimentacion')
INSERT [dbo].[Usuarios] ([IdUsuario], [Nombre], [Password], [Email], [IdRol], [Imagen], [nombre_empresa]) VALUES (3, N'gerente', N'12345', N'gerente1@supermercado.com', 2, N'perfil.jpg', N'Empresa Alimentacion')
INSERT [dbo].[Usuarios] ([IdUsuario], [Nombre], [Password], [Email], [IdRol], [Imagen], [nombre_empresa]) VALUES (4, N'EmpleadoTienda2', N'contrasenaEmpleado', N'empleado2@supermercado.com', 3, N'empleado.jpg', N'Empresa Alimentacion')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET IDENTITY_INSERT [dbo].[Ventas] ON 

INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (5, CAST(N'2023-10-27T00:00:00.000' AS DateTime), 1, 2, CAST(750.25 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (6, CAST(N'2023-10-28T00:00:00.000' AS DateTime), 2, 2, CAST(1200.90 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (7, CAST(N'2023-10-29T00:00:00.000' AS DateTime), 3, 2, CAST(300.50 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (8, CAST(N'2023-10-27T00:00:00.000' AS DateTime), 1, 3, CAST(750.25 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (9, CAST(N'2023-10-28T00:00:00.000' AS DateTime), 2, 3, CAST(1200.90 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (10, CAST(N'2023-10-29T00:00:00.000' AS DateTime), 3, 3, CAST(300.50 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (12, CAST(N'2025-03-02T19:57:00.000' AS DateTime), 2, 3, CAST(30.00 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (13, CAST(N'2025-03-05T17:54:00.000' AS DateTime), 1, 3, CAST(26.00 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (14, CAST(N'2025-03-05T20:09:00.000' AS DateTime), 1, 3, CAST(1.00 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (15, CAST(N'2025-03-08T12:41:00.000' AS DateTime), 1, 3, CAST(90.00 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (16, CAST(N'2025-03-08T13:27:00.000' AS DateTime), 1, 3, CAST(45.00 AS Decimal(10, 2)), 8)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (17, CAST(N'2025-03-08T13:29:00.000' AS DateTime), 1, 3, CAST(34.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (18, CAST(N'2025-03-08T13:33:00.000' AS DateTime), 1, 3, CAST(8.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (20, CAST(N'2025-03-09T10:33:00.000' AS DateTime), 1, 3, CAST(720.00 AS Decimal(10, 2)), 6)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (21, CAST(N'2025-03-09T10:40:00.000' AS DateTime), 2, 3, CAST(850.00 AS Decimal(10, 2)), 9)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (29, CAST(N'2025-03-11T21:04:00.000' AS DateTime), 2, 3, CAST(920.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (30, CAST(N'2025-03-11T21:09:00.000' AS DateTime), 2, 3, CAST(920.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (31, CAST(N'2025-03-11T21:17:00.000' AS DateTime), 2, 3, CAST(920.00 AS Decimal(10, 2)), 3)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (34, CAST(N'2025-03-11T21:45:00.000' AS DateTime), 2, 3, CAST(920.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (37, CAST(N'2025-03-12T17:41:00.000' AS DateTime), 1, 3, CAST(150.00 AS Decimal(10, 2)), 1)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (38, CAST(N'2025-03-12T17:42:00.000' AS DateTime), 2, 3, CAST(920.00 AS Decimal(10, 2)), 9)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (40, CAST(N'2025-01-20T00:00:00.000' AS DateTime), 1, 3, CAST(1000.50 AS Decimal(10, 2)), 5)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (41, CAST(N'2025-02-25T00:00:00.000' AS DateTime), 2, 4, CAST(1500.75 AS Decimal(10, 2)), 6)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (42, CAST(N'2025-03-15T00:00:00.000' AS DateTime), 3, 3, CAST(500.25 AS Decimal(10, 2)), 7)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (43, CAST(N'2025-04-10T00:00:00.000' AS DateTime), 1, 4, CAST(1800.00 AS Decimal(10, 2)), 8)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (44, CAST(N'2025-05-22T00:00:00.000' AS DateTime), 2, 3, CAST(2200.50 AS Decimal(10, 2)), 9)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (45, CAST(N'2025-06-28T00:00:00.000' AS DateTime), 3, 4, CAST(1200.75 AS Decimal(10, 2)), 10)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (46, CAST(N'2025-02-12T09:20:00.000' AS DateTime), 2, 3, CAST(6440.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (47, CAST(N'2025-02-13T09:36:00.000' AS DateTime), 2, 3, CAST(3500.00 AS Decimal(10, 2)), 6)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (48, CAST(N'2025-03-13T10:09:00.000' AS DateTime), 1, 3, CAST(450.00 AS Decimal(10, 2)), 2)
INSERT [dbo].[Ventas] ([IdVenta], [FechaVenta], [IdTienda], [IdUsuario], [ImporteTotal], [IdCliente]) VALUES (49, CAST(N'2025-03-13T10:10:00.000' AS DateTime), 2, 3, CAST(1840.00 AS Decimal(10, 2)), 9)
SET IDENTITY_INSERT [dbo].[Ventas] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Clientes__A9D105342302BECE]    Script Date: 13/03/2025 14:02:52 ******/
ALTER TABLE [dbo].[Clientes] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__A9D10534EA1EC672]    Script Date: 13/03/2025 14:02:52 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categorias]  WITH CHECK ADD FOREIGN KEY([IdCategoriaPadre])
REFERENCES [dbo].[Categorias] ([IdCategoria])
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD FOREIGN KEY([IdTienda])
REFERENCES [dbo].[Tiendas] ([IdTienda])
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Usuarios] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Compras_Usuarios]
GO
ALTER TABLE [dbo].[DetallesCompra]  WITH CHECK ADD FOREIGN KEY([IdCompra])
REFERENCES [dbo].[Compras] ([IdCompra])
GO
ALTER TABLE [dbo].[DetallesCompra]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[DetallesVenta]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[DetallesVenta]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[Ventas] ([IdVenta])
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[ManagersTiendas]  WITH CHECK ADD FOREIGN KEY([IdTienda])
REFERENCES [dbo].[Tiendas] ([IdTienda])
GO
ALTER TABLE [dbo].[ManagersTiendas]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[Categorias] ([IdCategoria])
GO
ALTER TABLE [dbo].[ProductosProveedores]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[ProductosProveedores]  WITH CHECK ADD FOREIGN KEY([IdProveedor])
REFERENCES [dbo].[Proveedores] ([IdProveedor])
GO
ALTER TABLE [dbo].[ProductosTienda]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Productos] ([IdProducto])
GO
ALTER TABLE [dbo].[ProductosTienda]  WITH CHECK ADD FOREIGN KEY([IdTienda])
REFERENCES [dbo].[Tiendas] ([IdTienda])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([IdRol])
REFERENCES [dbo].[Roles] ([IdRol])
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Clientes] ([IdCliente])
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD FOREIGN KEY([IdTienda])
REFERENCES [dbo].[Tiendas] ([IdTienda])
GO
ALTER TABLE [dbo].[Ventas]  WITH CHECK ADD FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuarios] ([IdUsuario])
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD CHECK  (([TipoMovimiento]='Salida' OR [TipoMovimiento]='Entrada'))
GO
/****** Object:  StoredProcedure [dbo].[IngresosMes]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IngresosMes]
    @mes INT,
    @año INT,
    @ingresos DECIMAL(18, 2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ventas DECIMAL(18, 2);
    DECLARE @compras DECIMAL(18, 2);

    -- Obtener ingresos por ventas
    SELECT @ventas = ISNULL(SUM(ImporteTotal), 0)
    FROM Ventas
    WHERE MONTH(FechaVenta) = @mes AND YEAR(FechaVenta) = @año;

    -- Obtener gastos por compras
    SELECT @compras = ISNULL(SUM(ImporteTotal), 0)
    FROM Compras
    WHERE MONTH(FechaCompra) = @mes AND YEAR(FechaCompra) = @año;

    -- Calcular ingresos netos
    SET @ingresos = @ventas - @compras;
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcesarCompra]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcesarCompra]
    @FechaCompra DATETIME,
    @IdProveedor INT,
    @IdTienda INT,
    @IdUsuario INT,
    @ImporteTotal DECIMAL(18, 2),
    @DetallesCompra XML
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar la compra
        INSERT INTO Compras (FechaCompra, IdProveedor, IdTienda, IdUsuario, ImporteTotal)
        VALUES (@FechaCompra, @IdProveedor, @IdTienda, @IdUsuario, @ImporteTotal);

        DECLARE @IdCompra INT = SCOPE_IDENTITY();

        -- 2. Insertar los detalles de compra
        INSERT INTO DetallesCompra (IdCompra, IdProducto, Cantidad, PrecioUnidad)
        SELECT @IdCompra,
               Detalles.value('(IdProducto)[1]', 'INT'),
               Detalles.value('(Cantidad)[1]', 'INT'),
               Detalles.value('(PrecioUnidad)[1]', 'DECIMAL(18, 2)')
        FROM @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 3. Actualizar el inventario (entrada en vez de salida)
        INSERT INTO Inventario (IdProducto, FechaMovimiento, TipoMovimiento, Cantidad, IdMovimiento)
        SELECT Detalles.value('(IdProducto)[1]', 'INT'),
               @FechaCompra,
               'Entrada',
               Detalles.value('(Cantidad)[1]', 'INT'),
               @IdCompra
        FROM @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 4. Actualizar el stock en ProductosTienda (incrementando en vez de decrementando)
        UPDATE ProductosTienda
        SET Cantidad = pt.Cantidad + Detalles.value('(Cantidad)[1]', 'INT')
        FROM ProductosTienda pt
        INNER JOIN @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles)
            ON pt.IdProducto = Detalles.value('(IdProducto)[1]', 'INT')
        WHERE pt.IdTienda = @IdTienda;

        -- 5. Manejar casos donde el producto no existe en la tienda todavía
        INSERT INTO ProductosTienda (IdProducto, IdTienda, Cantidad)
        SELECT 
            Detalles.value('(IdProducto)[1]', 'INT'),
            @IdTienda,
            Detalles.value('(Cantidad)[1]', 'INT')
        FROM @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles)
        WHERE NOT EXISTS (
            SELECT 1 FROM ProductosTienda 
            WHERE IdProducto = Detalles.value('(IdProducto)[1]', 'INT')
            AND IdTienda = @IdTienda
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Guardar información del error para diagnóstico
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcesarVenta]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcesarVenta]
    @FechaVenta DATETIME,
    @IdTienda INT,
    @IdUsuario INT,
    @ImporteTotal DECIMAL(18, 2), -- Asegúrate de que coincida con el tipo de datos en C#
    @IdCliente INT, -- Agregado el parámetro IdCliente
    @DetallesVenta XML
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar la venta
        INSERT INTO Ventas (FechaVenta, IdTienda, IdUsuario, ImporteTotal, IdCliente) -- Agregado IdCliente
        VALUES (@FechaVenta, @IdTienda, @IdUsuario, @ImporteTotal, @IdCliente); -- Agregado @IdCliente

        DECLARE @IdVenta INT = SCOPE_IDENTITY();

        -- 2. Insertar los detalles de venta
        INSERT INTO DetallesVenta (IdVenta, IdProducto, Cantidad, PrecioUnidad)
        SELECT @IdVenta,
               Detalles.value('(IdProducto)[1]', 'INT'),
               Detalles.value('(Cantidad)[1]', 'INT'),
               Detalles.value('(PrecioUnidad)[1]', 'DECIMAL(18, 2)') -- Asegúrate de que coincida con el tipo de datos en C#
        FROM @DetallesVenta.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 3. Actualizar el inventario
        -- Insertamos desde el XML recibido
        INSERT INTO Inventario (IdProducto, FechaMovimiento, TipoMovimiento, Cantidad, IdMovimiento)
        SELECT Detalles.value('(IdProducto)[1]', 'INT'),
               @FechaVenta,
               'Salida',
               Detalles.value('(Cantidad)[1]', 'INT'),
               @IdVenta
        FROM @DetallesVenta.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 4. Actualizar el stock en ProductosTienda
        UPDATE ProductosTienda
        SET Cantidad = pt.Cantidad - Detalles.value('(Cantidad)[1]', 'INT')
        FROM ProductosTienda pt
        INNER JOIN @DetallesVenta.nodes('/Detalles/Detalle') AS Detalles(Detalles)
            ON pt.IdProducto = Detalles.value('(IdProducto)[1]', 'INT')
        WHERE pt.IdTienda = @IdTienda;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW; -- Re-lanza la excepción para que se maneje en el código C#
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcesarVentaStock]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ProcesarVentaStock]
    @FechaVenta DATETIME,
    @IdTienda INT,
    @IdUsuario INT,
    @ImporteTotal DECIMAL(18, 2),
    @IdCliente INT,
    @DetallesVenta XML
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar la venta
        INSERT INTO Ventas (FechaVenta, IdTienda, IdUsuario, ImporteTotal, IdCliente)
        VALUES (@FechaVenta, @IdTienda, @IdUsuario, @ImporteTotal, @IdCliente);

        DECLARE @IdVenta INT = SCOPE_IDENTITY();

        -- 2. Insertar los detalles de venta
        INSERT INTO DetallesVenta (IdVenta, IdProducto, Cantidad, PrecioUnidad)
        SELECT @IdVenta,
               Detalles.value('(IdProducto)[1]', 'INT'),
               Detalles.value('(Cantidad)[1]', 'INT'),
               Detalles.value('(PrecioUnidad)[1]', 'DECIMAL(18, 2)')
        FROM @DetallesVenta.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 3. Actualizar el inventario
        INSERT INTO Inventario (IdProducto, FechaMovimiento, TipoMovimiento, Cantidad, IdMovimiento)
        SELECT Detalles.value('(IdProducto)[1]', 'INT'),
               @FechaVenta,
               'Salida',
               Detalles.value('(Cantidad)[1]', 'INT'),
               @IdVenta
        FROM @DetallesVenta.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 4. Actualizar el stock en ProductosTienda
        UPDATE ProductosTienda
        SET Cantidad = pt.Cantidad - Detalles.value('(Cantidad)[1]', 'INT')
        FROM ProductosTienda pt
        INNER JOIN @DetallesVenta.nodes('/Detalles/Detalle') AS Detalles(Detalles)
            ON pt.IdProducto = Detalles.value('(IdProducto)[1]', 'INT')
        WHERE pt.IdTienda = @IdTienda;

        -- 5. Verificar stock bajo y crear notificaciones
        DECLARE @IdProducto INT, @Cantidad INT, @NombreProducto VARCHAR(255), @NombreTienda VARCHAR(255);
        DECLARE DetallesCursor CURSOR FOR
            SELECT Detalles.value('(IdProducto)[1]', 'INT'), Detalles.value('(Cantidad)[1]', 'INT')
            FROM @DetallesVenta.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        OPEN DetallesCursor;
        FETCH NEXT FROM DetallesCursor INTO @IdProducto, @Cantidad;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener el nombre del producto
            SELECT @NombreProducto = Nombre FROM Productos WHERE IdProducto = @IdProducto;

            -- Obtener el nombre de la tienda
            SELECT @NombreTienda = Nombre FROM Tiendas WHERE IdTienda = @IdTienda;

            IF EXISTS (SELECT 1 FROM ProductosTienda WHERE IdProducto = @IdProducto AND IdTienda = @IdTienda AND Cantidad < 10) -- Umbral de stock bajo
            BEGIN
                IF NOT EXISTS (SELECT 1 FROM Notificaciones WHERE IdProducto = @IdProducto AND IdTienda = @IdTienda)
                BEGIN
                    INSERT INTO Notificaciones (Mensaje, Fecha, IdProducto, IdTienda)
                    VALUES ('Stock bajo para el producto ' + @NombreProducto + ' en la tienda ' + @NombreTienda, GETDATE(), @IdProducto, @IdTienda);
                END
            END
            FETCH NEXT FROM DetallesCursor INTO @IdProducto, @Cantidad;
        END

        CLOSE DetallesCursor;
        DEALLOCATE DetallesCursor;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[ProcesoCompraNotificaciones]    Script Date: 13/03/2025 14:02:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcesoCompraNotificaciones]
    @FechaCompra DATETIME,
    @IdProveedor INT,
    @IdTienda INT,
    @IdUsuario INT,
    @ImporteTotal DECIMAL(18, 2),
    @DetallesCompra XML
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Insertar la compra
        INSERT INTO Compras (FechaCompra, IdProveedor, IdTienda, IdUsuario, ImporteTotal)
        VALUES (@FechaCompra, @IdProveedor, @IdTienda, @IdUsuario, @ImporteTotal);

        DECLARE @IdCompra INT = SCOPE_IDENTITY();

        -- 2. Insertar los detalles de compra
        INSERT INTO DetallesCompra (IdCompra, IdProducto, Cantidad, PrecioUnidad)
        SELECT @IdCompra,
               Detalles.value('(IdProducto)[1]', 'INT'),
               Detalles.value('(Cantidad)[1]', 'INT'),
               Detalles.value('(PrecioUnidad)[1]', 'DECIMAL(18, 2)')
        FROM @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 3. Actualizar el inventario (entrada en vez de salida)
        INSERT INTO Inventario (IdProducto, FechaMovimiento, TipoMovimiento, Cantidad, IdMovimiento)
        SELECT Detalles.value('(IdProducto)[1]', 'INT'),
               @FechaCompra,
               'Entrada',
               Detalles.value('(Cantidad)[1]', 'INT'),
               @IdCompra
        FROM @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        -- 4. Actualizar el stock en ProductosTienda (incrementando en vez de decrementando)
        UPDATE ProductosTienda
        SET Cantidad = pt.Cantidad + Detalles.value('(Cantidad)[1]', 'INT')
        FROM ProductosTienda pt
        INNER JOIN @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles)
            ON pt.IdProducto = Detalles.value('(IdProducto)[1]', 'INT')
        WHERE pt.IdTienda = @IdTienda;

        -- 5. Manejar casos donde el producto no existe en la tienda todavía
        INSERT INTO ProductosTienda (IdProducto, IdTienda, Cantidad)
        SELECT 
            Detalles.value('(IdProducto)[1]', 'INT'),
            @IdTienda,
            Detalles.value('(Cantidad)[1]', 'INT')
        FROM @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles)
        WHERE NOT EXISTS (
            SELECT 1 FROM ProductosTienda 
            WHERE IdProducto = Detalles.value('(IdProducto)[1]', 'INT')
            AND IdTienda = @IdTienda
        );

        -- 6. Verificar stock bajo y crear notificaciones
        DECLARE @IdProducto INT, @CantidadActual INT, @NombreProducto VARCHAR(255), @NombreTienda VARCHAR(255);
        DECLARE DetallesCursor CURSOR FOR 
        SELECT Detalles.value('(IdProducto)[1]', 'INT')
        FROM @DetallesCompra.nodes('/Detalles/Detalle') AS Detalles(Detalles);

        OPEN DetallesCursor;
        FETCH NEXT FROM DetallesCursor INTO @IdProducto;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Obtener la cantidad actual en ProductosTienda
            SELECT @CantidadActual = Cantidad
            FROM ProductosTienda
            WHERE IdProducto = @IdProducto AND IdTienda = @IdTienda;

            -- Obtener el nombre del producto
            SELECT @NombreProducto = Nombre FROM Productos WHERE IdProducto = @IdProducto;

            -- Obtener el nombre de la tienda
            SELECT @NombreTienda = Nombre FROM Tiendas WHERE IdTienda = @IdTienda;

            -- Verificar si el stock es bajo
            IF @CantidadActual < 10
            BEGIN
                -- Crear notificación si no existe
                IF NOT EXISTS (SELECT 1 FROM Notificaciones WHERE IdProducto = @IdProducto AND IdTienda = @IdTienda)
                BEGIN
                    INSERT INTO Notificaciones (Mensaje, Fecha, IdProducto, IdTienda)
                    VALUES ('Stock bajo para el producto ' + @NombreProducto + ' en la tienda ' + @NombreTienda, GETDATE(), @IdProducto, @IdTienda);
                END
            END
            ELSE
            BEGIN
                -- Eliminar notificación si existe
                DELETE FROM Notificaciones WHERE IdProducto = @IdProducto AND IdTienda = @IdTienda;
            END

            FETCH NEXT FROM DetallesCursor INTO @IdProducto;
        END

        CLOSE DetallesCursor;
        DEALLOCATE DetallesCursor;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
USE [master]
GO
ALTER DATABASE [Almacenes] SET  READ_WRITE 
GO
