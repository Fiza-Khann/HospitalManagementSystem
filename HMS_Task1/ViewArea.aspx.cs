using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class ViewArea : System.Web.UI.Page
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
                    // Modify the query to fetch data for AreaName and CityName
                    using (SqlCommand cmd = new SqlCommand("SELECT AreaName, CityName FROM Area", con)) // Fetch areas and cities from the Area table
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
                    string areaName = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use AreaName as the key
                    string cityName = ((Label)row.FindControl("lblCityName")).Text; // Get the CityName from the row
                    DeleteArea(areaName, cityName); // Delete area by name and city
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select at least one area to delete.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Selected area(s) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindGrid(); // Refresh the grid after deletion
            }
        }

        private void DeleteArea(string areaName, string cityName)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                // Modify the query to delete an area by its AreaName and CityName
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Area WHERE AreaName = @AreaName AND CityName = @CityName", conn))
                {
                    cmd.Parameters.AddWithValue("@AreaName", areaName);
                    cmd.Parameters.AddWithValue("@CityName", cityName);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            bool recordSelected = false;
            string selectedArea = "";
            string selectedCity = "";

            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    recordSelected = true;
                    selectedArea = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use AreaName as the key
                    selectedCity = ((Label)row.FindControl("lblCityName")).Text; // Get the CityName
                    Response.Redirect("AddArea.aspx?Area=" + selectedArea + "&City=" + selectedCity); // Redirect to the area edit page
                    return;
                }
            }

            if (recordSelected)
            {
                Response.Redirect("AddArea.aspx?Area=" + selectedArea + "&City=" + selectedCity);
            }
            else
            {
                lblMsg.Text = "Please select an area to update.";
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
