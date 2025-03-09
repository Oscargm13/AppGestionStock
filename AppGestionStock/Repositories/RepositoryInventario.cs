using System.Data;
using System.Xml.Linq;
using AppGestionStock.Data;
using AppGestionStock.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

#region
/*
 CREATE PROCEDURE ProcesarCompra
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
 */
#endregion

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
                    command.Parameters.Add(new SqlParameter("@IdCliente", venta.IdCliente));

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
                    command.Parameters.Clear();
                }
                await connection.CloseAsync();
            }
        }

        public async Task ProcesarCompra(Compra compra, List<DetallesCompra> detalles)
        {
            using (var connection = context.Database.GetDbConnection())
            {
                await connection.OpenAsync();
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "ProcesarCompra";
                    command.CommandType = CommandType.StoredProcedure;

                    // Parámetros de la compra
                    command.Parameters.Add(new SqlParameter("@FechaCompra", compra.FechaCompra));
                    command.Parameters.Add(new SqlParameter("@IdProveedor", compra.IdProveedor));
                    command.Parameters.Add(new SqlParameter("@IdTienda", compra.IdTienda));
                    command.Parameters.Add(new SqlParameter("@ImporteTotal", compra.ImporteTotal));
                    command.Parameters.Add(new SqlParameter("@IdUsuario", compra.IdUsuario));

                    // Crear XML para los detalles de compra
                    var detallesXml = new XElement("Detalles",
                        detalles.Select(d => new XElement("Detalle",
                            new XElement("IdProducto", d.IdProducto),
                            new XElement("Cantidad", d.Cantidad),
                            new XElement("PrecioUnidad", d.PrecioUnidad)
                        ))
                    );

                    // Parámetro XML para los detalles de compra
                    command.Parameters.Add(new SqlParameter("@DetallesCompra", detallesXml.ToString()));

                    // Ejecutar el comando
                    await command.ExecuteNonQueryAsync();
                    command.Parameters.Clear();
                }
                await connection.CloseAsync();
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
