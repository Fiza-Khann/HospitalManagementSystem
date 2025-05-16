using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class ViewDischarge : System.Web.UI.Page
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
                    // SQL query with JOIN clause to fetch PatientName from the patient table
                    string query = @"
                SELECT 
                    D.SerialNo, 
                    P.PatientName, 
P.Reg,
P.Num,
                    D.Dstatus, 
                    D.Ddate, 
                    D.Dtime
                FROM 
                    Discharge D
                JOIN 
                    patient P 
                ON 
                    D.SerialNo = P.SerialNo";

                    using (SqlCommand cmd = new SqlCommand(query, con))
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
                    string serialNo = MainGrid.DataKeys[row.RowIndex].Value.ToString();
                    DeleteDischarge(serialNo);
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select at least one record to delete.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Selected discharge record(s) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindGrid();
            }
        }

        private void DeleteDischarge(string serialNo)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Discharge WHERE SerialNo = @SerialNo", conn))
                {
                    cmd.Parameters.AddWithValue("@SerialNo", serialNo);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            bool recordSelected = false;
            string selectedSerialNo = "";

            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    recordSelected = true;
                    selectedSerialNo = MainGrid.DataKeys[row.RowIndex].Value.ToString();
                    Response.Redirect("AddDischarge.aspx?SerialNo=" + selectedSerialNo);
                    return;
                }
            }

            if (recordSelected)
            {
                Response.Redirect("AddDischarge.aspx?SerialNo=" + selectedSerialNo);
            }
            else
            {
                lblMsg.Text = "Please select a discharge record to update.";
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
                    chkSelect.Checked = chkSelectAll.Checked;
                }
            }
        }
    }
}
