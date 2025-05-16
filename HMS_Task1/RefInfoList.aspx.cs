using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class RefInfoList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        //private void BindGrid()
        //{
        //    string connectionString = "Data Source=.;Initial Catalog=HMStemplateDB;Integrated Security=True;";
        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("SELECT * FROM Consultants", conn))
        //        {
        //            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
        //            {
        //                DataTable dt = new DataTable();
        //                sda.Fill(dt);
        //                MainGrid.DataSource = dt;
        //                MainGrid.DataBind();
        //            }
        //        }
        //    }
        //}
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM ReferenceInformation", con))
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
                    string recordID = MainGrid.DataKeys[row.RowIndex].Value.ToString();
                    DeleteReference(recordID);
                }
            }

            if (!recordSelected)
            {
                lblMsg.Text = "Please select at least one record to delete.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblMsg.Text = "Selected reference(s) deleted successfully.";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                BindGrid();
            }
        }

        private void DeleteReference(string id)
        {
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("DELETE FROM ReferenceInformation WHERE ID = @ID", conn))
                {
                    cmd.Parameters.AddWithValue("@ID", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            bool recordSelected = false;
            string selectedID = "";

            foreach (GridViewRow row in MainGrid.Rows)
            {
                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
                if (chkSelect != null && chkSelect.Checked)
                {
                    recordSelected = true;
                    selectedID = MainGrid.DataKeys[row.RowIndex].Value.ToString();
                    Response.Redirect("RefInfo.aspx?ID=" + selectedID);
                    return;
                }
            }

            if (recordSelected)
            {
                Response.Redirect("RefInfo.aspx?ID=" + selectedID);
            }
            else
            {
                lblMsg.Text = "Please select a reference to update.";
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