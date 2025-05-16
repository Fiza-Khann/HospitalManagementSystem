<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ConsultantList.aspx.cs" Inherits="HMS_template_Project.ConsultantList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Consultant</a></li>
            <li class="active">Manage Consultants</li>
        </ol>
        <!-- Main content -->
        <div class="content">
            <div class="se-pre-con" style="display: none;"></div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>Consultant</h4>
                            </div>
                            <div class="mr-25">
                                <a class="btn btn-primary" href="AddConsultant.aspx">Add Consultant</a>
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
                                                    BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ConsultantID"
                                                    Font-Size="12px" Font-Names="Arial" Width="100%" CssClass="table table-bordered">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ConsultantID" HeaderText="ID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="80px" />
                                                        <asp:BoundField DataField="ConsultantName" HeaderText="Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="Degrees" HeaderText="Degrees" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                        <asp:BoundField DataField="Timing" HeaderText="Timing" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                        <asp:BoundField DataField="Faculty" HeaderText="Faculty" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                        <asp:BoundField DataField="Address" HeaderText="Address" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px" />
                                                        <asp:BoundField DataField="Telephone" HeaderText="Telephone" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                        <asp:BoundField DataField="Fax" HeaderText="Fax" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                        <asp:BoundField DataField="Mobile" HeaderText="Mobile" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                        <asp:BoundField DataField="Email" HeaderText="Email" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="ConsultantCharges" HeaderText="Consultant Charges" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" DataFormatString="{0:C}" />
                                                        <asp:BoundField DataField="Type" HeaderText="Type" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="100px" />
                                                        <asp:BoundField DataField="TestTypeID" HeaderText="Test Type ID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" />
                                                        <asp:BoundField DataField="ConsultantShareOutdoor" HeaderText="Consultant Share Outdoor" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="180px" DataFormatString="{0:P2}" />
                                                        <asp:BoundField DataField="ConsultantShareIndoor" HeaderText="Consultant Share Indoor" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="180px" DataFormatString="{0:P2}" />
                                                        <asp:BoundField DataField="HospitalShareOutdoor" HeaderText="Hospital Share Outdoor" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="180px" DataFormatString="{0:P2}" />
                                                        <asp:BoundField DataField="HospitalShareIndoor" HeaderText="Hospital Share Indoor" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="180px" DataFormatString="{0:P2}" />
                                                        <asp:BoundField DataField="OPDpaid" HeaderText="OPD Paid" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" DataFormatString="{0}" />
                                                        <asp:BoundField DataField="SurgeryCharges" HeaderText="Surgery Charges" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" DataFormatString="{0:C}" />
                                                        <asp:BoundField DataField="AnesCharges" HeaderText="Anesthesia Charges" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" DataFormatString="{0:C}" />
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
