using System.Data;
using System.Xml.Linq;
using AppGestionStock.Data;
using AppGestionStock.Models;
using Microsoft.Data.SqlClient;
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

        public async Task<List<VistaInventarioDetalladoVenta>> GetMovimientos()
        {
            return await this.context.vistaInventarioDetalladoVenta.Include(i => i.Producto).ToListAsync();
        }

        public async Task ProcesarVenta(Venta venta, List<DetallesVenta> detalles)
        {
            using (var connection = context.Database.GetDbConnection())
            {
                await connection.OpenAsync();

                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "ProcesarVenta";
                    command.CommandType = CommandType.StoredProcedure;

                    // Parámetros de la venta
                    command.Parameters.Add(new SqlParameter("@FechaVenta", venta.FechaVenta));
                    command.Parameters.Add(new SqlParameter("@IdTienda", venta.IdTienda));
                    command.Parameters.Add(new SqlParameter("@IdUsuario", venta.IdUsuario));
                    command.Parameters.Add(new SqlParameter("@ImporteTotal", venta.ImporteTotal));

                    // Crear XML para los detalles de venta
                    var detallesXml = new XElement("Detalles",
                        detalles.Select(d => new XElement("Detalle",
                            new XElement("IdProducto", d.IdProducto),
                            new XElement("Cantidad", d.Cantidad),
                            new XElement("PrecioUnidad", d.PrecioUnidad)
                        ))
                    );

                    // Parámetro XML para los detalles de venta
                    command.Parameters.Add(new SqlParameter("@DetallesVenta", detallesXml.ToString()));

                    // Ejecutar el comando
                    await command.ExecuteNonQueryAsync();
                }
            }
        }

        public async Task<DetallesVenta> GetDetallesVenta(int idDetallesVenta)
        {
            var consulta = (from datos in this.context.DetallesVenta
                            where datos.IdProducto == idDetallesVenta
                            select datos).FirstOrDefault();
            return consulta;
        }
    }
}
