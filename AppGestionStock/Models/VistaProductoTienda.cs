using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

namespace AppGestionStock.Models
{
    [Table("VistaProductosTienda")]
    [PrimaryKey(nameof(IdProducto), nameof(IdTienda))]
    public class VistaProductoTienda
    {
        [ForeignKey("IdProducto")]
        public int IdProducto { get; set; }

        [Column("Nombre")]
        public string Nombre { get; set; }

        [Column("Precio")]
        public decimal Precio { get; set; }

        [Column("Coste")]
        public decimal Coste { get; set; }

        [Column("IdCategoria")]
        public int IdCategoria { get; set; }

        [Column("Imagen")]
        public string Imagen { get; set; }

        [ForeignKey("IdTienda")]
        public int IdTienda { get; set; }

        [Column("StockTienda")]
        public int StockTienda { get; set; }
    }
}
