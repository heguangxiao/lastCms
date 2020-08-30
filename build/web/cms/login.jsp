<%@page import="vn.web.lastCms.utils.Md5"%>
<%@page import="vn.web.lastCms.entity.User"%>
<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdminLTE 3 | Log in</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/fontawesome-free/css/all.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <!-- icheck bootstrap -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/adminlte.min.css">
        <!-- Google Font: Source Sans Pro -->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    </head>
    <%
        User user = User.getUser(session);
        if (user != null) {
            response.sendRedirect(request.getContextPath() + "/cms/index.jsp");
        }
        if (request.getParameter("submit") != null) {
            String userName = Tool.validStringRequest(request.getParameter("userName"));
            String password = Tool.validStringRequest(request.getParameter("password"));
            user = User.getUser(userName);
            if (user == null) {
                session.setAttribute("error", "Tài khoản không tồn tại");
            } else {
                if (user.getStatus()== 1) {
                    if (!Md5.encryptMD5(password).equals(user.getPassword())) {
                        session.setAttribute("error", "Mật khẩu không chính xác");
                    } else {
                        session.setAttribute("userLogin", user);
                        response.sendRedirect(request.getContextPath() + "/cms/");
                    }
                } else if (user.getStatus() == 0) {
                    session.setAttribute("error", "Tài khoản của bạn chưa được kích hoạt");
                } else if (user.getStatus() == 2) {
                    session.setAttribute("error", "Tài khoản của bạn đã bị khóa");
                }
            }
        }
    %>
    <body class="hold-transition login-page">        
        <div class="login-box">
            <div class="login-logo">
              <a href="<%=request.getContextPath()%>/cms/index.jsp"><b>Admin</b>LTE</a>
            </div>
            <!-- /.login-logo -->
            <div class="card">
                <div class="card-body login-card-body">
                    <p class="login-box-msg">
                        <%=(session.getAttribute("error") != null) ? "" + session.getAttribute("error") : "Sign in to start your session"%><%session.removeAttribute("error");%>
                    </p>

                    <form action="" method="post" id="quickForm">
                        <div class="input-group mb-3 ">
                            <input type="text" name="userName" id="userName" class="form-control" placeholder="Username">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-user"></span>
                                </div>
                            </div>
                        </div>
                        <div class="input-group mb-3">
                            <input type="password" name="password" id="password" class="form-control" placeholder="Password">
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-lock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
<!--                            <div class="col-8">
                                <div class="icheck-primary">
                                    <input type="checkbox" id="remember" name="remember">
                                    <label for="remember">
                                        Remember Me
                                    </label>
                              </div>
                            </div>-->
                            <!-- /.col -->
                            <div class="col-12">
                                <button type="submit" name="submit" id="submit" class="btn btn-primary btn-block">Sign In</button>
                            </div>
                            <!-- /.col -->
                        </div>
                    </form>

                    <div class="social-auth-links text-center mb-3">
                        <p>- OR -</p>
                        <a href="#" class="btn btn-block btn-primary">
                            <i class="fab fa-facebook mr-2"></i> Sign in using Facebook
                        </a>
                        <a href="#" class="btn btn-block btn-danger">
                            <i class="fab fa-google-plus mr-2"></i> Sign in using Google+
                        </a>
                    </div>
                    <!-- /.social-auth-links -->

                    <p class="mb-1">
                        <a href="#">I forgot my password</a>
                    </p>
                    <p class="mb-0">
                        <a href="<%=request.getContextPath()%>/cms/register.jsp" class="text-center">Register a new membership</a>
                    </p>
                </div>
                <!-- /.login-card-body -->
            </div>
        </div>
        <!-- /.login-box -->

        <!-- jQuery -->
        <script src="<%=request.getContextPath()%>/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="<%=request.getContextPath()%>/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%=request.getContextPath()%>/dist/js/adminlte.min.js"></script>
        <!-- jquery-validation -->
        <script src="<%=request.getContextPath()%>/plugins/jquery-validation/jquery.validate.min.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/jquery-validation/additional-methods.min.js"></script>
        
        <script type="text/javascript">
        $(document).ready(function () {
          $('#quickForm').validate({
            rules: {
              userName: {
                required: true,
                minlength: 5
              },
              password: {
                required: true,
                minlength: 5
              }
            },
            messages: {
              userName: {
                required: "Please enter a username",
                minlength: "Your username must be at least 5 characters long"
              },
              password: {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long"
              }
            },
            errorElement: 'span',
            errorPlacement: function (error, element) {
              error.addClass('invalid-feedback');
              element.closest('.input-group').append(error);
            },
            highlight: function (element, errorClass, validClass) {
              $(element).addClass('is-invalid');
            },
            unhighlight: function (element, errorClass, validClass) {
              $(element).removeClass('is-invalid');
            }
          });
        });
        </script>
    </body>
</html>
