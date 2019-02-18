using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.DAL
{
    public class TaxGroupDetaileViewModel
    {
        public int groupId { get; set; }
        public int? productId { get; set; }
        public int typeId { get; set; }
        public int taxdetailId { get; set; }
        public decimal? taxPercentage { get; set; }
        public decimal? taxTotalPercentage { get; set; }
        public decimal? taxTotalAmnt { get; set; }
        public decimal? productAmnt { get; set; }
        public string groupName { get; set; }
        public string productName { get; set; }
        public string typeName { get; set; }
    }
}
