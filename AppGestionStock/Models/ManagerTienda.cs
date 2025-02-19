namespace AppGestionStock.Models
{
    public class ManagerTienda
    {
        public int IdUsuario { get; set; }
        public int IdTienda { get; set; }

        public Usuario Usuario { get; set; }
        public Tienda Tienda { get; set; }
    }
}
