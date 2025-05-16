<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="HMS_Task1.AddUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .display {
            display: none;
        }
        /* Modal styling */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
        }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
    </style>
    <script type="text/javascript">
        function previewProfilePicture(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    var img = document.getElementById('<%= imgProfilePic.ClientID %>');
                    img.src = e.target.result;
                    img.style.display = 'block'; // Make sure it's visible
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server" enctype="multipart/form-data">
    <div class="content-wrapper">
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Setup</a></li>
            <li class="active">Add User</li>
        </ol>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="content">
                    <div class="se-pre-con" style="display: none;"></div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="panel panel-bd">
                                <div class="panel-heading">
                                    <div class="panel-title">
                                        <h4>Setup: Add User</h4>
                                    </div>
                                    <div class="mr-25">
                                        <a class="btn btn-primary" href="ViewUser.aspx">View Users</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="panel panel-default thumbnail">
                                                <div class="panel-body panel-form">
                                                    <div class="row">
                                                        <div class="col-md-9 col-sm-12">
                                                            <div class="form-group row">
                                                                <div class="col-xs-9 text-center">
                                                                    <asp:Image
                                                                        ID="imgProfilePic"
                                                                        runat="server"
                                                                        Width="150"
                                                                        Height="150"
                                                                        CssClass="img-thumbnail"
                                                                        ImageUrl="~/images/users/userblue.png"
                                                                        Style="margin: 10px auto;" />
                                                                </div>

                                                            </div>
                                                            <!-- Profile Pic -->
                                                            <div class="form-group row">
                                                                <label for="profilePic" class="col-xs-3 col-form-label">Profile Picture</label>
                                                                <div class="col-xs-9">
                                                                    <asp:FileUpload
                                                                        ID="fuProfilePic"
                                                                        runat="server"
                                                                        CssClass="form-control"
                                                                        accept="image/*"
                                                                        onchange="previewProfilePicture(this);" />
                                                                    <small class="text-muted">Maximum file size: 2MB</small>
                                                                    <asp:Image ID="imgPreview" runat="server" CssClass="profile-pic-preview" Style="display: none; max-width: 200px; max-height: 200px;" />
                                                                    <asp:CustomValidator ID="cvProfilePic" runat="server"
                                                                        ControlToValidate="fuProfilePic"
                                                                        OnServerValidate="ValidateProfilePic"
                                                                        ErrorMessage="Please upload a valid image file (JPEG, PNG, GIF)"
                                                                        ValidationGroup="SaveGroup"
                                                                        CssClass="error" />
                                                                </div>
                                                            </div>

                                                            <!-- ID -->
                                                            <div class="form-group row">
                                                                <label for="id" class="col-xs-3 col-form-label">ID</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtId" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <!-- Name -->
                                                            <div class="form-group row">
                                                                <label for="name" class="col-xs-3 col-form-label">Username <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtName" CssClass="form-control" runat="server" placeholder="Full Name"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvName" ValidationGroup="SaveGroup" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="error" />
                                                                </div>
                                                            </div>

                                                            <!-- Login ID -->
                                                            <div class="form-group row">
                                                                <label for="loginId" class="col-xs-3 col-form-label">Login ID <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtLoginId" CssClass="form-control" runat="server" placeholder="Login ID"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvLoginId" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtLoginId" ErrorMessage="Login ID is required" CssClass="error" />
                                                                </div>
                                                            </div>

                                                            <!-- Email -->
                                                            <div class="form-group row">
                                                                <label for="email" class="col-xs-3 col-form-label">Email <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" placeholder="Email"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="error" />
                                                                </div>
                                                            </div>

                                                            <!-- Designation -->
                                                            <div class="form-group row">
                                                                <label for="designation" class="col-xs-3 col-form-label">Designation</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtDesignation" CssClass="form-control" runat="server" placeholder="Designation"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <!-- Buttons -->
                                                            <div class="form-group row">
                                                                <div class="col-sm-offset-3 col-sm-6">
                                                                    <div class="ui buttons">
                                                                        <asp:Button ID="BSave" runat="server" Text="Save" ValidationGroup="SaveGroup" CssClass="ui positive button" OnClick="BSave_Click" />
                                                                        <div class="or"></div>
                                                                        <asp:Button ID="BExit" runat="server" Text="Exit" CssClass="ui button" OnClick="BExit_Click" CausesValidation="false" />
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <div class="col-md-offset-2 col-md-10">
                                                                    <div class="btn-toolbar fixed-actions fill-container">
                                                                        <asp:Label ID="lblErr" runat="server"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="BSave" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
