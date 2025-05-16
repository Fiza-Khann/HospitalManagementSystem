using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace HMS_Task1
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTotalEmployees();
                LoadEmployeeList();
                LoadAttendanceSummary();
                LoadNotifications();
            }
        }

        private void LoadTotalEmployees()
        {
            // Define the connection string (update with your actual connection details)
            string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            // Query to get the total count of employees from the UserInformation table
            string query = "SELECT COUNT(*) FROM UserInformation";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, connection);

                try
                {
                    connection.Open();
                    int totalEmployees = (int)cmd.ExecuteScalar(); // ExecuteScalar will return the first column of the first row

                    // Set the count to the label
                    lblTotEmployee.Text = totalEmployees.ToString();
                }
                catch (Exception ex)
                {
                    // Handle any errors that occur during the database query
                    lblTotEmployee.Text = "Error: " + ex.Message;
                }
            }
        }
        private void LoadEmployeeList()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            // SQL query to select Name, Designation, and GroupId
            string query = "SELECT Name, Designation, Email FROM [HMS].[dbo].[UserInformation]";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();

                try
                {
                    adapter.Fill(dt);

                    // Bind data to GridView or any other control you are using
                    gvEmployeeList.DataSource = dt;
                    gvEmployeeList.DataBind();
                }
                catch (SqlException sqlEx)
                {
                    lblGridNotice.Text = "Error loading employee list: " + sqlEx.Message;
                }
                catch (Exception ex)
                {
                    lblGridNotice.Text = "An unexpected error occurred: " + ex.Message;
                }
            }
        }
        private void LoadAttendanceSummary()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

            // SQL query to count today's attendance statuses, considering Half Day as Present
            string query = @"
        SELECT 
            SUM(CASE WHEN Status IN ('Present', 'Half Day') THEN 1 ELSE 0 END) AS PresentCount,
            SUM(CASE WHEN Status = 'Absent' THEN 1 ELSE 0 END) AS AbsentCount,
            SUM(CASE WHEN Status = 'On Leave' THEN 1 ELSE 0 END) AS LeaveCount
        FROM [HMS].[dbo].[Attendance]
        WHERE CAST(Date AS DATE) = CAST(GETDATE() AS DATE)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, connection);

                try
                {
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblTodayPresent.Text = reader["PresentCount"].ToString();
                        lblTodayAbsent.Text = reader["AbsentCount"].ToString();
                        lblTodayLeave.Text = reader["LeaveCount"].ToString();
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Response.Write(ex);
                }
            }
        }


        private void LoadNotifications()
        {
            // Simulated database data
            DataTable dt = new DataTable();
            dt.Columns.Add("Title");
            dt.Columns.Add("Message");

            dt.Rows.Add("New Employee Joined", "Dr. Bashir has joined as a Consultant.");
            dt.Rows.Add("System Maintenance", "Scheduled maintenance at 10 PM.");
            dt.Rows.Add("Team Meeting", "Meeting at 3 PM in conference room.");
            dt.Rows.Add("Holiday Announcement", "Hospital closed on 14th August for Independence Day.");
            dt.Rows.Add("COVID-19 Update", "Mandatory mask policy reinstated for all staff.");
            dt.Rows.Add("Employee On Leave", "Bilal Qureshi is on leave on 29th March.");
            rptNotifications.DataSource = dt;
            rptNotifications.DataBind();
        }

    }
}
