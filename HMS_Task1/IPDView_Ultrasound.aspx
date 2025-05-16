<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="IPDView_Ultrasound.aspx.cs" Inherits="HMS_Task_5.IPDView_Ultrasound" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
        <!-- Content Header (Page header) -->
        <ol class="breadcrumb breadcrumb-new">
            <li><a href="Home.aspx">Home</a></li>
            <li><a href="#">In-Patient</a></li>
            <li class="active">Ultrasound\Doppler</li>
        </ol>
        <!-- Main content -->
        <div class="content">
            <div class="se-pre-con" style="display: none;"></div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>View: Ultrasound \ Doppler</h4>
                            </div>
                            <div class="mr-25">
                                <a class="btn btn-primary" href="IPDEdit_Ultrasound.aspx">Edit Ultrasound</a>
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
                                                    BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" DataKeyNames="ID"
                                                    Font-Size="12px" Font-Names="Arial" Width="100%" CssClass="table table-bordered">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="True" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" OnClick="handleCheckboxSelection(this);" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ID" HeaderText="ID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="TestTypeName" HeaderText="TestTypeName" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="250px" />
                                                        <asp:BoundField DataField="TestName" HeaderText="TestName" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="250px" />
                                                        <asp:BoundField DataField="Charges" HeaderText="Charges" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="ConsultantShare" HeaderText="ConsultantShare" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                        <asp:BoundField DataField="HospitalShare" HeaderText="HospitalShare" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="150px" />
                                                    </Columns>
                                                    <HeaderStyle BackColor="#336699" ForeColor="White" Height="30px" />
                                                </asp:GridView>
                                            </div>
                                            <br />
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-success" OnClick="btnDelete_Click" />
                                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                                            <asp:Button ID="BPrint" runat="server" Text="Print Test Charges" CssClass="btn btn-success" OnClientClick="downloadPDF(); return false;" />
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
    <!-- JavaScript to generate and preview PDF -->
    <script type="text/javascript">
        var gridData = [
        <% foreach (GridViewRow row in MainGrid.Rows)
        { %>
                                        {
                                            TestName: '<%= row.Cells[3].Text %>',
                                            Charges: '<%= row.Cells[4].Text %>',
                                            ConsultantShare: '<%= row.Cells[5].Text %>',
                                            HospitalShare: '<%= row.Cells[6].Text %>'
                                        },
        <% } %>
        ];

        function generatePDF() {
            var docDefinition = {
                content: [
                    {
                        columns: [
                            {
                                width: '*',
                                text: 'Ultrasound / Doppler',
                                style: 'header',
                                alignment: 'left',
                                margin: [0, 0, 0, 20]
                            },
                            {
                                width: '*',
                                text: 'Printed on: <%= DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") %>',
                                alignment: 'right',
                                margin: [0, 0, 0, 5],
                                style: 'header1',
                            }
                        ],
                        margin: [0, 20, 0, 0]
                    },
                    {
                        table: {
                            headerRows: 1,
                            widths: ['*', '*', '*', '*'],
                            body: [
                                [
                                    { text: 'Test Name', style: 'tableHeader' },
                                    { text: 'Charges', style: 'tableHeader' },
                                    { text: 'Consultant Share', style: 'tableHeader' },
                                    { text: 'Hospital Share', style: 'tableHeader' }
                                ],
                                ...gridData.map(row => [row.TestName, row.Charges, row.ConsultantShare, row.HospitalShare])
                            ]

                        }
                    }
                ],
                styles: {
                    header: {
                        fontSize: 16,
                        bold: true,
                        margin: [0, 10, 0, 10]
                    },
                    header1: {
                        fontSize: 10,
                        margin: [0, 10, 0, 10]
                    },
                    tableHeader: {
                        bold: true,
                        fontSize: 12,
                        margin: [0, 5, 0, 5]
                    }
                }
            };
            return pdfMake.createPdf(docDefinition);
        }

        function downloadPDF() {
            generatePDF().download('UltrasoundReport.pdf');
            closeModal();
        }
    </script>
</asp:Content>
