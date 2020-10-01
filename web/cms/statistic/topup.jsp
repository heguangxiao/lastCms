<%@page import="vn.web.lastCms.utils.Advance"%>
<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page import="vn.web.lastCms.entity.HistoryTopup"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>AdminLTE 3 | Thống kê ứng thời gian gọi</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
    <%
        HistoryTopup dao = new HistoryTopup();
        ArrayList<HistoryTopup> list = dao.statistic("", "", "");
        
        String stRequest = Tool.validStringRequest(request.getParameter("stRequest"));
        String endRequest = Tool.validStringRequest(request.getParameter("endRequest"));
        String telco = Tool.validStringRequest(request.getParameter("telco"));
        if (request.getParameter("search") != null) {
            list = dao.statistic(stRequest, endRequest, telco);
        }
        
        String urlExport = request.getContextPath() + "/cms/statistic/exportTopup.jsp?";
        String dataGet = "";
        dataGet += "stRequest=" + stRequest;
        dataGet += "&endRequest=" + endRequest;
        dataGet += "&telco=" + telco;
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
                            <li class="breadcrumb-item">Lịch sử và thống kê</li>
                            <li class="breadcrumb-item active">Thống kê ứng thời gian gọi</li>
                          </ol>
                        </div>
                      </div>
                    </div><!-- /.container-fluid -->
                  </section>

                  <!-- Main content -->
                  <section class="content">
                    <div class="card">
                      <div class="card-header">
                        <h3 class="card-title">Thống kê ứng thời gian gọi</h3>
                      </div>
                      <!-- /.card-header -->
                                            
                      <form id="myForm">
                            <div class="card-body">
                              <div class="form-group">
                                <label>Telco</label>
                                <select id="telco" name="telco" class="form-control select2" style="width: 100%;">
                                    <option value="">Tất cả</option>
                                    <option <%=telco.equals("VTE") ? "selected='selected'" : ""%> value="VTE">VIETTEL</option>
                                    <option <%=telco.equals("GPC") ? "selected='selected'" : ""%> value="GPC">VINAPHONE</option>
                                    <option <%=telco.equals("VMS") ? "selected='selected'" : ""%> value="VMS">MOBIFONE</option>
                                    <option <%=telco.equals("VNM") ? "selected='selected'" : ""%> value="VNM">VIETNAMMOBILE</option>
                                    <option <%=telco.equals("BL") ? "selected='selected'" : ""%> value="BL">GMOBILE</option>
                                    <option <%=telco.equals("DDG") ? "selected='selected'" : ""%> value="DDG">ITELECOM</option>
                                </select>
                              </div>
                                
                                <div class="form-group">
                                  <label>Start Date:</label>
                                    <div class="input-group date" id="stRequest" data-target-input="nearest">
                                        <input type="text" name="stRequest" class="form-control datetimepicker-input" data-target="#stRequest"/>
                                        <div class="input-group-append" data-target="#stRequest" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                  <label>End Date:</label>
                                    <div class="input-group date" id="endRequest" data-target-input="nearest">
                                        <input type="text" name="endRequest" class="form-control datetimepicker-input" data-target="#endRequest"/>
                                        <div class="input-group-append" data-target="#endRequest" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                
                              <div class="form-group">
                                <button style="float: left" type="submit" name="search" id="search" class="btn btn-success">Tìm kiếm</button>
                                <input style="float: left" type="submit" class="btn btn-warning" value="Làm mới" src="<%=request.getContextPath()%>/cms/history/topup.jsp" />
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
        <script src="<%=request.getContextPath()%>/cms/statistic/topup.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/jsgrid/jsgrid.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%=request.getContextPath()%>/dist/js/adminlte.min.js"></script>
        <!-- Select2 -->
        <script src="<%=request.getContextPath()%>/plugins/select2/js/select2.full.min.js"></script>
        <!-- Bootstrap4 Duallistbox -->
        <script src="<%=request.getContextPath()%>/plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
        <!-- InputMask -->
        <script src="<%=request.getContextPath()%>/plugins/moment/moment.min.js"></script>
        <script src="<%=request.getContextPath()%>/plugins/inputmask/min/jquery.inputmask.bundle.min.js"></script>
        <!-- date-range-picker -->
        <script src="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.js"></script>
        <!-- bootstrap color picker -->
        <script src="<%=request.getContextPath()%>/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
        <!-- Tempusdominus Bootstrap 4 -->
        <script src="<%=request.getContextPath()%>/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
        <!-- Bootstrap Switch -->
        <script src="<%=request.getContextPath()%>/plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
        <!-- page script -->
        <script>    
            //Date range picker
            $('#stRequest').datetimepicker({
                format: 'L'
            });      
            $('#endRequest').datetimepicker({
                format: 'L'
            });      
                           
            db.clients = [
                <%
                    for (HistoryTopup elem : list) {
                %>
                {
                    "Time": "<%=Advance.intToTime(elem.getMoney())%>",
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
                      { name: "Time", type: "text", width: 100 },
                      { name: "Telco", type: "text", width: 100 }
                  ]
              });
            });
          </script>
    </body>
</html>
