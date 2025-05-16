using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class AttendanceForm : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get ID from query string (URL parameter)
                string id = Request.QueryString["ID"];
                LoadLoginId();

                // If ID is available in query string, load the attendance details
                if (!string.IsNullOrEmpty(id))
                {
                    LoadAttendanceDetails(id);
                }
                else
                {
                   txtID.Text= GenerateUniqueID();
                    // Fill the txtDate and txtTime with current date and time
                    txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd"); // Current date in yyyy-MM-dd format
                    txtTime.Text = DateTime.Now.ToString("HH:mm:ss"); // Current time in HH:mm:ss format
                }
            }
        }
        private string GenerateUniqueID()
        {
            string id;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(ID), 0) + 1  FROM Attendance";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                id = cmd.ExecuteScalar().ToString();
                conn.Close();
            }

            return id;
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

        // Method to load attendance details based on ID
        private void LoadAttendanceDetails(string id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT * FROM Attendance WHERE ID = @ID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ID", id); // Use ID for query

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtID.Text = reader["ID"].ToString();
                        ddlLoginID.SelectedValue = reader["LoginID"].ToString();

                        if (reader["Date"] != DBNull.Value)
                        {
                            txtDate.Text = Convert.ToDateTime(reader["Date"]).ToString("yyyy-MM-dd"); // Format as needed
                        }

                        txtTime.Text = reader["Time"].ToString();
                        ddlShift.SelectedValue = reader["Shift"].ToString();
                        ddlStatus.SelectedValue = reader["Status"].ToString();
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

        // Method to clear the form fields
        protected void BClear_Click(object sender, EventArgs e)
        {
            // Clear form fields
            ddlLoginID.SelectedIndex = -1;
            txtDate.Text = "";
            txtTime.Text = "";
            ddlShift.SelectedIndex = -1;
            ddlStatus.SelectedIndex = -1;
        }

        // Method to save attendance record
        protected void BSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query;

                        // Check if the ID exists in the Attendance table
                        query = "SELECT COUNT(*) FROM Attendance WHERE ID = @ID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@ID", txtID.Text); // Ensure correct parameter is used

                        conn.Open();
                        int count = (int)cmd.ExecuteScalar();
                        conn.Close();

                        if (count > 0)
                        {
                            // If record exists, update it
                            query = @"
                        UPDATE Attendance 
                        SET 
                            LoginID = @LoginID,
                            Date = @Date,
                            Time = @Time,
                            Shift = @Shift,
                            Status = @Status
                        WHERE ID = @ID";
                        }
                        else
                        {
                            // If record does not exist, insert a new record
                            query = @"
                        INSERT INTO Attendance (LoginID, Date, Time, Shift, Status)
                        VALUES (@LoginID, @Date, @Time, @Shift, @Status)";
                        }

                        // Create a new command after determining the query
                        cmd = new SqlCommand(query, conn);

                        // Add parameters to the query
                        cmd.Parameters.AddWithValue("@ID", txtID.Text); // Use ID for updates
                        cmd.Parameters.AddWithValue("@LoginID", ddlLoginID.SelectedValue);
                        cmd.Parameters.AddWithValue("@Date", DateTime.Parse(txtDate.Text)); // Ensure the date is parsed correctly
                        cmd.Parameters.AddWithValue("@Time", txtTime.Text);
                        cmd.Parameters.AddWithValue("@Shift", ddlShift.SelectedValue);
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                        // Execute the query (insert or update)
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        lblErr.Text = "Attendance record saved successfully.";
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
        }


        // Method to exit and redirect to the home page
        protected void BExit_Click(object sender, EventArgs e)
        {
            // Redirect to the home page (or any other page)
            Response.Redirect("Home.aspx");
        }

        private void LoadLoginId()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT LoginId FROM UserInformation";  // No CityID, only CityName
                SqlCommand cmd = new SqlCommand(query, conn);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    ddlLoginID.DataSource = reader;
                    ddlLoginID.DataTextField = "LoginId";  // Use CityName as both text and value
                    ddlLoginID.DataValueField = "LoginId";
                    ddlLoginID.DataBind();

                    ddlLoginID.Items.Insert(0, new ListItem("-- Select Login ID --", ""));
                    if (ddlLoginID.Items.Count > 1)
                    {
                        ddlLoginID.SelectedIndex = 1;
                    }
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}
