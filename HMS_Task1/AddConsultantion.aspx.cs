using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class AddConsultantion : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string originalReceiptNo = Request.QueryString["originalReceiptNo"];
                LoadConsultant();
                
                if (!string.IsNullOrEmpty(originalReceiptNo))
                {
                    LoadXrayDetails(originalReceiptNo);
                }
                else
                {
                    txtReceiptNo.Text = GenerateUniqueID();
                }

                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtTime.Text = DateTime.Now.ToString("HH:mm:ss");
                txtDate1.Text = DateTime.Now.ToString("yyyy-MM-dd");

            }
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
        private void LoadConsultant()
        {
            string connStr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();


                    // Load Consultant - Populate ddlConsultant
                    string consultantQuery = "SELECT ConsultantID, ConsultantName FROM Consultants";
                    SqlCommand consultantCmd = new SqlCommand(consultantQuery, conn);
                    SqlDataReader consultantReader = consultantCmd.ExecuteReader();
                    ddlConsultant.Items.Clear(); // Clear existing items before adding new ones
                    ddlConsultant.Items.Add(new ListItem("-- Select Consultant --", "")); // Default option

                    while (consultantReader.Read())
                    {
                        ddlConsultant.Items.Add(new ListItem(consultantReader["ConsultantName"].ToString(), consultantReader["ConsultantID"].ToString()));
                    }
                    consultantReader.Close();

                    if (ddlConsultant.Items.Count > 1)
                        ddlConsultant.SelectedIndex = 1; // Select the first consultant

                    string selectedConsultantID = ddlConsultant.SelectedValue;

                    if (!string.IsNullOrEmpty(selectedConsultantID))
                    {
                        string chargesQuery = "SELECT ConsultantCharges FROM Consultants WHERE ConsultantID = @ConsultantID";
                        SqlCommand chargesCmd = new SqlCommand(chargesQuery, conn);
                        chargesCmd.Parameters.AddWithValue("@ConsultantID", selectedConsultantID);

                        SqlDataReader chargesReader = chargesCmd.ExecuteReader();
                        if (chargesReader.Read())
                        {
                            txtRupees.Text = chargesReader["ConsultantCharges"].ToString();
                            string rupees = txtRupees.Text;
                            txtGross.Text = rupees;
                            txtNetAmount.Text = rupees;
                        }
                        chargesReader.Close();
                    }
                    else
                    {
                        txtRupees.Text = ""; // Clear if no valid selection
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
        }


        private string GenerateUniqueID()
        {
            string receipt;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(ReceiptNo), 0) + 1 FROM OP_Consultantion ";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                receipt = cmd.ExecuteScalar().ToString();
                conn.Close();
            }

            return receipt;
        }

        private void LoadXrayDetails(string receiptNo)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT * FROM OP_Consultantion WHERE ReceiptNo = @ReceiptNo";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ReceiptNo", receiptNo);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {

                        ddlCat.SelectedValue = reader["Category"].ToString();
                        txtDate.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd");
                        txtTime.Text = reader["Time"].ToString();
                        txtReceiptNo.Text = reader["ReceiptNo"].ToString();
                        ddlType.SelectedItem.Text = reader["Type"].ToString();
                        ddlBmj.SelectedItem.Text = reader["BmjCardNo"].ToString();
                        txtPatientName.Text = reader["PatientName"].ToString();
                        ddlGender.SelectedItem.Text = reader["Gender"].ToString();
                        txtContact.Text = reader["ContactNo"].ToString();
                        txtAgeNum.Text = reader["AgeNum"].ToString();
                        ddlConsultant.SelectedItem.Text = reader["Consultant"].ToString();
                        ddlAgeValue.SelectedItem.Text = reader["AgeUnit"].ToString();

                        txtRupees.Text = reader["Rupees"].ToString();
                        txtGross.Text = reader["Gross"].ToString();
                        chkOtherShift.Checked = Convert.ToBoolean(reader["OtherShiftCancel"]);
                        txtDate1.Text = Convert.ToDateTime(reader["RefundDate"]).ToString("yyyy-MM-dd");
                        ddlReference.SelectedItem.Text = reader["Reference"].ToString();
                        chkCancel.Checked = Convert.ToBoolean(reader["Cancel"]);
                        txtSPD.Text = reader["SPD"].ToString();
                        txtZF.Text = reader["ZF"].ToString();
                        txtNetAmount.Text = reader["NetAmount"].ToString();
                        txtRemarks.Text = reader["Remarks"].ToString();
                        ddlPatientName.SelectedItem.Text = reader["Title"].ToString();
                    }

                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
                finally
                {
                    conn.Close();
                }
            }
        }


        protected void BClear_Click(object sender, EventArgs e)
        {
            ddlCat.SelectedIndex = -1;
            txtReceiptNo.Text = GenerateUniqueID();
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtTime.Text = DateTime.Now.ToString("HH:mm:ss");
            txtDate1.Text = DateTime.Now.ToString("yyyy-MM-dd");
            ddlType.SelectedIndex = -1;
            ddlBmj.SelectedIndex = -1;
            txtPatientName.Text = string.Empty;
            ddlGender.SelectedIndex = -1;
            txtContact.Text = string.Empty;
            txtAgeNum.Text = string.Empty;
            ddlConsultant.SelectedIndex = -1;
            ddlAgeValue.SelectedIndex = -1;

            txtRupees.Text = "0";
            txtGross.Text = "0";
            chkOtherShift.Checked = false;
            ddlReference.SelectedIndex = -1;
            chkCancel.Checked = false;
            txtSPD.Text = "0";
            txtZF.Text = "0";
            txtNetAmount.Text = "0";
            txtRemarks.Text = string.Empty;
            ddlPatientName.SelectedIndex = -1;
        }

        protected void BSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query;
                        // check if the record with the given ReceiptNo already exists
                        query = "SELECT COUNT(*) FROM OP_Consultantion WHERE ReceiptNo = @ReceiptNo";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@ReceiptNo", txtReceiptNo.Text);

                        conn.Open();
                        int count = (int)cmd.ExecuteScalar();
                        conn.Close();

                        // First get the ConsultantID from the Consultants table
                        int consultantId = 0;
                        query = "SELECT ConsultantID FROM Consultants WHERE ConsultantName = @ConsultantName";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@ConsultantName", ddlConsultant.SelectedItem.Text);

                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            consultantId = (int)result;
                        }
                        conn.Close();

                        if (count > 0)
                        {
                            // if the record exists, update it
                            query = @"
                    UPDATE OP_Consultantion SET
                        Category = @Category, 
                        TokenNo = @TokenNo, 
                        Date = @Date, 
                        Time = @Time, 
                        Type = @Type, 
                        BmjCardNo = @BmjCardNo, 
                        PatientName = @PatientName, 
                        Gender = @Gender, 
                        ContactNo = @ContactNo, 
                        AgeNum = @AgeNum, 
                        AgeUnit = @AgeUnit, 
                        ConsultantID = @ConsultantID, 
                        Rupees = @Rupees, 
                        Gross = @Gross, 
                        OtherShiftCancel = @OtherShiftCancel, 
                        RefundDate = @RefundDate, 
                        Reference = @Reference, 
                        Cancel = @Cancel, 
                        SPD = @SPD, 
                        ZF = @ZF, 
                        NetAmount = @NetAmount, 
                        Remarks = @Remarks, 
                        NoOfPrints = @NoOfPrints, 
                        Title = @Title
                    WHERE ReceiptNo = @ReceiptNo";

                            cmd = new SqlCommand(query, conn);
                        }
                        else
                        {
                            // if the record doesn't exist, insert a new one
                            query = @"
                    INSERT INTO OP_Consultantion (
                        Category, TokenNo, ReceiptNo, Date, Time, Type, BmjCardNo, 
                        PatientName, Gender, ContactNo, AgeNum, AgeUnit, ConsultantID, 
                        Rupees, Gross, OtherShiftCancel, RefundDate, Reference, 
                        Cancel, SPD, ZF, NetAmount, Remarks, NoOfPrints, Title
                    ) VALUES (
                        @Category, @TokenNo, @ReceiptNo, @Date, @Time, @Type, @BmjCardNo, 
                        @PatientName, @Gender, @ContactNo, @AgeNum, @AgeUnit, @ConsultantID, 
                        @Rupees, @Gross, @OtherShiftCancel, @RefundDate, 
                        @Reference, @Cancel, @SPD, @ZF, @NetAmount, @Remarks, 
                        @NoOfPrints, @Title)";

                            cmd = new SqlCommand(query, conn);
                        }

                        cmd.Parameters.AddWithValue("@Category", ddlCat.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@TokenNo", "0");
                        cmd.Parameters.AddWithValue("@ReceiptNo", txtReceiptNo.Text);
                        cmd.Parameters.AddWithValue("@Date", txtDate.Text);
                        cmd.Parameters.AddWithValue("@Time", txtTime.Text);
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@BmjCardNo", ddlBmj.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@PatientName", txtPatientName.Text);
                        cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@ContactNo", txtContact.Text);
                        cmd.Parameters.AddWithValue("@AgeNum", txtAgeNum.Text);
                        cmd.Parameters.AddWithValue("@AgeUnit", ddlAgeValue.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@ConsultantID", consultantId);

                        cmd.Parameters.AddWithValue("@Rupees", txtRupees.Text);
                        cmd.Parameters.AddWithValue("@Gross", txtGross.Text);
                        cmd.Parameters.AddWithValue("@OtherShiftCancel", chkOtherShift.Checked);
                        cmd.Parameters.AddWithValue("@RefundDate", txtDate1.Text);
                        cmd.Parameters.AddWithValue("@Reference", ddlReference.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@Cancel", chkCancel.Checked);
                        cmd.Parameters.AddWithValue("@SPD", txtSPD.Text);
                        cmd.Parameters.AddWithValue("@ZF", txtZF.Text);
                        cmd.Parameters.AddWithValue("@NetAmount", txtNetAmount.Text);
                        cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
                        cmd.Parameters.AddWithValue("@NoOfPrints", "1");
                        cmd.Parameters.AddWithValue("@Title", ddlPatientName.SelectedItem.Text);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        lblErr.Text = "Record saved successfully.";
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

        protected void ddlPatientName_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPatientName.SelectedItem != null)
            {
                string selectedPrefix = ddlPatientName.SelectedItem.Text;
                string gender = GetGenderForPatient(selectedPrefix);

                ListItem genderItem = ddlGender.Items.FindByValue(gender);

                if (genderItem != null)
                {
                    ddlGender.SelectedValue = gender;
                }
                else
                {
                    ddlGender.ClearSelection();
                }
                ddlGender.Enabled = false;
                ddlGender.SelectedItem.Text = gender;

            }
        }

        private string GetGenderForPatient(string prefix)
        {
            if (prefix == "Mr.")
            {
                return "Male";
            }
            else if (prefix == "Mrs." || prefix == "Miss")
            {
                return "Female";
            }
            else
            {
                return null;
            }
        }


        protected void ddlConsultant_SelectedIndexChanged(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    // Get the selected consultant ID or Name
                    string selectedConsultant = ddlConsultant.SelectedValue;

                    if (!string.IsNullOrEmpty(selectedConsultant))
                    {
                        string query = "SELECT ConsultantCharges FROM Consultants WHERE ConsultantID = @ConsultantID"; // or WHERE ConsultantName = @ConsultantName
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@ConsultantID", selectedConsultant); // or @ConsultantName

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtRupees.Text = reader["ConsultantCharges"].ToString();
                            string rupees = txtRupees.Text;
                            txtGross.Text = rupees;
                            txtNetAmount.Text = rupees;
                        }
                        reader.Close();
                    }
                    else
                    {
                        txtRupees.Text = ""; // Clear if no valid selection
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
        }

        protected void TxtRs_TextChanged(object sender, EventArgs e)
        {

            try
            {
                // Parse values (default to 0 if empty or invalid)
                decimal rupees = decimal.TryParse(txtRupees.Text, out decimal r) ? r : 0;
                decimal spd = decimal.TryParse(txtSPD.Text, out decimal s) ? s : 0;
                decimal zf = decimal.TryParse(txtZF.Text, out decimal z) ? z : 0;

                // Calculate sum
                decimal netAmount = rupees - (spd + zf);

                // Update net amount
                txtNetAmount.Text = netAmount.ToString();
            }
            catch (Exception ex)
            {
                lblErr.Text = "Error calculating amount: " + ex.Message;
            }

        }

    }
}
    