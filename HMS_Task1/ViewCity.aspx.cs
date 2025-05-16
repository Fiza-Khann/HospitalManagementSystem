using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class ViewCity : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM City", con)) // Fetch cities from the City table
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
                    string cityName = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use city name as the key
                    DeleteCity(cityName); // Delete city by name
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select at least one city to delete.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Selected city(ies) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindGrid(); // Refresh the grid after deletion
            }
        }

        private void DeleteCity(string cityName)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM City WHERE CityName = @CityName", conn)) // Delete city by name
                {
                    cmd.Parameters.AddWithValue("@CityName", cityName);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            bool recordSelected = false;
            string selectedCity = "";

            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    recordSelected = true;
                    selectedCity = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use city name as the key
                    Response.Redirect("AddCity.aspx?CityName=" + selectedCity); // Redirect to the city edit page
                    return;
                }
            }

            if (recordSelected)
            {
                Response.Redirect("AddCity.aspx?CityName=" + selectedCity);
            }
            else
            {
                lblMsg.Text = "Please select a city to update.";
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
