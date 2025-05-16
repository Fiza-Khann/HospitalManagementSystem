using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_Task1
{
    public partial class AddRoom : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string roomName = Request.QueryString["Room"];

                if (!string.IsNullOrEmpty(roomName))
                {
                    LoadDetails(roomName);
                    // Check if the txtRoom contains any text and clear it or handle as required
                    if (!string.IsNullOrEmpty(txtRoom.Text))
                    {
                        string roomNameToDelete = txtRoom.Text.Trim();
                        DeleteRoom(roomNameToDelete);
                    }
                }
                else
                {
                    txtRoom.Text = string.Empty; // Initialize room text box
                }


            }
        }


        private void LoadDetails(string roomName)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    string query = "SELECT * FROM Room WHERE Room = @RoomName"; // Look for the room by name
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@RoomName", roomName);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtRoom.Text = reader["Room"].ToString(); // Load the room name
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
                        string roomName = txtRoom.Text.Trim();

                        // Delete the room if it already exists
                        DeleteRoom(roomName);

                        // Insert the new room
                        string insertQuery = "INSERT INTO Room (Room) VALUES (@Room)";
                        SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                        insertCmd.Parameters.AddWithValue("@Room", roomName);

                        insertCmd.ExecuteNonQuery();

                        lblErr.Text = "Room added successfully.";
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

        // Method to delete the room if it exists
        private void DeleteRoom(string roomName)
        {
            if (!string.IsNullOrEmpty(roomName))
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Delete the room if it exists
                    string deleteQuery = "DELETE FROM Room WHERE Room = @RoomName";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                    deleteCmd.Parameters.AddWithValue("@RoomName", roomName);

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
