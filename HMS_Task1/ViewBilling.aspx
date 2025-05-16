<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ViewBilling.aspx.cs" Inherits="HMS_Task1.ViewBilling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .padded-column {
            padding-left: 10px; /* Adjust the padding value as needed */
        }
    </style>
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
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Billing</a></li>
            <li class="active">View Billing</li>
        </ol>

        <div class="content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>View: View Billing</h4>
                            </div>
                            <div class="mr-25">
                                <a class="btn btn-primary" href="AddInBilling.aspx">Add Billing</a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                            <div class="dataTables_info">
                                Total
                                <asp:Label ID="lblCount" runat="server"></asp:Label>
                                entries
                            </div>
                            <asp:UpdatePanel ID="UpdatePanelPatientList" runat="server">
                                <ContentTemplate>
                                    <!-- Wrapper div for horizontal scrolling -->
                                    <div style="overflow-x: auto; white-space: nowrap;">
                                        <asp:GridView ID="MainGrid" runat="server" AutoGenerateColumns="False" BackColor="White"
                                            BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="BillNo"
                                            Font-Size="12px" Font-Names="Arial" Width="100%">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" OnClick="handleCheckboxSelection(this);" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="BillNo" HeaderText="Bill No" SortExpression="BillNo" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="BillingDate" HeaderText="Billing Date" SortExpression="BillingDate" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="BillingTime" HeaderText="Billing Time" SortExpression="BillingTime" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="SerialNo" HeaderText="Serial No" SortExpression="SerialNo" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="PackageCheckbox" HeaderText="Package" SortExpression="PackageCheckbox" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="PackageList" HeaderText="Package List" SortExpression="PackageList" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="RoomCharges" HeaderText="Room Charges" SortExpression="RoomCharges" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="XRay" HeaderText="X-Ray" SortExpression="XRay" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="MedicalServices" HeaderText="Medical Services" SortExpression="MedicalServices" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="Misc" HeaderText="Misc" SortExpression="Misc" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="Consultant" HeaderText="Consultant" SortExpression="Consultant" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="Ultrasound" HeaderText="Ultrasound" SortExpression="Ultrasound" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="TotalHospitalCharges" HeaderText="Total Hospital Charges" SortExpression="TotalHospitalCharges" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="TotalConsultantCharges" HeaderText="Total Consultant Charges" SortExpression="TotalConsultantCharges" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="SPD" HeaderText="SPD" SortExpression="SPD" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="ZF" HeaderText="ZF" SortExpression="ZF" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="DischargeCheckbox" HeaderText="Discharged" SortExpression="DischargeCheckbox" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="DischargeDate" HeaderText="Discharge Date" SortExpression="DischargeDate" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="DischargeTime" HeaderText="Discharge Time" SortExpression="DischargeTime" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" ItemStyle-Width="200px" />
                                                <asp:BoundField DataField="BillTotalCharges" HeaderText="Bill Total Charges" SortExpression="BillTotalCharges" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="DepositedAmount" HeaderText="Deposited Amount" SortExpression="DepositedAmount" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="Discount" HeaderText="Discount" SortExpression="Discount" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="ToBeRefunded" HeaderText="To Be Refunded" SortExpression="ToBeRefunded" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="NetBalance" HeaderText="Net Balance" SortExpression="NetBalance" ItemStyle-Width="150px" />

                                            </Columns>
                                            <HeaderStyle BackColor="#336699" ForeColor="White" />
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
</asp:Content>
