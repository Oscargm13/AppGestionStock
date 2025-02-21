using AppGestionStock.Models;
using AppGestionStock.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace AppGestionStock.Controllers
{
    public class ProductosController : Controller
    {
        private RepositoyProductos repo;
        public ProductosController(RepositoyProductos repo)
        {
            this.repo = repo;
        }

        public IActionResult Index()
        {
            List<Producto> productos = this.repo.GetProductos();
            return View(productos);
        }

        public IActionResult ProductosTienda()
        {
            List<VistaProductoTienda> productos = new List<VistaProductoTienda>();
            return View(productos);
        }

        [HttpPost]
        public IActionResult ProductosTienda(int idTienda)
        {
            List<VistaProductoTienda> productos = this.repo.GetProductosTienda(idTienda);
            return View(productos);
        }

        public IActionResult ProductosManager()
        {
            List<VistaProductosGerente> productos = new List<VistaProductosGerente>();
            return View(productos);
        }

        [HttpPost]
        public IActionResult ProductosManager(int idUsuario)
        {
            List<VistaProductosGerente> productos = this.repo.GetProductosGerente(idUsuario);
            return View(productos);
        }
    }
}
