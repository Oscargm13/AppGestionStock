namespace AppGestionStock.Models
{
    public class ProductoProveedor
    {
        public int IdProducto { get; set; }
        public int IdProveedor { get; set; }

        public Producto Producto { get; set; }
        public Proveedor Proveedor { get; set; }
    }
}
