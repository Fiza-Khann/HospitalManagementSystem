<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddDischarge.aspx.cs" Inherits="HMS_Task1.AddDischarge" %>

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
            <li><a href="#">Discharge</a></li>
            <li class="active">Discharge Patient </li>
        </ol>
        <!-- Main content -->
        <!-- /.content -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
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
                                        <h4>Add: Discharge Patient</h4>
                                    </div>
                                     <div class="mr-25">
                                <a class="btn btn-primary" href="ViewDischarge.aspx">Discharge List</a>
                            </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="panel-body panel-form" style="margin-bottom: -130px;">
                                                    <div class="form-group row">
                                                        <label for="labelRegNo" class="col-xs-4 col-form-label">Reg No. <i class="text-danger">*</i></label>
                                                        <div class="col-xs-8">
                                                            <div class="input-container">
                                                                <asp:TextBox ID="txtReg" CssClass="form-control text-box single-line custom-width" runat="server" AutoPostBack="True" OnTextChanged="TxtReg_TextChanged"></asp:TextBox>
                                                                <span class="separator">-</span>
                                                                <asp:TextBox ID="txtNo" CssClass="form-control text-box single-line custom-width1" runat="server" TextMode="Number" AutoPostBack="True" OnTextChanged="TxtNo_TextChanged"></asp:TextBox>
                                                            </div>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="SaveGroup" runat="server" ControlToValidate="txtNo" ErrorMessage="Reg No is required" CssClass="error" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-heading">
                                            
                                            <div class="panel panel-default thumbnail">
                                                <div class="row">
                                                    <div class="col-md-8">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="labelSerial" class="col-xs-4 col-form-label">Serial No.</label>
                                                                <div class="col-xs-8">
                                                                    <div class="input-container">
                                                                        <asp:TextBox ID="txtSerial" CssClass="form-control text-box single-line custom-width1" ReadOnly="True" runat="server"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="PatientName" class="col-xs-4 col-form-label">Patient Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtPatientName" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="txtDStatus">Discharge Status:</label>
                                                                <asp:DropDownList ID="txtDStatus" runat="server" CssClass="form-control">
                                                                    <asp:ListItem Text="Select Status" Value="" />
                                                                    <asp:ListItem Text="Y" Value="Y" Selected="True" />
                                                                    <asp:ListItem Text="N" Value="N" />
                                                                </asp:DropDownList>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="txtDDate">Discharge Date:</label>
                                                                <asp:TextBox ID="txtDDate" runat="server" CssClass="form-control" TextMode="Date" />
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="txtDTime">Discharge Time:</label>
                                                                <asp:TextBox ID="txtDTime" runat="server" CssClass="form-control" TextMode="Time" />
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
