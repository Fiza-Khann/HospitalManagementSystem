<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="HMS_Task1.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* General Notification Panel */
        .notification-container {
            width: 100%;
            height: 400px;
            overflow: hidden;
            position: relative;
            background-color: #f8f9fa;
        }

        /* Scrolling Container */
        .scroll-container {
            height: 100%;
            overflow: hidden;
            position: relative;
            padding-left: 10px;
            padding-right: 10px;
        }

        /* Scrolling Text - Notifications */
        #scroll-text {
            display: flex;
            position: relative;
            text-align: left;
            flex-direction: column;
            gap: 10px;
            top: 0px;
            width: 100%;
            animation: my-animation 10s linear infinite;
        }

        /* Pause animation when hovered */
        #scroll-text:hover {
            animation-play-state: paused;
        }

        /* Notification Cards */
        .card {
            width: 100%;
            padding: 10px;
            background: white;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        /* Notification Colors */
        .alert {
            color: black;
        }

        .alert-info {
            color: blue;
        }

        .alert-success {
            color: green;
        }

        .alert-warning {
            color: orange;
        }

        /* Scrolling Animation */
        @keyframes my-animation {
            from {
                transform: translateY(400px);
            }
            to {
                transform: translateY(-100%);
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content-wrapper" style="min-height: 975px;">
        <section class="content-header">
            <div class="p-l-30 p-r-30">
                <div class="header-icon"><i class="fas fa-home"></i></div>
                <div class="header-title">
                    <h1>Dashboard</h1>
                    <small>Home</small>
                </div>
            </div>
        </section>
        <div class="content">
            <div class="row">
                <!-- Dashboard Cards -->
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                    <div class="small-box bg-aqua">
                        <div class="inner">
                            <h3><asp:Label ID="lblTotEmployee" runat="server" Text="0"></asp:Label></h3>
                            <p>Total Employee</p>
                        </div>
                        <div class="icon"><i class="fa fa-users"></i></div>
                        <a href="ViewUser.aspx" class="small-box-footer">More Info <i class="small-box-footer"></i></a>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                    <div class="small-box bg-green">
                        <div class="inner">
                            <h3><asp:Label ID="lblTodayPresent" runat="server" Text="0"></asp:Label></h3>
                            <p>Today's Presents</p>
                        </div>
                        <div class="icon"><i class="fa fa-user-plus"></i></div>
                        <a href="AttendanceLog.aspx" class="small-box-footer">More Info <i class="small-box-footer"></i></a>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                    <div class="small-box bg-blue">
                        <div class="inner">
                            <h3><asp:Label ID="lblTodayAbsent" runat="server" Text="0"></asp:Label></h3>
                            <p>Today's Absents</p>
                        </div>
                        <div class="icon"><i class="fa fa-user-times"></i></div>
                        <a href="AttendanceLog.aspx" class="small-box-footer">More Info <i class="small-box-footer"></i></a>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                    <div class="small-box bg-yellow">
                        <div class="inner">
                            <h3><asp:Label ID="lblTodayLeave" runat="server" Text="0"></asp:Label></h3>
                            <p>Today's Leave</p>
                        </div>
                        <div class="icon"><i class="fa fa-user-o"></i></div>
                        <a href="AttendanceLog.aspx" class="small-box-footer">More Info <i class="small-box-footer"></i></a>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Employee List -->
                <div class="col-lg-8">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="widget-title">
                                <h3>Employee List</h3>
                                <hr />
                            </div>
                            <asp:GridView ID="gvEmployeeList" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-bordered table-striped"
                                HeaderStyle-BackColor="#f1f1f1"
                                HeaderStyle-ForeColor="black"
                                AlternatingRowStyle-BackColor="#f9f9f9">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="Designation" HeaderText="Designation" />
                                    <asp:BoundField DataField="Email" HeaderText="Email" />
                                </Columns>
                            </asp:GridView>
                            <div id="lineChart" style="display: block; width: 655px; height: 325px;">
                                <asp:Label ID="lblStaff" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Notification Panel -->
                <div class="col-lg-4">
                    <div class="panel panel-bd">
                        <div class="panel-heading">
                            <h3>Notifications</h3>
                        </div>
                        <div class="panel-body">
                            <div class="notification-container">
                                <div class="scroll-container">
                                    <div id="scroll-text">
                                        <asp:UpdatePanel ID="UpdatePanelNotifications" runat="server">
                                            <ContentTemplate>
                                                <asp:Repeater ID="rptNotifications" runat="server">
                                                    <ItemTemplate>
                                                        <div class="card alert alert-info">
                                                            <strong><%# Eval("Title") %></strong> - <%# Eval("Message") %>
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="message_inner">
                        <asp:Label ID="lblGridNotice" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const scrollText = document.getElementById("scroll-text");

            // Add click event listener to pause animation
            scrollText.addEventListener("click", function () {
                if (scrollText.classList.contains("paused")) {
                    scrollText.classList.remove("paused");
                } else {
                    scrollText.classList.add("paused");
                }
            });
        });
    </script>

</asp:Content>
