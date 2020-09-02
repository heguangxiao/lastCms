<%-- 
    Document   : delete
    Created on : Aug 27, 2020, 8:21:54 AM
    Author     : HIEU
--%>

<%@page import="vn.web.lastCms.entity.BlockPhone"%>
<%@page import="vn.web.lastCms.utils.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/cms/includes/checkLogin.jsp" %>
<%
    int id = Tool.string2Integer(request.getParameter("param1"));
    BlockPhone dao = new BlockPhone();
    dao = dao.findById(id);
    if (dao == null) {
        session.setAttribute("error", "Thuê bao này không bị khóa. Vui lòng kiểm tra lại. Tks.");
    } else {
        boolean result = dao.delete(id);
        if (result) {
            session.setAttribute("error", "Thuê bao " + dao.getPhone()+ " không còn bị khóa.");
        } else {
            session.setAttribute("error", "Chức năng bỏ khóa thuê bao hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
        }
    }
    response.sendRedirect(request.getContextPath() + "/cms/extensions/blockphone.jsp");
%>