<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddConsultantion.aspx.cs" Inherits="HMS_Task1.AddConsultantion" %>
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
<script type="text/javascript">
    // Prevent form submission on Enter key press
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelector('form').addEventListener('keypress', function (e) {
            if (e.keyCode === 13 || e.which === 13) {
                e.preventDefault();
                return false;
            }
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a>Out-Patient</a></li>
            <li class="active">Consultation</li>
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
                                        <h4>Edit Consultation</h4>
                                    </div>
                                    <div class="mr-25">
                                        <a class="btn btn-primary" href="ViewConsultantion.aspx">View Consultation</a>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="panel-body panel-form">
                                                    <div class="form-group row">
                                                        <label for="labelCategory" class="col-xs-4 col-form-label">CATEGORY</label>
                                                        <div class="col-xs-8">
                                                            <asp:DropDownList ID="ddlCat" CssClass="form-control" runat="server">
                                                                <asp:ListItem Value="1">Consultation</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel panel-default thumbnail">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <div class="col-md-6 col-sm-6">
                                                                <label for="TokenNO" class="col-form-label" style="font-size: 25px;">Token NO</label>
                                                                <asp:TextBox ID="txtTokenNO" TextMode="Number" CssClass="form-control text-box single-line" runat="server" Style="font-size: 25px; height: 50px;" ReadOnly="true" Text="0"></asp:TextBox>
                                                            </div>
                                                            <div class="col-md-6 col-sm-6">
                                                                <label for="ReceiptNo" class="col-form-label" style="font-size: 25px;">Receipt No</label>
                                                                <asp:TextBox ID="txtReceiptNo" TextMode="Number" CssClass="form-control text-box single-line" runat="server" Style="font-size: 25px; height: 50px;" ReadOnly="true" Text="0"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <div class="col-md-12 col-sm-12">
                                                                <label for="Date" class="col-form-label">Date</label>
                                                                <asp:TextBox ID="txtDate" TextMode="Date" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-md-12 col-sm-12">
                                                                <label for="Time" class="col-form-label">Time</label>
                                                                <asp:TextBox ID="txtTime" TextMode="Time" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel panel-default thumbnail">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Type" class="col-xs-4 col-form-label">Type</label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList ID="ddlType" CssClass="form-control" runat="server">
                                                                    <asp:ListItem Value="1">PUBLIC</asp:ListItem>
                                                                    <asp:ListItem Value="2">BMJ NEW</asp:ListItem>
                                                                    <asp:ListItem Value="3">SPF</asp:ListItem>
                                                                    <asp:ListItem Value="4">ZF</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="BmjCard" class="col-xs-4 col-form-label">Bmj Card #</label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList ID="ddlBmj" CssClass="form-control" runat="server" Enabled="false">
                                                                    <asp:ListItem Value="1">0001&nbsp;&nbsp;&nbsp;| M.ZUBAIR</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="PatientName" class="col-xs-4 col-form-label">Patient Name <i class="text-danger">*</i></label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList ID="ddlPatientName" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPatientName_SelectedIndexChanged">
                                                                    <asp:ListItem Text="Select Option" />
                                                                    <asp:ListItem Value="1">Mr.</asp:ListItem>
                                                                    <asp:ListItem Value="2">Mrs.</asp:ListItem>
                                                                    <asp:ListItem Value="3">Miss</asp:ListItem>
                                                                    <asp:ListItem Value="4">Baby</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <div class="col-xs-12">
                                                                <asp:TextBox ID="txtPatientName" CssClass="form-control text-box single-line" runat="server" placeholder="Patient Name"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="SaveGroup" runat="server" ControlToValidate="txtPatientName" ErrorMessage="Patient Name is required" CssClass="error" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Gender" class="col-xs-4 col-form-label">Gender</label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList ID="ddlGender" CssClass="form-control" runat="server">
                                                                    <asp:ListItem Text="Select Option" />
                                                                    <asp:ListItem Value="1">Male</asp:ListItem>
                                                                    <asp:ListItem Value="2">Female</asp:ListItem>
                                                                    <asp:ListItem Value="3">Other</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Contact" class="col-xs-4 col-form-label">Contact #<i class="text-danger">*</i></label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtContact" CssClass="form-control text-box single-line" runat="server" placeholder="Contact Number"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="SaveGroup" runat="server" ControlToValidate="txtContact" ErrorMessage="Contact is required" CssClass="error" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Age" class="col-xs-4 col-form-label">Age<i class="text-danger">*</i></label>
                                                            <div class="col-xs-8">
                                                                <div class="input-container">
                                                                    <asp:TextBox ID="txtAgeNum" CssClass="form-control text-box single-line" runat="server" placeholder="Age"></asp:TextBox>
                                                                    <span>&nbsp;</span>
                                                                    <asp:DropDownList ID="ddlAgeValue" CssClass="form-control" runat="server">
                                                                        <asp:ListItem Text="Select Option" />
                                                                        <asp:ListItem Value="1">Y</asp:ListItem>
                                                                        <asp:ListItem Value="2">M</asp:ListItem>
                                                                        <asp:ListItem Value="3">D</asp:ListItem>
                                                                    </asp:DropDownList>

                                                                </div>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="SaveGroup" runat="server" ControlToValidate="txtAgeNum" ErrorMessage="Age is required" CssClass="error" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Consultant" class="col-xs-4 col-form-label">Consultant</label>
                                                            <div class="col-xs-8">
                                                                 <asp:DropDownList ID="ddlConsultant" CssClass="form-control" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="ddlConsultant_SelectedIndexChanged"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Rupees" class="col-xs-4 col-form-label">Rs.</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtRupees" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="Gross" class="col-xs-4 col-form-label">Gross</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtGross" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <div class="col-xs-12">
                                                                <asp:CheckBox ID="chkOtherShift" CssClass="form-control" runat="server" Text="Other Shift Cancel (Refund)" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <div class="col-xs-12">
                                                                <asp:TextBox ID="txtDate1" TextMode="Date" CssClass="form-control text-box single-line" runat="server"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Reference" class="col-xs-4 col-form-label">Reference</label>
                                                            <div class="col-xs-8">
                                                                <asp:DropDownList ID="ddlReference" CssClass="form-control" runat="server" Enabled="false">
                                                                    <asp:ListItem Value="1">--Not Selected--</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="panel-body panel-form">
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <div class="form-group row">
                                                                    <div class="col-xs-12">
                                                                        <asp:CheckBox ID="chkCancel" CssClass="form-control" runat="server" Text="Cancel" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group row">
                                                                    <label for="SPD" class="col-xs-4 col-form-label">SPD</label>
                                                                    <div class="col-xs-8">
                                                                        <asp:TextBox ID="txtSPD" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0" AutoPostBack="true" OnTextChanged="TxtRs_TextChanged"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group row">
                                                                    <label for="ZF" class="col-xs-4 col-form-label">ZF</label>
                                                                    <div class="col-xs-8">
                                                                        <asp:TextBox ID="txtZF" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0" AutoPostBack="true" OnTextChanged="TxtRs_TextChanged"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="NetAmount" class="col-xs-4 col-form-label">Net Amount</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtNetAmount" CssClass="form-control text-box single-line" runat="server" TextMode="Number" Text="0"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel-body panel-form">
                                                        <div class="form-group row">
                                                            <label for="Remarks" class="col-xs-4 col-form-label">Remarks</label>
                                                            <div class="col-xs-8">
                                                                <asp:TextBox ID="txtRemarks" CssClass="form-control text-box single-line" runat="server" placeholder="Remarks"></asp:TextBox>
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
                                                    <asp:Button ID="BNew" runat="server" Text="Clear" CssClass="ui button" OnClick="BClear_Click" CausesValidation="false" />
                                                    <div class="or"></div>
                                                    <asp:Button ID="BSave" runat="server" Text="Save" ValidationGroup="SaveGroup" CssClass="ui positive button" OnClick="BSave_Click" />
                                                    <div class="or"></div>
                                                    <asp:Button ID="BPreview" runat="server" Text="Preview" CssClass="ui button" OnClientClick="previewPDF(); return false;" />
                                                    <div class="or"></div>
                                                    <asp:Button ID="BPrint" runat="server" Text="Print" CssClass="ui positive button" OnClientClick="downloadPDF(); return false;" />
                                                    <div class="or"></div>
                                                    <asp:Button ID="BExit" runat="server" Text="Exit" CssClass="ui button" OnClick="BExit_Click" CausesValidation="false" />
                                                </div>
                                            </div>
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
                    <h2>X-RAY</h2>
                </div>

                <div id="pdfViewer" style="height: 400px;"></div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        function generatePDF() {
            var category = document.getElementById('<%= ddlCat.ClientID %>').options[document.getElementById('<%= ddlCat.ClientID %>').selectedIndex].text;
           var currentDate = new Date();
           var date = currentDate.toLocaleDateString();
           var time = currentDate.toLocaleTimeString();
           var receiptno = document.getElementById('<%= txtReceiptNo.ClientID %>').value;
           var patientname = document.getElementById('<%= txtPatientName.ClientID %>').value;
           var title = document.getElementById('<%= ddlPatientName.ClientID %>').options[document.getElementById('<%= ddlPatientName.ClientID %>').selectedIndex].text;
           var gender = document.getElementById('<%= ddlGender.ClientID %>').options[document.getElementById('<%= ddlGender.ClientID %>').selectedIndex].text;
           var consultant = document.getElementById('<%= ddlConsultant.ClientID %>').options[document.getElementById('<%= ddlConsultant.ClientID %>').selectedIndex].text;
           var rupees = document.getElementById('<%= txtRupees.ClientID %>').value;
           var netamount = document.getElementById('<%= txtNetAmount.ClientID %>').value;

            // section A
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
                    text: 'Receipt: Consultation',
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
                    table: {
                        widths: ['*', '*'], // Adjust widths if necessary
                        body: [
                            [
                                { text: 'Rcpt #: ', style: 'tableHeader' },
                                { text: receiptno, style: 'tableData' }
                            ],
                            [
                                { text: 'Patient: ', style: 'tableHeader' },
                                { text: patientname + ', ' + title, style: 'tableData' }
                            ],
                            [
                                { text: 'Gender: ', style: 'tableHeader' },
                                { text: gender + ', Shift: EVENING', style: 'tableData' }
                            ],

                        ]
                    },
                    layout: 'lightHorizontalLines', // Optional: Adds horizontal lines
                    margin: [0, 0, 0, 10] // Adjust margin as needed
                },
                {
                    text: 'Consultant: ' + consultant,
                    style: 'tableData',
                    alignment: 'left',
                    margin: [0, 0, 0, 5]
                },

                {
                    columns: [

                        {
                            width: '*',
                            text: netamount,
                            alignment: 'right',
                            style: 'tableData'
                        }
                    ],
                    margin: [0, 20, 0, 0]
                },
                {
                    text: 'Net Amount Rs. ' + netamount,
                    alignment: 'right',
                    margin: [0, 10, 0, 0]
                }
            ];

            // section B
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
                    text: 'Original',
                    style: 'header1',
                    alignment: 'left',
                    margin: [0, 0, 0, 5]
                },
                {
                    text: 'Receipt: Consultation',
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
                    table: {
                        widths: ['*', '*'], // Adjust widths if necessary
                        body: [
                            [
                                { text: 'Rcpt #: ', style: 'tableHeader' },
                                { text: receiptno, style: 'tableData' }
                            ],
                            [
                                { text: 'Patient: ', style: 'tableHeader' },
                                { text: patientname + ', ' + title, style: 'tableData' }
                            ],
                            [
                                { text: 'Gender: ', style: 'tableHeader' },
                                { text: gender + ', Shift: EVENING', style: 'tableData' }
                            ],

                        ]
                    },
                    layout: 'lightHorizontalLines', // Optional: Adds horizontal lines
                    margin: [0, 0, 0, 10] // Adjust margin as needed
                },
                {
                    text: 'Consultant: ' + consultant,
                    style: 'tableData',
                    alignment: 'left',
                    margin: [0, 0, 0, 5]
                },

                {
                    columns: [

                        {
                            width: '*',
                            text: netamount,
                            alignment: 'right',
                            style: 'tableData'
                        }
                    ],
                    margin: [0, 20, 0, 0]
                },
                {
                    text: 'Net Amount Rs. ' + netamount,
                    alignment: 'right',
                    margin: [0, 10, 0, 0]
                }
            ];

            // section C
            var sectionContent2 = [
                {
                    text: 'Receipt: Consultation',
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
                    table: {
                        widths: ['*', '*'], // Adjust widths if necessary
                        body: [
                            [
                                { text: 'Rcpt #: ', style: 'tableHeader' },
                                { text: receiptno, style: 'tableData' }
                            ],
                            [
                                { text: 'Patient: ', style: 'tableHeader' },
                                { text: patientname + ', ' + title, style: 'tableData' }
                            ],
                            [
                                { text: 'Gender: ', style: 'tableHeader' },
                                { text: gender, style: 'tableData' }
                            ],
                            [
                                { text: 'Shift: ', style: 'tableHeader' },
                                { text: 'EVENING', style: 'tableData' }
                            ]

                        ]
                    },
                    layout: 'lightHorizontalLines', // Optional: Adds horizontal lines
                    margin: [0, 0, 0, 10] // Adjust margin as needed
                },
                {
                    text: 'Consultant: ' + consultant,
                    style: 'tableData',
                    alignment: 'left',
                    margin: [0, 0, 0, 5]
                },

                {
                    text: netamount,
                    alignment: 'right',
                    style: 'tableData',
                    margin: [0, 0, 0, 165]
                },
                {
                    text: 'Net Amount Rs. ' + netamount,
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
            generatePDF().download('ConsultationReceipt.pdf');
        }

    </script>
</asp:Content>

