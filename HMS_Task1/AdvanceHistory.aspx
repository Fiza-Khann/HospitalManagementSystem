<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AdvanceHistory.aspx.cs" Inherits="HMS_Task2.AdvanceHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Billing</a></li>
            <li class="active">Advance History</li>
        </ol>
        <!-- Main content -->
        <div class="content">
            <div class="se-pre-con" style="display: none;"></div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>Advance History</h4>
                            </div>
                            <div class="mr-25">
                                <a class="btn btn-primary" href="AdvanceInfo.aspx">View Advance Information</a>
                            </div>
                            <br />
                            <p class="text-primary">(press select to retrieve)</p>
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
                                            <asp:GridView ID="MainGrid" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="Receipt"
                                                Font-Size="12px" Font-Names="Arial" Width="100%" Height="252px" OnSelectedIndexChanged="MainGrid_SelectedIndexChanged">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelect" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Receipt" HeaderText="Receipt" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="SerialNo" HeaderText="SerialNo" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="AdvanceDate" HeaderText="Advance Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="AdvanceTime" HeaderText="Advance Time" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="Type" HeaderText="Type" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="LastUpdate" HeaderText="Last Update" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:BoundField DataField="LastUpdateTime" HeaderText="Last Update Time" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"/>
                                                    <asp:ButtonField ButtonType="Button" ItemStyle-CssClass="padded-column" CommandName="Select" Text="Select" HeaderText="Action" />
                                                </Columns>
                                                <HeaderStyle BackColor="#336699" ForeColor="White" Height="30px" />
                                            </asp:GridView>
                                            <br />
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-lg-4 col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label for="txtPrevious" class="font-weight-bold">Previous:</label>
                                                            <asp:TextBox ID="txtPrevious" runat="server" CssClass="form-control" Text="0" ReadOnly="True" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-6 mb-3">
                                                        <div class="form-group">
                                                            <label for="txtCurrent" class="font-weight-bold">Current:</label>
                                                            <asp:TextBox ID="txtCurrent" runat="server" CssClass="form-control" Text="0" ReadOnly="False" AutoPostBack="True" OnTextChanged="txtCurrent_TextChanged" />
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-4 col-md-12 mb-3">
                                                        <div class="form-group">
                                                            <label for="txtNetTotal" class="font-weight-bold">Net Total:</label>
                                                            <asp:TextBox ID="txtNetTotal" runat="server" CssClass="form-control" Text="0" ReadOnly="True" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />
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
