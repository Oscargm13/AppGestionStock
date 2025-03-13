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
        private RepositoryClientes repoClientes;

        public HomeController(ILogger<HomeController> logger, RepositoyProductos repoProductos,
            RepositoryInventario repoInventario, RepositoryClientes repoClientes)
        {
            _logger = logger;
            this.repoProductos = repoProductos;
            this.repoInventario = repoInventario;
            this.repoClientes = repoClientes;
        }

        public async Task<IActionResult> Index()
        {
            //Calculo de clientes
            List<Cliente> clientes = await this.repoClientes.GetClientes();
            int numeroClientes = clientes.Count();
            ViewData["NUMEROCLIENTES"] = numeroClientes;

            // C�lculo del stock total
            var usuario = HttpContext.Session.GetObject<Usuario>("USUARIO");
            int stockTotalGerente = this.repoProductos.GetTotalStockGerente(usuario.IdUsuario);
            ViewData["STOCKTOTAL"] = stockTotalGerente;

            // C�lculo de los ingresos mensuales
            int mesActual = DateTime.Now.Month;
            int a�oActual = DateTime.Now.Year;
            decimal ingresosMensuales = await repoInventario.GetIngresosMes(mesActual, a�oActual);
            ViewData["INGRESOSMENSUALES"] = ingresosMensuales;
            ViewData["MESACTUAL"] = mesActual;
            ViewData["A�OACTUAL"] = a�oActual;

            // Obtener la lista de movimientos de inventario y almacenarlos en la sesi�n
            List<VistaInventarioDetalladoVenta> inventario = await this.repoInventario.GetMovimientos();
            HttpContext.Session.SetObject("INVENTARIO", inventario);

            // Obtener notificaciones en caso de haberlas
            List<Notificacion> notificaciones = await repoInventario.GetNotificaciones();
            ViewData["NOTIFICACIONES"] = notificaciones;

            // Obtener ventas y compras
            List<Venta> ventas = await this.repoInventario.GetVentas();
            List<Compra> compras = await this.repoInventario.GetCompras();

            // Agrupar ventas por mes
            var ventasMensuales = ventas
                .GroupBy(v => v.FechaVenta.Month)
                .Select(g => new { Mes = g.Key, Total = g.Sum(v => v.ImporteTotal) })
                .OrderBy(g => g.Mes)
                .ToList();

            // Agrupar compras por mes
            var comprasMensuales = compras
                .GroupBy(c => c.FechaCompra.Month)
                .Select(g => new { Mes = g.Key, Total = g.Sum(c => c.ImporteTotal) })
                .OrderBy(g => g.Mes)
                .ToList();

            // Obtener listas de meses, montos de ventas y compras
            List<int> meses = ventasMensuales.Select(v => v.Mes).ToList();
            List<decimal> montosVentas = ventasMensuales.Select(v => v.Total).ToList();
            List<decimal> montosCompras = comprasMensuales.Select(c => c.Total).ToList();

            ViewData["MESES"] = meses;
            ViewData["MONTOS_VENTAS"] = montosVentas;
            ViewData["MONTOS_COMPRAS"] = montosCompras;

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
