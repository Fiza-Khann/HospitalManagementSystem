using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class ChangePass : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_Init(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-3.5.1.min.js",
                    DebugPath = "~/Scripts/jquery-3.5.1.js",
                    CdnPath = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.1.min.js",
                    CdnDebugPath = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.1.js",
                    CdnSupportsSecureConnection = true,
                    LoadSuccessExpression = "window.jQuery"
                });
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string oldPass = txtOldPassword.Text.Trim();
            string newPass = txtNewPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();

            if (newPass != confirmPass)
            {
                lblMessage.Text = "New password and confirmation do not match.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Get user Id from session
            string userId = Session["Id"]?.ToString(); // ✅ this matches what you stored in Login.aspx.cs
            if (string.IsNullOrEmpty(userId))
            {
                lblMessage.Text = "Session expired. Please log in again.";
                return;
            }


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                // Check old password (LoginId = password)
                string checkQuery = "SELECT COUNT(*) FROM UserInformation WHERE Id = @Id AND LoginId = @OldPassword";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@Id", userId);
                checkCmd.Parameters.AddWithValue("@OldPassword", oldPass);

                int count = (int)checkCmd.ExecuteScalar();

                if (count == 0)
                {
                    lblMessage.Text = "Old password is incorrect.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Update LoginId (i.e., password)
                string updateQuery = "UPDATE UserInformation SET LoginId = @NewPassword WHERE Id = @Id";
                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                updateCmd.Parameters.AddWithValue("@NewPassword", newPass);
                updateCmd.Parameters.AddWithValue("@Id", userId);

                updateCmd.ExecuteNonQuery();
                lblMessage.Text = "Password changed successfully.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
        }

    }
}