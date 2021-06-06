using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1 {
    public partial class _Default : Page {
        protected void lstLoadVendors_Click(object sender, EventArgs e) {
            lstVendors.Items.Clear();
            string st = txtVendorState.Text;
            foreach(ds.spGetVendorsRow row in (new dsTableAdapters.spGetVendorsTableAdapter()).GetData(st) ) {
                lstVendors.Items.Add( new ListItem (row.VendorName, "" + row.VendorId));
            }
        }
    }
}