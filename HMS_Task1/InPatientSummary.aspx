<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="InPatientSummary.aspx.cs" Inherits="HMS_Task3.InPatientSummary" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .display {
            display: none;
        }

        .input-container {
            display: flex;
            align-items: center;
        }

        .custom-width {
            width: 50px;
            margin-right: 2px;
        }

        .custom-width1 {
            width: 100px;
            margin-right: 2px;
        }

        .separator {
            margin: 5px;
        }

        .final-settlement-label {
            white-space: nowrap;
            overflow: visible;
            text-overflow: ellipsis;
            margin-left: -13px;
        }

        .letter-margin {
            margin-top: -35px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-check-inline {
            display: inline-flex;
            align-items: center;
            margin-right: 1rem;
        }

        .stickyheader {
            position: sticky;
            top: 0px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            padding-top: 20px;
        }

        .modal-content {
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 60%;
            background-color: #fefefe;
            position: relative;
        }

        .modal-header {
            text-align: center;
            font-size: 1.5em;
        }

        .close-button {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 24px;
            font-weight: bold;
            color: #000;
            background: none;
            border: none;
            cursor: pointer;
        }

        .modal-footer {
            text-align: center;
            margin-top: 20px;
        }

            .modal-footer button {
                padding: 10px 20px;
                margin: 0 15px;
                border: none;
                cursor: pointer;
                font-size: 0.9em;
                border-radius: 5px;
                background-color: #0066FF;
                color: #fff;
            }

                .modal-footer button:hover {
                    opacity: 0.8;
                }

        .icon-button {
            background: none;
            border: none;
            cursor: pointer;
        }

            .icon-button img {
                width: 32px;
                height: 32px;
            }
    </style>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.72/pdfmake.min.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.72/vfs_fonts.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">In-Patient</a></li>
            <li class="active">In-Patient Summary</li>
        </ol>
        <!-- Main content -->
        <!-- /.content -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
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
                                        <h4>In-Patient Summary</h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="panel-body panel-form" style="margin-bottom: -130px;">
                                                    <div class="form-group row">
                                                        <label for="labelRegNo" class="col-xs-4 col-form-label">Reg No. <i class="text-danger">*</i></label>
                                                        <div class="col-xs-8">
                                                            <div class="input-container">
                                                                <asp:TextBox ID="txtReg" CssClass="form-control text-box single-line custom-width" runat="server" AutoPostBack="True" OnTextChanged="TxtReg_TextChanged"></asp:TextBox>
                                                                <span class="separator">-</span>
                                                                <asp:TextBox ID="txtNo" CssClass="form-control text-box single-line custom-width1" runat="server" TextMode="Number" AutoPostBack="True" OnTextChanged="TxtNo_TextChanged"></asp:TextBox>
                                                            </div>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="SaveGroup" runat="server" ControlToValidate="txtNo" ErrorMessage="Reg No is required" CssClass="error" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-heading">
                                            <div class="panel-title text-success">
                                                <h4>General Information</h4>
                                            </div>
                                            <div class="panel panel-default thumbnail">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="AdmDate" class="col-xs-4 col-form-label">Adm. Date</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdmDate" TextMode="SingleLine" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Relation" class="col-xs-4 col-form-label">Relation</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtRelation" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Gender" class="col-xs-4 col-form-label">Gender</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtGender" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Address" class="col-xs-4 col-form-label">Address</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAddress" CssClass="form-control text-box single-line" runat="server" ReadOnly="true" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Cont1" class="col-xs-4 col-form-label">Contact (1)</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtCont1" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="AdmTime" class="col-xs-4 col-form-label">Adm. Time</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdmTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="RelationName" class="col-xs-4 col-form-label">Relation Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtRelationName" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Age" class="col-xs-4 col-form-label">Age</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAge" TextMode="Number" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="AreaName" class="col-xs-4 col-form-label">Area Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAreaName" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Cont2" class="col-xs-4 col-form-label">Contact (2) / Email</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtCont2" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Emergency" class="col-xs-4 col-form-label">Emergency</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtEmergency" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="PatientName" class="col-xs-4 col-form-label">Patient Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtPatientName" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Room" class="col-xs-4 col-form-label">Room</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtRoom" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Consultant" class="col-xs-4 col-form-label">Consultant</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtConsultant" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="CityName" class="col-xs-4 col-form-label">City Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtCityName" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Mobile" class="col-xs-4 col-form-label">Mobile</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtMobile" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-5">
                                                <div class="panel">
                                                    <div class="panel-title text-success">
                                                        <h4>Biling and Discharge</h4>
                                                    </div>
                                                    <div class="panel panel-default thumbnail">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">

                                                                <div class="col-md-4 col-sm-4">
                                                                    <label for="Discharge" class="col-form-label">Discharge</label>
                                                                    <asp:TextBox ID="txtDischarge" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4">
                                                                    <label for="Date" class="col-form-label">Date</label>
                                                                    <asp:TextBox ID="txtDate" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4">
                                                                    <label for="Time" class="col-form-label">Time</label>
                                                                    <asp:TextBox ID="txtTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <div class="col-md-4 col-sm-4">
                                                                    <label for="Billing" class="col-form-label">Billing</label>
                                                                    <asp:TextBox ID="txtBilling" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4">
                                                                    <label for="BillingDate" class="col-form-label">Date</label>
                                                                    <asp:TextBox ID="txtBillingDate" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                                <div class="col-md-4 col-sm-4">
                                                                    <label for="BillingTime" class="col-form-label">Time</label>
                                                                    <asp:TextBox ID="txtBillingTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="TotalCharges" class="col-xs-4 col-form-label">Total Charges</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtTotalCharges" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="DepositedAmount" class="col-xs-4 col-form-label">Deposited Amount</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDepositedAmount" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Discount" class="col-xs-4 col-form-label">Discount</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDiscount" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="Advpay" class="col-xs-4 col-form-label">Advance Paid</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdvpay" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7">
                                                <div class="row">
                                                    <div class="col-md-8">
                                                        <div class="panel">
                                                            <div class="panel-title text-success">
                                                                <h4>Payment Details</h4>
                                                            </div>
                                                            <div class="panel panel-default thumbnail">
                                                                <div class="panel-body panel-form">
                                                                    <div class="form-group row">
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="FinalSettlement" class="col-form-label final-settlement-label">Final Settlement</label>
                                                                            <asp:TextBox ID="txtFinalSettlement" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="FDate" class="col-form-label">Date</label>
                                                                            <asp:TextBox ID="txtFDate" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="FTime" class="col-form-label">Time</label>
                                                                            <asp:TextBox ID="txtFTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="Refund" class="col-form-label">Refund</label>
                                                                            <asp:TextBox ID="txtRefund" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="RDate" class="col-form-label">Date</label>
                                                                            <asp:TextBox ID="txtRDate" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="RAmount" class="col-form-label">Amount</label>
                                                                            <asp:TextBox ID="txtRAmount" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="NetBalance" class="col-form-label">Net Balance</label>
                                                                            <asp:TextBox ID="txtNetBalance" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="NDate" class="col-form-label">Date</label>
                                                                            <asp:TextBox ID="txtNetDate" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-4 col-sm-4">
                                                                            <label for="NAmount" class="col-form-label">Amount</label>
                                                                            <asp:TextBox ID="txtNAmount" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel">
                                                            <div class="panel-title text-success">
                                                                <h4>Payment Status</h4>
                                                            </div>
                                                            <div class="panel panel-default thumbnail">
                                                                <div class="panel-body panel-form">
                                                                    <div class="form-group">
                                                                        <asp:TextBox ID="txtRemarks" TextMode="MultiLine" Rows="9" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 letter-margin">
                                                        <div class="panel">
                                                            <div class="panel-title text-success">
                                                                <h4>Employee Details</h4>
                                                            </div>
                                                            <div class="panel panel-default thumbnail">
                                                                <div class="panel-body panel-form">
                                                                    <div class="form-group row">
                                                                        <div class="col-md-6 col-sm-6">
                                                                            <label for="EmployeeName" class="col-form-label">Employee Name</label>
                                                                            <asp:TextBox ID="txtEmployeeName" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-md-6 col-sm-6">
                                                                            <label for="Action" class="col-form-label">Action</label>
                                                                            <asp:TextBox ID="txtAction" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
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
                                    <!-- Buttons -->
                                    <div class="form-group row">
                                        <div class="col-sm-offset-3 col-sm-6">
                                            <div class="ui buttons">
                                                <asp:Button ID="BPrint" runat="server" Text="Print" CssClass="ui positive button" OnClientClick="downloadPDF(); return false;" />
                                                <div class="or"></div>
                                                <asp:Button ID="BPreview" runat="server" Text="Preview" CssClass="ui button" OnClientClick="previewPDF(); return false;" />
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
            </ContentTemplate>
        </asp:UpdatePanel>
        <div id="pdfModal" class="modal">
            <div class="modal-content">
                <button class="close-button" onclick="closeModal()">×</button>
                <div class="modal-header">
                    <h2>Billing</h2>
                </div>

                <div id="pdfViewer" style="height: 400px;"></div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        function generatePDF() {
            var currentDate = new Date();
            var date = currentDate.toLocaleDateString();
            var time = currentDate.toLocaleTimeString();

            // Fetching form values (same as before)...
            var regNo = document.getElementById('<%= txtReg.ClientID %>').value + '-' + document.getElementById('<%= txtNo.ClientID %>').value;
            var patientName = document.getElementById('<%= txtPatientName.ClientID %>').value;
            var gender = document.getElementById('<%= txtGender.ClientID %>').value;
            var age = document.getElementById('<%= txtAge.ClientID %>').value;
            var admDate = document.getElementById('<%= txtAdmDate.ClientID %>').value;
            var admTime = document.getElementById('<%= txtAdmTime.ClientID %>').value;
            var room = document.getElementById('<%= txtRoom.ClientID %>').value;
            var consultant = document.getElementById('<%= txtConsultant.ClientID %>').value;
            var address = document.getElementById('<%= txtAddress.ClientID %>').value;
            var areaName = document.getElementById('<%= txtAreaName.ClientID %>').value;
            var cityName = document.getElementById('<%= txtCityName.ClientID %>').value;
            var cont1 = document.getElementById('<%= txtCont1.ClientID %>').value;
            var cont2 = document.getElementById('<%= txtCont2.ClientID %>').value;
            var mobile = document.getElementById('<%= txtMobile.ClientID %>').value;
            var emergency = document.getElementById('<%= txtEmergency.ClientID %>').value;
            var relation = document.getElementById('<%= txtRelation.ClientID %>').value;
            var relationName = document.getElementById('<%= txtRelationName.ClientID %>').value;

            var dischargeStatus = document.getElementById('<%= txtDischarge.ClientID %>').value;
            var dischargeDate = document.getElementById('<%= txtDate.ClientID %>').value;
            var dischargeTime = document.getElementById('<%= txtTime.ClientID %>').value;
            var billingStatus = document.getElementById('<%= txtBilling.ClientID %>').value;
            var billingDate = document.getElementById('<%= txtBillingDate.ClientID %>').value;
            var billingTime = document.getElementById('<%= txtBillingTime.ClientID %>').value;
            var totalCharges = document.getElementById('<%= txtTotalCharges.ClientID %>').value || '0';
            var depositedAmount = document.getElementById('<%= txtDepositedAmount.ClientID %>').value || '0';
            var discount = document.getElementById('<%= txtDiscount.ClientID %>').value || '0';
            var advancePaid = document.getElementById('<%= txtAdvpay.ClientID %>').value || '0';
            var finalSettlement = document.getElementById('<%= txtFinalSettlement.ClientID %>').value;
            var finalDate = document.getElementById('<%= txtFDate.ClientID %>').value;
            var finalTime = document.getElementById('<%= txtFTime.ClientID %>').value;
            var refund = document.getElementById('<%= txtRefund.ClientID %>').value || '0';
            var refundDate = document.getElementById('<%= txtRDate.ClientID %>').value;
            var refundAmount = document.getElementById('<%= txtRAmount.ClientID %>').value || '0';
            var netBalance = document.getElementById('<%= txtNetBalance.ClientID %>').value || '0';
            var netDate = document.getElementById('<%= txtNetDate.ClientID %>').value;
            var netAmount = document.getElementById('<%= txtNAmount.ClientID %>').value || '0';
            var remarks = document.getElementById('<%= txtRemarks.ClientID %>').value;
            var employeeName = document.getElementById('<%= txtEmployeeName.ClientID %>').value;
            var action = document.getElementById('<%= txtAction.ClientID %>').value;

            function formatCurrency(value) {
                return 'Rs. ' + parseFloat(value).toFixed(2);
            }

            // Define the docDefinition with three sections
            var docDefinition = {
                content: [
                    {
                        text: 'HOSPITAL MANAGEMENT SYSTEM',
                        style: 'header',
                        alignment: 'center',
                        margin: [0, 0, 0, 10]
                    },
                    {
                        text: 'Karachi, Pakistan',
                        alignment: 'center',
                        margin: [0, 0, 0, 10]
                    },
                    {
                        text: 'Original',
                        style: 'header1',
                        alignment: 'left',
                        margin: [0, 0, 0, 5]
                    },
                    {
                        text: 'IN-PATIENT SUMMARY REPORT',
                        style: 'subheader',
                        alignment: 'center',
                        margin: [0, 10, 0, 10]
                    },
                    {
                        text: 'Generated on: ' + date + ' ' + time,
                        alignment: 'right',
                        margin: [0, 0, 0, 5]
                    },
                    {
                        text: 'Patient Information',
                        style: 'sectionHeader',
                        margin: [0, 10, 0, 5]
                    },
                    {
                        table: {
                            widths: ['30%', '70%'],
                            body: [
                                [{ text: 'Registration No:', style: 'tableHeader' }, { text: regNo, style: 'tableData' }],
                                [{ text: 'Patient Name:', style: 'tableHeader' }, { text: patientName, style: 'tableData' }],
                                [{ text: 'Gender/Age:', style: 'tableHeader' }, { text: gender + ' / ' + age, style: 'tableData' }],
                                [{ text: 'Relation:', style: 'tableHeader' }, { text: relation, style: 'tableData' }],
                                [{ text: 'Relation Name:', style: 'tableHeader' }, { text: relationName, style: 'tableData' }],
                                [{ text: 'Admission Date/Time:', style: 'tableHeader' }, { text: admDate + ' ' + admTime, style: 'tableData' }],
                                [{ text: 'Room:', style: 'tableHeader' }, { text: room, style: 'tableData' }],
                                [{ text: 'Consultant:', style: 'tableHeader' }, { text: consultant, style: 'tableData' }],
                                [{ text: 'Address:', style: 'tableHeader' }, { text: address, style: 'tableData' }],
                                [{ text: 'Area/City:', style: 'tableHeader' }, { text: areaName + ', ' + cityName, style: 'tableData' }],
                                [{ text: 'Contacts:', style: 'tableHeader' }, { text: cont1 + ', ' + mobile, style: 'tableData' }],
                                [{ text: 'Email/Emergency:', style: 'tableHeader' }, { text: cont2 + ', ' + emergency, style: 'tableData' }]
                            ]
                        },
                        layout: 'lightHorizontalLines',
                        margin: [0, 0, 0, 15]
                    },
                    {
                        text: 'Billing & Discharge Information',
                        style: 'sectionHeader',
                        margin: [0, 10, 0, 5]
                    },
                    {
                        table: {
                            widths: ['50%', '50%'],
                            body: [
                                [{ text: 'Discharge Status:', style: 'tableHeader' }, { text: dischargeStatus, style: 'tableData' }],
                                [{ text: 'Discharge Date/Time:', style: 'tableHeader' }, { text: dischargeDate + ' ' + dischargeTime, style: 'tableData' }],
                                [{ text: 'Billing Status:', style: 'tableHeader' }, { text: billingStatus, style: 'tableData' }],
                                [{ text: 'Billing Date/Time:', style: 'tableHeader' }, { text: billingDate + ' ' + billingTime, style: 'tableData' }],
                                [{ text: 'Total Charges:', style: 'tableHeader' }, { text: formatCurrency(totalCharges), style: 'tableData', alignment: 'right', bold: true }],
                                [{ text: 'Advance Paid:', style: 'tableHeader' }, { text: formatCurrency(advancePaid), style: 'tableData', alignment: 'right' }],
                                [{ text: 'Deposited Amount:', style: 'tableHeader' }, { text: formatCurrency(depositedAmount), style: 'tableData', alignment: 'right', bold: true }],
                                [{ text: 'Discount:', style: 'tableHeader' }, { text: formatCurrency(discount), style: 'tableData', alignment: 'right' }]
                            ]
                        },
                        layout: 'lightHorizontalLines',
                        margin: [0, 0, 0, 15]
                    },
                    {
                        text: 'Payment Details',
                        style: 'sectionHeader',
                        margin: [0, 10, 0, 5]
                    },
                    {
                        table: {
                            widths: ['50%', '50%'],
                            body: [
                                [{ text: 'Final Settlement:', style: 'tableHeader' }, { text: finalSettlement, style: 'tableData' }],
                                [{ text: 'Final Date/Time:', style: 'tableHeader' }, { text: finalDate + ' ' + finalTime, style: 'tableData' }],
                                [{ text: 'Refund Amount:', style: 'tableHeader' }, { text: formatCurrency(refundAmount), style: 'tableData', alignment: 'right', bold: true }],
                                [{ text: 'Refund Date:', style: 'tableHeader' }, { text: refundDate, style: 'tableData' }],
                                [{ text: 'Net Balance:', style: 'tableHeader', bold: true }, { text: formatCurrency(netAmount), style: 'tableData', alignment: 'right', bold: true }],
                                [{ text: 'Net Date:', style: 'tableHeader' }, { text: netDate, style: 'tableData' }],
                                [{ text: 'Remarks:', style: 'tableHeader' }, { text: remarks, style: 'tableData' }]
                            ]
                        },
                        layout: 'lightHorizontalLines',
                        margin: [0, 0, 0, 15]
                    },
                    {
                        text: 'Employee Details',
                        style: 'sectionHeader',
                        margin: [0, 10, 0, 5]
                    },

                    {
                        text: 'Employee Details',
                        style: 'sectionHeader',
                        margin: [0, 10, 0, 5]
                    },
                    {
                        table: {
                            widths: ['50%', '50%'],
                            body: [
                                [{ text: 'Employee Name:', style: 'tableHeader' }, { text: employeeName, style: 'tableData' }],
                                [{ text: 'Action:', style: 'tableHeader' }, { text: action, style: 'tableData' }]
                                
                            ]
                        },
                        layout: 'lightHorizontalLines',
                        margin: [0, 0, 0, 15]
                    }
                ],
                styles: {
                    header: {
                        fontSize: 18,
                        bold: true
                    },
                    header1: {
                        fontSize: 14,
                        bold: true
                    },
                    subheader: {
                        fontSize: 16,
                        bold: true
                    },
                    sectionHeader: {
                        fontSize: 12,
                        bold: true,
                        color: 'black'
                    },
                    tableHeader: {
                        bold: true,
                        fillColor: '#eeeeee'
                    },
                    tableData: {
                        margin: [0, 2, 0, 2]
                    }
                },
                defaultStyle: {
                    fontSize: 10
                }
            };

            return pdfMake.createPdf(docDefinition);
        }

        function previewPDF() {
            generatePDF().getDataUrl(function (dataUrl) {
                var iframe = '<iframe width="100%" height="100%" src="' + dataUrl + '"></iframe>';
                document.getElementById('pdfViewer').innerHTML = iframe;
                document.getElementById('pdfModal').style.display = 'block';
            });
        }

        function downloadPDF() {
            generatePDF().download('InPatient_Summary_' + document.getElementById('<%= txtReg.ClientID %>').value +
                '-' + document.getElementById('<%= txtNo.ClientID %>').value + '.pdf');
        }
    </script>
</asp:Content>
