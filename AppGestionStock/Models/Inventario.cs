namespace AppGestionStock.Models
{
    public class Inventario
    {
        public int IdInventario { get; set; }
        public int IdProducto { get; set; }
        public DateTime FechaMovimiento { get; set; }
        public string TipoMovimiento { get; set; } // Puede ser 'Entrada' o 'Salida'
        public int Cantidad { get; set; }
        public int IdMovimiento { get; set; }

        public Producto Producto { get; set; }
    }
}
