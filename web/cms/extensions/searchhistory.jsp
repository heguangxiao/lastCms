<%@page import="vn.web.lastCms.utils.Advance"%>
<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page import="vn.web.lastCms.entity.ServiceCdr"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>AdminLTE 3 | Tra cứu lịch sử thuê bao</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
    <%
        ServiceCdr dao = new ServiceCdr();
        ArrayList<ServiceCdr> list = dao.findAll();
        String phonesearch = Tool.validStringRequest(request.getParameter("phonesearch"));
        if (request.getParameter("search") != null) {
            list = dao.findAll(phonesearch);
        }
        
        String urlExport = request.getContextPath() + "/cms/extensions/exportHistory.jsp?";
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
                            <li class="breadcrumb-item active">Tra cứu lịch sử thuê bao</li>
                          </ol>
                        </div>
                      </div>
                    </div><!-- /.container-fluid -->
                  </section>

                  <!-- Main content -->
                  <section class="content">
                    <div class="card">
                      <div class="card-header">
                        <h3 class="card-title">Tra cứu lịch sử thuê bao</h3>
                      </div>
                      <!-- /.card-header -->
                                            
                        <form>
                            <div class="card-body">
                              <div class="form-group" style="float: left;width: 30%">
                                <input type="text" name="phonesearch" class="form-control" id="phonesearch">
                              </div>
                              <div class="form-group" style="float: left;width: 30%">
                                <button style="float: left" type="submit" name="search" id="search" class="btn btn-success">Tìm kiếm</button>
                                <input style="float: left" type="submit" class="btn btn-warning" value="Làm mới" src="<%=request.getContextPath()%>/cms/extensions/searchhistory.jsp" />
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
        <script src="<%=request.getContextPath()%>/cms/extensions/searchhistory.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/jsgrid/jsgrid.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%=request.getContextPath()%>/dist/js/adminlte.min.js"></script>
        <!-- page script -->
        <script>                   
            db.clients = [
                <%
                    for (ServiceCdr elem : list) {
                %>
                {
                    "Phone": "<%=elem.getPhone()%>",
                    "Time": "<%=Advance.stringToTime(elem.getMoney())%>",
                    "ChargAt": "<%=elem.getChargAt()%>",
                    "TopupAt": "<%=elem.getTopupAt()%>",
                    "Telco": "<%=elem.getTelco()%>"
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
                      { name: "Time", type: "text", width: 100 },
                      { name: "ChargAt", type: "date", width: 100 },
                      { name: "TopupAt", type: "date", width: 100 },
                      { name: "Telco", type: "text", width: 100 }
                  ]
              });
            });
          </script>
    </body>
</html>
