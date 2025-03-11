using System.Diagnostics;
using AppGestionStock.Extensions;
using AppGestionStock.Models;
using AppGestionStock.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace AppGestionStock.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private RepositoyProductos repoProductos;
        private RepositoryInventario repoInventario;

        public HomeController(ILogger<HomeController> logger, RepositoyProductos repoProductos, RepositoryInventario repoInventario)
        {
            _logger = logger;
            this.repoProductos = repoProductos;
            this.repoInventario = repoInventario;
        }

        public async Task<IActionResult> Index()
        {
            // C�lculo del stock total
            int stockTotalGerente = this.repoProductos.GetTotalStockGerente(HttpContext.Session.GetObject<Usuario>("USUARIO").IdUsuario);
            ViewData["STOCKTOTAL"] = stockTotalGerente;

            // C�lculo de los ingresos mensuales
            int mesActual = DateTime.Now.Month;
            int a�oActual = DateTime.Now.Year;
            decimal ingresosMensuales = await repoInventario.GetIngresosMes(mesActual, a�oActual);
            ViewData["INGRESOSMENSUALES"] = ingresosMensuales;
            ViewData["MESACTUAL"] = mesActual;
            ViewData["A�OACTUAL"] = a�oActual;

            // Obtener la lista de inventario
            List<VistaInventarioDetalladoVenta> inventario = await this.repoInventario.GetMovimientos();
            HttpContext.Session.SetObject("INVENTARIO", inventario);

            //OBTENER NOTIFICACIONES EN CASO DE HABERLAS
            List<Notificacion> notificaciones = await repoInventario.GetNotificaciones();
            ViewData["NOTIFICACIONES"] = notificaciones;
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
