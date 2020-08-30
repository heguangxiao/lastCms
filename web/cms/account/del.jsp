<%-- 
    Document   : delete
    Created on : Aug 27, 2020, 8:21:54 AM
    Author     : HIEU
--%>

<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/cms/includes/checkLogin.jsp" %>
<%
    int id = Tool.string2Integer(request.getParameter("param1"));
    User dao = User.getUser(id);
    if (dao == null) {
        session.setAttribute("error", "Tài khoản không tồn tại.");
    } else {
        boolean result = dao.delete(id);
        if (result) {
            session.setAttribute("error", "Xóa tài khoản " + dao.getUserName() + " thành công.");
        } else {
            session.setAttribute("error", "Chức năng xóa tài khoản hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
        }
    }
    response.sendRedirect(request.getContextPath() + "/cms/account/list.jsp");
%>