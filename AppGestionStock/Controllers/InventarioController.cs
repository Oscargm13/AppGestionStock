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
        public async Task<IActionResult> Inventario()
        {
            List<Inventario> inventario = await this.repo.GetMovimientos();
            return View();
        }
    }
}
