<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Font Awesome -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
<!-- JQVMap -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/jqvmap/jqvmap.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/adminlte.min.css">
<!-- overlayScrollbars -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
<!-- Daterange picker -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/daterangepicker/daterangepicker.css">
<!-- summernote -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/summernote/summernote-bs4.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

<!-- jsGrid -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/jsgrid/jsgrid.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/jsgrid/jsgrid-theme.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/dist/css/adminlte.min.css">

<!-- Bootstrap Color Picker -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/bootstrap-colorpicker/css/bootstrap-colorpicker.min.css">
<!-- Tempusdominus Bbootstrap 4 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
<!-- Select2 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/select2/css/select2.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
<!-- Bootstrap4 Duallistbox -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
<script type="text/javascript" language="javascript">
    function askBeforeDelete() {
        var flag = confirm("Bạn có chắc chắn muốn xóa không?");
        if (flag) {
            return true;
        } else {
            return false;
        }
    }
</script>