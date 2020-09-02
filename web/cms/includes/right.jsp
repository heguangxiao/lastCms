<%@page contentType="text/html" pageEncoding="UTF-8"%><!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
  <!-- Brand Logo -->
  <a href="<%=request.getContextPath()%>/cms/index.jsp" class="brand-link">
    <img src="<%=request.getContextPath()%>/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
         style="opacity: .8">
    <span class="brand-text font-weight-light">AdminLTE 3</span>
  </a>

  <!-- Sidebar -->
  <div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
            <img src="<%=request.getContextPath()%>/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
            <a href="#" class="d-block"><%=userLogin.getUserName()%></a>
        </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
            <li class="nav-item has-treeview menu-open">
                <a href="<%=request.getContextPath()%>/cms/index.jsp" class="nav-link" >
                    <i class="nav-icon fas fa-tachometer-alt"></i>
                    <p>
                        Dashboard
                    </p>
                </a>
            </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Quản lý tài khoản
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/account/list.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Danh sách tài khoản</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/account/add.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Thêm mới tài khoản</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-th"></i>
              <p>
                Lịch sử và thống kê
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/history/topup.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Lịch sử ứng tiền</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/statistic/topup.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Thống kê ứng tiền</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/history/charg.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Lịch sử nạp hoàn tiền</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/statistic/charg.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Thống kê nạp hoàn tiền</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon far fa-plus-square"></i>
              <p>
                Tiện ích hệ thống
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/extensions/searchhistory.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Tra cứu lịch sử thuê bao</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/extensions/blockphone.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                    <p>Khóa thuê bao</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<%=request.getContextPath()%>/cms/extensions/phonequota.jsp" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                    <p>Đặt hạn mức</p>
                </a>
              </li>
            </ul>
          </li>
        </ul>
    </nav>
    <!-- /.sidebar-menu -->
  </div>
  <!-- /.sidebar -->
</aside>