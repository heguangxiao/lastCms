<%@page import="vn.web.lastCms.utils.DateProc"%>
<%@page import="vn.web.lastCms.utils.Md5"%>
<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>AdminLTE 3 | Thêm mới tài khoản</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
<body class="hold-transition sidebar-mini">
        <%@include file="/cms/includes/checkLogin.jsp" %>
<div class="wrapper">
            
            <%@include file="/cms/includes/menu.jsp" %>
                            
            <%@include file="/cms/includes/right.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
              <span class="error">
                  <%=(session.getAttribute("error") != null) ? "" + session.getAttribute("error") : ""%><%session.removeAttribute("error");%>
              </span>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/cms/index.jsp">Home</a></li>
                <li class="breadcrumb-item">Quản lý tài khoản</li>
                <li class="breadcrumb-item active">Thêm mới tài khoản</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- left column -->
          <div class="col-md-12">
            <!-- jquery validation -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Thêm mới tài khoản</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form role="form" id="quickForm" action="<%=request.getContextPath()%>/addAccount" method="POST">
                <div class="card-body">
                  <div class="form-group">
                    <label for="userName">Username</label>
                    <input type="userName" name="userName" class="form-control" id="userName" placeholder="Username">
                  </div>
                  <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" class="form-control" id="password" placeholder="Password">
                  </div>
                  <div class="form-group">
                    <label for="rePassword">Retype Password</label>
                    <input type="password" name="rePassword" class="form-control" id="rePassword" placeholder="Retype Password">
                  </div>
                    <div class="form-group">
                      <label>Status</label>
                      <select id="status" name="status" class="select2 form-control " style="width: 100%;">
                          <option value="0">Chờ kích hoạt</option>
                          <option value="1">Kích hoạt</option>
                          <option value="2">Khóa</option>
                      </select>
                    </div>
                    <div class="form-group">
                      <label>Type</label>
                      <select id="type" name="type" class="form-control select2" style="width: 100%;">
                          <option value="">Choose type</option>
                          <option value="0">Đại lý</option>
                          <option value="1">Người dùng</option>
                      </select>
                    </div>
                    <div class="form-group">
                      <label>Role</label>
                      <select id="role" name="role" class="select2multip" multiple="multiple" style="width: 100%;">
                            <option value="ADMIN">ADMIN</option>
                            <option value="GUEST">GUEST</option>
                      </select>
                    </div>
                </div>
                <!-- /.card-body -->
                <div class="card-footer">
                  <button type="submit" name="submit" id="submit" class="btn btn-primary">Submit</button>
                </div>
              </form>
            </div>
            <!-- /.card -->
            </div>
          <!--/.col (left) -->
          <!-- right column -->
          <div class="col-md-6">

          </div>
          <!--/.col (right) -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

            <%@include file="/cms/includes/footer.jsp" %>
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="<%=request.getContextPath()%>/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%=request.getContextPath()%>/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- jquery-validation -->
<script src="<%=request.getContextPath()%>/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/jquery-validation/additional-methods.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath()%>/dist/js/adminlte.min.js"></script>
<!-- Select2 -->
<script src="<%=request.getContextPath()%>/plugins/select2/js/select2.full.min.js"></script>
<!-- bootstrap color picker -->
<script src="<%=request.getContextPath()%>/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
<!-- Bootstrap Switch -->
<script src="<%=request.getContextPath()%>/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
<!-- InputMask -->
<script src="<%=request.getContextPath()%>/plugins/moment/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/plugins/inputmask/min/jquery.inputmask.bundle.min.js"></script>
<!-- date-range-picker -->
<script src="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="<%=request.getContextPath()%>/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="<%=request.getContextPath()%>/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<script type="text/javascript">
    
$(function () {
  //Initialize Select2 Elements
  $('.select2multip').select2();
});

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
        },
        type: {
          required: true
        }
    },
    messages: {
        userName: {
          required: "Please enter a username",
          minlength: "Your username must be at least 5 characters long",
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
      element.closest('.form-group').append(error);
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
