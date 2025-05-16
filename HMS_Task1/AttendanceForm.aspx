<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AttendanceForm.aspx.cs" Inherits="HMS_Task1.AttendanceForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Attendance</a></li>
            <li class="active">Attendance Form</li>
        </ol>

        <!-- Main content -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="content">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="panel panel-bd">
                                <div class="panel-heading">
                                    <div class="panel-title">
                                        <h4>Attendance Form</h4>
                                    </div>
                                </div>

                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-8">
                                            <div class="panel-body panel-form">

                                                <div class="form-group row">
                                                    <label for="ID" class="col-xs-4 col-form-label">ID</label>
                                                    <div class="col-xs-8">
                                                        <asp:TextBox ID="txtID" CssClass="form-control text-box single-line" ReadOnly="true" runat="server" Required="True" />
                                                    </div>
                                                </div>
                                                <!-- Date Field -->
                                                <div class="form-group row">
                                                    <label for="Date" class="col-xs-4 col-form-label">Date</label>
                                                    <div class="col-xs-8">
                                                        <asp:TextBox ID="txtDate" CssClass="form-control text-box single-line" runat="server" TextMode="Date" Required="True" />
                                                    </div>
                                                </div>

                                                <!-- Time Field -->
                                                <div class="form-group row">
                                                    <label for="Time" class="col-xs-4 col-form-label">Time</label>
                                                    <div class="col-xs-8">
                                                        <asp:TextBox ID="txtTime" CssClass="form-control text-box single-line" runat="server" TextMode="Time" Required="True" />
                                                    </div>
                                                </div>

                                                <!-- Shift Dropdown -->
                                                <div class="form-group row">
                                                    <label for="Shift" class="col-xs-4 col-form-label">Shift</label>
                                                    <div class="col-xs-8">
                                                        <asp:DropDownList ID="ddlShift" CssClass="form-control" runat="server">
                                                            <asp:ListItem Value="Morning">Morning</asp:ListItem>
                                                            <asp:ListItem Value="Afternoon">Afternoon</asp:ListItem>
                                                            <asp:ListItem Value="Evening">Evening</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <!-- Status Dropdown -->
                                                <div class="form-group row">
                                                    <label for="Status" class="col-xs-4 col-form-label">Status</label>
                                                    <div class="col-xs-8">
                                                        <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server">
                                                            <asp:ListItem Value="Present">Present</asp:ListItem>
                                                            <asp:ListItem Value="Absent">Absent</asp:ListItem>
                                                            <asp:ListItem Value="On Leave">On Leave</asp:ListItem>
                                                            <asp:ListItem Value="Half Day">Half Day</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <!-- Login ID Field -->
                                                <div class="form-group row">
                                                    <label for="LoginID" class="col-xs-4 col-form-label">Login ID<i class="text-danger">*</i></label>
                                                    <div class="col-xs-8">
                                                        <asp:DropDownList ID="ddlLoginID" CssClass="form-control" runat="server"></asp:DropDownList>
                                                        <asp:RequiredFieldValidator
                                                            ID="rfvLoginID"
                                                            runat="server"
                                                            ControlToValidate="ddlLoginID"
                                                            InitialValue=""
                                                            ErrorMessage="Login ID is required"
                                                            CssClass="text-danger"
                                                            Display="Dynamic" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Buttons -->
                                    <div class="form-group row">
                                        <div class="col-sm-offset-3 col-sm-6">
                                            <div class="ui buttons">
                                                <asp:Button ID="BClear" runat="server" Text="Clear" CssClass="ui button" OnClick="BClear_Click" CausesValidation="false" />
                                                <div class="or"></div>
                                                <asp:Button ID="BSave" runat="server" ValidationGroup="SaveGroup" Text="Save" CssClass="ui positive button" OnClick="BSave_Click" />
                                                <div class="or"></div>
                                                <asp:Button ID="BExit" runat="server" Text="Exit" CssClass="ui button" OnClick="BExit_Click" CausesValidation="false" />
                                            </div>
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
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="BSave" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>

