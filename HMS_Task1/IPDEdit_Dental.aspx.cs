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
    public partial class IPDEdit_Dental : System.Web.UI.Page
    {

        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string originalReceiptNo = Request.QueryString["originalReceiptNo"];

                if (!string.IsNullOrEmpty(originalReceiptNo))
                {
                    LoadXrayDetails(originalReceiptNo);
                }
                else
                {
                    txtId.Text = GenerateUniqueID();
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
                string query = "SELECT ISNULL(MAX(ID), 0) + 1  FROM IN_Dental";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                id = cmd.ExecuteScalar().ToString();
                conn.Close();
            }

            return id;
        }

        private void LoadXrayDetails(string id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT * FROM IN_Dental WHERE ID = @ID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ID", id);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtId.Text = reader["ID"].ToString();
                        ddlCat.SelectedValue = reader["TestTypeName"].ToString();
                        txtId.Text = reader["ID"].ToString();
                        txtName.Text = reader["TestName"].ToString();
                        txtCharges.Text = reader["Charges"].ToString();
                        txtConsultantShare.Text = reader["ConsultantShare"].ToString();
                        txtHospitalShare.Text = reader["HospitalShare"].ToString();
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
            txtId.Text = GenerateUniqueID();
            txtName.Text = "";
            txtCharges.Text = ""; ;
            txtConsultantShare.Text = "";
            txtHospitalShare.Text = "";
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
                        query = "SELECT COUNT(*) FROM IN_Dental WHERE ID = @ID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@ID", txtId.Text);

                        conn.Open();
                        int count = (int)cmd.ExecuteScalar();
                        conn.Close();

                        if (count > 0)
                        {
                            // if the record exists, update it
                            query = @"
     UPDATE IN_Dental SET
         TestTypeName = @TestTypeName, 
         TestName = @TestName, 
         Charges = @Charges, 
         ConsultantShare = @ConsultantShare, 
         HospitalShare = @HospitalShare
     WHERE ID = @ID";

                            cmd = new SqlCommand(query, conn);
                        }
                        else
                        {
                            // if the record doesn't exist, insert a new one
                            query = @"
     INSERT INTO IN_Dental (
         ID, TestTypeName, TestName, Charges, ConsultantShare, HospitalShare 
       
     ) VALUES (
         @ID, @TestTypeName, @TestName, @Charges, @ConsultantShare, @HospitalShare)";

                            cmd = new SqlCommand(query, conn);
                        }

                        cmd.Parameters.AddWithValue("@TestTypeName", ddlCat.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@ID", txtId.Text);
                        cmd.Parameters.AddWithValue("@TestName", txtName.Text);
                        cmd.Parameters.AddWithValue("@Charges", txtCharges.Text);
                        cmd.Parameters.AddWithValue("@ConsultantShare", txtConsultantShare.Text);
                        cmd.Parameters.AddWithValue("@HospitalShare", txtHospitalShare.Text);

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
    }
}