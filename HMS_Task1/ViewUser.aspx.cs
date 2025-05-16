using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class ViewUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            if (string.IsNullOrEmpty(constr))
            {
                lblMsg.Text = "Connection string is not configured properly.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT Id, LoginId, Name,Email, Designation FROM UserInformation", con))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);

                            MainGrid.DataSource = dt;
                            MainGrid.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "An error occurred: " + ex.Message;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            bool recordSelected = false;
            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    recordSelected = true;
                    string userID = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use UserID as the key
                    DeleteUser(userID); // Delete user by UserID
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select at least one user to delete.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Selected user(s) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindGrid(); // Refresh the grid after deletion
            }
        }

        private void DeleteUser(string userID)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM UserInformation WHERE Id = @Id", conn)) // Delete user by UserID
                {
                    cmd.Parameters.AddWithValue("@Id", userID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            bool recordSelected = false;
            string selectedUserID = "";

            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    recordSelected = true;
                    selectedUserID = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use UserID as the key
                    Response.Redirect("AddUser.aspx?Id=" + selectedUserID); // Redirect to the user edit page
                    return;
                }
            }

            if (recordSelected)
            {
                Response.Redirect("AddUser.aspx?Id=" + selectedUserID);
            }
            else
            {
                lblMsg.Text = "Please select a user to update.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkSelectAll = (CheckBox)sender;
            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null)
                {
                    chkSelect.Checked = chkSelectAll.Checked; // Check or uncheck all
                }
            }
        }
    }
}
