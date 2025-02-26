﻿using AppGestionStock.Models;
using Microsoft.EntityFrameworkCore;

namespace AppGestionStock.Data
{
    public class AlmacenesContext: DbContext
    {
        public AlmacenesContext(DbContextOptions<AlmacenesContext> options): base(options) { }
        //MODELS PRODUCTOS
        public DbSet<Producto> Productos { get; set; }
        public DbSet<ProductosTienda> ProductosTienda { get; set; }
        public DbSet<VistaProductoTienda> VistaProductosTienda { get; set; }
        public DbSet<VistaProductosGerente> VistaProductosGerente { get; set; }
        public DbSet<ManagerTienda> ManagerTiendas { get; set; }

        //MODELS CLIENTES
        public DbSet<Cliente> Clientes { get; set; }

        //MODELS TIENDA
        public DbSet<Tienda> Tiendas { get; set; }

        //MODELS CATEGORIAS
        public DbSet<Categoria> Categorias { get; set; }
    }
}
