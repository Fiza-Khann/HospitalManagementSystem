<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddCity.aspx.cs" Inherits="HMS_Task1.AddCity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .display {
            display: none;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Setup</a></li>
            <li class="active">City</li>
        </ol>
        <!-- Main content -->
        <!-- /.content -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                                        <h4>Setup: City</h4>
                                    </div>
                                     <div class="mr-25">
                                <a class="btn btn-primary" href="ViewCity.aspx">View City</a>
                            </div>
                                </div>
                                <div class="panel-body">
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
                                                            <!-- City Name -->
                                                            <div class="form-group row">
                                                                <label for="CityName" class="col-xs-3 col-form-label">City Name <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtCity" CssClass="form-control text-box single-line" runat="server" placeholder="City Name"></asp:TextBox>
                                                                     <asp:RequiredFieldValidator ID="rfvRoom" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtCity" ErrorMessage="City Name is required" CssClass="error" />
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
        </asp:UpdatePanel>
    </div>
</asp:Content>