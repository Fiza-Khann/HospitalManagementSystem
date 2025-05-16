<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AdvanceInfo.aspx.cs" Inherits="HMS_Task2.AdvanceInfo" %>

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
            <li><a href="#">Billing</a></li>
            <li class="active">Patient Advance Information</li>
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
                                        <h4>Patient Advance Information</h4>
                                    </div>
                                    <div class="mr-25">
                                        <a class="btn btn-primary" href="AdvanceHistory.aspx">View Advance History</a>
                                    </div>
                                    <div class="panel-body">
                                        <div class="panel panel-default thumbnail">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="panel-body panel-form">
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
                                                        <div class="form-group row">
                                                            <label for="AdmDate" class="col-xs-4 col-form-label">Adm. Date</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtAdmDate" TextMode="SingleLine" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="AdmTime" class="col-xs-4 col-form-label">Adm. Time</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtAdmTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="AccType" class="col-xs-4 col-form-label">Account Type</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtAccType" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="Consultant" class="col-xs-4 col-form-label">Consultant</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtConsultant" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="SerialNo" class="col-xs-4 col-form-label">Serial No</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtSerialNo" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
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
                                                            <label for="Gender" class="col-xs-4 col-form-label">Gender</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtGender" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="Age" class="col-xs-4 col-form-label">Age</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtAge" TextMode="Number" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="panel-body panel-form">
                                                <div class="form-group row">
                                                    <label for="Receipt" class="col-xs-4 col-form-label">Receipt</label>
                                                    <div class="col-xs-8">
                                                        <asp:TextBox ID="txtReceipt" TextMode="Number" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label for="Date" class="col-xs-4 col-form-label">Date</label>
                                                    <div class="col-xs-8">
                                                        <asp:TextBox ID="txtDate" TextMode="Date" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label for="Time" class="col-xs-4 col-form-label">Time</label>
                                                    <div class="col-xs-8">
                                                        <asp:TextBox ID="txtTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="panel-body panel-form">
                                                <div class="form-group row">
                                                    <label for="Amount" class="col-xs-4 col-form-label">Amount</label>
                                                    <div class="col-xs-8">
                                                        <asp:TextBox ID="txtAmount" TextMode="Number" CssClass="form-control text-box single-line" runat="server" Text="0"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <!-- Mode of Payment -->
                                                <div class="form-group row">
                                                    <label for="ModeOfPayment" class="col-xs-4 col-form-label">Mode Of Payment</label>
                                                    <div class="col-xs-8">
                                                        <div class="form-check">
                                                            <asp:RadioButton ID="radiobtnCash" CssClass="form-check-input" runat="server" GroupName="PaymentMode" />
                                                            <label for="radiobtnCash" class="form-check-label">Cash</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <asp:RadioButton ID="radiobtnCheque" CssClass="form-check-input" runat="server" GroupName="PaymentMode" />
                                                            <label for="radiobtnCheque" class="form-check-label">Cheque</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <asp:RadioButton ID="radiobtnCreditCard" CssClass="form-check-input" runat="server" GroupName="PaymentMode" />
                                                            <label for="radiobtnCreditCard" class="form-check-label">Credit Card</label>
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
                                            <asp:Button ID="BNew" runat="server" Text="New" CssClass="ui button" OnClick="BNew_Click" CausesValidation="false" />
                                            <div class="or"></div>
                                            <asp:Button ID="BSave" runat="server" Text="Save" CssClass="ui positive button" ValidationGroup="SaveGroup" OnClick="BSave_Click" />
                                            <div class="or"></div>
                                            <asp:Button ID="BPreview" runat="server" Text="Preview" CssClass="ui button" OnClientClick="previewPDF(); return false;" />
                                            <div class="or"></div>
                                            <asp:Button ID="BPrint" runat="server" Text="Print" CssClass="ui positive button" OnClientClick="downloadPDF(); return false;" />
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
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="BSave" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <div id="pdfModal" class="modal">
            <div class="modal-content">
                <button class="close-button" onclick="closeModal()">×</button>
                <div class="modal-header">
                    <h2>Advance</h2>
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
           var receiptno = document.getElementById('<%= txtReceipt.ClientID %>').value;
        var patientname = document.getElementById('<%= txtPatientName.ClientID %>').value;
        var consultant = document.getElementById('<%= txtConsultant.ClientID %>').value;
        var regno = document.getElementById('<%= txtReg.ClientID %>').value + '-' + document.getElementById('<%= txtNo.ClientID %>').value;
        var room = document.getElementById('<%= txtRoom.ClientID %>').value;
        var amount = document.getElementById('<%= txtAmount.ClientID %>').value;
        var gender = document.getElementById('<%= txtGender.ClientID %>').value;
        var age = document.getElementById('<%= txtAge.ClientID %>').value;
        var serialNo = document.getElementById('<%= txtSerialNo.ClientID %>').value;
        var admDate = document.getElementById('<%= txtAdmDate.ClientID %>').value;
        var admTime = document.getElementById('<%= txtAdmTime.ClientID %>').value;
           var accType = document.getElementById('<%= txtAccType.ClientID %>').value;
           var paymentMode = '';
           if (document.getElementById('<%= radiobtnCash.ClientID %>').checked) {
               paymentMode = 'Cash';
           } else if (document.getElementById('<%= radiobtnCheque.ClientID %>').checked) {
    paymentMode = 'Cheque';
           } else if (document.getElementById('<%= radiobtnCreditCard.ClientID %>').checked) {
               paymentMode = 'Credit Card';
           }


           // Section A (Original)
           var sectionContent = [
               {
                   text: 'HOSPITAL MANAGEMENT SYSTEM',
                   style: 'header',
                   alignment: 'center',
                   margin: [0, 0, 0, 10]
               },
               {
                   text: 'Karachi, Pakistan.',
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
                   text: 'Receipt: Advance',
                   style: 'subheader',
                   alignment: 'center',
                   margin: [0, 10, 0, 10]
               },
               {
                   text: date + ' ' + time,
                   alignment: 'right',
                   margin: [0, 0, 0, 5]
               },
               {
                   text: 'Status: Admitted',
                   style: 'header1',
                   alignment: 'left',
                   margin: [0, 0, 0, 5]
               },
               {
                   table: {
                       widths: ['*', '*'],
                       body: [
                           [
                               { text: 'Rcpt #: ', style: 'tableHeader' },
                               { text: receiptno, style: 'tableData' }
                           ],
                           [
                               { text: 'Serial No: ', style: 'tableHeader' },
                               { text: serialNo, style: 'tableData' }
                           ],
                           [
                               { text: 'Reg No: ', style: 'tableHeader' },
                               { text: regno, style: 'tableData' }
                           ],
                           [
                               { text: 'Patient: ', style: 'tableHeader' },
                               { text: patientname, style: 'tableData' }
                           ],
                           [
                               { text: 'Gender: ', style: 'tableHeader' },
                               { text: gender, style: 'tableData' }
                           ],
                           [
                               { text: 'Age: ', style: 'tableHeader' },
                               { text: age, style: 'tableData' }
                           ],
                           [
                               { text: 'Room: ', style: 'tableHeader' },
                               { text: room, style: 'tableData' }
                           ],
                           [
                               { text: 'Adm Date: ', style: 'tableHeader' },
                               { text: admDate, style: 'tableData' }
                           ],
                           [
                               { text: 'Adm Time: ', style: 'tableHeader' },
                               { text: admTime, style: 'tableData' }
                           ]
                       ]
                   },
                   layout: 'lightHorizontalLines',
                   margin: [0, 0, 0, 10]
               },
               {
                   text: 'Consultant: ' + consultant,
                   style: 'tableData',
                   alignment: 'left',
                   margin: [0, 0, 0, 5]
               },
               {
                   text: 'Payment Mode: ' + paymentMode,
                   style: 'tableData',
                   alignment: 'left',
                   margin: [0, 5, 0, 10]
               },

               {
                   columns: [
                       {
                           width: '*',
                           text: accType + '\n',
                           style: 'tableData',
                           margin: [0, 0, 0, 100]
                       },
                       {
                           width: '*',
                           text: amount,
                           alignment: 'right',
                           style: 'tableData'
                       }
                   ],
                   margin: [0, 20, 0, 0]
               },
               {
                   text: 'Net Amount Rs. ' + amount,
                   alignment: 'right',
                   margin: [0, 10, 0, 0]
               }
           ];

           // Section B (Duplicate)
           var sectionContent1 = [
               {
                   text: 'HOSPITAL MANAGEMENT SYSTEM',
                   style: 'header',
                   alignment: 'center',
                   margin: [0, 0, 0, 10]
               },
               {
                   text: 'Karachi, Pakistan.',
                   alignment: 'center',
                   margin: [0, 0, 0, 10]
               },
               {
                   text: 'Duplicate',
                   style: 'header1',
                   alignment: 'left',
                   margin: [0, 0, 0, 5]
               },
               {
                   text: 'Receipt: Advance',
                   style: 'subheader',
                   alignment: 'center',
                   margin: [0, 10, 0, 10]
               },
               {
                   text: date + ' ' + time,
                   alignment: 'right',
                   margin: [0, 0, 0, 5]
               },
               {
                   text: 'Status: Admitted',
                   style: 'header1',
                   alignment: 'left',
                   margin: [0, 0, 0, 5]
               },
               {
                   table: {
                       widths: ['*', '*'],
                       body: [
                           [
                               { text: 'Rcpt #: ', style: 'tableHeader' },
                               { text: receiptno, style: 'tableData' }
                           ],
                           [
                               { text: 'Serial No: ', style: 'tableHeader' },
                               { text: serialNo, style: 'tableData' }
                           ],
                           [
                               { text: 'Reg No: ', style: 'tableHeader' },
                               { text: regno, style: 'tableData' }
                           ],
                           [
                               { text: 'Patient: ', style: 'tableHeader' },
                               { text: patientname, style: 'tableData' }
                           ],
                           [
                               { text: 'Gender: ', style: 'tableHeader' },
                               { text: gender, style: 'tableData' }
                           ],
                           [
                               { text: 'Age: ', style: 'tableHeader' },
                               { text: age, style: 'tableData' }
                           ],
                           [
                               { text: 'Room: ', style: 'tableHeader' },
                               { text: room, style: 'tableData' }
                           ],
                           [
                               { text: 'Adm Date: ', style: 'tableHeader' },
                               { text: admDate, style: 'tableData' }
                           ],
                           [
                               { text: 'Adm Time: ', style: 'tableHeader' },
                               { text: admTime, style: 'tableData' }
                           ]
                       ]
                   },
                   layout: 'lightHorizontalLines',
                   margin: [0, 0, 0, 10]
               },
               {
                   text: 'Consultant: ' + consultant,
                   style: 'tableData',
                   alignment: 'left',
                   margin: [0, 0, 0, 5]
               },
               {
                   text: 'Payment Mode: ' + paymentMode,
                   style: 'tableData',
                   alignment: 'left',
                   margin: [0, 5, 0, 10]
               },

               {
                   columns: [
                       {
                           width: '*',
                           text: accType + '\n',
                           style: 'tableData',
                           margin: [0, 0, 0, 100]
                       },
                       {
                           width: '*',
                           text: amount,
                           alignment: 'right',
                           style: 'tableData'
                       }
                   ],
                   margin: [0, 20, 0, 0]
               },
               {
                   text: 'Net Amount Rs. ' + amount,
                   alignment: 'right',
                   margin: [0, 10, 0, 0]
               }
           ];

           // Section C (Smaller version)
           var sectionContent2 = [
               {
                   text: 'Receipt: Advance',
                   style: 'header',
                   alignment: 'center',
                   margin: [0, 0, 0, 20],
                   fontSize: 15
               },
               {
                   text: date + ' ' + time,
                   alignment: 'right',
                   margin: [0, 0, 0, 5]
               },
               {
                   text: 'Status: Admitted',
                   style: 'header1',
                   alignment: 'left',
                   margin: [0, 0, 0, 5]
               },
               {
                   table: {
                       widths: ['*', '*'],
                       body: [
                           [
                               { text: 'Rcpt #: ', style: 'tableHeader' },
                               { text: receiptno, style: 'tableData' }
                           ],
                           [
                               { text: 'Serial No: ', style: 'tableHeader' },
                               { text: serialNo, style: 'tableData' }
                           ],
                           [
                               { text: 'Reg No: ', style: 'tableHeader' },
                               { text: regno, style: 'tableData' }
                           ],
                           [
                               { text: 'Patient: ', style: 'tableHeader' },
                               { text: patientname, style: 'tableData' }
                           ],
                           [
                               { text: 'Gender: ', style: 'tableHeader' },
                               { text: gender, style: 'tableData' }
                           ],
                           [
                               { text: 'Age: ', style: 'tableHeader' },
                               { text: age, style: 'tableData' }
                           ],
                           [
                               { text: 'Room: ', style: 'tableHeader' },
                               { text: room, style: 'tableData' }
                           ]
                       ]
                   },
                   layout: 'lightHorizontalLines',
                   margin: [0, 0, 0, 10]
               },
               {
                   text: 'Consultant: ' + consultant,
                   style: 'tableData',
                   alignment: 'left',
                   margin: [0, 0, 0, 5]
               },
               {
                   text: 'Payment Mode: ' + paymentMode,
                   style: 'tableData',
                   alignment: 'left',
                   margin: [0, 5, 0, 10]
               },

               {
                   columns: [
                       {
                           width: '*',
                           text: accType + '\n',
                           style: 'tableData',
                           margin: [0, 0, 0, 5]
                       }
                   ],
                   margin: [0, 20, 0, 0]
               },
               {
                   text: amount,
                   alignment: 'right',
                   style: 'tableData',
                   margin: [0, 0, 0, 165]
               },
               {
                   text: 'Net Amount Rs. ' + amount,
                   alignment: 'right',
                   margin: [0, 10, 0, 0]
               }
           ];

           // Define the docDefinition with three sections
           var docDefinition = {
               content: [
                   {
                       columns: [
                           {
                               width: '38%',
                               stack: sectionContent,
                               margin: [10, 0, 0, 0]
                           },
                           {
                               width: '38%',
                               stack: sectionContent1,
                               margin: [10, 0, 0, 0]
                           },
                           {
                               width: '24%',
                               stack: sectionContent2,
                               margin: [10, 0, 0, 0]
                           }
                       ]
                   }
               ],
               styles: {
                   header: {
                       fontSize: 15,
                       bold: true
                   },
                   header1: {
                       fontSize: 10,
                       bold: true
                   },
                   subheader: {
                       bold: true
                   },
                   tableHeader: {
                       bold: true,
                       fontSize: 10,
                       color: 'black',
                       fillColor: '#f3f3f3'
                   },
                   tableData: {
                       fontSize: 10
                   }
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
           generatePDF().download('AdvanceReceipt.pdf');
       }
   </script>
</asp:Content>
