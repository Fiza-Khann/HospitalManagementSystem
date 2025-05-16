using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace HMS_template_Project
{
    public partial class Discharge_report1 : System.Web.UI.Page
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
        P.AdmDate AS AdmissionDate, 
        DATEDIFF(day, P.AdmDate, ISNULL(P.DischargeDate, GETDATE())) AS Days, 
        P.PatientName, 
        P.Room AS RoomName, 
        P.ConsultantName, 
        D.Dstatus AS Dstatus, 
        D.Dtime AS Dtime, 
        D.Ddate AS Ddate
    FROM 
       Discharge D 
    LEFT JOIN 
         Patient P
    ON 
       D.SerialNo= P.SerialNo 
    WHERE 
        D.Ddate BETWEEN @FromDate AND @ToDate";


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