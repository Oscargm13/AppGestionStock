using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace AppGestionStock.Models
{
    [Table("Compras")]
    public class Compra
    {
        [Key]
        [Column("IdCompra")]
        public int IdCompra { get; set; }

        [Required(ErrorMessage = "La fecha de compra es obligatoria")]
        [Column("FechaCompra")]
        public DateTime FechaCompra { get; set; }

        [Required(ErrorMessage = "El proveedor es obligatorio")]
        [Column("IdProveedor")]
        public int IdProveedor { get; set; }

        [Required(ErrorMessage = "La tienda es obligatoria")]
        [Column("IdTienda")]
        public int IdTienda { get; set; }

        [Required(ErrorMessage = "El importe total es obligatorio")]
        [Column("ImporteTotal")]
        public decimal ImporteTotal { get; set; }

        public Proveedor Proveedor { get; set; }
        public Tienda Tienda { get; set; }
        public ICollection<DetallesCompra> DetallesCompras { get; set; }
    }
}
