using AppGestionStock.Data;
using AppGestionStock.Models;

namespace AppGestionStock.Repositories
{
    public class RepositoryClientes
    {
        private AlmacenesContext context;
        public RepositoryClientes(AlmacenesContext context)
        {
            this.context = context;
        }

        public List<Cliente> GetClientes()
        {
            var consulta = from datos in this.context.Clientes select datos;
            return consulta.ToList();
        }

        public List<Proveedor> GetProveedores()
        {
            var consulta = from datos in this.context.Proveedores select datos;
            return consulta.ToList();
        }
    }
}
