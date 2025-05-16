<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="HMS_Task1.Profile" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .profile-container {
            text-align: center;
            padding: 30px;
        }

        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 2px solid #ccc;
        }

        .profile-details {
            margin-top: 20px;
        }

        .table-container {
            margin: 40px auto;
            width: 80%;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server" enctype="multipart/form-data">
    <div class="content-wrapper">
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li class="active">Profile</li>
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
                                        <h4>Profile</h4>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="panel panel-default thumbnail">
                                                <div class="panel-body panel-form">
                                                    <div class="row">
                                                        <div class="col-md-9 col-sm-12">
                                                            <div class="profile-container">
                                                                <asp:Image ID="imgProfile" runat="server" CssClass="profile-img" />

                                                                <div class="profile-details">
                                                                    <h3>
                                                                        <asp:Label ID="lblName" runat="server" /></h3>
                                                                    <p><strong>Email:</strong>
                                                                        <asp:Label ID="lblEmail" runat="server" /></p>
                                                                    <p><strong>Designation:</strong>
                                                                        <asp:Label ID="lblDesignation" runat="server" /></p>
                                                                </div>
                                                            </div>

                                                            <div class="table-container">
                                                                <h4>Attendance Details</h4>
                                                                <asp:GridView ID="gvAttendance" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" />
                                                                        <asp:BoundField DataField="Status" HeaderText="Status" />
                                                                        <asp:BoundField DataField="Time" HeaderText="Time" />
                                                                        <asp:BoundField DataField="Shift" HeaderText="Shift" />
                                                                    </Columns>
                                                                </asp:GridView>
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
