namespace AppGestionStock.Models
{
    public class Producto
    {
        public int IdProducto { get; set; }
        public string Nombre { get; set; }
        public decimal Precio { get; set; }
        public int Stock { get; set; }
        public decimal Coste { get; set; }
        public int IdCategoria { get; set; }
        public string Imagen { get; set; } // Nueva propiedad para la imagen

        public Categoria Categoria { get; set; }
        public ICollection<DetallesVenta> DetallesVentas { get; set; }
        public ICollection<DetallesCompra> DetallesCompras { get; set; }
        public ICollection<ProductoProveedor> ProductosProveedores { get; set; }
    }
}
