using AppGestionStock.Data;
using AppGestionStock.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.Blazor;

namespace AppGestionStock.Repositories
{
    public class RepositoyProductos
    {
        private AlmacenesContext context;
        public RepositoyProductos(AlmacenesContext context)
        {
            this.context = context;
        }

        public List<Producto> GetProductos()
        {
            var consulta = from datos in this.context.Productos select datos;
            return consulta.ToList();
        }
        
        public List<VistaProductoTienda> GetProductosTienda(int idTienda)
        {
            var consulta = from datos in this.context.VistaProductosTienda
                           where datos.IdTienda == idTienda
                           select datos;
            return consulta.ToList();
        }

        public List<VistaProductosGerente> GetProductosGerente(int idUsuarioGerente)
        {
            var consulta = from datos in this.context.VistaProductosGerente
                           join managers in this.context.ManagerTiendas
                           on datos.IdTienda equals managers.IdTienda
                           where managers.IdUsuario == idUsuarioGerente
                           select datos;
            return consulta.ToList();
        }

        public VistaProductoTienda FindProducto(int idProducto, int idTienda)
        {
            var consulta = (from datos in this.context.VistaProductosTienda
                            where datos.IdProducto == idProducto && datos.IdTienda == idTienda
                            select datos).FirstOrDefault();
            return consulta;
        }

        public List<VistaProductosGerente> FindProductoManager(int idProducto, int idUsuarioGerente)
        {
            var consulta = from datos in this.context.VistaProductosGerente
                           join managers in this.context.ManagerTiendas
                           on datos.IdTienda equals managers.IdTienda
                           where managers.IdUsuario == idUsuarioGerente && datos.IdProducto == idProducto
                           select datos;
            return consulta.ToList();
        }

        public List<Producto> findProductosCategoria(int idCategoria)
        {
            var consulta = from productos in this.context.Productos
                           where productos.IdCategoria == idCategoria
                           select productos;
            return consulta.ToList();
        }

        public void CrearProducto(string nombreProducto, decimal precio, decimal coste, string nombreCategoria, int? idCategoriaPadre, string imagen)
        {
            // 1. Crear o encontrar la categoría
            Categoria categoria = this.context.Categorias.FirstOrDefault(c => c.Nombre == nombreCategoria);

            if (categoria == null)
            {
                categoria = new Categoria
                {
                    Nombre = nombreCategoria,
                    IdCategoriaPadre = idCategoriaPadre
                };

                this.context.Categorias.Add(categoria);
                this.context.SaveChanges();
            }

            // 2. Crear el producto
            Producto nuevoProducto = new Producto
            {
                Nombre = nombreProducto,
                Precio = precio,
                Coste = coste,
                IdCategoria = categoria.IdCategoria,
                Imagen = imagen
            };

            this.context.Productos.Add(nuevoProducto);
            this.context.SaveChanges();
        }

        public void EliminarProducto(int idProducto)
        {
            Producto productoAEliminar = this.context.Productos.Find(idProducto);
            if (productoAEliminar != null)
            {
                this.context.Productos.Remove(productoAEliminar);
                this.context.SaveChanges();
            }
        }

        public async Task<List<Categoria>> GetCategoriasAsync()
        {
            var consulta = from datos in this.context.Categorias select datos;
            return await consulta.ToListAsync();
        } 
    }
}
