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
    public partial class AddDischarge : System.Web.UI.Page
    {
        private readonly IDischargeRepository _dischargeRepository;

        // Constructor with dependency injection
        public AddDischarge()
        {
            _dischargeRepository = new DischargeRepository(WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string serialno = Request.QueryString["SerialNo"];
                if (!string.IsNullOrEmpty(serialno))
                {
                    LoadDetails(serialno);
                }
                else
                {
                    txtDDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtDTime.Text = DateTime.Now.ToString("HH:mm:ss");
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
        private void LoadDetails(string serialNo)
        {
            try
            {
                var discharge = _dischargeRepository.GetDischargeBySerialNo(serialNo);
                if (discharge != null)
                {
                    txtSerial.Text = discharge.SerialNo;
                    txtDStatus.SelectedValue = discharge.DStatus;
                    txtDDate.Text = discharge.DDate.ToString("yyyy-MM-dd");
                    txtDTime.Text = discharge.DTime;
                    txtReg.Text = discharge.Patient.Reg;
                    txtNo.Text = discharge.Patient.Num;
                    txtPatientName.Text = discharge.Patient.PatientName;
                }
                else
                {
                    lblErr.Text = "No discharge record found.";
                }
            }
            catch (Exception ex)
            {
                lblErr.Text = "Error: " + ex.Message;
            }
        }

        protected void BSave_Click(object sender, EventArgs e)
        {
            lblErr.Text = "";
            try
            {
                var discharge = new Discharge
                {
                    SerialNo = txtSerial.Text,
                    DStatus = txtDStatus.SelectedValue,
                    DDate = DateTime.Parse(txtDDate.Text),
                    DTime = txtDTime.Text
                };

                // Check if the patient exists before adding or updating
                if (_dischargeRepository.PatientExists(discharge.SerialNo))
                {
                    // If patient exists, update discharge record
                    _dischargeRepository.UpdateDischarge(discharge);
                    lblErr.Text = "Discharge record updated successfully.";
                }
                else
                {
                    // If patient does not exist, insert a new discharge record
                    _dischargeRepository.AddDischarge(discharge);
                    lblErr.Text = "Discharge record saved successfully.";
                }
            }
            catch (Exception ex)
            {
                lblErr.Text = "Error: " + ex.Message;
            }
        }

        protected void FetchAndFillData()
        {
            lblErr.Text = "";

            if (!string.IsNullOrEmpty(txtReg.Text) && !string.IsNullOrEmpty(txtNo.Text))
            {
                try
                {
                    var patient = _dischargeRepository.GetPatientByRegNum(txtReg.Text, txtNo.Text);

                    if (patient != null)
                    {
                        txtSerial.Text = patient.SerialNo;
                        txtPatientName.Text = patient.PatientName;
                    }
                    else
                    {
                        lblErr.Text = "No records found.";
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
        // Load patient data for the SerialNo dropdown list
        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

       

        protected void TxtReg_TextChanged(object sender, EventArgs e)
        {
            FetchAndFillData();
        }

        protected void TxtNo_TextChanged(object sender, EventArgs e)
        {
            FetchAndFillData();
        }

        // Clear fields after successful insert
        protected void BClear_Click(object sender, EventArgs e)
        {
            txtSerial.Text = "";
            txtPatientName.Text = "";
            txtReg.Text = "";
            txtNo.Text = "";
            txtDDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtDTime.Text = DateTime.Now.ToString("HH:mm:ss");
            txtDStatus.SelectedIndex = 0;
            lblErr.Text = "";
        }

       
    }
}