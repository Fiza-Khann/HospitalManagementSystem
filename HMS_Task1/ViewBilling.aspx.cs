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
    public partial class ViewBilling : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM [HMS].[dbo].[InPatientBilling]", con))
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
                    string billNo = MainGrid.DataKeys[row.RowIndex].Value.ToString(); // Use serialno as the key
                    DeletePatient(billNo); // Delete patient by serialno
                    
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

        private void DeletePatient(string billNo)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                conn.Open();

                // Begin a transaction to ensure both deletions happen together
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Step 1: Get the SerialNo from InPatientBilling table based on BillNo
                        string serialNo = null;
                        using (SqlCommand cmd1 = new SqlCommand("SELECT ib.SerialNo FROM [HMS].[dbo].[InPatientBilling] ib INNER JOIN [HMS].[dbo].[Bill_By_Employee] bbe ON ib.SerialNo = bbe.SerialNo WHERE ib.BillNo = @BillNo", conn, transaction))
                        {
                            cmd1.Parameters.AddWithValue("@BillNo", billNo);
                            object result = cmd1.ExecuteScalar();
                            if (result != null)
                            {
                                serialNo = result.ToString();
                            }
                        }

                        if (string.IsNullOrEmpty(serialNo))
                        {
                            // If no SerialNo found for the given BillNo, show an alert via label
                            lblMsg.Text = "No record found for the given BillNo.";
                            lblMsg.ForeColor = System.Drawing.Color.Red;
                            return;
                        }

                        // Step 2: Check if the SerialNo exists in the Bill_By_Employee table
                        using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM [HMS].[dbo].[Bill_By_Employee] WHERE SerialNo = @SerialNo", conn, transaction))
                        {
                            checkCmd.Parameters.AddWithValue("@SerialNo", serialNo);
                            int count = (int)checkCmd.ExecuteScalar();

                            if (count == 0)
                            {
                                // If no records found in Bill_By_Employee table, show an alert via label
                                lblMsg.Text = "No record found in Bill_By_Employee for the given SerialNo.";
                                lblMsg.ForeColor = System.Drawing.Color.Red;
                                return;
                            }
                        }

                        // Step 3: Delete from Bill_By_Employee table using SerialNo
                        using (SqlCommand deleteCmd1 = new SqlCommand("DELETE FROM [HMS].[dbo].[Bill_By_Employee] WHERE SerialNo = @SerialNo", conn, transaction))
                        {
                            deleteCmd1.Parameters.AddWithValue("@SerialNo", serialNo);
                            deleteCmd1.ExecuteNonQuery();
                        }

                        // Step 4: Delete from InPatientBilling table using BillNo
                        using (SqlCommand deleteCmd2 = new SqlCommand("DELETE FROM [HMS].[dbo].[InPatientBilling] WHERE BillNo = @BillNo", conn, transaction))
                        {
                            deleteCmd2.Parameters.AddWithValue("@BillNo", billNo);
                            deleteCmd2.ExecuteNonQuery();
                        }

                        // Commit the transaction
                        transaction.Commit();

                        // Success message via label
                        lblMsg.Text = "Record deleted successfully.";
                        lblMsg.ForeColor = System.Drawing.Color.Green;
                    }
                    catch (Exception ex)
                    {
                        // Rollback transaction in case of error
                        transaction.Rollback();
                        lblMsg.Text = "Error: " + ex.Message;
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                    }
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
                    Response.Redirect("AddInBilling.aspx?BillNo=" + serialno); // Redirect to the patient edit page
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