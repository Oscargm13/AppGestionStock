using AppGestionStock.Extensions;
using AppGestionStock.Models;
using AppGestionStock.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace AppGestionStock.Controllers
{
    public class InventarioController : Controller
    {
        private RepositoryInventario repo;
        private RepositryTiendas repoTiendas;
        public InventarioController(RepositoryInventario repo, RepositryTiendas repoTiendas)
        {
            this.repo = repo;
            this.repoTiendas = repoTiendas;
        }
        public async Task<IActionResult> Index()
        {
            //List<Inventario> inventario = await this.repo.GetMovimientos();
            return View();
        }

        public async Task<IActionResult> Venta()
        {
            List<Tienda> tiendas = this.repoTiendas.GetTiendas();
            ViewData["TIENDAS"] = tiendas;
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Venta(DateTime fechaVenta, int idTienda, int IdCliente,
            List<int> idProducto, List<int> cantidad, List<decimal> precioUnidad)
        {
            try
            {
                decimal importe = 0;
                if (cantidad != null && precioUnidad != null && idProducto != null && 
                    cantidad.Count == precioUnidad.Count && cantidad.Count == idProducto.Count &&
                    cantidad.Count > 0)
                {
                    for (int i = 0; i < cantidad.Count; i++)
                    {
                        importe += precioUnidad[i] * cantidad[i];
                    }
                }
                else
                {
                    return BadRequest("Las listas de cantidad, precioUnidad o idProducto son inválidas.");
                }
                // 1. Crear el objeto Venta
                var venta = new Venta
                {
                    FechaVenta = fechaVenta,
                    IdTienda = idTienda,
                    IdUsuario = HttpContext.Session.GetObject<Usuario>("USUARIO").IdUsuario,
                    ImporteTotal = importe,
                    IdCliente = IdCliente
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
                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                // 5. Manejar errores
                return BadRequest($"Error al procesar la venta: {ex.Message}");
            }
        }

    }
}
