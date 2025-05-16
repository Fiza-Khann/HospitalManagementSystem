using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace HMS_Task1
{
    public partial class RefInfo : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
        //Data Source=DESKTOP-6F9NV7M\SQLEXPRESS;Initial Catalog=HMStemplateDB;Integrated Security=True
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["ID"];

                if (!string.IsNullOrEmpty(id))
                {
                    LoadDetails(id);
                }
                else
                {
                    txtId.Text = GenerateUniqueID();
                }

            }
        }

        private void LoadDetails(string id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT * FROM ReferenceInformation WHERE ID = @ID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ID", id);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtId.Text = reader["ID"].ToString();
                        txtRefName.Text = reader["ReferenceName"].ToString();
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


        private string GenerateUniqueID()
        {
            string ID;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(ID), 0) + 1 FROM ReferenceInformation";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                ID = cmd.ExecuteScalar().ToString();
                conn.Close();
            }

            return ID;
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
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        // Check if the record with the given ID already exists
                        string checkQuery = "SELECT COUNT(*) FROM ReferenceInformation WHERE ID = @ID";
                        SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                        checkCmd.Parameters.AddWithValue("@ID", txtId.Text);

                        int count = (int)checkCmd.ExecuteScalar();

                        if (count > 0)
                        {
                            // If the ID exists, update the record
                            string updateQuery = "UPDATE ReferenceInformation SET ReferenceName = @ReferenceName WHERE ID = @ID";
                            SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                            updateCmd.Parameters.AddWithValue("@ID", txtId.Text);
                            updateCmd.Parameters.AddWithValue("@ReferenceName", txtRefName.Text);

                            updateCmd.ExecuteNonQuery();
                            lblErr.Text = "Reference updated successfully.";
                            lblErr.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            // If the ID does not exist, insert a new record
                            string insertQuery = "INSERT INTO ReferenceInformation (ID, ReferenceName) VALUES (@ID, @ReferenceName)";
                            SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                            insertCmd.Parameters.AddWithValue("@ID", txtId.Text);
                            insertCmd.Parameters.AddWithValue("@ReferenceName", txtRefName.Text);

                            insertCmd.ExecuteNonQuery();
                            lblErr.Text = "Reference added successfully.";
                            lblErr.ForeColor = System.Drawing.Color.Green;
                        }

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

        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}