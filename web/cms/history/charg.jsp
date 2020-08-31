<%@page import="vn.web.lastCms.entity.HistoryCharg"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>AdminLTE 3 | Lịch sử nạp hoàn tiền</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
    <%
        HistoryCharg dao = new HistoryCharg();
        ArrayList<HistoryCharg> list = dao.findAll();
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
                            <li class="breadcrumb-item">Lịch sử và thống kê</li>
                            <li class="breadcrumb-item active">Lịch sử nạp hoàn tiền</li>
                          </ol>
                        </div>
                      </div>
                    </div><!-- /.container-fluid -->
                  </section>

                  <!-- Main content -->
                  <section class="content">
                    <div class="card">
                      <div class="card-header">
                        <h3 class="card-title">Lịch sử nạp hoàn tiền</h3>
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
        <script src="<%=request.getContextPath()%>/cms/history/charg.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/jsgrid/jsgrid.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%=request.getContextPath()%>/dist/js/adminlte.min.js"></script>
        <!-- page script -->
        <script>                   
            db.clients = [
                <%
                    for (HistoryCharg elem : list) {
                %>
                {
                    "Phone": "<%=elem.getPhone()%>",
                    "Money": "<%=elem.getMoney()%>",
                    "ChargAt": "<%=elem.getChargAt()%>",
                    "Telco": "<%=elem.getTelco()%>",
                    "TopUpId": "<%=elem.getTopupId()%>"
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
                      { name: "Money", type: "text", width: 100 },
                      { name: "ChargAt", type: "date", width: 100 },
                      { name: "Telco", type: "text", width: 100 },
                      { name: "TopUpId", type: "text", width: 100 }
                  ]
              });
            });
          </script>
    </body>
</html>
