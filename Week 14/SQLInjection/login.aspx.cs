using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SQLInjection
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                StringBuilder builder = new StringBuilder();
                using (SqlConnection connection = new SqlConnection(@"Data Source=(localdb)\ProjectsV13;Initial Catalog=AP;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False"))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("SELECT * FROM Users WHERE userName='" + txtUserName.Text + "' and password = '" + txtPassword.Text + "'", connection))
                    {
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            builder.Append("<table width='200px' border='1'>");
                            while (reader.Read())
                            {
                                builder
                                    .Append("<tr>")
                                    .Append("<td>").Append(reader["userID"]).Append("</td>")
                                    .Append("<td>").Append(reader["userName"]).Append("</td>")
                                    .Append("<td>").Append(reader["password"]).Append("</td>")
                                    .Append("</tr>");
                            }
                            builder.Append("</table>");
                        }
                    }
                }
                lblResult.Text = builder.ToString();
            }
            catch (Exception err)
            {
                lblResult.Text = err.Message;
            }
        }

        protected void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                StringBuilder builder = new StringBuilder();
                using (SqlConnection connection = new SqlConnection(@"Data Source=(localdb)\ProjectsV13;Initial Catalog=AP;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False"))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("spLogin", connection))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@un", txtUserName.Text);
                        command.Parameters.AddWithValue("@pw", txtPassword.Text);
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            builder.Append("<table width='200px' border='1'>");
                            while (reader.Read())
                            {
                                builder
                                    .Append("<tr>")
                                    .Append("<td>").Append(reader["userID"]).Append("</td>")
                                    .Append("<td>").Append(reader["userName"]).Append("</td>")
                                    .Append("<td>").Append(reader["password"]).Append("</td>")
                                    .Append("</tr>");
                            }
                            builder.Append("</table>");
                        }
                    }
                }
                lblResult.Text = builder.ToString();
            }
            catch (Exception err)
            {
                lblResult.Text = err.Message;
            }
        }
    }
}