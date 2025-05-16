using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class AddRefund : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetRefundDateTime();
                ToggleRefundFields(false);
            }
        }

        protected void txtSerialNo_TextChanged(object sender, EventArgs e)
        {
            string serialNo = txtSerialNo.Text.Trim();

            if (serialNo.Length > 0)
            {
                string query = @"SELECT p.*, 
                                p.Reg AS Reg,
                                p.Num AS Num,
                                b.Bdate AS BillingDate, 
                                b.Btime AS BillingTime, 
                                p.Typee AS Typee,
                                p.ConsultantName AS ConsultantName,
                                p.PatientName AS PatientName,
                                p.AdmDate AS AdmDate,
                                p.AdmTime AS AdmTime,
                                p.Gender AS Gender,
                                p.Room AS Room,
                                rp.TotalCharges, 
                                rp.DepositedAmount, 
                                rp.Discount, 
                                rp.ToBeRefunded, 
                                rp.NetBalance,
                                r.RecPersonName AS ReceivingPersonName, 
                                r.RelationWpatient AS RelationWithPatient
                        FROM patient p
                        LEFT JOIN Billing b ON p.serialno = b.SerialNo
                        LEFT JOIN Refund r ON p.serialno = r.SerialNo
                        LEFT JOIN RefPaymentStatus rp ON r.RNo = rp.RNo
                        WHERE p.SerialNo = @SerialNo";

                try
                {
                    using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString))
                    {
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@SerialNo", serialNo);

                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // Populate the fields with the retrieved data
                            txtReg.Text = reader["Reg"]?.ToString();
                            txtNum.Text = reader["Num"]?.ToString();
                            txtBillingDate.Text = reader["BillingDate"]?.ToString();
                            txtTime.Text = reader["BillingTime"]?.ToString();
                            txtType.Text = reader["Typee"]?.ToString();
                            txtConsultant.Text = reader["ConsultantName"]?.ToString();
                            txtPatientName.Text = reader["PatientName"]?.ToString();
                            txtAdmDate.Text = reader["AdmDate"]?.ToString();
                            txtAdmTime.Text = reader["AdmTime"]?.ToString();
                            txtGender.Text = reader["Gender"]?.ToString();
                            txtRoom.Text = reader["Room"]?.ToString();
                            txtTotalCharges.Text = reader["TotalCharges"]?.ToString();
                            txtDepositedAmount.Text = reader["DepositedAmount"]?.ToString();
                            txtDiscount.Text = reader["Discount"]?.ToString();
                            txtToBeRefunded.Text = reader["ToBeRefunded"]?.ToString();
                            txtNetBalance.Text = reader["NetBalance"]?.ToString();
                        }
                        else
                        {
                            lblMessage.Text = "No patient found with this Serial number.";
                        }
                    }
                }
                catch (SqlException sqlEx)
                {
                    lblMessage.Text = "SQL Error: " + sqlEx.Message;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
            else
            {
                lblMessage.Text = "Please enter a valid Serial Number.";
            }
        }

        protected void chkRefundYN_CheckedChanged(object sender, EventArgs e)
        {
            ToggleRefundFields(chkRefundYN.Checked);

            if (chkRefundYN.Checked)
            {
                SetRefundDateTime();
            }
        }

        private void ToggleRefundFields(bool enable)
        {
            txtRefundAmount.Enabled = enable;
            txtReceivingPersonName.Enabled = enable;
            txtRelationWithPatient.Enabled = enable;
            txtContact.Enabled = enable;
            txtRemarks.Enabled = enable;
        }

        protected void SetRefundDateTime()
        {
            txtRefundDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtRefundTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string serialNo = txtSerialNo.Text;
            string RStatus = chkRefundYN.Checked ? "Y" : "N";
            string refundDate = txtRefundDate.Text;
            string refundTime = txtRefundTime.Text;
            string refundAmount = txtRefundAmount.Text;
            string receivingPersonName = txtReceivingPersonName.Text;
            string relationWithPatient = txtRelationWithPatient.Text;
            string contact = txtContact.Text;
            string remarks = txtRemarks.Text;

            if (string.IsNullOrEmpty(serialNo))
            {
                lblMessage.Text = "Serial Number is required";
                return;
            }

            bool isSaved = SaveRefundDetails(serialNo, RStatus, refundDate, refundTime, refundAmount, receivingPersonName, relationWithPatient, contact, remarks);

            if (isSaved)
            {
                lblMessage.Text = "Refund details saved successfully.";
            }
            else
            {
                lblMessage.Text = "Failed to save refund details.";
            }
        }

        private bool SaveRefundDetails(string serialNo, string RStatus, string refundDate, string refundTime, string refundAmount, string receivingPersonName, string relationWithPatient, string contact, string remarks)
        {
            try
            {
                string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Refund (SerialNo, Rstatus, Rdate, Rtime, Ramount, RecPersonName, RelationWpatient, ContactNo, Rremarks)
                                     VALUES (@SerialNo, @Rstatus, @refundDate, @refundTime, @refundAmount, @receivingPersonName, @relationWithPatient, @contact, @remarks);
                                     SELECT SCOPE_IDENTITY();";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@SerialNo", serialNo);
                    cmd.Parameters.AddWithValue("@Rstatus", RStatus);
                    cmd.Parameters.AddWithValue("@refundDate", refundDate);
                    cmd.Parameters.AddWithValue("@refundTime", refundTime);
                    cmd.Parameters.AddWithValue("@refundAmount", refundAmount);
                    cmd.Parameters.AddWithValue("@receivingPersonName", receivingPersonName);
                    cmd.Parameters.AddWithValue("@relationWithPatient", relationWithPatient);
                    cmd.Parameters.AddWithValue("@contact", contact);
                    cmd.Parameters.AddWithValue("@remarks", remarks);

                    conn.Open();
                    int result = Convert.ToInt32(cmd.ExecuteScalar());

                    return result > 0;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                return false;
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSerialNo.Text = "";
            txtReg.Text = "";
            txtNum.Text = "";
            txtBillingDate.Text = "";
            txtTime.Text = "";
            txtType.Text = "";
            txtConsultant.Text = "";
            txtPatientName.Text = "";
            txtAdmDate.Text = "";
            txtAdmTime.Text = "";
            txtGender.Text = "";
            txtRoom.Text = "";
            txtTotalCharges.Text = "";
            txtDepositedAmount.Text = "";
            txtDiscount.Text = "";
            txtToBeRefunded.Text = "";
            txtNetBalance.Text = "";
            txtRefundAmount.Text = "";
            txtReceivingPersonName.Text = "";
            txtRelationWithPatient.Text = "";
            txtContact.Text = "";
            txtRemarks.Text = "";

            hfSerialNo.Value = "";
            lblMessage.Text = "";
        }

        protected void btnExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Dashboard.aspx");
        }

    }
}