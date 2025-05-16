using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace HMS_Task2
{
    public partial class AdvanceHistory : System.Web.UI.Page
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
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM AdvanceHistory", con))
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

        protected void MainGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = MainGrid.SelectedRow;
            if (row != null)
            {
                string selectedAmountStr = row.Cells[5].Text;
                decimal selectedAmount;
                if (decimal.TryParse(selectedAmountStr, out selectedAmount))
                {
                    txtPrevious.Text = selectedAmount.ToString();

                    decimal previousAmount;
                    decimal currentAmount;
                    decimal.TryParse(txtPrevious.Text, out previousAmount);
                    decimal.TryParse(txtCurrent.Text, out currentAmount);
                    decimal netTotal = previousAmount + currentAmount;
                    txtNetTotal.Text = netTotal.ToString();
                }
            }
        }
       
        protected void txtCurrent_TextChanged(object sender, EventArgs e)
        {
            decimal previousAmount;
            decimal currentAmount;
            decimal netTotal;

            decimal.TryParse(txtPrevious.Text, out previousAmount);
            decimal.TryParse(txtCurrent.Text, out currentAmount);
            netTotal = previousAmount + currentAmount;
            txtNetTotal.Text = netTotal.ToString();
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