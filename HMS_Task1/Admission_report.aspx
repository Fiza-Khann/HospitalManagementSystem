<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Admission_report.aspx.cs" Inherits="HMS_Task1.Admission_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .display {
            display: none;
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.72/pdfmake.min.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.72/vfs_fonts.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper">
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a>Admission</a></li>
            <li class="active">Admission Report</li>
        </ol>

        <div class="content">
            <div class="se-pre-con" style="display: none;"></div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>Admission Report</h4>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div id="DataTables_Table_0_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">

                                <div class="date-input" style="margin-bottom: 20px;">
                                    <label class="col-xs-2 date-label" style="margin-right: 2px;">Date:</label>
                                    <label for="date-from" style="margin-right: 10px;">From:</label>
                                    <asp:TextBox ID="dateFrom" runat="server" TextMode="Date" Style="margin-right: 30px;"></asp:TextBox>
                                    <label for="date-to" style="margin-right: 10px;">To:</label>
                                    <asp:TextBox ID="dateTo" runat="server" TextMode="Date"></asp:TextBox>
                                </div>
                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>

                                <div class="form-group row" style="display: flex; justify-content: center; margin-bottom: 20px;">
                                    <div>
                                        <div class="ui buttons">
                                            <asp:Button ID="BShow" runat="server" Text="Show" CssClass="ui button" OnClick="BShow_Click" />
                                            <div class="or"></div>
                                            <asp:Button ID="BPrint" runat="server" Text="Print" CssClass="ui positive button" OnClick="BPrint_Click" />
                                            <div class="or"></div>
                                            <asp:Button ID="BExit" runat="server" Text="Exit" CssClass="ui button" OnClick="BExit_Click" />
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 20px; margin-left: 30px; margin-right: 30px;">
                                    <asp:UpdatePanel ID="UpdatePanel2aa" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                                                Font-Size="12px" Font-Names="Arial" Width="100%" Height="252px">
                                                <Columns>
                                                    <asp:BoundField DataField="BillNo" HeaderText="BillNo" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="PatientName" HeaderText="Patient Name" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="RoomName" HeaderText="Room Name" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="ConsultantName" HeaderText="Consultant Name" ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="AdmDate" HeaderText="Admission Date" itemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="AdmTime" HeaderText="Admission Time" itemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                                    <asp:BoundField DataField="Mobile" HeaderText="Contact" itemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                                                </Columns>
                                                <HeaderStyle BackColor="#336699" ForeColor="White" Height="30px" CssClass="text-center" />
                                            </asp:GridView>
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

        <!-- Modal for PDF preview -->
        <div id="pdfModal" class="modal">
            <div class="modal-content">
                <button class="close-button" onclick="closeModal()">×</button>
                <div class="modal-header">
                    <h2>Admission Report</h2>
                </div>

                <div id="pdfViewer" style="height: 400px;"></div>

            </div>
        </div>

    </div>

    <!-- JavaScript to generate and preview PDF -->
    <script type="text/javascript">
        var docDefinition = {
            content: [
                {
                    text: 'Admission Report',
                    style: 'header',
                    alignment: 'center'
                },
                {
                    text: 'Date From: ' + document.getElementById('<%= dateFrom.ClientID %>').value,
                    style: 'subheader',
                    alignment: 'left',
                    margin: [0, 10, 0, 0]
                },
                {
                    text: 'Date To: ' + document.getElementById('<%= dateTo.ClientID %>').value,
                    style: 'subheader',
                    alignment: 'left',
                    margin: [0, 0, 0, 20]
                },
                {
                    table: {
                        headerRows: 1,
                        widths: ['auto', 'auto', 'auto', 'auto', 'auto', 'auto', 'auto'],
                        body: [
                            ['BillNo', 'Patient Name', 'Room Name', 'Consultant Name', 'Admission Date', 'Admission Time','Contact'],
                            <% foreach (GridViewRow row in GridView1.Rows)
        { %>
                            [
                                '<%= row.Cells[0].Text %>',
                                '<%= row.Cells[1].Text %>',
                                '<%= row.Cells[2].Text %>',
                                '<%= row.Cells[3].Text %>',
                                '<%= row.Cells[4].Text %>',
                                '<%= row.Cells[5].Text %>',
                                '<%= row.Cells[6].Text %>'
                            ],
                            <% } %>
                        ]
                    }
                }
            ],
            styles: {
                header: {
                    fontSize: 18,
                    bold: true,
                    margin: [0, 0, 0, 10]
                },
                subheader: {
                    fontSize: 14,
                    margin: [0, 10, 0, 10]
                }
            }
        };

        function generatePDF() {
            pdfMake.createPdf(docDefinition).getDataUrl(function (dataUrl) {
                var iframe = '<iframe width="100%" height="100%" src="' + dataUrl + '"></iframe>';
                document.getElementById('pdfViewer').innerHTML = iframe;
                document.getElementById('pdfModal').style.display = 'block';
            });
        }

        function closeModal() {
            document.getElementById('pdfModal').style.display = 'none';
        }

        function downloadPDF() {
            pdfMake.createPdf(docDefinition).download('Admission_Report.pdf');
            closeModal();
        }
    </script>
</asp:Content>
