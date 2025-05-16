using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class AddInBilling : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMedServices();
                BindXRayServices();
                BindDentalServices();
                BindUltrasoundServices();

                string BillNo = Request.QueryString["BillNo"];

                if (!string.IsNullOrEmpty(BillNo))
                {
                    LoadBillDetails(BillNo);
                    ddlRoomType.Enabled = chkPackage.Checked;
                    if (!chkPackage.Checked)
                    {
                        txtRoomCharges.Text = "0";
                        ddlRoomType.SelectedIndex = 0;
                    }
                }
                else
                {
                    txtBillNo.Text = GenerateUniqueID();
                    txtBillingDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtBillingTime.Text = DateTime.Now.ToString("HH:mm:ss");
                    ddlRoomType.Enabled = chkPackage.Checked;
                    FetchAndFillData();
                }

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
        private string GenerateUniqueID()
        {
            string id;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(BillNo), 0) + 1  FROM InPatientBilling";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                id = cmd.ExecuteScalar().ToString();
                conn.Close();
            }

            return id;
        }
        private void LoadBillDetails(string billNo)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                // Corrected query with proper field names and syntax
                string query = @"
            SELECT b.*, p.Reg, p.AdmDate, p.Gender, p.Mobile, p.AdmTime, 
                   p.AgeNum, p.City, p.PatientName, p.Room, p.ConsultantName, p.Num,a.Amount
            FROM InPatientBilling b
            JOIN patient p ON b.SerialNo = p.serialno
            JOIN AdvanceHistory a ON p.serialno=a.SerialNo
            WHERE b.BillNo = @BillNo";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@BillNo", billNo);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {

                        // ===== Billing Information =====
                        txtBillNo.Text = reader["BillNo"].ToString();

                        // Billing Date/Time
                        txtBillingDate.Text = reader["BillingDate"] is DBNull ?
                            string.Empty :
                            Convert.ToDateTime(reader["BillingDate"]).ToString("yyyy-MM-dd");
                        txtBillingTime.Text = reader["BillingTime"] is DBNull ?
                            string.Empty :
                            ((TimeSpan)reader["BillingTime"]).ToString(@"hh\:mm");

                        txtSerialNo.Text = reader["SerialNo"].ToString();

                        // Checkboxes
                        chkPackage.Checked = reader["PackageCheckbox"] != DBNull.Value &&
                                           Convert.ToBoolean(reader["PackageCheckbox"]);
                        chkDischarge.Checked = reader["DischargeCheckbox"] != DBNull.Value &&
                                             Convert.ToBoolean(reader["DischargeCheckbox"]);

                        // Numeric fields
                        txtRoomCharges.Text = reader["RoomCharges"].ToString();
                        txtXRay.Text = reader["XRay"].ToString();
                        txtMedicalServices.Text = reader["MedicalServices"].ToString();
                        txtMisc.Text = reader["Misc"].ToString();
                        TextBox1.Text = reader["Consultant"].ToString();
                        txtUltrasound.Text = reader["Ultrasound"].ToString();
                        txtTotalHospitalCharges.Text = reader["TotalHospitalCharges"].ToString();
                        txtTotalConsultantCharges.Text = reader["TotalConsultantCharges"].ToString();
                        txtSPD.Text = reader["SPD"].ToString();
                        txtZF.Text = reader["ZF"].ToString();

                        // Discharge Date/Time with improved parsing
                        if (reader["DischargeDate"] != DBNull.Value)
                        {
                            DateTime dischargeDate;
                            if (DateTime.TryParse(reader["DischargeDate"].ToString(), out dischargeDate))
                            {
                                txtDischargeDate.Text = dischargeDate.ToString("dd/MM/yyyy");
                            }
                        }
                        else
                        {
                            txtDischargeDate.Text = string.Empty;
                        }

                        txtDischargeTime.Text = reader["DischargeTime"] is DBNull ?
                            string.Empty :
                            ((TimeSpan)reader["DischargeTime"]).ToString(@"hh\:mm");

                        // Other billing fields
                        txtRemarks.Text = reader["Remarks"].ToString();
                        txtBillTotalCharges.Text = reader["BillTotalCharges"].ToString();
                        txtDepositedAmount.Text = reader["DepositedAmount"].ToString();
                        txtDiscount.Text = reader["Discount"].ToString();
                        txtToBeRefunded.Text = reader["ToBeRefunded"].ToString();
                        txtNetBalance.Text = reader["NetBalance"].ToString();

                        // ===== Patient Information =====
                        txtReg.Text = reader["Reg"].ToString();
                        txtNo.Text = reader["Num"].ToString();

                        // Admission Date/Time
                        txtAdmDate.Text = reader["AdmDate"] is DBNull ?
                            string.Empty :
                            Convert.ToDateTime(reader["AdmDate"]).ToString("dd/MM/yyyy");
                        txtAdmTime.Text = reader["AdmTime"] is DBNull ?
                            string.Empty :
                            ((TimeSpan)reader["AdmTime"]).ToString(@"hh\:mm");

                        // Patient Details
                        txtGender.Text = reader["Gender"].ToString();
                        txtMobile.Text = reader["Mobile"].ToString();
                        txtAdvancePaid.Text = reader["Amount"].ToString();
                        // Age (combining AgeNum and AgeValue)
                        txtAge.Text = reader["AgeNum"].ToString();
                        txtCityName.Text = reader["City"].ToString();
                        txtPatientName.Text = reader["PatientName"].ToString();
                        txtRoom.Text = reader["Room"].ToString();
                        txtConsultant.Text = reader["ConsultantName"].ToString();
                    }

                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error loading details: " + ex.Message;
                    lblErr.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
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
                        string query = @"
    SELECT 
