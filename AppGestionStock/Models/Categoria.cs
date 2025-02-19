namespace AppGestionStock.Models
{
    public class Categoria
    {
        public int IdCategoria { get; set; }
        public string Nombre { get; set; }
        public int? IdCategoriaPadre { get; set; }

        public Categoria CategoriaPadre { get; set; }
        public ICollection<Categoria> CategoriasHijas { get; set; }
    }
}
