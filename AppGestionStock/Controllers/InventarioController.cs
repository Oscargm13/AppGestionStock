using AppGestionStock.Models;
using AppGestionStock.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace AppGestionStock.Controllers
{
    public class InventarioController : Controller
    {
        private RepositoryInventario repo;
        public InventarioController(RepositoryInventario repo)
        {
            this.repo = repo;
        }
        public async Task<IActionResult> Index()
        {
            //List<Inventario> inventario = await this.repo.GetMovimientos();
            return View();
        }

        public async Task<IActionResult> Venta()
        {
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Venta(DateTime fechaVenta, int idTienda, int idUsuario, decimal importeTotal, int idCliente,
            List<int> idProducto, List<int> cantidad, List<decimal> precioUnidad)
        {
            try
            {
                // 1. Crear el objeto Venta
                var venta = new Venta
                {
                    FechaVenta = fechaVenta,
                    IdTienda = idTienda,
                    IdUsuario = idUsuario,
                    ImporteTotal = importeTotal,
                    IdCliente = idCliente
                };

                // 2. Crear la lista de DetallesVenta
                var detallesVenta = new List<DetallesVenta>();
                for (int i = 0; i < idProducto.Count; i++)
                {
                    detallesVenta.Add(new DetallesVenta
                    {
                        IdProducto = idProducto[i],
                        Cantidad = cantidad[i],
                        PrecioUnidad = precioUnidad[i]
                    });
                }

                // 3. Llamar al repositorio para procesar la venta
                await repo.ProcesarVenta(venta, detallesVenta);
                ViewData["MensajeExito"] = "Venta registrada con exito";

                // 4. Retornar una respuesta exitosa
                return View("Index", "Home");
            }
            catch (Exception ex)
            {
                // 5. Manejar errores
                return BadRequest($"Error al procesar la venta: {ex.Message}");
            }
        }

    }
}
