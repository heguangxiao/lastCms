<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>AdminLTE 3 | Danh sách tài khoản</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
    <%
        User dao = new User();
        ArrayList<User> list = dao.findAll();
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
                            <li class="breadcrumb-item">Quản lý tài khoản</li>
                            <li class="breadcrumb-item active">Danh sách tài khoản</li>
                          </ol>
                        </div>
                      </div>
                    </div><!-- /.container-fluid -->
                  </section>

                  <!-- Main content -->
                  <section class="content">
                    <div class="card">
                      <div class="card-header">
                        <h3 class="card-title">Danh sách tài khoản</h3>
                      </div>
                      <!-- /.card-header -->
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
        <script src="<%=request.getContextPath()%>/cms/account/account.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/jsgrid/jsgrid.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%=request.getContextPath()%>/dist/js/adminlte.min.js"></script>
        <!-- page script -->
        <script>            
            db.status = [
                { Name: "Chờ kích hoạt", Id: 0 },
                { Name: "Kích hoạt", Id: 1 },
                { Name: "Khóa", Id: 2 }
            ];
            
            db.type = [
                { Name: "Đại lý", Id: 0 },
                { Name: "Người dùng", Id: 1 }
            ];
            
            db.clients = [
                <%
                    for (User elem : list) {
                %>
                {
                    "Username": "<%=elem.getUserName()%>",
                    "CreateAt": "<%=elem.getCreatedAt()%>",
                    "CreateBy": "<%=elem.getCreatedBy()%>",
                    "Status": <%=elem.getStatus()%>,
                    "Type": <%=elem.getType()%>,
                    "Role": "<%=elem.getRole()%>",
                    "Edit": "<a href='<%=request.getContextPath()%>/cms/account/edit.jsp?param1=<%=elem.getId()%>'><img src='<%=request.getContextPath()%>/dist/img/edit.png' class='img-sm' alt='Edit'></a>",
                    "Delete": "<a onclick='return askBeforeDelete()' href='<%=request.getContextPath()%>/cms/account/del.jsp?param1=<%=elem.getId()%>'><img src='<%=request.getContextPath()%>/dist/img/delete.png' class='img-sm' alt='Delete'></a>"
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
                      { name: "Username", type: "text", width: 100 },
                      { name: "CreateAt", type: "date", width: 100 },
                      { name: "CreateBy", type: "text", width: 100 },
                      { name: "Status", type: "select", items: db.status, valueField: "Id", textField: "Name" },
                      { name: "Type", type: "select", items: db.type, valueField: "Id", textField: "Name" },
                      { name: "Role", type: "text", width: 100 },
                      { name: "Edit", type: "text", width: 50 },
                      { name: "Delete", type: "text", width: 60 }
                  ]
              });
            });
          </script>
    </body>
</html>
