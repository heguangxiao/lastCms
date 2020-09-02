<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page import="vn.web.lastCms.entity.BlockPhone"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>AdminLTE 3 | Khóa thuê bao</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
    <%        
        BlockPhone dao = new BlockPhone();
        ArrayList<BlockPhone> list = dao.findAll();
        
        String phonesearch = Tool.validStringRequest(request.getParameter("phonesearch"));
        if (request.getParameter("search") != null) {
            list = dao.findAll(phonesearch);
        }
        
        String phoneblock = Tool.validStringRequest(request.getParameter("phoneblock"));
        if (request.getParameter("block") != null) {
            if (!Tool.checkNull(phoneblock)) {
                if (!dao.existsByPhone(phoneblock)) {
                    BlockPhone blockPhone = new BlockPhone();
                    blockPhone.setPhone(phoneblock);

                    if (!dao.save(blockPhone)) {
                        session.setAttribute("error", "Chức năng khóa thuê bao hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
                    } else {
                        session.setAttribute("error", "Khóa thuê bao thành công. ");
                        list = dao.findAll(phoneblock);
                    }
                } else {
                    session.setAttribute("error", "Thuê bao " + phoneblock + " đã bị khóa. ");
                }
            }
        }
        
        String urlExport = request.getContextPath() + "/cms/extensions/exportPhoneBlock.jsp?";
        String dataGet = "";
        dataGet += "phonesearch=" + phonesearch;
        urlExport += dataGet;
    %>
    <body class="hold-transition sidebar-mini layout-fixed">
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
                            <p class="login-box-msg error-content">
                                <%=(session.getAttribute("error") != null) ? "" + session.getAttribute("error") : ""%><%session.removeAttribute("error");%>
                            </p>
                        </div>
                        <div class="col-sm-6">
                          <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/cms/index.jsp">Home</a></li>
                            <li class="breadcrumb-item">Tiện ích hệ thống</li>
                            <li class="breadcrumb-item active">Khóa thuê bao</li>
                          </ol>
                        </div>
                      </div>
                    </div><!-- /.container-fluid -->
                  </section>
                    
                  <!-- Main content -->
                  <section class="content">
                    <div class="card">
                      <div class="card-header">
                        <h3 class="card-title">Khóa thuê bao</h3>
                      </div>
                      <!-- /.card-header -->     
                        <form role="form" id="quickForm">
                            <div class="card-body">
                              <div class="form-group" style="float: left;width: 30%">
                                <input type="text" name="phoneblock" class="form-control" id="phoneblock" placeholder="Phone Block Number. Ex: 84987654321">
                              </div>
                              <div class="form-group" style="float: left;width: 30%">
                                <button style="float: left" type="submit" name="block" id="block" class="btn btn-dark">Khóa thuê bao</button>
                              </div>
                            </div>
                        </form>
                                            
                        <form>
                            <div class="card-body">
                              <div class="form-group" style="float: left;width: 30%">
                                <input type="text" name="phonesearch" class="form-control" id="phonesearch">
                              </div>
                              <div class="form-group" style="float: left;width: 30%">
                                <button style="float: left" type="submit" name="search" id="search" class="btn btn-success">Tìm kiếm</button>
                                <input style="float: left" type="submit" class="btn btn-warning" value="Làm mới" src="<%=request.getContextPath()%>/cms/extensions/blockphone.jsp" />
                              </div>
                            </div>
                        </form>
                              
                      <div class="card-body">
                          <div>
                              <input onclick="window.open('<%=urlExport%>')" class="btn btn-primary" type="button" name="btnExport" value="Xuất Excel"/>
                          </div>
                      </div>
                      
                      <div class="card-body">
                        <div id="jsGrid1"></div>
                      </div>
                      
                      <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                  </section>
                  <!-- /.content -->
                </div>
              <!-- /.content-wrapper -->

            <%@include file="/cms/includes/footer.jsp" %>
            
        </div>
        
        <!-- jQuery -->
        <script src="<%=request.getContextPath()%>/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="<%=request.getContextPath()%>/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- jsGrid -->
        <script src="<%=request.getContextPath()%>/cms/extensions/blockphone.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/jsgrid/jsgrid.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%=request.getContextPath()%>/dist/js/adminlte.min.js"></script>
        <!-- jquery-validation -->
        <script src="<%=request.getContextPath()%>/plugins/jquery-validation/jquery.validate.min.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/jquery-validation/additional-methods.min.js"></script>
        <!-- page script -->
        <script>      
            $(document).ready(function () {
            var phone_regex = /^(84)+(9|8|7|5|3)+([0-9]{8})$/;
            $('#quickForm').validate({
              rules: {
                  phoneblock: {
                    regex: phone_regex
                  }
              },
              messages: {
                  phoneblock: {
                    regex: "Phone number not valid. Ex: 84987654321"
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
            db.clients = [
                <%
                    for (BlockPhone elem : list) {
                %>
                {
                    "Phone": "<%=elem.getPhone()%>",
                    "Delete": "<a onclick='return askBeforeDelete()' href='<%=request.getContextPath()%>/cms/extensions/delblockphone.jsp?param1=<%=elem.getId()%>'><img src='<%=request.getContextPath()%>/dist/img/delete.png' class='img-sm' alt='Delete'></a>"
                },
                <%
                    }
                %>
            ];

            $(function () {
              $("#jsGrid1").jsGrid({
                  height: "auto",
                  width: "100%",

                  sorting: true,
                  paging: true,

                  data: db.clients,

                  fields: [
                      { name: "Phone", type: "text", width: 100 },
                      { name: "Delete", type: "text", width: 100 }
                  ]
              });
            });
          </script>
    </body>
</html>
