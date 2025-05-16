<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AttendanceLog.aspx.cs" Inherits="HMS_Task1.AttendanceLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function handleCheckboxSelection(chkSelect) {
            var checkboxes = document.querySelectorAll('#<%= MainGrid.ClientID %> input[type=checkbox]');
            checkboxes.forEach(function (checkbox) {
                if (checkbox !== chkSelect) {
                    checkbox.checked = false;
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Attendance</a></li>
            <li class="active">Attendance Log</li>
        </ol>
        <!-- Main content -->
        <div class="content">
            <div class="se-pre-con" style="display: none;"></div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>View Attendance Log</h4>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <div class="row">
                                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                    <div class="dataTables_info">
                                        Total
                                       
                                        <asp:Label ID="lblCount" runat="server"></asp:Label>
                                        entries
                                   
                                    </div>
                                </div>
                                <div class="row">
                                    <asp:UpdatePanel ID="UpdatePanel2aa" runat="server">
                                        <contenttemplate>
                                            <div style="overflow-x: auto;">
                                                <asp:GridView ID="MainGrid" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                    BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ID"
                                                    Font-Size="12px" Font-Names="Arial" Width="100%" CssClass="table table-bordered">
                                                    <columns>
                                                        <asp:TemplateField>
                                                            <headertemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                                            </headertemplate>
                                                            <itemtemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" OnClick="handleCheckboxSelection(this);" />
                                                            </itemtemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ID" HeaderText="ID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="Date" HeaderText="Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px" />
                                                        <asp:BoundField DataField="Time" HeaderText="Time" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px" />
                                                        <asp:BoundField DataField="Shift" HeaderText="Shift" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="LoginID" HeaderText="Login ID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="250px" />
                                                    </columns>
                                                    <headerstyle backcolor="#336699" forecolor="White" height="30px" />
                                                </asp:GridView>
                                            </div>
                                            <br />
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-success" OnClick="btnDelete_Click" />
                                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                                        </contenttemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
