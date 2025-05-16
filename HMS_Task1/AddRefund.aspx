<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddRefund.aspx.cs" Inherits="HMS_Task1.AddRefund" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .display {
            display: none;
        }

        .input-container {
            display: flex;
            align-items: center;
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
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Refund</a></li>
            <li class="active">In-Patient Refund Information</li>
        </ol>
        <asp:HiddenField ID="hfSerialNo" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">

            <ContentTemplate>
                <div class="content">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="panel panel-bd">
                                <div class="panel-heading">
                                    <div class="panel-title">
                                        <h4>In-Patient Refund Information</h4>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="panel panel-default thumbnail">
                                                <div class="panel-body panel-form">
                                                    <div class="row">
                                                        <div class="col-md-9 col-sm-12">


                                                            <div class="form-group row">
                                                                <label for="SerialNo" class="col-xs-3 col-form-label">Serial No.</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtSerialNo" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="txtSerialNo_TextChanged"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            

                                                            <!-- RegNo -->
                                                            <div class="form-group row">
                                                                <label for="Reg" class="col-xs-3 col-form-label">Registration</label>
                                                                <div class="col-xs-9">
                                                                    <div class="row">
                                                                        <div class="col-xs-4">
                                                                            <asp:TextBox ID="txtReg" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                        <div class="col-xs-1 text-center">
                                                                            <label>- </label>
                                                                        </div>
                                                                        <div class="col-xs-7">
                                                                            <asp:TextBox ID="txtNum" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <!-- Billing Date -->
                                                            <div class="form-group row">
                                                                <label for="BillingDate" class="col-xs-3 col-form-label">Billing Date</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtBillingDate" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <!-- Time -->
                                                            <div class="form-group row">
                                                                <label for="Time" class="col-xs-3 col-form-label">Time</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtTime" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <!-- Type -->
                                                            <div class="form-group row">
                                                                <label for="Type" class="col-xs-3 col-form-label">Type</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtType" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <!-- Consultant -->
                                                            <div class="form-group row">
                                                                <label for="Consultant" class="col-xs-3 col-form-label">Consultant</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtConsultant" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <!-- Patient Name -->
                                                            <div class="form-group row">
                                                                <label for="PatientName" class="col-xs-3 col-form-label">Patient Name </i></label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtPatientName" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>

                                                                </div>
                                                            </div>


                                                            <div class="form-group row">
                                                                <label for="AdmDate" class="col-xs-3 col-form-label">Adm. Date</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtAdmDate" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <!-- Admission Time -->
                                                            <div class="form-group row">
                                                                <label for="AdmTime" class="col-xs-3 col-form-label">Adm. Time</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtAdmTime" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <!-- Gender -->
                                                            <div class="form-group row">
                                                                <label for="Gender" class="col-xs-3 col-form-label">Gender</label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtGender" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <!-- Room -->
                                                            <div class="form-group row">
                                                                <label for="Room" class="col-xs-3 col-form-label">Room </label>
                                                                <div class="col-xs-9">
                                                                    <asp:TextBox ID="txtRoom" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="container-fluid">
                                                                <div class="row">
                                                                    <!-- Left Column: Payment History and Status -->
                                                                    <div class="col-md-6">
                                                                        <h5>Payment History and Status</h5>

                                                                        <!-- Total Charges -->
                                                                        <div class="form-group row">
                                                                            <label for="TotalCharges" class="col-sm-6 col-form-label">Total Charges</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:TextBox ID="txtTotalCharges" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Deposited Amount -->
                                                                        <div class="form-group row">
                                                                            <label for="DepositedAmount" class="col-sm-6 col-form-label">Deposited Amount</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:TextBox ID="txtDepositedAmount" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Discount -->
                                                                        <div class="form-group row">
                                                                            <label for="Discount" class="col-sm-6 col-form-label">Discount</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:TextBox ID="txtDiscount" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <!-- To be Refunded -->
                                                                        <div class="form-group row">
                                                                            <label for="ToBeRefunded" class="col-sm-6 col-form-label">To be Refunded</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:TextBox ID="txtToBeRefunded" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group row">
                                                                            <label for="NetBalance" class="col-sm-6 col-form-label">Net Balance</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:TextBox ID="txtNetBalance" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Refund Y/N -->
                                                                        <div class="form-group row">
                                                                            <label for="RefundYN" class="col-sm-6 col-form-label">Refund Y/N</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:CheckBox ID="chkRefundYN" runat="server" AutoPostBack="True" OnCheckedChanged="chkRefundYN_CheckedChanged" />
                                                                            </div>
                                                                        </div>

                                                                        <!-- Refund Date -->
                                                                        <div class="form-group row">
                                                                            <label for="RefundDate" class="col-sm-6 col-form-label">Refund Date</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:TextBox ID="txtRefundDate" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Refund Time -->
                                                                        <div class="form-group row">
                                                                            <label for="RefundTime" class="col-sm-6 col-form-label">Time</label>
                                                                            <div class="col-sm-6">
                                                                                <asp:TextBox ID="txtRefundTime" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Right Column: Refund Information -->
                                                                    <div class="col-md-6">
                                                                        <h5>&nbsp;</h5>
                                                                        <!-- Empty header to align with the first column -->

                                                                        <!-- Refund Amount -->
                                                                        <div class="form-group row">
                                                                            <label for="RefundAmount" class="col-sm-4 col-form-label">Refund Amount</label>
                                                                            <div class="col-sm-8">
                                                                                <asp:TextBox ID="txtRefundAmount" CssClass="form-control" runat="server" Placeholder="Enter Refund Amount" Enabled="false"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Receiving Person Name -->
                                                                        <div class="form-group row">
                                                                            <label for="ReceivingPersonName" class="col-sm-4 col-form-label">Receiving Person Name</label>
                                                                            <div class="col-sm-8">
                                                                                <asp:TextBox ID="txtReceivingPersonName" CssClass="form-control" runat="server" Placeholder="Enter Recieving Person's Name" Enabled="false"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group row">
                                                                            <label for="RelationWithPatient" class="col-sm-4 col-form-label">Relation with Patient</label>
                                                                            <div class="col-sm-8">
                                                                                <asp:TextBox ID="txtRelationWithPatient" CssClass="form-control" runat="server" Placeholder="Enter Relation With Patient" Enabled="false"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <div class="form-group row">
                                                                            <label for="Contact" class="col-sm-4 col-form-label">Contact Number</label>
                                                                            <div class="col-sm-8">
                                                                                <asp:TextBox ID="txtContact" CssClass="form-control" runat="server" Placeholder="Enter contact number" Enabled="false"></asp:TextBox>
                                                                            </div>
                                                                        </div>

                                                                        <!-- Remarks -->
                                                                        <div class="form-group row">
                                                                            <label for="Remarks" class="col-sm-4 col-form-label">Remarks</label>
                                                                            <div class="col-sm-8">
                                                                                <asp:TextBox ID="txtRemarks" CssClass="form-control" runat="server" Placeholder="Enter remarks" Enabled="false"></asp:TextBox>

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <asp:TextBox ID="txtAge" runat="server" Visible="false"></asp:TextBox>

                                                            <div class="form-group row">
                                                                <div class="col-xs-12">
                                                                    <asp:Label ID="lblMessage" runat="server" CssClass="text-success"></asp:Label>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <div class="col-sm-offset-3 col-sm-6">
                                                                    <div class="ui buttons">
                                                                        <asp:Button ID="btnClear" CssClass="ui button" runat="server" Text="Clear" OnClick="btnClear_Click" CausesValidation="false" />
                                                                        <div class="or"></div>
                                                                        <asp:Button ID="btnSave" CssClass="ui positive button" runat="server" Text="Save" OnClick="btnSave_Click" CausesValidation="false" />
                                                                        <div class="or"></div>
                                                                       <asp:Button ID="btnPreview" CssClass="ui button" runat="server" Text="Preview" OnClientClick="previewPDF(); return false;" CausesValidation="false" />
                                                                        <div class="or"></div>
                                                                        <asp:Button ID="btnPrint" CssClass="ui positive button" runat="server" Text="Print" OnClientClick=" downloadPDF(); return false;" CausesValidation="false" />
                                                                        <div class="or"></div>
                                                                        <asp:Button ID="btnExit" CssClass="ui button" runat="server" Text="Exit" OnClick="btnExit_Click" CausesValidation="false" />
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
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtSerialNo" EventName="TextChanged" />
                <asp:AsyncPostBackTrigger ControlID="chkRefundYN" EventName="CheckedChanged" />
               
                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnClear" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnPreview" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnExit" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>

        <div id="pdfModal" class="modal">
            <div class="modal-content">
                <button class="close-button" onclick="closeModal()">×</button>
                <div class="modal-header">
                    <h2>Refund</h2>
                </div>

                <div id="pdfViewer" style="height: 400px;"></div>

            </div>
        </div>
    </div>

<script type="text/javascript">
    // Function to generate the PDF
    function generatePDF() {
        

        var currentDate = new Date();
        var formattedDate = currentDate.toLocaleDateString();
        var formattedTime = currentDate.toLocaleTimeString();

        var docDefinition = {
            content: [
                {
                    text: 'MEMON MEDICAL COMPLEX\nUnder the Management of\nBANTVA TOWN MEMON WELFARE COMMITTEE',
                    style: 'header',
                    alignment: 'center',
                    margin: [0, 0, 0, 10]
                },
                {
                    text: '1503-04/3, Siddiqabad, F.B. Area, Karachi, 75950.',
                    alignment: 'center'
                },
                {
                    text: 'REFUND VOUCHER',
                    style: 'subheader',
                    alignment: 'center',
                    margin: [0, 20, 0, 20]
                },
                
            ],
            styles: {
                header: {
                    fontSize: 16,
                    bold: true
                },
                subheader: {
                    fontSize: 14,
                    bold: true
                }
            }
        };

        return pdfMake.createPdf(docDefinition);
    }

    // Function to preview the PDF
    function previewPDF() {
        generatePDF().getDataUrl(function (dataUrl) {
            var iframe = '<iframe width="100%" height="100%" src="' + dataUrl + '"></iframe>';
            document.getElementById('pdfViewer').innerHTML = iframe;
            document.getElementById('pdfModal').style.display = 'block';
        });
    }

    // Function to download the PDF
    function downloadPDF() {
        generatePDF().download('RefundInformation.pdf');
    }

</script>
</asp:Content>