using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace HMS_Task3
{
    public partial class InPatientSummary : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchAndFillData();
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
                        string query = @"
                    SELECT 
                        p.AdmDate, 
                        p.AdmTime,  
                        p.PatientName, 
                        p.Relation, 
                        p.RelationName, 
                        p.Room, 
                        p.Gender, 
                        p.AgeNum, 
                        p.ConsultantName, 
                        p.Address, 
                        p.AreaName, 
                        p.City, 
                        p.OtherContact, 
                        p.Email, 
                        p.Mobile, 
                        p.Emergency,
                        d.Dstatus AS DischargeStatus, 
                        d.Ddate AS DischargeDate, 
                        d.Dtime AS DischargeTime,
                        i.BillingDate, 
                        i.BillingTime, 
                        i.BillTotalCharges, 
                        i.DepositedAmount, 
                        i.Discount, 
                        i.ToBeRefunded, 
                        i.NetBalance,
                        i.Remarks,
                        a.Amount AS AdvanceAmount,
                        b.EmpName
                    FROM patient p
                    LEFT JOIN Discharge d ON p.serialno = d.SerialNo
                    LEFT JOIN InPatientBilling i ON p.serialno = i.SerialNo
LEFT JOIN Bill_By_Employee b ON i.SerialNo = b.SerialNo
                    LEFT JOIN Consultants c ON p.ConsultantName = c.ConsultantName
                    LEFT JOIN AdvanceHistory a ON p.serialno = a.SerialNo
                    WHERE p.Reg = @Reg AND p.Num = @Num";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Reg", txtReg.Text);
                            cmd.Parameters.AddWithValue("@Num", txtNo.Text);

                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    string outputDateFormat = "dd/MM/yyyy";

                                    if (DateTime.TryParse(reader["AdmDate"]?.ToString(), out DateTime admDate))
                                        txtAdmDate.Text = admDate.ToString(outputDateFormat);

                                    if (DateTime.TryParse(reader["DischargeDate"]?.ToString(), out DateTime ddate))
                                        txtDate.Text = ddate.ToString(outputDateFormat);

                                    if (DateTime.TryParse(reader["BillingDate"]?.ToString(), out DateTime bdate))
                                    {
                                        txtBillingDate.Text = bdate.ToString(outputDateFormat);
                                        txtRDate.Text = bdate.ToString(outputDateFormat);
                                        txtNetDate.Text = bdate.ToString(outputDateFormat);
                                    }

                                    txtAdmTime.Text = reader["AdmTime"]?.ToString();
                                    txtPatientName.Text = reader["PatientName"]?.ToString();
                                    txtRelation.Text = reader["Relation"]?.ToString();
                                    txtRelationName.Text = reader["RelationName"]?.ToString();
                                    txtRoom.Text = reader["Room"]?.ToString();
                                    txtGender.Text = reader["Gender"]?.ToString();
                                    txtAge.Text = reader["AgeNum"]?.ToString();
                                    txtConsultant.Text = reader["ConsultantName"]?.ToString();
                                    txtAddress.Text = reader["Address"]?.ToString();
                                    txtAreaName.Text = reader["AreaName"]?.ToString();
                                    txtCityName.Text = reader["City"]?.ToString();
                                    txtCont1.Text = reader["OtherContact"]?.ToString();
                                    txtCont2.Text = reader["Email"]?.ToString();
                                    txtMobile.Text = reader["Mobile"]?.ToString();
                                    txtEmergency.Text = reader["Emergency"]?.ToString();
                                    txtDischarge.Text = reader["DischargeStatus"]?.ToString();
                                    txtTime.Text = reader["DischargeTime"]?.ToString();
                                    txtBilling.Text = "Y";
                                    txtBillingTime.Text = reader["BillingTime"]?.ToString();
                                    txtFinalSettlement.Text = "Y";
                                    txtFDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                                    txtFTime.Text = DateTime.Now.ToString("HH:mm:ss");
                                    txtTotalCharges.Text = reader["BillTotalCharges"] != DBNull.Value ? reader["BillTotalCharges"].ToString() : "";
                                    txtDepositedAmount.Text = reader["DepositedAmount"] != DBNull.Value ? reader["DepositedAmount"].ToString() : "";
                                    txtDiscount.Text = reader["Discount"] != DBNull.Value ? reader["Discount"].ToString() : "";
                                    txtRAmount.Text = reader["ToBeRefunded"] != DBNull.Value ? reader["ToBeRefunded"].ToString() : "";
                                    txtNAmount.Text = reader["NetBalance"] != DBNull.Value ? reader["NetBalance"].ToString() : "";
                                    txtAdvpay.Text = reader["AdvanceAmount"] != DBNull.Value ? reader["AdvanceAmount"].ToString() : "";
                                    txtRemarks.Text = reader["Remarks"]?.ToString();
                                    txtEmployeeName.Text = reader["EmpName"]?.ToString();
                                    txtAction.Text = "Created";
                                    decimal rAmount = 0;
                                    decimal nAmount = 0;

                                    if (decimal.TryParse(txtRAmount.Text, out rAmount) && rAmount > 0)
                                    {
                                        txtRefund.Text = "Y";
                                    }
                                    else
                                    {
                                        txtRefund.Text = "N";
                                    }

                                    if (decimal.TryParse(txtNAmount.Text, out nAmount) && nAmount > 0)
                                    {
                                        txtNetBalance.Text = "Y";
                                    }
                                    else
                                    {
                                        txtNetBalance.Text = "N";
                                    }
                                }
                                else
                                {
                                    lblErr.Text = "No records found.";
                                }
                            }
                            conn.Close();
                        }
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