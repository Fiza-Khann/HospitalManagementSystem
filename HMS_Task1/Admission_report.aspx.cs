using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class Admission_report : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BPrint.Visible = true;
                BPrint.Enabled = false;
                BindGrid();
            }
        }


        protected void BShow_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(dateFrom.Text) || string.IsNullOrEmpty(dateTo.Text))
            {
                lblMsg.Text = "Please fill in both 'From' and 'To' dates.";
                return;
            }

            BindGrid();
            BPrint.Visible = true;
            lblMsg.Text = "";
        }

        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Home.aspx"); // Redirect to home or another appropriate page
        }

        protected void BPrint_Click(object sender, EventArgs e)
        {
            BindGrid();
            ClientScript.RegisterStartupScript(this.GetType(), "GeneratePDF", "generatePDF();", true);
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
    SELECT 
        P.Reg, 
        P.Num AS BillNo, 
        P.PatientName, 
        P.Room AS RoomName, 
        P.ConsultantName, 
 P.AdmDate AS AdmDate, 
        P.AdmTime AS AdmTime, 
        P.Mobile AS Mobile
    FROM 
       Patient P
    WHERE 
        P.AdmDate BETWEEN @FromDate AND @ToDate";


                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FromDate", dateFrom.Text);
                    cmd.Parameters.AddWithValue("@ToDate", dateTo.Text);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                        BPrint.Enabled = dt.Rows.Count > 0;
                    }
                }
            }
        }
    }
}