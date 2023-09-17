using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShopSolutions.Entity
{
    [Table("ProductInCategory")] // Sản phẩm Trong Category
    public class ProductInCategory
    {
        public int Id { get; set; }
        public int ProductId { get; set; }

        public Product Product { get; set; }

        public int CategoryId { get; set; }

        public Category Category { get; set; }
    }
}
