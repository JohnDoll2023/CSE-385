using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SQLInjection
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.IsInRole("Admin")) Response.Redirect("~/");
        }


        protected void btnLoadVendors_Click(object sender, EventArgs e)
        {
            lstVendors.Items.Clear();
            lstInvoices.Items.Clear();

            foreach(ds.spGetVendorsRow r in (new dsTableAdapters.spGetVendorsTableAdapter()).GetData(txtState.Text))
                lstVendors.Items.Add(new ListItem(r.VendorName, "" + r.VendorID));
        }

        protected void btnLoadInvoices_Click(object sender, EventArgs e)
        {
            lstInvoices.Items.Clear();
            if (lstVendors.SelectedIndex == -1) return;
            int vid = Convert.ToInt32(lstVendors.SelectedValue);

            foreach (ds.spGetInvoicesRow r in (new dsTableAdapters.spGetInvoicesTableAdapter()).GetData(vid))
                lstInvoices.Items.Add(r.InvoiceNumber);
        }

    }
}