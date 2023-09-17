using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ShopSolutions.Entity
{
    [Table("AppConfig")] // Cấu hình ứng dụng
    public class AppConfig
    {
        public int Id { get; set; }
        public string Key { get; set; }

        public string Value { get; set; }
    }
}
