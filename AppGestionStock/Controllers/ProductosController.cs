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
        [HttpPost]
        public IActionResult Index(int idTienda)
        {
            List<VistaProductoTienda> productos = this.repo.GetVistaProductosTienda(idTienda);
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
            List<VistaProductoTienda> productos = this.repo.GetVistaProductosTienda(idTienda);
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

        public async Task<IActionResult> CrearProducto()
        {
            List<Categoria> categorias = await this.repo.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> CrearProducto(string nombre, decimal precio, decimal coste, string nombreCategoria, int? idCategoriaPadre, string imagen)
        {
            List<Categoria> categorias = await this.repo.GetCategoriasAsync();
            ViewData["CATEGORIAS"] = categorias;
            
            this.repo.CrearProducto(nombre, precio, coste, nombreCategoria, idCategoriaPadre, imagen);
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> UpdateProducto(int idProducto)
        {
            Producto producto = await this.repo.FindProductoAsync(idProducto);
            return View(producto);
        }
        [HttpPost]
        public async Task<IActionResult> UpdateProducto(int idProducto, string nombre, decimal precio, decimal coste, int idCategoria, string imagen)
        {
            await this.repo.UpdateProductoAsync(idProducto, nombre, precio, coste, idCategoria, imagen);
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> EliminarProducto(int idProducto)
        {
            await this.repo.EliminarProducto(idProducto);
            return RedirectToAction("Index");
        }
    }
}
