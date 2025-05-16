<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ChangePass.aspx.cs" Inherits="HMS_Task1.ChangePass" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .display {
            display: none;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script type="text/javascript">
        // Function to toggle password visibility
        function togglePasswordVisibility(textBoxId, checkbox) {
            var txt = document.getElementById('<%= txtOldPassword.ClientID %>'); // Default to txtOldPassword
            if (textBoxId === 'txtNewPassword') {
                txt = document.getElementById('<%= txtNewPassword.ClientID %>'); // Change to txtNewPassword
            } else if (textBoxId === 'txtConfirmPassword') {
                txt = document.getElementById('<%= txtConfirmPassword.ClientID %>'); // Change to txtConfirmPassword
            }

            // Toggle the password visibility based on checkbox state
            if (checkbox.checked) {
                txt.type = 'text'; // Show password
            } else {
                txt.type = 'password'; // Hide password
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li class="active">Change Password</li>
        </ol>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <contenttemplate>
                <div class="content">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="panel panel-bd">
                                <div class="panel-heading">
                                    <div class="panel-title">
                                        <h4>Change Password</h4>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="panel panel-default thumbnail">
                                                <div class="panel-body panel-form">
                                                    <div class="row">
                                                        <div class="col-md-9 col-sm-12">
                                                            <!-- Old Password -->
                                                            <div class="form-group row">
                                                                <label for="txtOldPassword" class="col-xs-3 col-form-label">Old Password <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter old password"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvOld" runat="server" ControlToValidate="txtOldPassword" ValidationGroup="SaveGroup" CssClass="error" ErrorMessage="Old Password is required" />
                                                                    <br />
                                                                    <asp:CheckBox ID="chkShowOld" runat="server" Text="Show Password" OnClick="return togglePasswordVisibility('txtOldPassword', this);" />
                                                                </div>
                                                            </div>

                                                            <!-- New Password -->
                                                            <div class="form-group row">
                                                                <label for="txtNewPassword" class="col-xs-3 col-form-label">New Password <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter new password"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvNew" runat="server" ControlToValidate="txtNewPassword" ValidationGroup="SaveGroup" CssClass="error" ErrorMessage="New Password is required" />
                                                                    <br />
                                                                    <asp:CheckBox ID="chkShowNew" runat="server" Text="Show Password" OnClick="return togglePasswordVisibility('txtNewPassword', this);" />
                                                                </div>
                                                            </div>

                                                            <!-- Confirm Password -->
                                                            <div class="form-group row">
                                                                <label for="txtConfirmPassword" class="col-xs-3 col-form-label">Confirm Password <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Re-enter new password"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirmPassword" ValidationGroup="SaveGroup" CssClass="error" ErrorMessage="Confirm Password is required" />
                                                                    <br />
                                                                    <asp:CheckBox ID="chkShowConfirm" runat="server" Text="Show Password" OnClick="return togglePasswordVisibility('txtConfirmPassword', this);" />
                                                                </div>
                                                            </div>

                                                            <!-- Buttons -->
                                                            <div class="form-group row">
                                                                <div class="col-sm-offset-3 col-sm-6">
                                                                    <div class="ui buttons">
                                                                        <asp:Button ID="btnChangePassword" runat="server" Text="Save" CssClass="ui positive button" OnClick="btnChangePassword_Click" ValidationGroup="SaveGroup" />
                                                                        <div class="or"></div>
                                                                        <asp:Button ID="btnExit" runat="server" Text="Exit" CssClass="ui button" CausesValidation="false" PostBackUrl="~/Dashboard.aspx" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <div class="col-md-offset-2 col-md-10">
                                                                    <asp:Label ID="lblMessage" runat="server" CssClass="text-success"></asp:Label>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- /.col-md-9 -->
                                                    </div>
                                                    <!-- /.row -->
                                                </div>
                                                <!-- /.panel-body -->
                                            </div>
                                            <!-- /.thumbnail -->
                                        </div>
                                    </div>
                                </div>
                                <!-- /.panel-body -->
                            </div>
                        </div>
                    </div>
                </div>
            </contenttemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
