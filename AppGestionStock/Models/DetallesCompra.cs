namespace AppGestionStock.Models
{
    public class DetallesCompra
    {
        public int IdDetallesCompra { get; set; }
        public int IdCompra { get; set; }
        public int IdProducto { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnidad { get; set; }

        public Compra Compra { get; set; }
        public Producto Producto { get; set; }
    }
}
