<%@page import="vn.web.lastCms.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = User.getUser(session);
    if (user == null) {
        out.print("<script>top.location='" + request.getContextPath() + "/cms/index.jsp';</script>");
        return;
    }
    session.removeAttribute("userLogin");
    session.invalidate();
    out.print("<script>top.location='" + request.getContextPath() + "/cms/index.jsp';</script>");
%>