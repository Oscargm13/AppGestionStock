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

            List<Venta> ventas = await this.repoInventario.GetVentas();

            // Agrupar ventas por mes y calcular el total de montos
            var ventasMensuales = ventas
        .GroupBy(v => v.FechaVenta.Month)
        .Select(g => new { Mes = g.Key, Total = g.Sum(v => v.ImporteTotal) })
        .OrderBy(g => g.Mes)
        .ToList();

            // Imprimir ventasMensuales
            Console.WriteLine("ventasMensuales:");
            foreach (var venta in ventasMensuales)
            {
                Console.WriteLine($"Mes: {venta.Mes}, Total: {venta.Total}");
            }

            List<int> meses = ventasMensuales.Select(v => v.Mes).ToList();
            List<decimal> montos = ventasMensuales.Select(v => v.Total).ToList();

            // Imprimir meses
            Console.WriteLine("\nMeses:");
            foreach (var mes in meses)
            {
                Console.WriteLine(mes);
            }

            // Imprimir montos
            Console.WriteLine("\nMontos:");
            foreach (var monto in montos)
            {
                Console.WriteLine(monto);
            }

            ViewData["MESES"] = meses;
            ViewData["MONTOS"] = montos;

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
