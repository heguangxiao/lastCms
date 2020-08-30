<%@page import="vn.web.lastCms.utils.DateProc"%>
<%@page import="vn.web.lastCms.utils.Md5"%>
<%@page import="vn.web.lastCms.entity.User"%>
<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdminLTE 3 | Registration Page</title>
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
        if (request.getParameter("submit") != null) {
            String userName = Tool.validStringRequest(request.getParameter("userName"));
            String password = Tool.validStringRequest(request.getParameter("password"));
            String rePassword = Tool.validStringRequest(request.getParameter("rePassword"));
            if (Tool.stringIsSpace(userName)) {
                session.setAttribute("error", "Tài khoản không được có khoảng trắng");
            }
            if (Tool.stringIsSpace(password)) {
                session.setAttribute("error", "Mật khẩu không được có khoảng trắng");
            }
            if (!Tool.Password_Validation(password)) {
                session.setAttribute("error", "Mật khẩu phải có một chữ hoa, một chữ thường, một chữ số và một ký tự đặc biệt !@#$%&*()");
            }
            if (!password.equals(rePassword)) {
                session.setAttribute("error", "Xác nhận mật khẩu không chính xác");
            } else {
                User user = User.getUser(userName);
                if (user != null) {
                    session.setAttribute("error", "Tài khoản đã tồn tại. Vui lòng chọn tài khoản khác để đăng ký.");
                } else {
                    user = new User();
                    user.setUserName(userName);
                    user.setPassword(Md5.encryptMD5(password));
                    user.setCreatedBy(userName);
                    user.setCreatedAt(DateProc.createTimestamp());
                    user.setStatus(0);
                    user.setType(1);
                    user.setRole("");                    
                    if (!user.save(user)) {
                        session.setAttribute("error", "Trang web hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
                    } else {
                        session.setAttribute("error", "Tạo tài khoản thành công. Vui lòng chờ bàn quản trị kích hoạt. Tks.");
                        response.sendRedirect(request.getContextPath() + "/cms/login.jsp");
                    }
                }
            }
        }
    %>
    <body class="hold-transition register-page">
        <div class="register-box">
            <div class="register-logo">
                <a href="<%=request.getContextPath()%>/cms/index.jsp"><b>Admin</b>LTE</a>
            </div>

            <div class="card">
            <div class="card-body register-card-body">
                <p class="login-box-msg">              
                    <%=(session.getAttribute("error") != null) ? "" + session.getAttribute("error") : "Register a new membership"%><%session.removeAttribute("error");%>
                </p>

                <form action="" method="post" id="quickForm">
                    <div class="input-group mb-3">
                        <input type="userName" class="form-control" name="userName" id="userName" placeholder="Username">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" name="password" id="password" placeholder="Password">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" class="form-control" name="rePassword" id="rePassword" placeholder="Retype password">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button type="submit" name="submit" id="submit" class="btn btn-primary btn-block">Register</button>
                        </div>
                        <!-- /.col -->
                    </div>
                </form>

                <div class="social-auth-links text-center">
                    <p>- OR -</p>
                    <a href="#" class="btn btn-block btn-primary">
                        <i class="fab fa-facebook mr-2"></i>
                        Sign up using Facebook
                    </a>
                    <a href="#" class="btn btn-block btn-danger">
                        <i class="fab fa-google-plus mr-2"></i>
                        Sign up using Google+
                    </a>
                </div>

                <a href="<%=request.getContextPath()%>/cms/login.jsp" class="text-center">I already have a membership</a>
            </div>
            <!-- /.form-box -->
          </div><!-- /.card -->
        </div>
        <!-- /.register-box -->

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
        var pasReg = /^(?=.*[0-9])(?=.*[!@#$%^&*()])(?=.*[A-Z])[a-zA-Z0-9!@#$%^&*]{5,30}$/;
        var userReg = /^[a-zA-Z0-9_.]+$/;
          $('#quickForm').validate({
            rules: {
              userName: {
                required: true,
                minlength: 5,
                maxlength: 30,
                regex: userReg
              },
              password: {
                required: true,
                minlength: 5,
                maxlength: 30,
                regex: pasReg
              },
              rePassword: {
                required: true,
                minlength: 5,
                maxlength: 30,
                equalTo : "#password"
              }
            },
            messages: {
              userName: {
                required: "Please enter a username",
                minlength: "Please enter a vaild username",
                regex: "Your username must have not space. Ex: Ab1_."
              },
              password: {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long",
                regex: "Mật khẩu phải bao gồm chữ hoa, chữ thường, ký tự đặc biệt, số và không được có khoản trắng. Ex: Abcd1&"
              },
              rePassword: {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long",
                equalTo : "Repyte pasword must equals password"
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
            jQuery.validator.addMethod("regex", function (value, element, regexpr) {
                return regexpr.test(value);
            });
        });
        </script>
    </body>
</html>
