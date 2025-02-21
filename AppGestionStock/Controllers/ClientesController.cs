using AppGestionStock.Models;
using AppGestionStock.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace AppGestionStock.Controllers
{
    public class ClientesController : Controller
    {
        private RepositoryClientes repo;
        public ClientesController(RepositoryClientes repo)
        {
            this.repo = repo;
        }
        public IActionResult Index()
        {
            List<Cliente> clientes = this.repo.GetClientes();
            return View(clientes);
        }
    }
}
