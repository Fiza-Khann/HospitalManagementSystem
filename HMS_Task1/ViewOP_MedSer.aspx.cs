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
    public partial class ViewOP_MedSer : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM OP_MedSer", con))
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
                    string ReceiptNo = MainGrid.DataKeys[row.RowIndex].Value.ToString();
                    DeleteConsultant(ReceiptNo);
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


        private void DeleteConsultant(string ReceiptNo)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM OP_MedSer WHERE ReceiptNo = @ReceiptNo", conn))
                {
                    cmd.Parameters.AddWithValue("@ReceiptNo", ReceiptNo);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    string originalReceiptNo = MainGrid.DataKeys[row.RowIndex].Value.ToString();

                    // Redirect to EditOP_Xray.aspx with the original ReceiptNo
                    Response.Redirect("EditOP_MedSer.aspx?originalReceiptNo=" + originalReceiptNo);
                    return;
                }
            }

            lblMsg.Text = "Please select a row to update.";
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
                    chkSelect.Checked = chkSelectAll.Checked;
                }
            }
        }
    }
}