namespace AppGestionStock.Models
{
    public class Venta
    {
        public int IdVenta { get; set; }
        public DateTime FechaVenta { get; set; }
        public int IdTienda { get; set; }
        public int IdUsuario { get; set; }
        public decimal ImporteTotal { get; set; }

        public Tienda Tienda { get; set; }
        public Usuario Usuario { get; set; }
        public ICollection<DetallesVenta> DetallesVentas { get; set; }
    }
}
