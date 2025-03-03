using AppGestionStock.Data;
using AppGestionStock.Models;
using Microsoft.EntityFrameworkCore;

namespace AppGestionStock.Repositories
{
    public class RepositoryInventario
    {
        private AlmacenesContext context;

        public RepositoryInventario(AlmacenesContext context)
        {
            this.context = context;
        }

        public async Task<List<Inventario>> GetMovimientos()
        {
            return await this.context.Inventario.Include(i => i.Producto).ToListAsync();
        }
    }
}
