<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AdmittedPatients.aspx.cs" Inherits="HMS_Task1.AdmittedPatients" %>

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
            <li><a href="#">Admission</a></li>
            <li class="active">Patients List</li>
        </ol>

        <div class="content">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>View: Patient List</h4>
                            </div>
                            <div class="mr-25">
                                <a class="btn btn-primary" href="AdmitPatient.aspx">Add New Patient</a>
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
                                            BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="serialno"
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
                                                <asp:BoundField DataField="serialno" HeaderText="Serial No" SortExpression="serialno" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="Reg" HeaderText="Reg" SortExpression="Reg" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="Num" HeaderText="Num" SortExpression="Num" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="AdmDate" HeaderText="Adm Date" SortExpression="AdmDate" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="AdmTime" HeaderText="Adm Time" SortExpression="AdmTime" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="Bmj#" HeaderText="Bmj#" SortExpression="Bmj#" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="PatientName" HeaderText="Patient Name" SortExpression="PatientName" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="ConsultantName" HeaderText="Consultant Name" SortExpression="ConsultantName" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="RelationName" HeaderText="Relation Name" SortExpression="RelationName" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="Emergency" HeaderText="Emergency" SortExpression="Emergency" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="Mobile" HeaderText="Mobile" SortExpression="Mobile" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="OtherContact" HeaderText="Other Contact" SortExpression="OtherContact" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="ReferenceName" HeaderText="Reference Name" SortExpression="ReferenceName" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="AdmittedFor" HeaderText="Admitted For" SortExpression="AdmittedFor" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="AdmissionRemarks" HeaderText="Admission Remarks" SortExpression="AdmissionRemarks" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="AdmissionLoginId" HeaderText="Admission Login ID" SortExpression="AdmissionLoginId" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="Discharged" HeaderText="Discharged" SortExpression="Discharged" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="DischargeDate" HeaderText="Discharge Date" SortExpression="DischargeDate" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="DischargeTime" HeaderText="Discharge Time" SortExpression="DischargeTime" ItemStyle-Width="150px" />
                                                <asp:BoundField DataField="DischargeRemarks" HeaderText="Discharge Remarks" SortExpression="DischargeRemarks" ItemStyle-Width="180px" />
                                                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="AreaName" HeaderText="Area Name" SortExpression="AreaName" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" ItemStyle-Width="100px" />
                                                <asp:BoundField DataField="AgeNum" HeaderText="Age Num" SortExpression="AgeNum" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="AgeValue" HeaderText="Age Value" SortExpression="AgeValue" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="Typee" HeaderText="Typee" SortExpression="Typee" ItemStyle-Width="120px" />
                                                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" ItemStyle-Width="200px" />
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
