namespace AppGestionStock.Models
{
    public class DetallesVenta
    {
        public int IdDetallesVenta { get; set; }
        public int IdVenta { get; set; }
        public int IdProducto { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnidad { get; set; }

        public Venta Venta { get; set; }
        public Producto Producto { get; set; }
    }
}
