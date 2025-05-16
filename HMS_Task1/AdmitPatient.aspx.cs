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
    public partial class AdmitPatient : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        private readonly IPatientRepository _patientRepository;

        public AdmitPatient()
        {
            _patientRepository = new PatientRepository(WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string serialno = Request.QueryString["serialno"];
                LoadDropdowns();

                if (!string.IsNullOrEmpty(serialno))
                {
                    LoadPatientDetails(serialno);
                }
                else
                {
                    InitializeNewPatient();
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


        private void LoadDropdowns()
        {
            // Load cities
            ddlCityName.DataSource = _patientRepository.GetCities();
            ddlCityName.DataBind();
            ddlCityName.Items.Insert(0, new ListItem("-- Select City --", ""));

            // Load rooms
            ddlRoom.DataSource = _patientRepository.GetRooms();
            ddlRoom.DataBind();
            ddlRoom.Items.Insert(0, new ListItem("-- Select Room --", ""));

            // Load consultants
            var consultants = _patientRepository.GetConsultants();
            ddlConsultant.DataSource = consultants;
            ddlConsultant.DataTextField = "Value";
            ddlConsultant.DataValueField = "Key";
            ddlConsultant.DataBind();
            ddlConsultant.Items.Insert(0, new ListItem("-- Select Consultant --", ""));

            // Load areas
            ddlAreaName.DataSource = _patientRepository.GetAreas();
            ddlAreaName.DataBind();
            ddlAreaName.Items.Insert(0, new ListItem("-- Select Area --", ""));

            // Load reference names
            ddlrefname.DataSource = _patientRepository.GetReferenceNames();
            ddlrefname.DataBind();
            ddlrefname.Items.Insert(0, new ListItem("-- Select Reference Name --", ""));
        }

        private void LoadPatientDetails(string serialNo)
        {
            var patient = _patientRepository.GetPatientBySerialNo(serialNo);
            if (patient != null)
            {
                PopulateFormFields(patient);
            }
            else
            {
                lblErr.Text = "Patient not found.";
            }
        }

        private void PopulateFormFields(Patient patient)
        {
            txtSerial.Text = patient.SerialNo;
            txtReg.Text = patient.Reg;
            txtNo.Text = patient.Num;
            txtAdmDate.Text = patient.AdmDate.ToString("yyyy-MM-dd");
            txtAdmTime.Text = patient.AdmTime;
            txtbmj.Text = patient.Bmj;
            ddlTitle.SelectedValue = patient.Title;
            txtPatientName.Text = patient.PatientName;
            ddlRoom.SelectedValue = patient.Room;
            ddlConsultant.SelectedValue = patient.ConsultantName;
            txtRelation.Text = patient.Relation;
            txtRelationName.Text = patient.RelationName;
            txtEmergency.Text = patient.Emergency;
            txtMobile.Text = patient.Mobile;
            txtCont1.Text = patient.OtherContact;
            txtCont2.Text = patient.Email;
            ddlrefname.SelectedValue = patient.ReferenceName;
            txtAdmittedFor.Text = patient.AdmittedFor;
            txtAdmissionRemarks.Text = patient.AdmissionRemarks;
            txtAdmissionLoginId.Text = patient.AdmissionLoginId;
            chkDischarged.Checked = patient.Discharged;
            txtDischargeDate.Text = patient.DischargeDate?.ToString("yyyy-MM-dd");
            txtDischargeTime.Text = patient.DischargeTime;
            txtDischargeRemarks.Text = patient.DischargeRemarks;
            ddlCityName.SelectedValue = patient.City;
            ddlAreaName.SelectedValue = patient.AreaName;
            ddlGender.SelectedValue = patient.Gender;
            txtAge.Text = patient.AgeNum;
            ddlAgeValue.SelectedValue = patient.AgeValue;
            ddlAccountType.SelectedValue = patient.Typee;
            txtAddress.Text = patient.Address;
        }

        private void InitializeNewPatient()
        {
            txtAge.Text = "0";
            txtSerial.Text = _patientRepository.GenerateUniqueSerialNo();
            txtNo.Text = _patientRepository.GenerateUniqueSerialNo();
            txtReg.Text = _patientRepository.GenerateUniqueRegID();
            txtAdmDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtAdmTime.Text = DateTime.Now.ToString("HH:mm:ss");
        }

        protected void BSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    if (!_patientRepository.LoginIdExists(txtAdmissionLoginId.Text.Trim()))
                    {
                        lblErr.Text = "Invalid LoginId.";
                        lblErr.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    var patient = new Patient
                    {
                        SerialNo = txtSerial.Text.Trim(),
                        Reg = txtReg.Text.Trim(),
                        Num = txtNo.Text.Trim(),
                        AdmDate = DateTime.Parse(txtAdmDate.Text.Trim()),
                        AdmTime = txtAdmTime.Text.Trim(),
                        Bmj = txtbmj.Text.Trim(),
                        Title = ddlTitle.SelectedValue,
                        PatientName = txtPatientName.Text.Trim(),
                        Room = ddlRoom.SelectedValue,
                        ConsultantName = ddlConsultant.SelectedItem.Text,
                        Relation = txtRelation.Text.Trim(),
                        RelationName = txtRelationName.Text.Trim(),
                        Emergency = txtEmergency.Text.Trim(),
                        Mobile = txtMobile.Text.Trim(),
                        OtherContact = txtCont1.Text.Trim(),
                        Email = txtCont2.Text.Trim(),
                        ReferenceName = ddlrefname.SelectedValue,
                        AdmittedFor = txtAdmittedFor.Text.Trim(),
                        AdmissionRemarks = txtAdmissionRemarks.Text.Trim(),
                        AdmissionLoginId = txtAdmissionLoginId.Text.Trim(),
                        Discharged = chkDischarged.Checked,
                        DischargeDate = string.IsNullOrEmpty(txtDischargeDate.Text) ? (DateTime?)null : DateTime.Parse(txtDischargeDate.Text),
                        DischargeTime = txtDischargeTime.Text.Trim(),
                        DischargeRemarks = txtDischargeRemarks.Text.Trim(),
                        City = ddlCityName.SelectedValue,
                        AreaName = ddlAreaName.SelectedValue,
                        Gender = ddlGender.SelectedValue,
                        AgeNum = txtAge.Text.Trim(),
                        AgeValue = ddlAgeValue.Text.Trim(),
                        Typee = ddlAccountType.SelectedValue,
                        Address = txtAddress.Text.Trim()
                    };

                    if (_patientRepository.PatientExists(patient.SerialNo))
                    {
                        _patientRepository.UpdatePatient(patient);
                        lblErr.Text = "Patient record updated successfully.";
                    }
                    else
                    {
                        _patientRepository.AddPatient(patient);
                        lblErr.Text = "Patient record saved successfully.";
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                    lblErr.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
       

        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }


        protected void BClear_Click(object sender, EventArgs e)
        {
            txtAdmDate.Text = string.Empty;
            txtAdmTime.Text = string.Empty;
            txtbmj.Text = string.Empty;
            txtPatientName.Text = string.Empty;
            txtRelation.Text = string.Empty;
            txtRelationName.Text = string.Empty;
            txtEmergency.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtCont1.Text = string.Empty;
            txtCont2.Text = string.Empty;
          
            txtAdmittedFor.Text = string.Empty;
            txtAdmissionRemarks.Text = string.Empty;
            txtAdmissionLoginId.Text = string.Empty;
            txtDischargeDate.Text = string.Empty;
            txtDischargeTime.Text = string.Empty;
            txtDischargeRemarks.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtAge.Text = string.Empty;

            // Reset dropdown lists to default (first item)
            ddlTitle.SelectedIndex = 0;
            ddlRoom.SelectedIndex = 0;
            ddlConsultant.SelectedIndex = 0;
            ddlCityName.SelectedIndex = 0;
            ddlAreaName.SelectedIndex = 0;
            ddlGender.SelectedIndex = 0;
            ddlAgeValue.SelectedIndex = 0;
            ddlAccountType.SelectedIndex = 0;
            ddlrefname.SelectedIndex = 0;

            // Reset CheckBox
            chkDischarged.Checked = false;

            // Clear any error or message labels
            lblErr.Text = string.Empty;
        }


    }
}