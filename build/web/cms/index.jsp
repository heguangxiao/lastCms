<%@page import="vn.web.lastCms.entity.BlockPhone"%>
<%@page import="vn.web.lastCms.entity.ServiceQuota"%>
<%@page import="vn.web.lastCms.entity.HistoryCharg"%>
<%@page import="vn.web.lastCms.entity.HistoryTopup"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vn.web.lastCms.utils.DateProc"%>
<%@page import="java.sql.Timestamp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AdminLTE 3 | Dashboard</title>
        <%@include file="/cms/includes/header.jsp" %>
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <%@include file="/cms/includes/checkLogin.jsp" %>
        
        <div class="wrapper">
            
            <%@include file="/cms/includes/menu.jsp" %>
                            
            <%@include file="/cms/includes/right.jsp" %>

              <!-- Content Wrapper. Contains page content -->
              <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                  <div class="container-fluid">
                    <div class="row mb-2">
                      <div class="col-sm-6">
                        <h1 class="m-0 text-dark">Dashboard</h1>
                      </div><!-- /.col -->
                      <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                          <li class="breadcrumb-item"><a href="#">Home</a></li>
                          <li class="breadcrumb-item active">Dashboard</li>
                        </ol>
                      </div><!-- /.col -->
                    </div><!-- /.row -->
                  </div><!-- /.container-fluid -->
                </div>
                <!-- /.content-header -->

                <!-- Main content -->
                <section class="content">
                  <div class="container-fluid">
                    <!-- Small boxes (Stat box) -->
                    <div class="row">
                        <%
                            String stRequest = DateProc.createMMDDYYYY_Start01();
                            String endRequest = DateProc.createMMDDYYYY();
                            
                            System.out.println(stRequest);
                            System.out.println(endRequest);
                            
                            HistoryTopup daoHTU = new HistoryTopup();
                            ArrayList<HistoryTopup> listHTU = daoHTU.findAll("", stRequest, endRequest, "");
                        %>
                      <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-info">
                          <div class="inner">
                            <h3><%=listHTU.size()%></h3>

                            <p>New Topup</p>
                          </div>
                          <div class="icon">
                            <i class="ion ion-bag"></i>
                          </div>
                          <a href="<%=request.getContextPath()%>/cms/history/topup.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                      </div>
                      <!-- ./col -->
                      <%
                            HistoryCharg daoHC = new HistoryCharg();
                            ArrayList<HistoryCharg> listHC = daoHC.findAll("", stRequest, endRequest, "", 0);
                      %>
                      <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-success">
                          <div class="inner">
                            <h3><%=listHC.size()%></h3>

                            <p>Refund</p>
                          </div>
                          <div class="icon">
                            <i class="ion ion-stats-bars"></i>
                          </div>
                          <a href="<%=request.getContextPath()%>/cms/history/charg.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                      </div>
                      <!-- ./col -->
                      <%
                            ServiceQuota daoSQ = new ServiceQuota();
                            ArrayList<ServiceQuota> listSQ = daoSQ.findAll();
                      %>
                      <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-warning">
                          <div class="inner">
                            <h3><%=listSQ.size()%></h3>

                            <p>Phone had quota</p>
                          </div>
                          <div class="icon">
                            <i class="ion ion-person-add"></i>
                          </div>
                          <a href="<%=request.getContextPath()%>/cms/extensions/phonequota.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                      </div>
                      <!-- ./col -->
                      <%
                            BlockPhone daoBP = new BlockPhone();
                            ArrayList<BlockPhone> listBP = daoBP.findAll();
                      %>
                      <div class="col-lg-3 col-6">
                        <!-- small box -->
                        <div class="small-box bg-danger">
                          <div class="inner">
                            <h3><%=listBP.size()%></h3>

                            <p>Phone is block</p>
                          </div>
                          <div class="icon">
                            <i class="ion ion-pie-graph"></i>
                          </div>
                          <a href="<%=request.getContextPath()%>/cms/extensions/blockphone.jsp" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
                        </div>
                      </div>
                      <!-- ./col -->
                    </div>
                    <!-- /.row -->                    
                  </div><!-- /.container-fluid -->
                </section>
                <!-- /.content -->
              </div>
              <!-- /.content-wrapper -->

            <%@include file="/cms/includes/footer.jsp" %>
            
        </div>
        
        <%@include file="/cms/includes/jquery.jsp" %>
        
    </body>
</html>
