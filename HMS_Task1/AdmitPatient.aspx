<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AdmitPatient.aspx.cs" Inherits="HMS_Task1.AdmitPatient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .display {
            display: none;
        }

        .input-container {
            display: flex;
            align-items: center;
        }

        .custom-width {
            width: 50px;
            margin-right: 2px;
        }

        .custom-width1 {
            width: 100px;
            margin-right: 2px;
        }

        .separator {
            margin: 5px;
        }

        .final-settlement-label {
            white-space: nowrap;
            overflow: visible;
            text-overflow: ellipsis;
            margin-left: -13px;
        }

        .letter-margin {
            margin-top: -35px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Admission</a></li>
            <li class="active">Admit New Patient</li>
        </ol>
        <!-- Main content -->
        <!-- /.content -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <contenttemplate>
                <div class="content">
                    <!-- load messages -->
                    <div class="se-pre-con" style="display: none;"></div>
                    <!-- load custom page -->
                    <div class="row">
                        <!-- table area -->
                        <div class="col-sm-12">
                            <div class="panel panel-bd">
                                <div class="panel-heading">
                                    <div class="panel-title">
                                        <h4>Add: Admit New Patient</h4>
                                    </div>
                                     <div class="mr-25">
                                <a class="btn btn-primary" href="AdmittedPatients.aspx">Patients List</a>
                            </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="panel-body panel-form" style="margin-bottom: -130px;">
                                                    <div class="form-group row">
                                                        <label for="labelSerial" class="col-xs-4 col-form-label">Serial No.</label>
                                                        <div class="col-xs-8">
                                                            <div class="input-container">
                                                                <asp:TextBox ID="txtSerial" CssClass="form-control text-box single-line custom-width1" readonly="True" runat="server"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="panel-body panel-form" style="margin-bottom: -130px;">
                                                    <div class="form-group row">
                                                        <label for="labelRegNo" class="col-xs-4 col-form-label">Reg No.</label>
                                                        <div class="col-xs-8">
                                                            <div class="input-container">
                                                                <asp:TextBox ID="txtReg" CssClass="form-control text-box single-line custom-width" runat="server" readonly="true"></asp:TextBox>
                                                                <span class="separator">-</span>
                                                                <asp:TextBox ID="txtNo" CssClass="form-control text-box single-line custom-width1" runat="server" TextMode="Number" readonly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-heading">
                                            <div class="panel-title text-success">
                                                <h4>General Information</h4>
                                            </div>
                                            <div class="panel panel-default thumbnail">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="Title" class="col-xs-4 col-form-label">Title</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlTitle" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Text="Select Title" Value="" />
                                                                        <asp:ListItem Text="Mr" Value="Mr." Selected="True" />
                                                                        <asp:ListItem Text="Mrs" Value="Mrs." />
                                                                        <asp:ListItem Text="Miss" Value="Miss" />
                                                                        <asp:ListItem Text="Other" Value="Baby" />
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                             <div class="form-group row">
                                                                <label for="RelationName" class="col-xs-4 col-form-label">Relation Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtRelationName" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Gender" class="col-xs-4 col-form-label">Gender</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlGender" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Text="Select Gender" Value="" />
                                                                        <asp:ListItem Text="Male" Value="Male" Selected="True" />
                                                                        <asp:ListItem Text="Female" Value="Female" />
                                                                        <asp:ListItem Text="Other" Value="Other" />
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Address" class="col-xs-4 col-form-label">Address<i class="text-danger">*</i></label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAddress" CssClass="form-control text-box single-line" runat="server" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtAddress" ErrorMessage="Address is required" CssClass="error" />

                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Cont1" class="col-xs-4 col-form-label">Contact (1)</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtCont1" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>


                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="PatientName" class="col-xs-4 col-form-label">Patient Name<i class="text-danger">*</i></label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtPatientName" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvPatientName" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtPatientName" ErrorMessage="Patient Name is required" CssClass="error" />
                                                                </div>
                                                            </div>
                                                           
                                                            <div class="form-group row">
                                                                <label for="Relation" class="col-xs-4 col-form-label">Relation</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtRelation" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group row">
                                                                        <label for="Age" class="col-xs-4 col-form-label">Age</label>
                                                                        <div class="col-xs-8">
                                                                            <asp:TextBox ID="txtAge" TextMode="Number" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group row">
                                                                        <div class="col-xs-8">
                                                                            <asp:DropDownList ID="ddlAgeValue" runat="server" CssClass="form-control">
                                                                                <asp:ListItem Text="Select Age Unit" Value="" />
                                                                                <asp:ListItem Text="Y" Value="Y" Selected="True" />
                                                                                <asp:ListItem Text="M" Value="M" />
                                                                                <asp:ListItem Text="D" Value="D" />
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="AreaName" class="col-xs-4 col-form-label">Area Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlAreaName" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Cont2" class="col-xs-4 col-form-label">Contact (2) / Email</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtCont2" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Emergency" class="col-xs-4 col-form-label">Emergency</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtEmergency" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="ReferenceName" class="col-xs-4 col-form-label">Reference Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlrefname" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Room" class="col-xs-4 col-form-label">Room</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlRoom" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <label for="Consultant" class="col-xs-4 col-form-label">Consultant</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlConsultant" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <label for="CityName" class="col-xs-4 col-form-label">City Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlCityName" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <label for="Mobile" class="col-xs-4 col-form-label">Mobile<i class="text-danger">*</i></label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtMobile" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtMobile" ErrorMessage="Mobile Number is required" CssClass="error" />

                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="bmj#" class="col-xs-4 col-form-label">Bmj#</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtbmj" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="AccountType" class="col-xs-4 col-form-label">Account Type</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlAccountType" runat="server" CssClass="form-control">
                                                                        <asp:ListItem Text="Select Account Type" Value="" />
                                                                        <asp:ListItem Text="PUBLIC" Value="PUBLIC" Selected="True" />
                                                                        <asp:ListItem Text="BMJ NEW" Value="BMJ NEW" />
                                                                        <asp:ListItem Text="SPF" Value="SPF" />
                                                                        <asp:ListItem Text="ZF" Value="ZF" />
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <div class="panel-body" style="margin-top: -60px;">
                                        <div class="panel-heading">
                                            <div class="panel-title text-success">
                                                <h4>Admission & Discharge</h4>
                                            </div>
                                            <div class="panel panel-default thumbnail">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="AdmDate" class="col-xs-4 col-form-label">Adm. Date</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdmDate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="AdmissionRemarks" class="col-xs-4 col-form-label">Admission Remarks</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdmissionRemarks" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="DischargeDate" class="col-xs-4 col-form-label">Discharge Date</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDischargeDate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="AdmTime" class="col-xs-4 col-form-label">Adm. Time</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdmTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="AdmissionLoginId" class="col-xs-4 col-form-label">Login ID<i class="text-danger">*</i></label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdmissionLoginId" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvAdmissionLoginId" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtAdmissionLoginId" ErrorMessage="Login Id is required" CssClass="error" />

                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="DischargeTime" class="col-xs-4 col-form-label">Discharge Time</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDischargeTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="AdmittedFor" class="col-xs-4 col-form-label">Admitted For</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdmittedFor" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Discharged" class="col-xs-4 col-form-label">Discharged</label>
                                                                <div class="col-xs-8">
                                                                    <asp:CheckBox ID="chkDischarged" runat="server" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="DischargeRemarks" class="col-xs-4 col-form-label">Discharge Remarks</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDischargeRemarks" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <!-- Buttons -->
                                    <div class="form-group row">
                                        <div class="col-sm-offset-3 col-sm-6">
                                            <div class="ui buttons">
                                                <asp:Button ID="BNew" runat="server" Text="Clear" CssClass="ui button" OnClick="BClear_Click" CausesValidation="false" />
                                                <div class="or"></div>
                                                <asp:Button ID="BSave" runat="server" Text="Save" CssClass="ui positive button" ValidationGroup="SaveGroup" OnClick="BSave_Click" />
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
            </contenttemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
