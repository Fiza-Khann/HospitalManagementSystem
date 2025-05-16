using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class Profile : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Session["id"]?.ToString();

                if (!string.IsNullOrEmpty(id))
                {
                    LoadUserProfile(id);
                    LoadAttendance(id);
                }
                else
                {
                    Response.Redirect("Login.aspx");
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


        private void LoadUserProfile(string userId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM UserInformation WHERE Id = @Id"; // Adjust table name
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Id", userId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    lblName.Text = reader["Name"].ToString();
                    lblEmail.Text = reader["Email"].ToString();
                    lblDesignation.Text = reader["Designation"].ToString();


                    if (reader["ProfilePic"] != DBNull.Value)
                    {
                        byte[] imageData = (byte[])reader["ProfilePic"];
                        string base64String = Convert.ToBase64String(imageData);
                        imgProfile.ImageUrl = "data:image/png;base64," + base64String;
                    }
                    else
                    {
                        imgProfile.ImageUrl = "~/images/users/userblue.png";
                    }
                }
                reader.Close();
            }
        }

        private void LoadAttendance(string userId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT A.Date, A.Time, A.Shift, A.Status 
            FROM Attendance A
            INNER JOIN UserInformation U ON A.LoginID = U.LoginID
            WHERE U.ID = @ID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ID", userId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvAttendance.DataSource = dt;
                        gvAttendance.DataBind();
                    }
                }
            }
        }
    }
 }