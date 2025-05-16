<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="IPDEdit_Xray.aspx.cs" Inherits="HMS_Task1.IPDEdit_Xray" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">In-Patient</a></li>
            <li class="active">X-RAY</li>
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
                                        <h4>Add: X-RAY</h4>
                                    </div>
                                    <div class="mr-25">
                                        <a class="btn btn-primary" href="IPDView_Xray.aspx">View X-RAY</a>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="panel-body panel-form">
                                                    <div class="form-group row">
                                                        <label for="labelCategory" class="col-xs-4 col-form-label">CATEGORY</label>
                                                        <div class="col-xs-8">
                                                            <asp:DropDownList ID="ddlCat" CssClass="form-control" runat="server">
                                                                <asp:ListItem Value="1">X-RAY</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="panel panel-default thumbnail">
                                                    <div class="panel-body panel-form">
                                                        <div class="row">
                                                            <div class="col-md-9 col-sm-12">
                                                                <!-- ID -->
                                                                <div class="form-group row">
                                                                    <label for="id" class="col-xs-3 col-form-label">ID</label>
                                                                    <div class="col-xs-9">
                                                                        <asp:TextBox ID="txtId" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <!-- Name -->
                                                                <div class="form-group row">
                                                                    <label for="Name" class="col-xs-3 col-form-label">Name<i class="text-danger">*</i></label>
                                                                    <div class="col-xs-9">
                                                                        <asp:TextBox ID="txtName" CssClass="form-control text-box single-line" runat="server" placeholder="Name"></asp:TextBox>
                                                                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="error" />
                                                                    </div>
                                                                </div>
                                                                <!-- Charges -->
                                                                <div class="form-group row">
                                                                    <label for="Charges" class="col-xs-3 col-form-label">Charges</label>
                                                                    <div class="col-xs-9">
                                                                        <asp:TextBox ID="txtCharges" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <!-- Consultant Share -->
                                                                <div class="form-group row">
                                                                    <label for="ConsultantShare" class="col-xs-3 col-form-label">Consultant Share %</label>
                                                                    <div class="col-xs-9">
                                                                        <asp:TextBox ID="txtConsultantShare" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                                <!-- Hospital Share -->
                                                                <div class="form-group row">
                                                                    <label for="HospitalShare" class="col-xs-3 col-form-label">Hospital Share %</label>
                                                                    <div class="col-xs-9">
                                                                        <asp:TextBox ID="txtHospitalShare" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0"></asp:TextBox>
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
                                                    <asp:Button ID="BSave" runat="server" Text="Save" CssClass="ui positive button" OnClick="BSave_Click" />
                                                    <div class="or"></div>
                                                    <asp:Button ID="BExit" runat="server" Text="Exit" CssClass="ui button" OnClick="BExit_Click" CausesValidation="false" />
                                                </div>
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
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="BSave" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
