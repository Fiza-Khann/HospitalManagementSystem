using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace HMS_template_Project
{
    public partial class ConsultantList : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM Consultants", con))
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



        protected void BAddDepartment_Click(object sender, EventArgs e)
        {
            // Redirect to the AddConsultant form
            Response.Redirect("AddConsultant.aspx");
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
                    string consultantID = MainGrid.DataKeys[row.RowIndex].Value.ToString();
                    DeleteConsultant(consultantID);
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select a record!";
                lblMsg.ForeColor = System.Drawing.Color.Red; // Set error message color to red
            }
            else
            {
                lblMsg.Text = "Record(s) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green; // Set success message color to green
                BindGrid();
            }
        }


        private void DeleteConsultant(string consultantID)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Consultants WHERE ConsultantID = @ConsultantID", conn))
                {
                    cmd.Parameters.AddWithValue("@ConsultantID", consultantID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Get the selected consultant ID from the grid
            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    int consultantID = Convert.ToInt32(MainGrid.DataKeys[row.RowIndex].Value);

                    // Redirect to AddConsultant.aspx with the selected ConsultantID
                    Response.Redirect("AddConsultant.aspx?ConsultantID=" + consultantID);
                    return;
                }
            }

            // Display error message if no row is selected
            lblMsg.Text = "Please select a row to update.";
        }


        protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkSelectAll = (CheckBox)sender;
            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null)
                {
                    chkSelect.Checked = chkSelectAll.Checked;
                }
            }
        }
    }
}
