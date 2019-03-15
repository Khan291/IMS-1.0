using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IMSBLL.DAL
{
    public class DashboardOrderTableViewModel
    {
        public int ID { get; set; }
        public string InvoiceNumber { get; set; }
        public string PartyName { get; set; }
        public decimal? TotalTax { get; set; }
        public decimal? TotalDiscount { get; set; }
        public decimal? TotalAmount { get; set; }
        public decimal? GrandTotal { get; set; }

        public decimal? GivenAmnt { get; set; }
        public decimal? BalanceAmnt { get; set; }
        public DateTime? Date { get; set; }

        public decimal? LastMonthTotal { get; set; }
    }

    public class DashboardChartViewModel
    {
        public int? ProductId { get; set; }
        public decimal? Quantity { get; set; }
        public string ProductName { get; set; }
    }

}
