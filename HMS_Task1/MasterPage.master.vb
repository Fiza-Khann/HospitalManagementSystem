Imports System.Data.SqlClient
Imports System.Web.Configuration

Partial Class MasterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.Header.DataBind()

        If Not IsPostBack Then
            LoadUserName()
        End If
    End Sub

    Private Sub LoadUserName()
        If Session("LoginID") IsNot Nothing Then
            Dim loginID As String = Session("LoginID").ToString()
            Dim connectionString As String = WebConfigurationManager.ConnectionStrings("HMS").ConnectionString
            Dim query As String = "SELECT Name, ProfilePic FROM UserInformation WHERE LoginID = @LoginID"

            Using connection As New SqlConnection(connectionString)
                Dim cmd As New SqlCommand(query, connection)
                cmd.Parameters.AddWithValue("@LoginID", loginID)

                Try
                    connection.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        If reader.Read() Then
                            ' Load user name
                            lblUserName.Text = reader("Name").ToString()

                            ' Check if profile picture exists
                            If reader("ProfilePic") IsNot DBNull.Value Then
                                Dim profilePicData As Byte() = CType(reader("ProfilePic"), Byte())
                                Dim base64String As String = Convert.ToBase64String(profilePicData)
                                ImgUser.ImageUrl = "data:image/png;base64," & base64String ' Set the profile picture dynamically
                            Else
                                ImgUser.ImageUrl = "~/images/users/default.png" ' Default image if no profile picture exists
                            End If
                        Else
                            lblUserName.Text = "Unknown User"
                            ImgUser.ImageUrl = "~/images/users/userblue.png" ' Default image if no user found
                        End If
                    End Using
                Catch ex As Exception
                    lblUserName.Text = "Error: " & ex.Message
                    ImgUser.ImageUrl = "~/images/users/userblue.png" ' Default image in case of error
                End Try
            End Using
        Else
            lblUserName.Text = "Guest"
            ImgUser.ImageUrl = "~/images/users/userblue.png" ' Default image for guest users
        End If
    End Sub


    Protected Sub lnkDashboard_ServerClick(sender As Object, e As System.EventArgs) Handles lnkDashboard.ServerClick
        Response.Redirect("Home.aspx", True)
    End Sub

    Protected Sub lnkSignout_ServerClick(sender As Object, e As System.EventArgs) Handles lnkSignout.ServerClick
        Response.Redirect("Login.aspx", True)
    End Sub

    Protected Sub lnkRefInfo_ServerClick(sender As Object, e As System.EventArgs) Handles lnkRefInfo.ServerClick
        Response.Redirect("RefInfo.aspx", True)
    End Sub

    Protected Sub lnkadvInfo_ServerClick(sender As Object, e As System.EventArgs) Handles lnkadvInfo.ServerClick
        Response.Redirect("AdvanceInfo.aspx", True)
    End Sub

    Protected Sub lnkadvHis_ServerClick(sender As Object, e As System.EventArgs) Handles lnkadvHis.ServerClick
        Response.Redirect("AdvanceHistory.aspx", True)
    End Sub

    Protected Sub lnkRefList_ServerClick(sender As Object, e As System.EventArgs) Handles lnkRefList.ServerClick
        Response.Redirect("RefInfoList.aspx", True)
    End Sub

    Protected Sub U1_ServerClick(sender As Object, e As System.EventArgs) Handles U1.ServerClick
        Response.Redirect("IPDEdit_Ultrasound.aspx", True)
    End Sub

    Protected Sub U2_ServerClick(sender As Object, e As System.EventArgs) Handles U2.ServerClick
        Response.Redirect("IPDView_Ultrasound.aspx", True)
    End Sub

    Protected Sub M1_ServerClick(sender As Object, e As System.EventArgs) Handles M1.ServerClick
        Response.Redirect("IPDEdit_MedServices.aspx", True)
    End Sub

    Protected Sub M2_ServerClick(sender As Object, e As System.EventArgs) Handles M2.ServerClick
        Response.Redirect("IPDView_MedServices.aspx", True)
    End Sub

    Protected Sub X1_ServerClick(sender As Object, e As System.EventArgs) Handles X1.ServerClick
        Response.Redirect("EditOP_Xray.aspx", True)
    End Sub

    Protected Sub X2_ServerClick(sender As Object, e As System.EventArgs) Handles X2.ServerClick
        Response.Redirect("ViewOP_Xray.aspx", True)
    End Sub

    Protected Sub lnkRoom1_ServerClick(sender As Object, e As System.EventArgs) Handles lnkRoom1.ServerClick
        Response.Redirect("AddRoom.aspx", True)
    End Sub

    Protected Sub lnkRoom2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkRoom2.ServerClick
        Response.Redirect("ViewRoom.aspx", True)
    End Sub

    Protected Sub lnkInXray_ServerClick(sender As Object, e As System.EventArgs) Handles lnkInXray.ServerClick
        Response.Redirect("IPDEdit_Xray.aspx", True)
    End Sub

    Protected Sub lnkInXray2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkInXray2.ServerClick
        Response.Redirect("IPDView_Xray.aspx", True)
    End Sub

    Protected Sub lnkDental_ServerClick(sender As Object, e As System.EventArgs) Handles lnkDental.ServerClick
        Response.Redirect("IPDEdit_Dental.aspx", True)
    End Sub

    Protected Sub lnkDental2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkDental2.ServerClick
        Response.Redirect("IPDView_Dental.aspx", True)
    End Sub

    Protected Sub lnkCon_ServerClick(sender As Object, e As System.EventArgs) Handles lnkCon.ServerClick
        Response.Redirect("AddConsultant.aspx", True)
    End Sub

    Protected Sub lnkCon2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkCon2.ServerClick
        Response.Redirect("ConsultantList.aspx", True)
    End Sub


    Protected Sub lnkArea_ServerClick(sender As Object, e As System.EventArgs) Handles lnkArea.ServerClick
        Response.Redirect("AddArea.aspx", True)
    End Sub

    Protected Sub lnkArea2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkArea2.ServerClick
        Response.Redirect("ViewArea.aspx", True)
    End Sub

    Protected Sub lnkUser_ServerClick(sender As Object, e As System.EventArgs) Handles lnkUser.ServerClick
        Response.Redirect("AddUser.aspx", True)
    End Sub

    Protected Sub lnkUser2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkUser2.ServerClick
        Response.Redirect("ViewUser.aspx", True)
    End Sub

    Protected Sub lnkAttendanceForm_ServerClick(sender As Object, e As System.EventArgs) Handles lnkAttendanceForm.ServerClick
        Response.Redirect("AttendanceForm.aspx", True)
    End Sub

    Protected Sub lnkAttendanceLog_ServerClick(sender As Object, e As System.EventArgs) Handles lnkAttendanceLog.ServerClick
        Response.Redirect("AttendanceLog.aspx", True)
    End Sub

    Protected Sub lnkAdmit_ServerClick(sender As Object, e As System.EventArgs) Handles lnkAdmit.ServerClick
        Response.Redirect("AdmitPatient.aspx", True)
    End Sub

    Protected Sub lnkAdmit2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkAdmit2.ServerClick
        Response.Redirect("AdmittedPatients.aspx", True)
    End Sub

    Protected Sub lnkDis_ServerClick(sender As Object, e As System.EventArgs) Handles lnkDis.ServerClick
        Response.Redirect("AddDischarge.aspx", True)
    End Sub

    Protected Sub lnkDis2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkDis2.ServerClick
        Response.Redirect("ViewDischarge.aspx", True)
    End Sub
    Protected Sub lnkCity_ServerClick(sender As Object, e As System.EventArgs) Handles lnkCity.ServerClick
        Response.Redirect("AddCity.aspx", True)
    End Sub

    Protected Sub lnkCity2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkCity2.ServerClick
        Response.Redirect("ViewCity.aspx", True)
    End Sub
    Protected Sub lnkUltrasound_ServerClick(sender As Object, e As System.EventArgs) Handles lnkUltrasound.ServerClick
        Response.Redirect("EditOP_Ultrasound.aspx", True)
    End Sub

    Protected Sub lnkUltrasound2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkUltrasound2.ServerClick
        Response.Redirect("ViewOP_Ultrasound.aspx", True)
    End Sub

    Protected Sub lnkMed_ServerClick(sender As Object, e As System.EventArgs) Handles lnkMed.ServerClick
        Response.Redirect("EditOP_MedSer.aspx", True)
    End Sub
    Protected Sub lnkMed2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkMed2.ServerClick
        Response.Redirect("ViewOP_MedSer.aspx", True)
    End Sub

    Protected Sub D1_ServerClick(sender As Object, e As System.EventArgs) Handles D1.ServerClick
        Response.Redirect("EditOP_Dental.aspx", True)
    End Sub
    Protected Sub D2_ServerClick(sender As Object, e As System.EventArgs) Handles D2.ServerClick
        Response.Redirect("ViewOP_Dental.aspx", True)
    End Sub
    Protected Sub lnkcons_ServerClick(sender As Object, e As System.EventArgs) Handles lnkcons.ServerClick
        Response.Redirect("AddConsultantion.aspx", True)
    End Sub
    Protected Sub lnkcons2_ServerClick(sender As Object, e As System.EventArgs) Handles lnkcons2.ServerClick
        Response.Redirect("ViewConsultantion.aspx", True)
    End Sub
    Protected Sub A1_ServerClick(sender As Object, e As System.EventArgs) Handles A1.ServerClick
        Response.Redirect("AddInBilling.aspx", True)
    End Sub
    Protected Sub A2_ServerClick(sender As Object, e As System.EventArgs) Handles A2.ServerClick
        Response.Redirect("ViewBilling.aspx", True)
    End Sub
End Class
