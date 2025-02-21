using AppGestionStock.Data;
using AppGestionStock.Models;
using Microsoft.EntityFrameworkCore;

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
    }
}
