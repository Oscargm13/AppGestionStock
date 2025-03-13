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
        //CLIENTES

        public async Task<IActionResult> Clientes()
        {
            List<Cliente> clientes = await this.repo.GetClientes();
            return View(clientes);
        }

        // CREATE
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create(Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                await this.repo.CreateCliente(cliente);
                return RedirectToAction("Clientes");
            }
            return View(cliente);
        }

        // EDIT
        public async Task<IActionResult> Edit(int id)
        {
            Cliente cliente = await this.repo.FindCliente(id);
            if (cliente == null)
            {
                return NotFound();
            }
            return View(cliente);
        }

        [HttpPost]
        public async Task<IActionResult> Edit(Cliente cliente)
        {
            if (ModelState.IsValid)
            {
                await this.repo.UpdateCliente(cliente);
                return RedirectToAction("Clientes");
            }
            return View(cliente);
        }

        public async Task<IActionResult> Delete(int id)
        {
            await this.repo.DeleteCliente(id);
            return RedirectToAction("Clientes");
        }

        //PROVEEDORES

        public async Task<IActionResult> Proveedores()
        {
            List<Proveedor> proveedores = await this.repo.GetProveedores();
            return View("Index", proveedores); // Asegúrate de que la vista se llama "Index"
        }

        // CREATE
        public IActionResult ProveedorCreate()
        {
            return View(); // Crear una vista Create.cshtml
        }

        [HttpPost]
        public async Task<IActionResult> ProveedorCreate(Proveedor proveedor)
        {
            if (ModelState.IsValid)
            {
                await this.repo.CreateProveedor(proveedor);
                return RedirectToAction("Proveedores");
            }
            return View(proveedor);
        }

        // EDIT
        public async Task<IActionResult> ProveedorEdit(int id)
        {
            Proveedor proveedor = await this.repo.FindProveedor(id);
            if (proveedor == null)
            {
                return NotFound();
            }
            return View(proveedor); // Crear una vista Edit.cshtml
        }

        [HttpPost]
        public async Task<IActionResult> ProveedorEdit(Proveedor proveedor)
        {
            if (ModelState.IsValid)
            {
                await this.repo.UpdateProveedor(proveedor);
                return RedirectToAction("Proveedores");
            }
            return View(proveedor);
        }

        // DELETE
        public async Task<IActionResult> ProveedorDelete(int id)
        {
            Proveedor proveedor = await this.repo.FindProveedor(id);
            if (proveedor == null)
            {
                return NotFound();
            }
            return View(proveedor); // Crear una vista Delete.cshtml
        }

        [HttpPost, ActionName("ProveedorDelete")]
        public async Task<IActionResult> ProveedorDeleteConfirmed(int id)
        {
            await this.repo.DeleteProveedor(id);
            return RedirectToAction("Proveedores");
        }
    }
}
