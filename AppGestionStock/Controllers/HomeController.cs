using System.Diagnostics;
using AppGestionStock.Models;
using AppGestionStock.Repositories;
using AppGestionStock.Filters;
using Microsoft.AspNetCore.Mvc;

namespace AppGestionStock.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private RepositoyProductos repoProductos;

        public HomeController(ILogger<HomeController> logger, RepositoyProductos repoProductos)
        {
            _logger = logger;
            this.repoProductos = repoProductos;
        }

        public IActionResult Index()
        {
            //List<ProductosTienda> productosTienda = repoProductos.GetProductosTienda();
            //ViewData["STOCKTOTAL"] = 
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
