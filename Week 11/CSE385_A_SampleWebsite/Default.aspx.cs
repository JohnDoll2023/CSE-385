using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CSE385_A_SampleWebsite
{
    public partial class Default : System.Web.UI.Page {
        private string connString = @"Data Source = (localdb)\ProjectsV13; Initial Catalog = AP; Integrated Security = True;";
        protected void btnGetVendors_Click(object sender, EventArgs e) {
            StringBuilder sb = new StringBuilder();
            using (SqlConnection conn = new SqlConnection(connString)) {
                using (SqlCommand cmd = new SqlCommand("spGetVendors", conn)) {
                    cmd.Parameters.AddWithValue("@st", txtState.Text);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read()) {
                        sb.Append(reader["VendorName"].ToString());
                        sb.Append("<br />");
                    }
                }
            }

            /*foreach (DataSet1.spGetVendorsRow r in (new DataSet1TableAdapters.spGetVendorsTableAdapter()).GetData(txtState.Text, false))
            {
                sb.Append(r.VendorName);
                sb.Append("<br />");
            }*/

            /*lblVendors.Text = "hello world";*/
        }
    }
}