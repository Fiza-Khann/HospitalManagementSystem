<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddConsultant.aspx.cs" Inherits="HMS_template_Project.AddConsultant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .display {
            display: none;
        }

        .field-container {
            margin-bottom: 15px;
        }

        .field-label {
            font-weight: bold;
        }

        .field-row {
            margin-bottom: 15px;
        }
    </style>


    <script type="text/javascript">
        function navigateWithValidation(linkId) {
            var form = document.querySelector('form');
            if (form) {
                form.setAttribute('novalidate', 'true');
            }

            var link = document.getElementById(linkId);
            if (link) {
                link.click();
                return;
            }
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Consultants</a></li>
            <li class="active">Add Consultant</li>
        </ol>
        <!-- Main content -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="content">

                    <!-- Load messages -->
                    <div class="se-pre-con" style="display: none;"></div>
                    <!-- Load custom page -->
                    <div class="row">
                        <!-- Table area -->
                        <div class="col-sm-12">
                            <div class="panel panel-bd">
                                <div class="panel-heading">
                                    <div class="panel-title">
                                        <h4>Add Consultant</h4>
                                    </div>
                                    <div class="mr-25">
                                        <a class="btn btn-primary" href="ConsultantList.aspx">View Consultant</a>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="panel panel-default thumbnail">
                                                <div class="panel-body panel-form">
                                                    <div class="row">
                                                        <div class="col-md-9 col-sm-12">
                                                            <!-- Consultant ID and Deactivate -->
                                                            <div class="form-group row field-row">
                                                                <div class="col-md-6">
                                                                    <label for="ConsultantID" class="col-form-label">Consultant ID</label>
                                                                    <asp:TextBox ID="txtConsultantID" CssClass="form-control text-box single-line" runat="server" ReadOnly="True"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label for="Deactivate" class="col-form-label">Deactivate</label>
                                                                    <asp:CheckBox ID="chkDeactivate" CssClass="form-control" runat="server" />
                                                                </div>
                                                            </div>
                                                            <!-- Consultant Name -->
                                                            <div class="form-group row">
                                                                <label for="ConsultantName" class="col-xs-3 col-form-label">Consultant Name <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtConsultantName" CssClass="form-control text-box single-line" runat="server" placeholder="Consultant Name"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvConsultantName" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtConsultantName" ErrorMessage="Consultant Name is required" CssClass="error" />
                                                                    <asp:RegularExpressionValidator ID="revConsultantName" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtConsultantName"
                                                                        ErrorMessage="Please enter a correct name" CssClass="error"
                                                                        ValidationExpression="^[a-zA-Z\s]+$" />
                                                                </div>
                                                            </div>

                                                            <!-- Address and Degree -->
                                                            <div class="form-group row field-row">
                                                                <div class="col-md-6">
                                                                    <label for="Address" class="col-form-label">Address</label>
                                                                    <asp:TextBox ID="txtAddress" TextMode="MultiLine" Height="92px" CssClass="form-control" runat="server" placeholder="Address"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label for="Degree" class="col-form-label">Degree</label>
                                                                    <asp:TextBox ID="txtDegree" CssClass="form-control text-box single-line" runat="server" placeholder="Degree"></asp:TextBox>
                                                                </div>
                                                            </div>


                                                            <!-- Mobile and Telephone -->
                                                            <div class="form-group row field-row">
                                                                <div class="col-md-6">
                                                                    <label for="Mobile" class="col-form-label">Mobile <i class="text-danger">*</i></label>
                                                                    <asp:TextBox ID="txtMobile" CssClass="form-control text-box single-line" runat="server" placeholder="Mobile"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvMobile" ValidationGroup="SaveGroup" runat="server" ControlToValidate="txtMobile" ErrorMessage="Mobile is required" CssClass="error" />
                                                                    <asp:RegularExpressionValidator ID="revMobile" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtMobile" ErrorMessage="Invalid Mobile Number" CssClass="error" ValidationExpression="^\d{10}$" />
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label for="Telephone" class="col-form-label">Telephone</label>
                                                                    <asp:TextBox ID="txtTelephone" CssClass="form-control text-box single-line" runat="server" placeholder="Telephone"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <!-- Fax and Email -->
                                                            <div class="form-group row field-row">
                                                                <div class="col-md-6">
                                                                    <label for="Fax" class="col-form-label">Fax</label>
                                                                    <asp:TextBox ID="txtFax" CssClass="form-control text-box single-line" runat="server" placeholder="Fax"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label for="Email" class="col-form-label">Email</label>
                                                                    <asp:TextBox ID="txtEmail" CssClass="form-control text-box single-line" runat="server" placeholder="Email"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <!-- Consultant Charges and Type -->
                                                            <div class="form-group row field-row">
                                                                <div class="col-md-6">
                                                                    <label for="ConsultantCharges" class="col-form-label">Consultant Charges (%)<i class="text-danger">*</i></label>
                                                                    <asp:TextBox ID="txtConsultantCharges" CssClass="form-control text-box single-line" runat="server" placeholder="Consultant Charges"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="revConsultantCharges" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtConsultantCharges" ErrorMessage="Invalid Consultant Charges" CssClass="error" ValidationExpression="^\d+(\.\d{1,2})?$" />
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label for="Type" class="col-form-label">Type</label>
                                                                    <asp:DropDownList ID="ddlType" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Value="1">General OPD</asp:ListItem>
                                                                        <asp:ListItem Value="2">Laboratory</asp:ListItem>
                                                                        <asp:ListItem Value="3">Consultant OPD</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <!-- Additional Charges Section -->
                                                            <div class="form-group row">
                                                                <div class="col-xs-12">
                                                                    <h4>Additional Charges</h4>
                                                                </div>
                                                            </div>
                                                            <!-- Consultant In-Patient & Out-Patient -->
                                                            <div class="form-group row field-row">
                                                                <div class="col-md-6">
                                                                    <label for="ConsultantInPatient" class="col-form-label">Consultant In-Patient (%)<i class="text-danger">*</i></label>
                                                                    <asp:TextBox ID="txtConsultantInPatient" CssClass="form-control text-box single-line" runat="server" placeholder="Consultant In-Patient"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="revConsultantInPatient" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtConsultantInPatient" ErrorMessage="Invalid Consultant In-Patient" CssClass="error" ValidationExpression="^\d+(\.\d{1,2})?$" />
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label for="ConsultantOutPatient" class="col-form-label">Consultant Out-Patient (%)<i class="text-danger">*</i></label>
                                                                    <asp:TextBox ID="txtConsultantOutPatient" CssClass="form-control text-box single-line" runat="server" placeholder="Consultant Out-Patient"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="revConsultantOutPatient" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtConsultantOutPatient" ErrorMessage="Invalid Consultant Out-Patient" CssClass="error" ValidationExpression="^\d+(\.\d{1,2})?$" />
                                                                </div>
                                                            </div>
                                                            <!-- Hospital In-Patient & Out-Patient -->
                                                            <div class="form-group row field-row">
                                                                <div class="col-md-6">
                                                                    <label for="HospitalInPatient" class="col-form-label">Hospital In-Patient (%)<i class="text-danger">*</i></label>
                                                                    <asp:TextBox ID="txtHospitalInPatient" CssClass="form-control text-box single-line" runat="server" placeholder="Hospital In-Patient"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="revHospitalInPatient" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtHospitalInPatient" ErrorMessage="Invalid Hospital In-Patient" CssClass="error" ValidationExpression="^\d+(\.\d{1,2})?$" />
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label for="HospitalOutPatient" class="col-form-label">Hospital Out-Patient (%)<i class="text-danger">*</i></label>
                                                                    <asp:TextBox ID="txtHospitalOutPatient" CssClass="form-control text-box single-line" runat="server" placeholder="Hospital Out-Patient"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="revHospitalOutPatient" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtHospitalOutPatient" ErrorMessage="Invalid Hospital Out-Patient" CssClass="error" ValidationExpression="^\d+(\.\d{1,2})?$" />
                                                                </div>
                                                            </div>
                                                            <!-- Empty row for spacing -->
                                                            <div class="form-group row spacer"></div>
                                                            <!-- Add this Label for messages -->
                                                            <asp:Label ID="lblErr" runat="server" ForeColor="Red" />

                                                            <!-- Buttons -->
                                                            <div class="form-group row">
                                                                <div class="col-sm-offset-3 col-sm-6">
                                                                    <div class="ui buttons">
                                                                        <asp:Button ID="BClear" runat="server" Text="Clear" CssClass="ui button" OnClick="BClear_Click" />
                                                                        <div class="or"></div>
                                                                        <asp:Button ID="BSave" runat="server" Text="Save" CssClass="ui positive button" ValidationGroup="SaveGroup" OnClick="BSave_Click" />
                                                                        <div class="or"></div>
                                                                        <asp:Button ID="BUpdate" runat="server" Text="Update" CssClass="ui button" OnClick="BUpdate_Click" />
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
        </asp:UpdatePanel>
    </div>
</asp:Content>

