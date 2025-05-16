using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace HMS_template_Project
{
    public partial class AddConsultant : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string consultantID = Request.QueryString["ConsultantID"];

                if (!string.IsNullOrEmpty(consultantID))
                {
                    BindConsultantData(Convert.ToInt32(consultantID));
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

        protected void BSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            if (string.IsNullOrEmpty(constr))
            {
                lblErr.Text = "Connection string is not configured properly.";
                return;
            }

            string query = @"
INSERT INTO Consultants (
    ConsultantName, Degrees, Timing, Faculty, Address, Telephone, Fax, Mobile, Email, ConsultantCharges, 
    Type, ConsultantShareOutdoor, ConsultantShareIndoor, HospitalShareOutdoor, HospitalShareIndoor, OPDpaid,
    SurgeryCharges, AnesCharges
) VALUES (
    @ConsultantName, @Degrees, @Timing, @Faculty, @Address, @Telephone, @Fax, @Mobile, @Email, @ConsultantCharges,
    @Type, @ConsultantShareOutdoor, @ConsultantShareIndoor, @HospitalShareOutdoor, @HospitalShareIndoor, @OPDpaid,
    @SurgeryCharges, @AnesCharges
)";

            try
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ConsultantName", txtConsultantName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Degrees", txtDegree.Text.Trim());
                        cmd.Parameters.AddWithValue("@Timing", ""); // Not present in the form
                        cmd.Parameters.AddWithValue("@Faculty", ""); // Not present in the form
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@Telephone", txtTelephone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Fax", txtFax.Text.Trim());
                        cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@ConsultantCharges", string.IsNullOrEmpty(txtConsultantCharges.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtConsultantCharges.Text));
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);


                        // Handle values for ConsultantShareOutdoor, ConsultantShareIndoor, HospitalShareOutdoor, HospitalShareIndoor
                        cmd.Parameters.AddWithValue("@ConsultantShareOutdoor", string.IsNullOrEmpty(txtConsultantInPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtConsultantInPatient.Text));
                        cmd.Parameters.AddWithValue("@ConsultantShareIndoor", string.IsNullOrEmpty(txtConsultantOutPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtConsultantOutPatient.Text));
                        cmd.Parameters.AddWithValue("@HospitalShareOutdoor", string.IsNullOrEmpty(txtHospitalInPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtHospitalInPatient.Text));
                        cmd.Parameters.AddWithValue("@HospitalShareIndoor", string.IsNullOrEmpty(txtHospitalOutPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtHospitalOutPatient.Text));

                        // Handle optional fields
                        cmd.Parameters.AddWithValue("@OPDpaid", DBNull.Value); // Not present in the form
                        cmd.Parameters.AddWithValue("@SurgeryCharges", DBNull.Value); // Not present in the form
                        cmd.Parameters.AddWithValue("@AnesCharges", DBNull.Value); // Not present in the form

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        lblErr.Text = "Consultant information saved successfully!";
                    }
                }
            }
            catch (Exception ex)
            {
                lblErr.Text = "Error: " + ex.Message;
            }
        }

        protected void BUpdate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                UpdateConsultantData();
            }
        }

        protected void BClear_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        private void BindConsultantData(int consultantID)
        {
            // Connection string
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            if (string.IsNullOrEmpty(constr))
            {
                lblErr.Text = "Connection string is not configured properly.";
                return;
            }

            string query = "SELECT * FROM Consultants WHERE ConsultantID = @ConsultantID";

            try
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ConsultantID", consultantID);

                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            txtConsultantID.Text = reader["ConsultantID"].ToString();
                            txtConsultantName.Text = reader["ConsultantName"].ToString();
                            txtDegree.Text = reader["Degrees"].ToString();
                            txtAddress.Text = reader["Address"].ToString();
                            txtTelephone.Text = reader["Telephone"].ToString();
                            txtFax.Text = reader["Fax"].ToString();
                            txtMobile.Text = reader["Mobile"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtConsultantCharges.Text = reader["ConsultantCharges"].ToString();
                            ddlType.SelectedValue = reader["Type"].ToString();
                            txtConsultantInPatient.Text = reader["ConsultantShareIndoor"].ToString();
                            txtConsultantOutPatient.Text = reader["ConsultantShareOutdoor"].ToString();
                            txtHospitalInPatient.Text = reader["HospitalShareIndoor"].ToString();
                            txtHospitalOutPatient.Text = reader["HospitalShareOutdoor"].ToString();
                            chkDeactivate.Checked = Convert.ToBoolean(reader["OPDpaid"]);
                        }

                        con.Close();
                    }
                }
            }
            catch (Exception ex)
            {
              //  lblErr.Text = "Error: " + ex.Message;
            }
        }

        
        protected void UpdateConsultantData()
        {
            // Connection string
            string constr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            if (string.IsNullOrEmpty(constr))
            {
                lblErr.Text = "Connection string is not configured properly.";
                return;
            }

            // Query to update the consultant's data
            string query = @"
        UPDATE Consultants
        SET 
            ConsultantName = @ConsultantName,
            Degrees = @Degrees,
            Timing = @Timing,
            Faculty = @Faculty,
            Address = @Address,
            Telephone = @Telephone,
            Fax = @Fax,
            Mobile = @Mobile,
            Email = @Email,
            ConsultantCharges = @ConsultantCharges,
            Type = @Type,
            ConsultantShareOutdoor = @ConsultantShareOutdoor,
            ConsultantShareIndoor = @ConsultantShareIndoor,
            HospitalShareOutdoor = @HospitalShareOutdoor,
            HospitalShareIndoor = @HospitalShareIndoor,
            OPDpaid = @OPDpaid,
            SurgeryCharges = @SurgeryCharges,
            AnesCharges = @AnesCharges
        WHERE ConsultantID = @ConsultantID";

            try
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Add parameters and their values
                        cmd.Parameters.AddWithValue("@ConsultantName", txtConsultantName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Degrees", txtDegree.Text.Trim());
                        cmd.Parameters.AddWithValue("@Timing", ""); // Not present in the form
                        cmd.Parameters.AddWithValue("@Faculty", ""); // Not present in the form
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@Telephone", txtTelephone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Fax", txtFax.Text.Trim());
                        cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@ConsultantCharges", string.IsNullOrEmpty(txtConsultantCharges.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtConsultantCharges.Text));
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);

                        cmd.Parameters.AddWithValue("@ConsultantShareOutdoor", string.IsNullOrEmpty(txtConsultantOutPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtConsultantOutPatient.Text));
                        cmd.Parameters.AddWithValue("@ConsultantShareIndoor", string.IsNullOrEmpty(txtConsultantInPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtConsultantInPatient.Text));
                        cmd.Parameters.AddWithValue("@HospitalShareOutdoor", string.IsNullOrEmpty(txtHospitalOutPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtHospitalOutPatient.Text));
                        cmd.Parameters.AddWithValue("@HospitalShareIndoor", string.IsNullOrEmpty(txtHospitalInPatient.Text) ? (object)DBNull.Value : Convert.ToDecimal(txtHospitalInPatient.Text));
                        cmd.Parameters.AddWithValue("@OPDpaid", chkDeactivate.Checked ? (object)1 : (object)0); // Use 1 for true, 0 for false
                        cmd.Parameters.AddWithValue("@SurgeryCharges", DBNull.Value); // Not present in the form
                        cmd.Parameters.AddWithValue("@AnesCharges", DBNull.Value); // Not present in the form
                        cmd.Parameters.AddWithValue("@ConsultantID", Convert.ToInt32(txtConsultantID.Text.Trim()));

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        lblErr.Text = "Consultant information updated successfully!";
                    }
                }
            }
            catch (Exception ex)
            {
                lblErr.Text = "Error: " + ex.Message;
            }
        }


        private void ClearFields()
        {
            txtConsultantID.Text = "";
            txtConsultantName.Text = "";
            txtAddress.Text = "";
            txtDegree.Text = "";
            txtMobile.Text = "";
            txtTelephone.Text = "";
            txtFax.Text = "";
            txtEmail.Text = "";
            txtConsultantCharges.Text = "";
            ddlType.SelectedIndex = 0; // Assuming ddlType is a DropDownList
            txtConsultantInPatient.Text = "";
            txtConsultantOutPatient.Text = "";
            txtHospitalInPatient.Text = "";
            txtHospitalOutPatient.Text = "";
            chkDeactivate.Checked = false;

        }
    }
}