using AppGestionStock.Data;
using AppGestionStock.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.Web.CodeGenerators.Mvc.Templates.Blazor;

namespace AppGestionStock.Repositories
{
    public class RepositoyProductos
    {
        SqlConnection cn;
        SqlCommand com;
        SqlDataReader reader;

        private AlmacenesContext context;
        public RepositoyProductos(AlmacenesContext context)
        {
            this.context = context;
            this.cn = new SqlConnection();
            this.com = new SqlCommand();
            this.com.Connection = this.cn;
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

        public void CrearProducto(string nombre, decimal precio, decimal coste, int idCategoria, string imagen)
        {
            Producto nuevoProducto = new Producto
            {
                Nombre = nombre,
                Precio = precio,
                Coste = coste,
                IdCategoria = idCategoria,
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
    }
}
