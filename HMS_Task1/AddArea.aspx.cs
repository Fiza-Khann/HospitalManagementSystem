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
    public partial class AddArea : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string areaName = Request.QueryString["Area"];
                LoadCities();
                if (!string.IsNullOrEmpty(areaName))
                {
                    LoadDetails(areaName);
                    // Check if the txtArea contains any text and clear it or handle as required
                    if (!string.IsNullOrEmpty(txtArea.Text))
                    {
                        string areaNameToDelete = txtArea.Text.Trim();
                        string cityNameToDelete = ddlCity.SelectedValue.Trim();
                        DeleteArea(areaNameToDelete, cityNameToDelete);
                    }
                }
                else
                {
                    txtArea.Text = string.Empty; // Initialize area text box
                }
            }
        }

        private void LoadCities()
        {
            string connStr = ConfigurationManager.ConnectionStrings["HMS"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT CityName FROM City";  // No CityID, only CityName
                SqlCommand cmd = new SqlCommand(query, conn);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    ddlCity.DataSource = reader;
                    ddlCity.DataTextField = "CityName";  // Use CityName as both text and value
                    ddlCity.DataValueField = "CityName";
                    ddlCity.DataBind();

                    ddlCity.Items.Insert(0, new ListItem("-- Select City --", ""));
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                }
            }
        }

        private void LoadDetails(string areaName)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT AreaName, CityName FROM Area WHERE AreaName = @AreaName";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@AreaName", areaName);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtArea.Text = reader["AreaName"].ToString(); // Load the area name

                        string cityName = reader["CityName"].ToString(); // Get the city name
                        ddlCity.SelectedValue = cityName; // Set the selected value (not Text)
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
                        string areaName = txtArea.Text.Trim();
                        string cityName = ddlCity.SelectedValue.Trim();

                        if (string.IsNullOrEmpty(cityName))
                        {
                            lblErr.Text = "Please select a valid city.";
                            lblErr.ForeColor = System.Drawing.Color.Red;
                            return;
                        }

                        // Delete the area if it already exists
                        DeleteArea(areaName, cityName);

                        // Insert the new area and city name
                        string insertQuery = "INSERT INTO Area (AreaName, CityName) VALUES (@AreaName, @CityName)";
                        SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                        insertCmd.Parameters.AddWithValue("@AreaName", areaName);
                        insertCmd.Parameters.AddWithValue("@CityName", cityName);

                        insertCmd.ExecuteNonQuery();

                        lblErr.Text = "Area added successfully.";
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

        // Method to delete the area if it exists
        private void DeleteArea(string areaName, string cityName)
        {
            if (!string.IsNullOrEmpty(areaName) && !string.IsNullOrEmpty(cityName))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Delete the area if it exists
                    string deleteQuery = "DELETE FROM Area WHERE AreaName = @AreaName AND CityName = @CityName";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                    deleteCmd.Parameters.AddWithValue("@AreaName", areaName);
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
