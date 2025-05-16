<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ViewOP_Xray.aspx.cs" Inherits="HMS_Task4.ViewOP_Xray" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a>Out-Patient</a></li>
            <li class="active">X-RAY</li>
        </ol>
        <!-- Main content -->
        <div class="content">
            <div class="se-pre-con" style="display: none;"></div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>View X-RAY</h4>
                            </div>
                            <div class="mr-25">
                                <a class="btn btn-primary" href="EditOP_Xray.aspx">Edit X-RAY</a>
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
                                        <ContentTemplate>
                                            <div style="overflow-x: auto;">
                                                <asp:GridView ID="MainGrid" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                    BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ReceiptNo"
                                                    Font-Size="12px" Font-Names="Arial" Width="100%" CssClass="table table-bordered">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" OnClick="handleCheckboxSelection(this);" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="TokenNo" HeaderText="Token" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="ReceiptNo" HeaderText="Rcp #" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="Type" HeaderText="Type" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="NetAmount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="PatientName" HeaderText="PatientName" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="Consultant" HeaderText="ConsulantName" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px" />
                                                        <asp:BoundField DataField="NoOfPrints" HeaderText="NoOfPrint" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                    </Columns>
                                                    <HeaderStyle BackColor="#336699" ForeColor="White" Height="30px" />
                                                </asp:GridView>
                                            </div>
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
        </div>
    </div>
</asp:Content>
