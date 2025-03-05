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
            int stockTotalGerente = this.repoProductos.GetTotalStockGerente(HttpContext.Session.GetObject<Usuario>("USUARIO").IdUsuario);
            ViewData["STOCKTOTAL"] = stockTotalGerente;

            List<VistaInventarioDetalladoVenta> inventario = await this.repoInventario.GetMovimientos();
            //TempData["INVENTARIO"] = inventario;
            HttpContext.Session.SetObject("INVENTARIO", inventario);

            //DetallesVenta detallesVenta = await this.repoInventario.GetDetallesVenta(idventa){

            //}

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
