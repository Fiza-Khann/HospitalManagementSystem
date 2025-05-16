using System;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web.Configuration;
using System.Web.UI;

namespace HMS_Task1
{
    public partial class Login : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            txtUserName.Focus();

        }

        protected void BLogin_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Value.Trim();
            string password = txtPassword.Value.Trim();

            if (IsValidUser(username, password))
            {
                Response.Redirect("Home.aspx");
            }
            else
            {
                lblErr.Text = "Incorrect username or password.";
                lblErr.ForeColor = System.Drawing.Color.Red;
            }
        }

        private bool IsValidUser(string username, string password)
        {
            bool isValid = false;
            using (SqlConnection conn = Singleton.Instance.GetConnection())
            {
                try
                {
                    string query = "SELECT Id, LoginID, Email, Name FROM UserInformation WHERE Name = @Name AND LoginId = @LoginId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", username);
                    cmd.Parameters.AddWithValue("@LoginId", password);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["LoginID"] = reader["LoginID"].ToString();
                        Session["Id"] = reader["Id"].ToString();
                        Session["Email"] = reader["Email"].ToString();
                        Session["Name"] = reader["Name"].ToString();
                        isValid = true;
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
            return isValid;
        }

    }
}
