using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class AddCity : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string cityName = Request.QueryString["CityName"];

                if (!string.IsNullOrEmpty(cityName))
                {
                    LoadDetails(cityName); // Load city details if CityName is passed via QueryString
                    // Check if the txtCity contains any text and clear it or handle as required
                    if (!string.IsNullOrEmpty(txtCity.Text))
                    {
                        string cityNameToDelete = txtCity.Text.Trim();
                        DeleteCity(cityNameToDelete); // Delete city if already exists (optional)
                    }
                }
                else
                {
                    txtCity.Text = string.Empty; // Initialize city text box if no query string is passed
                }
            }
        }

        private void LoadDetails(string cityName)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT * FROM City WHERE CityName = @CityName"; // Look for the city by name
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CityName", cityName);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtCity.Text = reader["CityName"].ToString(); // Load city name into textbox
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                    lblErr.ForeColor = System.Drawing.Color.Red;
                }
                finally
                {
                    conn.Close();
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
            if (Page.IsValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();

                        // Trim input to avoid issues with leading/trailing spaces
                        string cityName = txtCity.Text.Trim();

                        // Delete the city if it already exists
                        DeleteCity(cityName);

                        // Insert the new city
                        string insertQuery = "INSERT INTO City (CityName) VALUES (@CityName)";
                        SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                        insertCmd.Parameters.AddWithValue("@CityName", cityName);

                        insertCmd.ExecuteNonQuery();

                        lblErr.Text = "City added successfully.";
                        lblErr.ForeColor = System.Drawing.Color.Green;

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

        // Method to delete the city if it exists
        private void DeleteCity(string cityName)
        {
            if (!string.IsNullOrEmpty(cityName))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Delete the city if it exists
                    string deleteQuery = "DELETE FROM City WHERE CityName = @CityName";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                    deleteCmd.Parameters.AddWithValue("@CityName", cityName);

                    int rowsAffected = deleteCmd.ExecuteNonQuery();

                    conn.Close();
                }
            }
        }

        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
