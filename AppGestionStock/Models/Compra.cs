namespace AppGestionStock.Models
{
    public class Compra
    {
        public int IdCompra { get; set; }
        public DateTime FechaCompra { get; set; }
        public int IdProveedor { get; set; }
        public int IdTienda { get; set; }
        public decimal ImporteTotal { get; set; }

        public Proveedor Proveedor { get; set; }
        public Tienda Tienda { get; set; }
        public ICollection<DetallesCompra> DetallesCompras { get; set; }
    }
}