p.SerialNo,
        p.AdmDate, 
        p.AdmTime,  
        p.PatientName, 
        p.Room, 
        p.Gender, 
        p.AgeNum, 
        p.ConsultantName, 
       c.ConsultantCharges,
        p.City, 
       
        p.Mobile, 
    
        d.Dstatus AS DischargeStatus, 
        d.Ddate AS DischargeDate, 
        d.Dtime AS DischargeTime,
        a.Amount AS AdvanceAmount
       
      
    FROM patient p
   
    LEFT JOIN Discharge d ON p.serialno = d.SerialNo
LEFT JOIN Consultants c ON p.ConsultantName = c.ConsultantName  
LEFT JOIN AdvanceHistory a ON p.serialno=a.SerialNo
    WHERE p.Reg = @Reg AND p.Num = @Num";

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

                            string DisDateString = reader["DischargeDate"].ToString();
                            DateTime disDate;


                            if (DateTime.TryParse(DisDateString, out disDate))
                            {
                                txtDischargeDate.Text = disDate.ToString(outputDateFormat);
                            }
                            txtSerialNo.Text = reader["SerialNo"].ToString();
                            txtAdmTime.Text = reader["AdmTime"].ToString();
                            txtPatientName.Text = reader["PatientName"].ToString();
                            TextBox1.Text = reader["ConsultantCharges"].ToString();
                            txtRoom.Text = reader["Room"].ToString();
                            txtGender.Text = reader["Gender"].ToString();
                            txtAge.Text = reader["AgeNum"].ToString();
                            txtConsultant.Text = reader["ConsultantName"].ToString();

                            txtCityName.Text = reader["City"].ToString();
                            txtAdvancePaid.Text = reader["AdvanceAmount"].ToString();
                            txtMobile.Text = reader["Mobile"].ToString();

                            if (reader["DischargeStatus"].ToString() == "Y")
                            {
                                chkDischarge.Checked = true;
                            }
                            else
                            {
                                chkDischarge.Checked = false;
                            }

                            txtDischargeTime.Text = reader["DischargeTime"].ToString();

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
        protected void chkPackage_CheckedChanged(object sender, EventArgs e)
        {
            // If the checkbox is checked, disable the dropdown (readonly behavior)
            ddlRoomType.Enabled = chkPackage.Checked;
            if (!chkPackage.Checked)
            {
                txtRoomCharges.Text = "0";
                ddlRoomType.SelectedIndex = 0;
            }


        }
        protected void ddlRoomType_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Initialize a variable to store the charges based on the selected room type
            decimal roomCharges = 0;

            // Check the selected room type and set the corresponding charges
            switch (ddlRoomType.SelectedValue)
            {
                case "Standard":
                    roomCharges = 1000; // Example charge for Standard room
                    break;
                case "Deluxe":
                    roomCharges = 1500; // Example charge for Deluxe room
                    break;
                case "Basic":
                    roomCharges = 800; // Example charge for Basic room
                    break;
                case "Economy":
                    roomCharges = 500; // Example charge for Economy room
                    break;
                case "Premium":
                    roomCharges = 2000; // Example charge for Premium room
                    break;
                default:
                    roomCharges = 0;
                    break;
            }

            // Set the charges to the textbox
            txtRoomCharges.Text = roomCharges.ToString(); // Displaying the charges in currency format
        }
        protected void BSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        string employeeName = Session["Name"]?.ToString();

                        if (string.IsNullOrEmpty(employeeName))
                        {
                            throw new Exception("Employee name not found in session. Please login again.");
                        }

                        string serialNo = txtSerialNo.Text.Trim();

                        // Helper function to safely convert string to decimal
                        decimal SafeConvertToDecimal(string value)
                        {
                            return decimal.TryParse(value, out decimal result) ? result : 0;
                        }

                        // Helper function to parse time from different input types
                        TimeSpan ParseTime(string timeString)
                        {
                            if (string.IsNullOrWhiteSpace(timeString)) return TimeSpan.Zero;

                            // Try parsing as TimeSpan directly (for HTML5 time input)
                            if (TimeSpan.TryParse(timeString, out TimeSpan result))
                                return result;

                            // Try parsing as DateTime and extract time (for text inputs)
                            if (DateTime.TryParse(timeString, out DateTime timeAsDate))
                                return timeAsDate.TimeOfDay;

                            return TimeSpan.Zero;
                        }

                        // Helper function to parse date from different input types
                        DateTime? ParseDate(string dateString)
                        {
                            if (string.IsNullOrWhiteSpace(dateString)) return null;

                            // Try parsing as DateTime (works for both HTML5 date input and text inputs)
                            if (DateTime.TryParse(dateString, out DateTime result))
                                return result.Date;

                            return null;
                        }

                        // Check if the BillNo exists in the InPatientBilling table
                        string checkBillQuery = "SELECT COUNT(1) FROM InPatientBilling WHERE BillNo = @BillNo";
                        SqlCommand checkBillCmd = new SqlCommand(checkBillQuery, conn);
                        checkBillCmd.Parameters.AddWithValue("@BillNo", txtBillNo.Text.Trim());

                        int billCount = Convert.ToInt32(checkBillCmd.ExecuteScalar());

                        if (billCount > 0)
                        {
                            // Bill exists, perform UPDATE
                            string updateQuery = @"
                    UPDATE InPatientBilling
                    SET 
                        BillingDate = @BillingDate, 
                        BillingTime = @BillingTime, 
                        SerialNo = @SerialNo, 
                        PackageCheckbox = @PackageCheckbox, 
                        PackageList = @PackageList, 
                        RoomCharges = @RoomCharges, 
                        XRay = @XRay, 
                        MedicalServices = @MedicalServices, 
                        Misc = @Misc, 
                        Consultant = @Consultant, 
                        Ultrasound = @Ultrasound, 
                        TotalHospitalCharges = @TotalHospitalCharges, 
                        TotalConsultantCharges = @TotalConsultantCharges, 
                        SPD = @SPD, 
                        ZF = @ZF, 
                        DischargeCheckbox = @DischargeCheckbox, 
                        DischargeDate = @DischargeDate, 
                        DischargeTime = @DischargeTime, 
                        Remarks = @Remarks, 
                        BillTotalCharges = @BillTotalCharges, 
                        DepositedAmount = @DepositedAmount, 
                        Discount = @Discount, 
                        ToBeRefunded = @ToBeRefunded, 
                        NetBalance = @NetBalance
                    WHERE BillNo = @BillNo";

                            SqlCommand updateCmd = new SqlCommand(updateQuery, conn);


                            // Billing Date (HTML5 date input)
                            var billingDate = ParseDate(txtBillingDate.Text.Trim());
                            updateCmd.Parameters.AddWithValue("@BillingDate", billingDate ?? (object)DBNull.Value);
                            updateCmd.Parameters.AddWithValue("@BillNo", txtBillNo.Text.Trim());

                            // Billing Time (HTML5 time input)
                            updateCmd.Parameters.AddWithValue("@BillingTime", ParseTime(txtBillingTime.Text.Trim()));

                            // Other fields
                            updateCmd.Parameters.AddWithValue("@SerialNo", txtSerialNo.Text.Trim());
                            updateCmd.Parameters.AddWithValue("@PackageCheckbox", chkPackage.Checked);

                            // Numeric fields
                            updateCmd.Parameters.AddWithValue("@PackageList", ddlRoomType.SelectedValue);
                            updateCmd.Parameters.AddWithValue("@RoomCharges", SafeConvertToDecimal(txtRoomCharges.Text));
                            updateCmd.Parameters.AddWithValue("@XRay", SafeConvertToDecimal(txtXRay.Text));
                            updateCmd.Parameters.AddWithValue("@MedicalServices", SafeConvertToDecimal(txtMedicalServices.Text));
                            updateCmd.Parameters.AddWithValue("@Misc", SafeConvertToDecimal(txtMisc.Text));
                            updateCmd.Parameters.AddWithValue("@Consultant", SafeConvertToDecimal(TextBox1.Text));
                            updateCmd.Parameters.AddWithValue("@Ultrasound", SafeConvertToDecimal(txtUltrasound.Text));
                            updateCmd.Parameters.AddWithValue("@TotalHospitalCharges", SafeConvertToDecimal(txtTotalHospitalCharges.Text));
                            updateCmd.Parameters.AddWithValue("@TotalConsultantCharges", SafeConvertToDecimal(txtTotalConsultantCharges.Text));
                            updateCmd.Parameters.AddWithValue("@SPD", SafeConvertToDecimal(txtSPD.Text));
                            updateCmd.Parameters.AddWithValue("@ZF", SafeConvertToDecimal(txtZF.Text));
                            updateCmd.Parameters.AddWithValue("@DischargeCheckbox", chkDischarge.Checked);

                            DateTime dischargeDate;
                            try
                            {
                                dischargeDate = DateTime.ParseExact(txtDischargeDate.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                                updateCmd.Parameters.AddWithValue("@DischargeDate", dischargeDate);
                            }
                            catch (FormatException)
                            {
                                // Handle invalid date format if needed
                                updateCmd.Parameters.AddWithValue("@DischargeDate", DBNull.Value);
                            }


                            // Discharge Time (regular text input)
                            updateCmd.Parameters.AddWithValue("@DischargeTime", ParseTime(txtDischargeTime.Text.Trim()));

                            updateCmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                            updateCmd.Parameters.AddWithValue("@BillTotalCharges", SafeConvertToDecimal(txtBillTotalCharges.Text));
                            updateCmd.Parameters.AddWithValue("@DepositedAmount", SafeConvertToDecimal(txtDepositedAmount.Text));
                            updateCmd.Parameters.AddWithValue("@Discount", SafeConvertToDecimal(txtDiscount.Text));
                            updateCmd.Parameters.AddWithValue("@ToBeRefunded", SafeConvertToDecimal(txtToBeRefunded.Text));
                            updateCmd.Parameters.AddWithValue("@NetBalance", SafeConvertToDecimal(txtNetBalance.Text));

                            updateCmd.ExecuteNonQuery();
                            lblErr.Text = "Billing record updated successfully.";
                        }
                        else
                        {
                            // Bill doesn't exist, perform INSERT
                            string insertQuery = @"
                    INSERT INTO InPatientBilling 
                    (BillingDate, BillingTime, SerialNo, PackageCheckbox, PackageList, RoomCharges, 
                     XRay, MedicalServices, Misc, Consultant, Ultrasound, TotalHospitalCharges, 
                     TotalConsultantCharges, SPD, ZF, DischargeCheckbox, DischargeDate, DischargeTime, 
                     Remarks, BillTotalCharges, DepositedAmount, Discount, ToBeRefunded, NetBalance) 
                    VALUES 
                    (@BillingDate, @BillingTime, @SerialNo, @PackageCheckbox, @PackageList, @RoomCharges, 
                     @XRay, @MedicalServices, @Misc, @Consultant, @Ultrasound, @TotalHospitalCharges, 
                     @TotalConsultantCharges, @SPD, @ZF, @DischargeCheckbox, @DischargeDate, @DischargeTime, 
                     @Remarks, @BillTotalCharges, @DepositedAmount, @Discount, @ToBeRefunded, @NetBalance)";

                            SqlCommand insertCmd = new SqlCommand(insertQuery, conn);


                            // Billing Date (HTML5 date input)
                            var billingDate = ParseDate(txtBillingDate.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@BillingDate", billingDate ?? (object)DBNull.Value);

                            // Billing Time (HTML5 time input)
                            insertCmd.Parameters.AddWithValue("@BillingTime", ParseTime(txtBillingTime.Text.Trim()));

                            // Other fields
                            insertCmd.Parameters.AddWithValue("@SerialNo", txtSerialNo.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@PackageCheckbox", chkPackage.Checked);
                            insertCmd.Parameters.AddWithValue("@PackageList", ddlRoomType.SelectedValue);
                            insertCmd.Parameters.AddWithValue("@RoomCharges", SafeConvertToDecimal(txtRoomCharges.Text));
                            insertCmd.Parameters.AddWithValue("@XRay", SafeConvertToDecimal(txtXRay.Text));
                            insertCmd.Parameters.AddWithValue("@MedicalServices", SafeConvertToDecimal(txtMedicalServices.Text));
                            insertCmd.Parameters.AddWithValue("@Misc", SafeConvertToDecimal(txtMisc.Text));
                            insertCmd.Parameters.AddWithValue("@Consultant", TextBox1.Text);
                            insertCmd.Parameters.AddWithValue("@Ultrasound", SafeConvertToDecimal(txtUltrasound.Text));
                            insertCmd.Parameters.AddWithValue("@TotalHospitalCharges", SafeConvertToDecimal(txtTotalHospitalCharges.Text));
                            insertCmd.Parameters.AddWithValue("@TotalConsultantCharges", SafeConvertToDecimal(txtTotalConsultantCharges.Text));
                            insertCmd.Parameters.AddWithValue("@SPD", SafeConvertToDecimal(txtSPD.Text));
                            insertCmd.Parameters.AddWithValue("@ZF", SafeConvertToDecimal(txtZF.Text));
                            insertCmd.Parameters.AddWithValue("@DischargeCheckbox", chkDischarge.Checked);

                            // Discharge Date (regular text input)
                            DateTime dischargeDate;
                            try
                            {
                                dischargeDate = DateTime.ParseExact(txtDischargeDate.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                                insertCmd.Parameters.AddWithValue("@DischargeDate", dischargeDate);
                            }
                            catch (FormatException)
                            {
                                // Handle invalid date format if needed
                                insertCmd.Parameters.AddWithValue("@DischargeDate", DBNull.Value);
                            }


                            // Discharge Time (regular text input)
                            insertCmd.Parameters.AddWithValue("@DischargeTime", ParseTime(txtDischargeTime.Text.Trim()));

                            insertCmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@BillTotalCharges", SafeConvertToDecimal(txtBillTotalCharges.Text));
                            insertCmd.Parameters.AddWithValue("@DepositedAmount", SafeConvertToDecimal(txtDepositedAmount.Text));
                            insertCmd.Parameters.AddWithValue("@Discount", SafeConvertToDecimal(txtDiscount.Text));
                            insertCmd.Parameters.AddWithValue("@ToBeRefunded", SafeConvertToDecimal(txtToBeRefunded.Text));
                            insertCmd.Parameters.AddWithValue("@NetBalance", SafeConvertToDecimal(txtNetBalance.Text));

                            insertCmd.ExecuteNonQuery();
                            lblErr.Text = "Billing record added successfully.";
                        }
                        string employeeBillQuery = @"
                    MERGE INTO Bill_By_Employee AS target
                    USING (SELECT @SerialNo AS SerialNo, @EmpName AS EmpName) AS source
                    ON target.SerialNo = source.SerialNo
                    WHEN MATCHED THEN
                        UPDATE SET EmpName = source.EmpName
                    WHEN NOT MATCHED THEN
                        INSERT (SerialNo, EmpName) VALUES (source.SerialNo, source.EmpName);";

                        SqlCommand employeeBillCmd = new SqlCommand(employeeBillQuery, conn);
                        employeeBillCmd.Parameters.AddWithValue("@SerialNo", serialNo);
                        employeeBillCmd.Parameters.AddWithValue("@EmpName", employeeName);
                        employeeBillCmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                    lblErr.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
        protected void BClear_Click(object sender, EventArgs e)
        {

            txtSerialNo.Text = string.Empty;
            txtRoomCharges.Text = string.Empty;
            txtXRay.Text = string.Empty;
            txtMedicalServices.Text = string.Empty;
            txtMisc.Text = string.Empty;
            TextBox1.Text = string.Empty;
            txtUltrasound.Text = string.Empty;
            txtTotalHospitalCharges.Text = string.Empty;
            txtTotalConsultantCharges.Text = string.Empty;
            txtSPD.Text = string.Empty;
            txtZF.Text = string.Empty;
            txtDischargeDate.Text = string.Empty;
            txtDischargeTime.Text = string.Empty;
            txtRemarks.Text = string.Empty;
            txtBillTotalCharges.Text = string.Empty;
            txtDepositedAmount.Text = string.Empty;
            txtDiscount.Text = string.Empty;
            txtToBeRefunded.Text = string.Empty;
            txtNetBalance.Text = string.Empty;

            // Clear checkboxes
            chkPackage.Checked = false;
            chkDischarge.Checked = false;

            // Reset dropdowns
            ddlRoomType.SelectedIndex = 0; // or set to default value if required

            txtReg.Text = string.Empty;
            txtNo.Text = string.Empty;
            txtAdmDate.Text = string.Empty;
            txtAdmTime.Text = string.Empty;
            txtGender.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtAdvancePaid.Text = string.Empty;
            txtAge.Text = string.Empty;
            txtCityName.Text = string.Empty;
            txtPatientName.Text = string.Empty;
            txtRoom.Text = string.Empty;
            txtConsultant.Text = string.Empty;
        }
        private void BindMedServices()
        {
            BindCheckboxList(chkMedChecklist, "SELECT TestName, Charges FROM [dbo].[IPD_MedServices]");
        }

        private void BindXRayServices()
        {
            BindCheckboxList(chkXrayChecklist, "SELECT TestName, Charges FROM [dbo].[IN_Xray]");
        }

        private void BindDentalServices()
        {
            BindCheckboxList(chkListDental, "SELECT TestName, Charges FROM [dbo].[IN_Dental]");
        }

        private void BindUltrasoundServices()
        {
            BindCheckboxList(chkListUltrasound, "SELECT TestName, Charges FROM [dbo].[IPD_Ultrasound]");
        }

        // Generic method to bind any checkbox list
        private void BindCheckboxList(CheckBoxList listControl, string query)
        {

            listControl.Items.Clear();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        string displayText = reader[0].ToString(); // First column (TestName/ServiceName)
                        string value = reader["Charges"].ToString();
                        listControl.Items.Add(new ListItem(displayText, value));
                    }
                }
                reader.Close();
            }
        }
        private decimal GetAdvanceAmountBySerialNo(string serialNo)
        {
            decimal advanceAmount = 0;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(SUM(Amount), 0) FROM AdvanceHistory WHERE SerialNo = @SerialNo";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SerialNo", serialNo);

                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    advanceAmount = Convert.ToDecimal(result);
                }
            }

            return advanceAmount;
        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            decimal totalHospitalCharges = 0;
            decimal totalConsultantCharges = 0;

            // Calculate charges for X-ray tests
            CalculateChargesFromSelectedTests(chkXrayChecklist, "IN_Xray", ref totalHospitalCharges, ref totalConsultantCharges);

            // Calculate charges for Ultrasound tests
            CalculateChargesFromSelectedTests1(chkListUltrasound, "IPD_Ultrasound", ref totalHospitalCharges, ref totalConsultantCharges);

            // Calculate charges for MedServices tests
            CalculateChargesFromSelectedTests2(chkMedChecklist, "IPD_MedServices", ref totalHospitalCharges, ref totalConsultantCharges);

            // Calculate charges for Dental tests
            CalculateChargesFromSelectedTests3(chkListDental, "IN_Dental", ref totalHospitalCharges, ref totalConsultantCharges);
            CalculateConsultantAndHospitalShareForPatient(ref totalHospitalCharges, ref totalConsultantCharges);

            decimal roomCharges = 0, miscCharges = 0;
            decimal.TryParse(txtRoomCharges.Text, out roomCharges);
            decimal.TryParse(txtMisc.Text, out miscCharges);

            totalHospitalCharges += roomCharges + miscCharges;
            // Update the totals on the page
            txtTotalHospitalCharges.Text = totalHospitalCharges.ToString();
            txtTotalConsultantCharges.Text = totalConsultantCharges.ToString();

            decimal zf = 0, spd = 0;


            decimal.TryParse(txtZF.Text, out zf);
            decimal.TryParse(txtSPD.Text, out spd);
            string serialNo = txtSerialNo.Text.Trim();
            decimal advanceAmount = GetAdvanceAmountBySerialNo(serialNo);
            txtBillTotalCharges.Text = ((totalHospitalCharges + totalConsultantCharges) - (advanceAmount + zf + spd)).ToString();


        }

        private void CalculateChargesFromSelectedTests(CheckBoxList chkList, string tableName, ref decimal totalHospitalCharges, ref decimal totalConsultantCharges)
        {
            foreach (ListItem item in chkList.Items)
            {
                if (item.Selected)
                {
                    string testName = item.Text;

                    // Fetch the ConsultantShare and HospitalShare from the database
                    CalculateChargesFromSelectedTest(
                        tableName: tableName,
                        testName: testName,
                        amount: Convert.ToDecimal(txtXRay.Text), // The total amount for this test
                        ref totalHospitalCharges,
                        ref totalConsultantCharges
                    );
                }
            }
        }

        private void CalculateChargesFromSelectedTests1(CheckBoxList chkList, string tableName, ref decimal totalHospitalCharges, ref decimal totalConsultantCharges)
        {
            foreach (ListItem item in chkList.Items)
            {
                if (item.Selected)
                {
                    string testName = item.Text;

                    // Fetch the ConsultantShare and HospitalShare from the database
                    CalculateChargesFromSelectedTest(
                        tableName: tableName,
                        testName: testName,
                        amount: Convert.ToDecimal(txtUltrasound.Text), // The total amount for this test
                        ref totalHospitalCharges,
                        ref totalConsultantCharges
                    );
                }
            }
        }

        private void CalculateChargesFromSelectedTests2(CheckBoxList chkList, string tableName, ref decimal totalHospitalCharges, ref decimal totalConsultantCharges)
        {
            foreach (ListItem item in chkList.Items)
            {
                if (item.Selected)
                {
                    string testName = item.Text;

                    // Fetch the ConsultantShare and HospitalShare from the database
                    CalculateChargesFromSelectedTest(
                        tableName: tableName,
                        testName: testName,
                        amount: Convert.ToDecimal(txtMedicalServices.Text), // The total amount for this test
                        ref totalHospitalCharges,
                        ref totalConsultantCharges
                    );
                }
            }
        }

        private void CalculateChargesFromSelectedTests3(CheckBoxList chkList, string tableName, ref decimal totalHospitalCharges, ref decimal totalConsultantCharges)
        {
            foreach (ListItem item in chkList.Items)
            {
                if (item.Selected)
                {
                    string testName = item.Text;

                    // Fetch the ConsultantShare and HospitalShare from the database
                    CalculateChargesFromSelectedTest(
                        tableName: tableName,
                        testName: testName,
                        amount: Convert.ToDecimal(txtDental.Text), // The total amount for this test
                        ref totalHospitalCharges,
                        ref totalConsultantCharges
                    );
                }
            }
        }

        private void CalculateChargesFromSelectedTest(string tableName, string testName, decimal amount, ref decimal totalHospitalCharges, ref decimal totalConsultantCharges)
        {
            string query = $@"SELECT TOP 1 ConsultantShare, HospitalShare 
                      FROM [HMS].[dbo].[{tableName}]
                      WHERE TestName = @TestName";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@TestName", testName);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        decimal consultantShare = reader.GetDecimal(0);
                        decimal hospitalShare = reader.GetDecimal(1);

                        totalConsultantCharges += amount * (consultantShare / 100); // Consultant share is in percentage
                        totalHospitalCharges += amount * (hospitalShare / 100);   // Hospital share is in percentage
                    }
                }
            }
        }

        private void CalculateConsultantAndHospitalShareForPatient(ref decimal totalHospitalCharges, ref decimal totalConsultantCharges)
        {
            // Get the serialno from the textbox
            string serialno = txtSerialNo.Text.Trim();

            // Query to fetch ConsultantName for the given serialno
            string query = $@"SELECT ConsultantName 
                      FROM [HMS].[dbo].[patient] 
                      WHERE SerialNo = @SerialNo";

            string consultantName = string.Empty;

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@SerialNo", serialno);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        consultantName = reader.GetString(0); // Fetch the ConsultantName for the patient
                    }
                }
            }


            decimal grossAmount = 0;
            if (!decimal.TryParse(TextBox1.Text.Trim(), out grossAmount))
            {
                // Handle invalid input here if needed
                grossAmount = 0;
            }

            query = @"SELECT ConsultantShareIndoor, HospitalShareIndoor 
              FROM [HMS].[dbo].[Consultants] 
              WHERE ConsultantName = @ConsultantName";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ConsultantName", consultantName);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        decimal consultantShareIndoor = reader.GetDecimal(0); // % consultant share
                        decimal hospitalShareIndoor = reader.GetDecimal(1);   // % hospital share

                        decimal consultantAmount = (grossAmount * consultantShareIndoor) / 100;
                        decimal hospitalAmount = (grossAmount * hospitalShareIndoor) / 100;

                        totalConsultantCharges += consultantAmount;
                        totalHospitalCharges += hospitalAmount;
                    }
                }
            }
        }

        protected void CalculateNetAndRefund(object sender, EventArgs e)
        {
            decimal totalBill = 0;
            decimal deposited = 0;
            decimal discountPercent = 0;

            // Try parsing values safely
            decimal.TryParse(txtBillTotalCharges.Text, out totalBill);
            decimal.TryParse(txtDepositedAmount.Text, out deposited);
            decimal.TryParse(txtDiscount.Text, out discountPercent);

            // Convert percentage to amount
            decimal discountAmount = (discountPercent / 100m) * totalBill;

            // Calculate total paid (deposited + discount)
            decimal paid = deposited + discountAmount;

            // Calculate Net Balance and To Be Refunded
            decimal netBalance = totalBill - paid;
            decimal toBeRefunded = paid - totalBill;

            // Set the results
            txtNetBalance.Text = netBalance > 0 ? netBalance.ToString() : "0.00";
            txtToBeRefunded.Text = toBeRefunded > 0 ? toBeRefunded.ToString() : "0.00";
        }


    }
}
