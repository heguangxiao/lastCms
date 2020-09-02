<%@page import="vn.web.lastCms.entity.ServiceQuota"%>
<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>AdminLTE 3 | Đặt hạn mức</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
    <%        
        String phoneedit = "";
        int quotaedit = 0;
        int id = 0;
        String param1 = request.getParameter("param1");
        if (!Tool.checkNull(param1)) {
            id = Tool.string2Integer(param1);
        }
        ServiceQuota dao = new ServiceQuota();
        ServiceQuota edit = dao.findById(id);
        if (edit != null) {
            phoneedit = edit.getPhone();
            quotaedit = edit.getQuota();
        }
        ArrayList<ServiceQuota> list = dao.findAll();
        
        String phonesearch = Tool.validStringRequest(request.getParameter("phonesearch"));
        if (request.getParameter("search") != null) {
            list = dao.findAll(phonesearch);
        }
        
        String phonequota = Tool.validStringRequest(request.getParameter("phonequota"));
        if (request.getParameter("quota") != null) {
            if (!Tool.checkNull(phonequota)) {
                int quota = Tool.string2Integer(request.getParameter("quota"), 0);
                if (!dao.existsByPhone(phonequota)) {
                    ServiceQuota serviceQuota = new ServiceQuota();
                    serviceQuota.setPhone(phonequota);
                    serviceQuota.setQuota(quota);
                    if (!dao.save(serviceQuota)) {
                        session.setAttribute("error", "Chức năng đặt hạn mức thuê bao hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
                    } else {
                        session.setAttribute("error", "Đặt hạn mức thuê bao thành công. ");
                        list = dao.findAll(phonequota);
                    }
                } else {
                    ServiceQuota serviceQuota = dao.findByPhone(phonequota);
                    serviceQuota.setPhone(phonequota);
                    serviceQuota.setQuota(quota);
                    if (!dao.update(serviceQuota)) {
                        session.setAttribute("error", "Chức năng chỉnh sửa hạn mức thuê bao hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
                    } else {
                        session.setAttribute("error", "Chỉnh sửa hạn mức thuê bao thành công. ");
                        list = dao.findAll(phonequota);
                    }
                }
            }
        }
        
        String urlExport = request.getContextPath() + "/cms/extensions/exportPhoneQuota.jsp?";
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
                            <li class="breadcrumb-item active">Đặt hạn mức</li>
                          </ol>
                        </div>
                      </div>
                    </div><!-- /.container-fluid -->
                  </section>
                    
                  <!-- Main content -->
                  <section class="content">
                    <div class="card">
                      <div class="card-header">
                        <h3 class="card-title">Đặt hạn mức</h3>
                      </div>
                      <!-- /.card-header -->     
                        <form role="form" id="quickForm">
                            <div class="card-body">
                              <div class="form-group" style="float: left;width: 60%">
                                  <div style="float: left;width: 50%">
                                      <input type="text" name="phonequota" value="<%=phoneedit%>" class="form-control" id="phonequota" placeholder="Phone Number. Ex: 84987654321">
                                  </div>
                                  <div style="float: left;width: 50%">                                      
                                    <input type="number" name="quota" value="<%=quotaedit%>" class="form-control" id="quota" placeholder="Number. Ex: 0123456789">
                                  </div>
                              </div>
                              <div class="form-group" style="float: left;width: 30%">
                                <button style="float: left" type="submit" name="quota" id="quota" class="btn btn-dark">Đặt hạn mức</button>
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
        <script src="<%=request.getContextPath()%>/cms/extensions/phonequota.js"></script>
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
            var number_regex = /^[0-9]{1,10}$/;
            $('#quickForm').validate({
              rules: {
                  phonequota: {
                    regex: phone_regex
                  },
                  quota: {
                    regex: number_regex
                  }
              },
              messages: {
                  phonequota: {
                    regex: "Phone number not valid. Ex: 84987654321"
                  },
                  quota: {
                    regex: "Input number. Ex: 0123456789"
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
                    for (ServiceQuota elem : list) {
                %>
                {
                    "Phone": "<%=elem.getPhone()%>",
                    "Quota": "<%=elem.getQuota()%>",
                    "Edit": "<a href='<%=request.getContextPath()%>/cms/extensions/phonequota.jsp?param1=<%=elem.getId()%>'><img src='<%=request.getContextPath()%>/dist/img/edit.png' class='img-sm' alt='Edit'></a>",
                    "Delete": "<a onclick='return askBeforeDelete()' href='<%=request.getContextPath()%>/cms/extensions/delphonequota.jsp?param1=<%=elem.getId()%>'><img src='<%=request.getContextPath()%>/dist/img/delete.png' class='img-sm' alt='Delete'></a>"
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
                      { name: "Quota", type: "text", width: 100 },
                      { name: "Edit", type: "text", width: 100 },
                      { name: "Delete", type: "text", width: 100 }
                  ]
              });
            });
          </script>
    </body>
</html>
