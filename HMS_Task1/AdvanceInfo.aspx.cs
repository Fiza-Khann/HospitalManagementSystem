using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace HMS_Task2
{
    public partial class AdvanceInfo : System.Web.UI.Page
    {

        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtReceipt.Text = GenerateUniqueID();
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd"); 
                txtTime.Text = DateTime.Now.ToString("HH:mm:ss");
                radiobtnCash.Checked = true;
            }
        }
        private string GenerateUniqueID()
        {
            string receipt;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(Receipt), 0) + 1 FROM AdvanceHistory";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                receipt = cmd.ExecuteScalar().ToString();
                conn.Close();
            }

            return receipt;
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery",
                new ScriptResourceDefinition
                {
                    Path = "~/Scripts/jquery-3.5.1.min.js",
                    DebugPath = "~/Scripts/jquery-3.5.1.js",
                    CdnPath = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.1.min.js",
                    CdnDebugPath = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.1.js",
                    CdnSupportsSecureConnection = true,
                    LoadSuccessExpression = "window.jQuery"
                });
        }
        protected void BNew_Click(object sender, EventArgs e)
        {
            lblErr.Text = "";
                txtReg.Text = "";
                txtNo.Text = "";
                txtAdmDate.Text = "";
                txtAdmTime.Text = "";
                txtAccType.Text = "";
                txtConsultant.Text = "";
            txtSerialNo.Text = "0";
                txtPatientName.Text = "";
                txtRoom.Text = "";
                txtGender.Text = "";
                txtAge.Text = "";
                txtAmount.Text = "0";
                radiobtnCash.Checked = true;
                radiobtnCreditCard.Checked = false;
                radiobtnCheque.Checked = false;
                txtReceipt.Text = GenerateUniqueID();
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtTime.Text = DateTime.Now.ToString("HH:mm:ss");
            
        }
        private string GetSelectedPaymentMode()
        {
            if (radiobtnCash.Checked)
            {
                return "Cash";
            }
            else if (radiobtnCheque.Checked)
            {
                return "Cheque";
            }
            else if(radiobtnCreditCard.Checked)
            {
                return "Credit Card";
            }
            else
            {
                return string.Empty; 
            }
        }
        protected void BSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "INSERT INTO AdvanceHistory (Receipt, SerialNo,AdvanceDate,AdvanceTime,Amount,Type,Mode,LastUpdate,LastUpdateTime)" +
                                       "VALUES (@Receipt,@SerialNo,@AdvanceDate,@AdvanceTime,@Amount,@Type,@Mode,@LastUpdate,@LastUpdateTime)";

                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Receipt", txtReceipt.Text);
                        cmd.Parameters.AddWithValue("@SerialNo", txtSerialNo.Text);
                        cmd.Parameters.AddWithValue("@AdvanceDate", txtDate.Text);
                        cmd.Parameters.AddWithValue("@AdvanceTime", txtTime.Text);
                        cmd.Parameters.AddWithValue("@Amount", txtAmount.Text);
                        cmd.Parameters.AddWithValue("@Type", "Advance");
                        cmd.Parameters.AddWithValue("@Mode", GetSelectedPaymentMode()); 
                        cmd.Parameters.AddWithValue("@LastUpdate", DateTime.Now.ToString("yyyy-MM-dd"));
                        cmd.Parameters.AddWithValue("@LastUpdateTime", DateTime.Now.ToString("HH:mm:ss"));

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        lblErr.Text = "Reference added successfully.";
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
        }
        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

       protected void BPrint_Click(object sender, EventArgs e)
        {

        }
        protected void BPreview_Click(object sender, EventArgs e)
        {

        }
        protected void FetchAndFillData()
        {
            lblErr.Text = "";

            if (!string.IsNullOrEmpty(txtReg.Text) && !string.IsNullOrEmpty(txtNo.Text))
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "SELECT SerialNo,AdmDate, AdmTime, Typee, ConsultantName, PatientName, Room, Gender, AgeNum FROM patient WHERE Reg = @Reg AND Num = @Num";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Reg", txtReg.Text);
                        cmd.Parameters.AddWithValue("@Num", txtNo.Text);

                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            string admDateString = reader["AdmDate"].ToString();

                            DateTime admDate;
                            string outputDateFormat = "dd/MM/yyyy"; 

                            if (DateTime.TryParse(admDateString, out admDate))
                            {
                                txtAdmDate.Text = admDate.ToString(outputDateFormat); 
                            }
                            else
                            {
                                txtAdmDate.Text = "Invalid Date Format"; 
                            }

                            txtAdmTime.Text = reader["AdmTime"].ToString();
                            txtAccType.Text = reader["Typee"].ToString();
                            txtConsultant.Text = reader["ConsultantName"].ToString();
                            txtPatientName.Text = reader["PatientName"].ToString();
                            txtRoom.Text = reader["Room"].ToString();
                            txtGender.Text = reader["Gender"].ToString();
                            txtAge.Text = reader["AgeNum"].ToString();
                            txtSerialNo.Text = reader["SerialNo"].ToString();
                            
                        }
                        else
                        {
                            lblErr.Text = "No records found.";
                        }
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
            else
            {
                lblErr.Text = "Please enter both Registration Number and Number.";
            }
        }

        protected void TxtReg_TextChanged(object sender, EventArgs e)
        {
            FetchAndFillData();
        }

        protected void TxtNo_TextChanged(object sender, EventArgs e)
        {
            FetchAndFillData();
        }
       
    }
}