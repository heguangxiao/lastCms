<%@page import="vn.web.lastCms.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User userLogin = User.getUser(session);
    if (userLogin == null) {
        session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
        out.print("<script>top.location='" + request.getContextPath() + "/cms/login.jsp';</script>");
        return;
    }
%>