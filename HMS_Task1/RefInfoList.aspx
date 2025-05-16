<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="RefInfoList.aspx.cs" Inherits="HMS_Task1.RefInfoList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .padded-column {
            padding-left: 10px; /* Adjust the padding value as needed */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Setup</a></li>
            <li class="active">Reference List</li>
        </ol>

        <div class="content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>View: Reference Information</h4>
                            </div>
                            <div class="mr-25">
                                <a class="btn btn-primary" href="RefInfo.aspx">Edit Reference Information</a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                            <div class="dataTables_info">
                                Total <asp:Label ID="lblCount" runat="server"></asp:Label> entries
                            </div>
                            <asp:UpdatePanel ID="UpdatePanel2aa" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="MainGrid" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ID"
                                        Font-Size="12px" Font-Names="Arial" Width="100%">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelect" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ID" HeaderText="Reference ID" />
                                            <asp:BoundField DataField="ReferenceName" HeaderText="Reference Name" />
                                        </Columns>
                                        <HeaderStyle BackColor="#336699" ForeColor="White" />
                                    </asp:GridView>
                                    <br />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-success" OnClick="btnDelete_Click" />
                                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>