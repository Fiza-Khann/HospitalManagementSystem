using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using System.Data;

namespace HMS_Task1
{
    public partial class AddUser : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["HMS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string Id = Request.QueryString["Id"];

                if (!string.IsNullOrEmpty(Id))
                {
                    LoadDetails(Id);
                }
                else
                {
                    txtId.Text = GenerateUniqueID();
                    ClearFields();
                }
            }
        }

        private string GenerateUniqueID()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ISNULL(MAX(Id), 0) + 1 FROM UserInformation";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                string id = cmd.ExecuteScalar().ToString();
                conn.Close();

                return id;
            }
        }

        private void LoadDetails(string Id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM UserInformation WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", Id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtId.Text = reader["Id"].ToString();
                    txtLoginId.Text = reader["LoginId"].ToString();
                    txtName.Text = reader["Name"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtDesignation.Text = reader["Designation"].ToString();

                    if (reader["ProfilePic"] != DBNull.Value)
                    {
                        byte[] imageData = (byte[])reader["ProfilePic"];
                        string base64String = Convert.ToBase64String(imageData);
                        imgProfilePic.ImageUrl = "data:image/png;base64," + base64String;
                    }
                    else
                    {
                        imgProfilePic.ImageUrl = "~/images/users/userblue.png";
                    }
                }
                reader.Close();
                conn.Close();
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
                    byte[] profilePicData = null;

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        string userId = txtId.Text.Trim();

                        // Check if user exists
                        string checkQuery = "SELECT COUNT(1) FROM UserInformation WHERE Id = @Id";
                        SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                        checkCmd.Parameters.AddWithValue("@Id", userId);

                        int userCount = Convert.ToInt32(checkCmd.ExecuteScalar());



                        if (userCount > 0)
                        {
                            // UPDATE existing user
                            if (fuProfilePic.HasFile)
                            {
                                // Validate the uploaded file
                                if (fuProfilePic.PostedFile == null || fuProfilePic.PostedFile.ContentLength == 0)
                                {
                                    lblErr.Text = "Error: No file data received or file is empty";
                                    return;
                                }

                                // Read file using MemoryStream (more reliable than BinaryReader)
                                try
                                {
                                    // Reset stream position to start in case it was read before
                                    fuProfilePic.PostedFile.InputStream.Position = 0;

                                    using (MemoryStream ms = new MemoryStream())
                                    {
                                        fuProfilePic.PostedFile.InputStream.CopyTo(ms);
                                        profilePicData = ms.ToArray();

                                        // Verify we got actual data
                                        if (profilePicData == null || profilePicData.Length == 0)
                                        {
                                            lblErr.Text = "Error: Failed to read image data";
                                            return;
                                        }
                                    }

                                    string updateQuery = @"UPDATE UserInformation 
                                SET Name = @Name,
                                    Email = @Email,
                                    Designation = @Designation,
                                    ProfilePic = @ProfilePic
                                WHERE Id = @Id";

                                    SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                                    updateCmd.Parameters.AddWithValue("@Id", userId);
                                    updateCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                                    updateCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                                    updateCmd.Parameters.AddWithValue("@Designation", txtDesignation.Text.Trim());

                                    // Proper binary parameter handling
                                    SqlParameter picParam = updateCmd.Parameters.Add("@ProfilePic", SqlDbType.VarBinary);
                                    picParam.Value = profilePicData;

                                    int rowsAffected = updateCmd.ExecuteNonQuery();

                                    if (rowsAffected > 0)
                                    {
                                        string base64String = Convert.ToBase64String(profilePicData);
                                        imgProfilePic.ImageUrl = "data:image/png;base64," + base64String;

                                        lblErr.Text = "Profile updated successfully with new image";
                                    }
                                }
                                catch (Exception ex)
                                {
                                    lblErr.Text = "Error processing image: " + ex.Message;
                                    return;
                                }
                            }
                            else
                            {
                                string updateQuery = @"UPDATE UserInformation 
        SET Name = @Name,
            Email = @Email,
            Designation = @Designation
        WHERE Id = @Id";

                                SqlCommand updateCmd = new SqlCommand(updateQuery, conn);
                                updateCmd.Parameters.AddWithValue("@Id", userId);
                                updateCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                                updateCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                                updateCmd.Parameters.AddWithValue("@Designation", txtDesignation.Text.Trim());

                                updateCmd.ExecuteNonQuery();
                                lblErr.Text = "User updated successfully without changing profile picture.";
                            }

                        }
                        else
                        {
                            // If no image uploaded, load the default image
                            if (profilePicData == null)
                            {
                                string defaultImagePath = Server.MapPath("~/images/users/userblue.png");
                                profilePicData = File.ReadAllBytes(defaultImagePath);
                            }

                            // INSERT new user
                            string insertQuery = @"INSERT INTO UserInformation 
                           (Id,LoginId, Name, Email, Designation, ProfilePic) 
                           VALUES 
                           (@Id,@LoginId, @Name, @Email, @Designation, @ProfilePic)";

                            SqlCommand insertCmd = new SqlCommand(insertQuery, conn);
                            insertCmd.Parameters.AddWithValue("@Id", txtId.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@LoginId", txtLoginId.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Designation", txtDesignation.Text.Trim());
                            insertCmd.Parameters.Add("@ProfilePic", SqlDbType.VarBinary).Value = profilePicData;

                            insertCmd.ExecuteNonQuery();
                            lblErr.Text = "User information saved successfully.";
                        }

                        lblErr.ForeColor = System.Drawing.Color.Green;
                        conn.Close();
                    }
                }
                catch (SqlException sqlEx)
                {
                    if (sqlEx.Number == 2627) // Unique key violation
                    {
                        lblErr.Text = "Error: Login ID already exists. Please choose a different one.";
                    }
                    else
                    {
                        lblErr.Text = "Database error: " + sqlEx.Message;
                    }
                    lblErr.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception ex)
                {
                    lblErr.Text = "Error: " + ex.Message;
                    lblErr.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void ValidateProfilePic(object source, ServerValidateEventArgs args)
        {
            if (!fuProfilePic.HasFile)
            {
                args.IsValid = true; // Picture is optional
                return;
            }

            // Check file size (2MB max)
            if (fuProfilePic.PostedFile.ContentLength > 2097152)
            {
                args.IsValid = false;
                cvProfilePic.ErrorMessage = "Image size must be less than 2MB";
                return;
            }

            // Check file type
            string fileExtension = Path.GetExtension(fuProfilePic.FileName).ToLower();
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".bmp" };

            if (Array.IndexOf(allowedExtensions, fileExtension) == -1)
            {
                args.IsValid = false;
                cvProfilePic.ErrorMessage = "Only image files (JPEG, PNG, GIF, BMP) are allowed";
                return;
            }

            // Additional check for actual image content
            try
            {
                using (var img = System.Drawing.Image.FromStream(fuProfilePic.PostedFile.InputStream))
                {
                    args.IsValid = true;
                }
            }
            catch
            {
                args.IsValid = false;
                cvProfilePic.ErrorMessage = "The selected file is not a valid image";
            }
        }

        private void ClearFields()
        {
            txtLoginId.Text = string.Empty;
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtDesignation.Text = string.Empty;
            imgPreview.Visible = false;
        }

        protected void BExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
    }
}
