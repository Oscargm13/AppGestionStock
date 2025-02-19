namespace AppGestionStock.Models
{
    public class Proveedor
    {
        public int IdProveedor { get; set; }
        public string NombreEmpresa { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string NombreContacto { get; set; }
        public string Direccion { get; set; }

        public ICollection<ProductoProveedor> ProductosProveedores { get; set; }
        public ICollection<Compra> Compras { get; set; }
    }
}
