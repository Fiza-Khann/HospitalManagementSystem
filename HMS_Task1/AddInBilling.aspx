<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="AddInBilling.aspx.cs" Inherits="HMS_Task1.AddInBilling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include Bootstrap 5 JS (this includes Popper.js internally) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function () {
            $(".dropdown-menu").hide();

            $(".dropdown-toggle").click(function () {
                $(this).next(".dropdown-menu").toggle();
            });

            // X-Ray
            $(document).on('change', '#<%= chkXrayChecklist.ClientID %> input[type="checkbox"]', function () {
                calculateTotalPrice();
            });

            // Medical Services
            $(document).on('change', '#<%= chkMedChecklist.ClientID %> input[type="checkbox"]', function () {
                calculateTotalPrice1();
            });

            // Dental Services
            $(document).on('change', '#<%= chkListDental.ClientID %> input[type="checkbox"]', function () {
                calculateDentalPrice();
            });

            // Ultrasound Services
            $(document).on('change', '#<%= chkListUltrasound.ClientID %> input[type="checkbox"]', function () {
                calculateUltrasoundPrice();
            });

            function calculateTotalPrice() {
                var totalPrice = 0;
                $('#<%= chkXrayChecklist.ClientID %> input[type="checkbox"]:checked').each(function () {
                    totalPrice += parseFloat($(this).val()) || 0;
                });
                $('#<%= txtXRay.ClientID %>').val(totalPrice.toFixed(2));
            }

            function calculateTotalPrice1() {
                var total = 0;
                $('#<%= chkMedChecklist.ClientID %> input[type="checkbox"]:checked').each(function () {
                    total += parseFloat($(this).val()) || 0;
                });
                $('#<%= txtMedicalServices.ClientID %>').val(total.toFixed(2));
            }
            function calculateDentalPrice() {
                var dentalTotal = 0;
                $('#<%= chkListDental.ClientID %> input[type="checkbox"]:checked').each(function () {
                    dentalTotal += parseFloat($(this).val()) || 0;
                });
                $('#<%= txtDental.ClientID %>').val(dentalTotal.toFixed(2));
            }

            function calculateUltrasoundPrice() {
                var ultrasoundTotal = 0;
                $('#<%= chkListUltrasound.ClientID %> input[type="checkbox"]:checked').each(function () {
                    ultrasoundTotal += parseFloat($(this).val()) || 0;
                });
                $('#<%= txtUltrasound.ClientID %>').val(ultrasoundTotal.toFixed(2));
            }

        });
    </script>

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">Billing</a></li>
            <li class="active">Add Billing</li>
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
                                        <h4>Add: Add Billing</h4>
                                    </div>
                                    <div class="mr-25">
                                        <a class="btn btn-primary" href="ViewBilling.aspx">View Billing</a>
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
                                                                <label for="Gender" class="col-xs-4 col-form-label">Gender</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtGender" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <label for="Cont1" class="col-xs-4 col-form-label">Mobile</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtMobile" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
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
                                                                <label for="Age" class="col-xs-4 col-form-label">Age</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAge" TextMode="Number" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="CityName" class="col-xs-4 col-form-label">City Name</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtCityName" CssClass="form-control text-box single-line" runat="server" ReadOnly="true"></asp:TextBox>
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


                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-heading">
                                            <div class="panel-title text-success">
                                                <h4>Billing</h4>
                                            </div>
                                            <div class="panel panel-default thumbnail">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="txtBillNo" class="col-xs-4 col-form-label">Bill No</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtBillNo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtBillingDate" class="col-xs-4 col-form-label">Billing Date</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtBillingDate" runat="server" CssClass="form-control" TextMode="Date" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtBillingTime" class="col-xs-4 col-form-label">Billing Time</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtBillingTime" runat="server" CssClass="form-control" TextMode="Time" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtSerialNo" class="col-xs-4 col-form-label">Serial No</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtSerialNo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="chkPackage" class="col-xs-4 col-form-label">Package</label>
                                                                <div class="col-xs-8">
                                                                    <asp:CheckBox ID="chkPackage" runat="server" OnCheckedChanged="chkPackage_CheckedChanged" AutoPostBack="True" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtPackageList" class="col-xs-4 col-form-label">Package List</label>
                                                                <div class="col-xs-8">
                                                                    <asp:DropDownList ID="ddlRoomType" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlRoomType_SelectedIndexChanged" AutoPostBack="True">
                                                                        <asp:ListItem Text="Select Room Type" Value="" Selected="True" />
                                                                        <asp:ListItem Text="Standard" Value="Standard" />
                                                                        <asp:ListItem Text="Deluxe" Value="Deluxe" />
                                                                        <asp:ListItem Text="Basic" Value="Basic" />
                                                                        <asp:ListItem Text="Economy" Value="Economy" />
                                                                        <asp:ListItem Text="Premium" Value="Premium" />
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtRoomCharges" class="col-xs-4 col-form-label">Room Charges</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtRoomCharges" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtXRay" class="col-xs-4 col-form-label">X-Ray</label>
                                                                <div class="col-xs-8">

                                                                    <div class="dropdown">
                                                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                            Select X-ray Tests           
                                                                        </button>
                                                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                                            <!-- Dynamically populated checkbox list goes here -->
                                                                            <asp:CheckBoxList ID="chkXrayChecklist" runat="server" CssClass="form-control">
                                                                            </asp:CheckBoxList>
                                                                        </div>
                                                                    </div>

                                                                    <asp:TextBox ID="txtXRay" runat="server" CssClass="form-control" Text="0"></asp:TextBox>

                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtMedicalServices" class="col-xs-4 col-form-label">Medical Services</label>
                                                                <div class="col-xs-8">
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="ddMedMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                            Select Med Services           
                                                                        </button>
                                                                        <div class="dropdown-menu" aria-labelledby="ddMedMenu">
                                                                            <!-- Dynamically populated checkbox list goes here -->
                                                                            <asp:CheckBoxList ID="chkMedChecklist" runat="server" CssClass="form-control">
                                                                            </asp:CheckBoxList>
                                                                        </div>
                                                                    </div>
                                                                    <asp:TextBox ID="txtMedicalServices" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">
                                                            <div class="form-group row">
                                                                <label for="txtConsultant" class="col-xs-4 col-form-label">Consultant</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" TextMode="Number" ReadOnly="true" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtDental" class="col-xs-4 col-form-label">Dental</label>
                                                                <div class="col-xs-8">
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="ddlDental" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                            Select Dental Services           
                                                                        </button>
                                                                        <div class="dropdown-menu" aria-labelledby="ddlDental">
                                                                            <!-- Dynamically populated checkbox list goes here -->
                                                                            <asp:CheckBoxList ID="chkListDental" runat="server" CssClass="form-control">
                                                                            </asp:CheckBoxList>
                                                                        </div>
                                                                    </div>
                                                                    <asp:TextBox ID="txtDental" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtUltrasound" class="col-xs-4 col-form-label">Ultrasound</label>
                                                                <div class="col-xs-8">
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="ddlUltrasound" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                            Select Ultrasound Services           
                                                                        </button>
                                                                        <div class="dropdown-menu" aria-labelledby="ddlUltrasound">
                                                                            <!-- Dynamically populated checkbox list goes here -->
                                                                            <asp:CheckBoxList ID="chkListUltrasound" runat="server" CssClass="form-control">
                                                                            </asp:CheckBoxList>
                                                                        </div>
                                                                    </div>
                                                                    <asp:TextBox ID="txtUltrasound" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="form-group row">
                                                                <label for="txtMisc" class="col-xs-4 col-form-label">Miscellaneous</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtMisc" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <asp:Button ID="btnCalculate" runat="server" Text="Calculate" OnClick="btnCalculate_Click" CssClass="btn btn-primary" />
                                                            </div>
                                                            <div class="form-group row">

                                                                <label for="txtTotalHospitalCharges" class="col-xs-4 col-form-label">Total Hospital Charges</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtTotalHospitalCharges" runat="server" CssClass="form-control" TextMode="Number" Enabled="true" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtTotalConsultantCharges" class="col-xs-4 col-form-label">Total Consultant Charges</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtTotalConsultantCharges" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtSPD" class="col-xs-4 col-form-label">SPD</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtSPD" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtZF" class="col-xs-4 col-form-label">ZF</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtZF" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="panel-body panel-form">

                                                            <div class="form-group row">
                                                                <label for="chkDischarge" class="col-xs-4 col-form-label">Discharge</label>
                                                                <div class="col-xs-8">
                                                                    <asp:CheckBox ID="chkDischarge" runat="server" />
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtDischargeDate" class="col-xs-4 col-form-label">Discharge Date</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDischargeDate" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtDischargeTime" class="col-xs-4 col-form-label">Discharge Time</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDischargeTime" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtRemarks" class="col-xs-4 col-form-label">Remarks</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtAdvancePaid" class="col-xs-4 col-form-label">Advance Paid</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtAdvancePaid" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtBillTotalCharges" class="col-xs-4 col-form-label">Bill Total Charges (<span style="color: green;">- Adv Rs.</span>)</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtBillTotalCharges" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtDepositedAmount" class="col-xs-4 col-form-label">Deposited Amount</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDepositedAmount" runat="server" CssClass="form-control" TextMode="Number" Text="0" AutoPostBack="true" OnTextChanged="CalculateNetAndRefund"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtDiscount" class="col-xs-4 col-form-label">Discount %</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtDiscount" runat="server" CssClass="form-control" TextMode="Number" Text="0" AutoPostBack="true" OnTextChanged="CalculateNetAndRefund"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtRefunded" class="col-xs-4 col-form-label">To Be Refunded</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtToBeRefunded" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="txtNetBalance" class="col-xs-4 col-form-label">Net Balance</label>
                                                                <div class="col-xs-8">
                                                                    <asp:TextBox ID="txtNetBalance" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
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
                                                <asp:Button ID="BNew" runat="server" Text="Clear" CssClass="ui button" OnClick="BClear_Click" CausesValidation="false" />
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

           // Get patient information
           var regNo = document.getElementById('<%= txtReg.ClientID %>').value + '-' + document.getElementById('<%= txtNo.ClientID %>').value;
        var patientName = document.getElementById('<%= txtPatientName.ClientID %>').value;
        var gender = document.getElementById('<%= txtGender.ClientID %>').value;
        var age = document.getElementById('<%= txtAge.ClientID %>').value;
        var admDate = document.getElementById('<%= txtAdmDate.ClientID %>').value;
        var admTime = document.getElementById('<%= txtAdmTime.ClientID %>').value;
        var room = document.getElementById('<%= txtRoom.ClientID %>').value;
        var consultant = document.getElementById('<%= txtConsultant.ClientID %>').value;
        var mobile = document.getElementById('<%= txtMobile.ClientID %>').value;
        var city = document.getElementById('<%= txtCityName.ClientID %>').value;
        var serialNo = document.getElementById('<%= txtSerialNo.ClientID %>').value;
        var billNo = document.getElementById('<%= txtBillNo.ClientID %>').value;
        var billingDate = document.getElementById('<%= txtBillingDate.ClientID %>').value;
        var billingTime = document.getElementById('<%= txtBillingTime.ClientID %>').value;
        var dischargeDate = document.getElementById('<%= txtDischargeDate.ClientID %>').value || 'N/A';
        var dischargeTime = document.getElementById('<%= txtDischargeTime.ClientID %>').value || '';
        var remarks = document.getElementById('<%= txtRemarks.ClientID %>').value;

        // Billing information
        var roomCharges = document.getElementById('<%= txtRoomCharges.ClientID %>').value || '0';
        var xRay = document.getElementById('<%= txtXRay.ClientID %>').value || '0';
        var medicalServices = document.getElementById('<%= txtMedicalServices.ClientID %>').value || '0';
        var dental = document.getElementById('<%= txtDental.ClientID %>').value || '0';
        var ultrasound = document.getElementById('<%= txtUltrasound.ClientID %>').value || '0';
        var misc = document.getElementById('<%= txtMisc.ClientID %>').value || '0';
        var consultantFees = document.getElementById('<%= TextBox1.ClientID %>').value || '0';
        var totalHospitalCharges = document.getElementById('<%= txtTotalHospitalCharges.ClientID %>').value || '0';
        var totalConsultantCharges = document.getElementById('<%= txtTotalConsultantCharges.ClientID %>').value || '0';
        var spd = document.getElementById('<%= txtSPD.ClientID %>').value || '0';
        var zf = document.getElementById('<%= txtZF.ClientID %>').value || '0';
        var advancePaid = document.getElementById('<%= txtAdvancePaid.ClientID %>').value || '0';
        var billTotalCharges = document.getElementById('<%= txtBillTotalCharges.ClientID %>').value || '0';
        var depositedAmount = document.getElementById('<%= txtDepositedAmount.ClientID %>').value || '0';
        var discount = document.getElementById('<%= txtDiscount.ClientID %>').value || '0';
        var toBeRefunded = document.getElementById('<%= txtToBeRefunded.ClientID %>').value || '0';
        var netBalance = document.getElementById('<%= txtNetBalance.ClientID %>').value || '0';

        function formatCurrency(value) {
            return 'Rs. ' + parseFloat(value).toFixed(2);
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
                text: 'BILLING RECEIPT',
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
                text: 'Patient Information',
                style: 'sectionHeader',
                margin: [0, 10, 0, 5]
            },
            {
                table: {
                    widths: ['*', '*'],
                    body: [
                        [{ text: 'Bill No:', style: 'tableHeader' }, { text: billNo, style: 'tableData' }],
                        [{ text: 'Reg No:', style: 'tableHeader' }, { text: regNo, style: 'tableData' }],
                        [{ text: 'Patient:', style: 'tableHeader' }, { text: patientName, style: 'tableData' }],
                        [{ text: 'Gender/Age:', style: 'tableHeader' }, { text: gender + ' / ' + age, style: 'tableData' }],
                        [{ text: 'Adm Date/Time:', style: 'tableHeader' }, { text: admDate + ' ' + admTime, style: 'tableData' }],
                        [{ text: 'Discharge Date/Time:', style: 'tableHeader' }, { text: dischargeDate + ' ' + dischargeTime, style: 'tableData' }],
                        [{ text: 'Room:', style: 'tableHeader' }, { text: room, style: 'tableData' }],
                        [{ text: 'Consultant:', style: 'tableHeader' }, { text: consultant, style: 'tableData' }]
                    ]
                },
                layout: 'lightHorizontalLines',
                margin: [0, 0, 0, 15]
            },
            {
                text: 'Billing Details',
                style: 'sectionHeader',
                margin: [0, 10, 0, 5]
            },
            {
                table: {
                    widths: ['*', '*'],
                    body: [
                        [{ text: 'Room Charges', style: 'tableHeader' }, { text: formatCurrency(roomCharges), style: 'tableData', alignment: 'right' }],
                        [{ text: 'X-Ray Services', style: 'tableHeader' }, { text: formatCurrency(xRay), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Medical Services', style: 'tableHeader' }, { text: formatCurrency(medicalServices), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Dental Services', style: 'tableHeader' }, { text: formatCurrency(dental), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Ultrasound Services', style: 'tableHeader' }, { text: formatCurrency(ultrasound), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Miscellaneous', style: 'tableHeader' }, { text: formatCurrency(misc), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Consultant Fees', style: 'tableHeader' }, { text: formatCurrency(consultantFees), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Advance Paid', style: 'tableHeader' }, { text: formatCurrency(advancePaid), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Bill Total (-Adv)', style: 'tableHeader' }, { text: formatCurrency(billTotalCharges), style: 'tableData', alignment: 'right', bold: true }],
                        [{ text: 'Deposited Amount', style: 'tableHeader' }, { text: formatCurrency(depositedAmount), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Discount (' + discount + '%)', style: 'tableHeader' }, { text: formatCurrency((parseFloat(billTotalCharges) * parseFloat(discount) / 100)), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Net Balance', style: 'tableHeader', bold: true }, { text: formatCurrency(netBalance), style: 'tableData', alignment: 'right', bold: true }],
                        [{ text: 'To Be Refunded', style: 'tableHeader' }, { text: formatCurrency(toBeRefunded), style: 'tableData', alignment: 'right', bold: true }]
                    ]
                },
                layout: 'lightHorizontalLines',
                margin: [0, 0, 0, 10]
            },
            {
                text: 'Remarks: ' + (remarks || 'N/A'),
                margin: [0, 10, 0, 5]
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
                text: 'BILLING RECEIPT',
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
                text: 'Patient Information',
                style: 'sectionHeader',
                margin: [0, 10, 0, 5]
            },
            {
                table: {
                    widths: ['*', '*'],
                    body: [
                        [{ text: 'Bill No:', style: 'tableHeader' }, { text: billNo, style: 'tableData' }],
                        [{ text: 'Reg No:', style: 'tableHeader' }, { text: regNo, style: 'tableData' }],
                        [{ text: 'Patient:', style: 'tableHeader' }, { text: patientName, style: 'tableData' }],
                        [{ text: 'Gender/Age:', style: 'tableHeader' }, { text: gender + ' / ' + age, style: 'tableData' }],
                        [{ text: 'Adm Date/Time:', style: 'tableHeader' }, { text: admDate + ' ' + admTime, style: 'tableData' }],
                        [{ text: 'Discharge Date/Time:', style: 'tableHeader' }, { text: dischargeDate + ' ' + dischargeTime, style: 'tableData' }],
                        [{ text: 'Room:', style: 'tableHeader' }, { text: room, style: 'tableData' }],
                        [{ text: 'Consultant:', style: 'tableHeader' }, { text: consultant, style: 'tableData' }]
                    ]
                },
                layout: 'lightHorizontalLines',
                margin: [0, 0, 0, 15]
            },
            {
                text: 'Billing Details',
                style: 'sectionHeader',
                margin: [0, 10, 0, 5]
            },
            {
                table: {
                    widths: ['*', '*'],
                    body: [
                        [{ text: 'Room Charges', style: 'tableHeader' }, { text: formatCurrency(roomCharges), style: 'tableData', alignment: 'right' }],
                        [{ text: 'X-Ray Services', style: 'tableHeader' }, { text: formatCurrency(xRay), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Medical Services', style: 'tableHeader' }, { text: formatCurrency(medicalServices), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Dental Services', style: 'tableHeader' }, { text: formatCurrency(dental), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Ultrasound Services', style: 'tableHeader' }, { text: formatCurrency(ultrasound), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Miscellaneous', style: 'tableHeader' }, { text: formatCurrency(misc), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Consultant Fees', style: 'tableHeader' }, { text: formatCurrency(consultantFees), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Advance Paid', style: 'tableHeader' }, { text: formatCurrency(advancePaid), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Bill Total (-Adv)', style: 'tableHeader' }, { text: formatCurrency(billTotalCharges), style: 'tableData', alignment: 'right', bold: true }],
                        [{ text: 'Deposited Amount', style: 'tableHeader' }, { text: formatCurrency(depositedAmount), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Discount (' + discount + '%)', style: 'tableHeader' }, { text: formatCurrency((parseFloat(billTotalCharges) * parseFloat(discount) / 100)), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Net Balance', style: 'tableHeader', bold: true }, { text: formatCurrency(netBalance), style: 'tableData', alignment: 'right', bold: true }],
                        [{ text: 'To Be Refunded', style: 'tableHeader' }, { text: formatCurrency(toBeRefunded), style: 'tableData', alignment: 'right', bold: true }]
                    ]
                },
                layout: 'lightHorizontalLines',
                margin: [0, 0, 0, 10]
            },
            {
                text: 'Remarks: ' + (remarks || 'N/A'),
                margin: [0, 10, 0, 5]
            }
        ];

        // Section C (Smaller version)
        var sectionContent2 = [
            {
                text: 'BILLING RECEIPT',
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
                    widths: ['*', '*'],
                    body: [
                        [{ text: 'Bill No:', style: 'tableHeader' }, { text: billNo, style: 'tableData' }],
                        [{ text: 'Patient:', style: 'tableHeader' }, { text: patientName, style: 'tableData' }],
                        [{ text: 'Room:', style: 'tableHeader' }, { text: room, style: 'tableData' }],
                        [{ text: 'Adm Date:', style: 'tableHeader' }, { text: admDate, style: 'tableData' }],
                        [{ text: 'Discharge Date:', style: 'tableHeader' }, { text: dischargeDate, style: 'tableData' }],
                        [{ text: 'Consultant:', style: 'tableHeader' }, { text: consultant, style: 'tableData' }]
                    ]
                },
                layout: 'lightHorizontalLines',
                margin: [0, 0, 0, 10]
            },
            {
                table: {
                    widths: ['*', '*'],
                    body: [
                        [{ text: 'Advance Paid', style: 'tableHeader' }, { text: formatCurrency(advancePaid), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Bill Total (-Adv)', style: 'tableHeader' }, { text: formatCurrency(billTotalCharges), style: 'tableData', alignment: 'right', bold: true }],
                        [{ text: 'Deposited Amount', style: 'tableHeader' }, { text: formatCurrency(depositedAmount), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Discount (' + discount + '%)', style: 'tableHeader' }, { text: formatCurrency((parseFloat(billTotalCharges) * parseFloat(discount) / 100)), style: 'tableData', alignment: 'right' }],
                        [{ text: 'Net Balance', style: 'tableHeader', bold: true }, { text: formatCurrency(netBalance), style: 'tableData', alignment: 'right', bold: true }],
                        [{ text: 'To Be Refunded', style: 'tableHeader' }, { text: formatCurrency(toBeRefunded), style: 'tableData', alignment: 'right', bold: true }]
                    ]
                },
                layout: 'lightHorizontalLines',
                margin: [0, 0, 0, 10]
            },
            {
                text: 'Remarks: ' + (remarks || 'N/A'),
                margin: [0, 10, 0, 5]
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
                sectionHeader: {
                    fontSize: 12,
                    bold: true,
                    color: '#2c3e50'
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
        generatePDF().download('Hospital_Billing_Receipt_' + document.getElementById('<%= txtBillNo.ClientID %>').value + '.pdf');
       }
   </script>
</asp:Content>
