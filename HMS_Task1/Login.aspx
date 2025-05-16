<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HMS_Task1.Login" %>

<!DOCTYPE html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Favicon icon -->
    <link rel="apple-touch-icon" sizes="180x180" href="images/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="images/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon/favicon-16x16.png">
    <link rel="manifest" href="images/favicon/site.webmanifest">
    <link rel="mask-icon" href="images/favicon/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    <title>Login Window</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/monsteradmin/">
    <!-- Custom CSS -->
    <link href="css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        // Function to toggle password visibility
        function togglePasswordVisibility(textBoxId, checkbox) {
            var txt = document.getElementById(textBoxId); // Get the textbox element by ID

            // Toggle the password visibility based on checkbox state
            if (checkbox.checked) {
                txt.type = 'text'; // Show password
            } else {
                txt.type = 'password'; // Hide password
            }
        }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-wrapper">
            <!-- ============================================================== -->
            <!-- Preloader - style you can find in spinners.css -->
            <!-- ============================================================== -->
            <div class="preloader" style="display: none;">
                <div class="lds-ripple">
                    <div class="lds-pos">
                    </div>
                    <div class="lds-pos">
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- Preloader - style you can find in spinners.css -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Login box.scss -->
            <!-- ============================================================== -->
            <div class="auth-wrapper d-flex no-block justify-content-center align-items-center"
                style="background: url(images/background/login-register.jpg) no-repeat center center; background-size: cover;">
                <div class="auth-box p-4 bg-white rounded">
                    <div id="loginform">
                        <div class="logo">
                            <h3 class="box-title mb-3">Sign In</h3>
                        </div>
                        <!-- Form -->
                        <div class="row">
                            <div class="col-12">
                                <form class="form-horizontal mt-3 form-material" id="loginform" action="Login.aspx" method="post">
                                    <div class="form-group mb-3">
                                        <div class="">
                                            <input id="txtUserName" class="form-control" type="text" required="" placeholder="Username"
                                                runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group mb-4">
                                        <div class="">
                                        <input id="txtPassword" class="form-control" type="password" required="" placeholder="Password" runat="server"/>

                                            <label for="chkShow" style="margin-top: 20px;">
                                                <input type="checkbox" id="chkShow" onclick="togglePasswordVisibility('txtPassword', this)" />
                                                Show Password </label>
                                        </div>
                                    </div>

                                    <div class="form-group text-center mt-4">
                                        <div class="col-xs-12">
                                            <asp:Button ID="BLogin" runat="server" Text="Log In" CssClass="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light" OnClick="BLogin_Click" runat="server" />
                                            <div class="col-sm-12 justify-content-center d-flex">
                                                <p>
                                                    <asp:Label ID="lblErr" runat="server" ForeColor="Red"></asp:Label>
                                                </p>
                                            </div>
                                            <%--<button class="btn btn-info btn-lg btn-block text-uppercase waves-effect waves-light"
                                        type="submit" runat="server">
                                        Log In</button>--%>
                                        </div>
                                    </div>
                                    <%--<div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12 mt-2 text-center">
                                    <div class="social mb-3">
                                        <a href="javascript:void(0)" class="btn  btn-facebook" data-toggle="tooltip" title=""
                                            data-original-title="Login with Facebook"><i aria-hidden="true" class="fab fa-facebook-f">
                                            </i></a><a href="javascript:void(0)" class="btn btn-googleplus" data-toggle="tooltip"
                                                title="" data-original-title="Login with Google"><i aria-hidden="true" class="fab fa-google-plus">
                                                </i></a>
                                    </div>
                                </div>
                            </div>--%>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- ============================================================== -->
        <!-- Login box.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper scss in scafholding.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper scss in scafholding.scss -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Right Sidebar -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Right Sidebar -->
        <!-- ============================================================== -->

        <!-- ============================================================== -->
        <!-- All Required js -->
        <!-- ============================================================== -->
        <script src="js/jquery.min.js"></script>
        <!-- Bootstrap tether Core JavaScript -->
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- ============================================================== -->
        <!-- This page plugin js -->
        <!-- ============================================================== -->

    </form>
</body>
</html>
