<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddArea.aspx.cs" Inherits="HMS_Task1.AddArea" %>

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
            <li class="active">Area</li>
        </ol>
        <!-- Main content -->
        <!-- /.content -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                                        <h4>Setup: Area</h4>
                                    </div>
                                    <div class="mr-25">
                                        <a class="btn btn-primary" href="ViewArea.aspx">View Area</a>
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
                                                            <!-- Area Name -->
                                                            <div class="form-group row">
                                                                <label for="AreaName" class="col-xs-3 col-form-label">Area Name <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtArea" CssClass="form-control text-box single-line" runat="server" placeholder="Area Name"></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="rfvArea" runat="server" ValidationGroup="SaveGroup" ControlToValidate="txtArea" ErrorMessage="Area Name is required" CssClass="error" />
                                                                </div>
                                                            </div>
                                                            <!-- City Dropdown -->
                                                            <div class="form-group row">
                                                                <label for="ddlCity" class="col-xs-3 col-form-label">City <i class="text-danger">*</i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:DropDownList ID="ddlCity" CssClass="form-control" runat="server">
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="ddlCity"
                                                                        InitialValue="0" ErrorMessage="City is required" ValidationGroup="SaveGroup" CssClass="error" />
                                                                </div>
                                                            </div>

                                                            <!-- Buttons -->
                                                            <div class="form-group row">
                                                                <div class="col-sm-offset-3 col-sm-6">
                                                                    <div class="ui buttons">
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
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </contenttemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
