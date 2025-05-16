using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class AdmittedPatients : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SELECT serialno, Reg, Num, AdmDate, AdmTime, Bmj#, Title, PatientName, Room, ConsultantName, Relation, RelationName, Emergency, Mobile, OtherContact, Email, ReferenceName, AdmittedFor, AdmissionRemarks, AdmissionLoginId, Discharged, DischargeDate, DischargeTime, DischargeRemarks, City, AreaName, Gender, AgeNum, AgeValue, Typee, Address FROM [HMS].[dbo].[patient]", con))
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
                    string serialNo = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use serialno as the key
                    DeletePatient(serialNo); // Delete patient by serialno
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select at least one patient to delete.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Selected patient(s) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindGrid(); // Refresh the grid after deletion
            }
        }

        private void DeletePatient(string serialNo)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM [HMS].[dbo].[patient] WHERE serialno = @serialno", conn)) // Delete patient by serialno
                {
                    cmd.Parameters.AddWithValue("@serialno", serialNo);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string serialno = string.Empty;
            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    serialno = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use serialno as the key
                    Response.Redirect("AdmitPatient.aspx?serialno=" + serialno); // Redirect to the patient edit page
                    return;
                }
            }

            lblMsg.Text = "Please select a patient to update.";
            lblMsg.ForeColor = System.Drawing.Color.Red;
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