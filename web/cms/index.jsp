<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="vn.web.lastCms.entity.Chart"%>
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
    <%
        String stRequest = DateProc.createMMDDYYYY_Start01();
        String endRequest = DateProc.createMMDDYYYY();
        Date myDate = new SimpleDateFormat("MM/dd/yyyy").parse(stRequest); 
        int month = myDate.getMonth() + 1;

        HistoryTopup daoHTU = new HistoryTopup();
        HistoryCharg daoHC = new HistoryCharg();
        ServiceQuota daoSQ = new ServiceQuota();
        BlockPhone daoBP = new BlockPhone();
        Chart daoC = new Chart();
    %>
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
                    
                    <div class="col-lg-12">
                        <%
                            ArrayList<Chart> chart = daoC.chartTopupAndCharg(stRequest, endRequest);
                            int totalMoneyCharg = 0;
                            int totalMoneyTopup = 0;
                            for (Chart elem : chart) {
                                totalMoneyCharg += elem.getMoneyCharg();
                                totalMoneyTopup += elem.getMoneyTopup();
                            }
                        %>
                        <div class="card">
                            <div class="card-header border-0">
                              <div class="d-flex justify-content-between">
                                <h3 class="card-title">Tháng <%=month%></h3>
                                <!--<a href="javascript:void(0);">View Report</a>-->
                              </div>
                            </div>
                            <div class="card-body">
                              <div class="d-flex">
                                <p class="d-flex flex-column">
                                  <span class="text-bold text-lg">Giây <%=totalMoneyCharg%> / <%=totalMoneyTopup%></span>
                                  <!--<span>Money Over Time</span>-->
                                </p>
                                <p class="ml-auto d-flex flex-column text-right">
                                  <span class="text-success">
                                    <!--<i class="fas fa-arrow-up"></i> 33.1%-->
                                  </span>
                                  <span class="text-muted">
                                      <!--Since last month-->
                                  </span>
                                </p>
                              </div>
                              <!-- /.d-flex -->

                              <div class="position-relative mb-4">
                                <canvas id="sales-chart" height="200"></canvas>
                              </div>

                              <div class="d-flex flex-row justify-content-end">
                                <span class="mr-2">
                                  <i class="fas fa-square text-primary"></i> Charg
                                </span>

                                <span>
                                  <i class="fas fa-square text-gray"></i> Topup
                                </span>
                              </div>
                            </div>
                        </div>
                    </div>
                  </div><!-- /.container-fluid -->
                </section>
                <!-- /.content -->
              </div>
              <!-- /.content-wrapper -->

            <%@include file="/cms/includes/footer.jsp" %>
            
        </div>
        
        <%@include file="/cms/includes/jquery.jsp" %>
        <!-- OPTIONAL SCRIPTS -->
        <script src="<%=request.getContextPath()%>/plugins/chart.js/Chart.min.js"></script>
        <script>
            $(function () {
                'use strict';

                var ticksStyle = {
                  fontColor: '#495057',
                  fontStyle: 'bold'
                };

                var mode      = 'index';
                var intersect = true;

                var $salesChart = $('#sales-chart');
                var salesChart  = new Chart($salesChart, {
                  type   : 'bar',
                  data   : {
                    labels  : [
                         <%
                             for (Chart elem : chart) {
                                 %>'<%=elem.getDate()%>',<%
                             }
                         %>
                    ],
                    datasets: [
                      {
                        backgroundColor: '#007bff',
                        borderColor    : '#007bff',
                        data           : [
                            <%
                                for (Chart elem : chart) {
                                    %><%=elem.getMoneyCharg()%>,<%
                                }
                            %>
                        ]
                      },
                      {
                        backgroundColor: '#ced4da',
                        borderColor    : '#ced4da',
                        data           : [
                            <%
                                for (Chart elem : chart) {
                                    %><%=elem.getMoneyTopup()%>,<%
                                }
                            %>
                        ]
                      }
                    ]
                  },
                  options: {
                    maintainAspectRatio: false,
                    tooltips           : {
                      mode     : mode,
                      intersect: intersect
                    },
                    hover              : {
                      mode     : mode,
                      intersect: intersect
                    },
                    legend             : {
                      display: false
                    },
                    scales             : {
                      yAxes: [{
                        // display: false,
                        gridLines: {
                          display      : true,
                          lineWidth    : '4px',
                          color        : 'rgba(0, 0, 0, .2)',
                          zeroLineColor: 'transparent'
                        },
                        ticks    : $.extend({
                          beginAtZero: true,

                          // Include a dollar sign in the ticks
                          callback: function (value, index, values) {
                            if (value >= 1000) {
                              value /= 1000;
                              value += 'k';
                            }
                            return value + " s";
                          }
                        }, ticksStyle)
                      }],
                      xAxes: [{
                        display  : true,
                        gridLines: {
                          display: false
                        },
                        ticks    : ticksStyle
                      }]
                    }
                  }
                });
            });
        </script>
        
    </body>
</html>
