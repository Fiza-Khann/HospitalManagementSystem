using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class ViewRoom : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM Room", con)) // Fetch rooms from the Room table
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
                    string roomName = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use room name as the key
                    DeleteRoom(roomName); // Delete room by name
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select at least one room to delete.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Selected room(s) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindGrid(); // Refresh the grid after deletion
            }
        }

        private void DeleteRoom(string roomName)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Room WHERE Room = @Room", conn)) // Delete room by name
                {
                    cmd.Parameters.AddWithValue("@Room", roomName);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            bool recordSelected = false;
            string selectedRoom = "";

            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    recordSelected = true;
                    selectedRoom = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use room name as the key
                    Response.Redirect("AddRoom.aspx?Room=" + selectedRoom); // Redirect to the room edit page
                    return;
                }
            }

            if (recordSelected)
            {
                Response.Redirect("AddRoom.aspx?Room=" + selectedRoom);
            }
            else
            {
                lblMsg.Text = "Please select a room to update.";
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
