/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.web.lastCms.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import vn.web.lastCms.entity.User;
import vn.web.lastCms.utils.DateProc;
import vn.web.lastCms.utils.Md5;
import vn.web.lastCms.utils.Tool;

/**
 *
 * @author HIEU
 */
public class AddAccount extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        try {
            User userLogin = User.getUser(session);
            String userName = Tool.validStringRequest(request.getParameter("userName"));
            String password = Tool.validStringRequest(request.getParameter("password"));
            String rePassword = Tool.validStringRequest(request.getParameter("rePassword"));
            int status = Tool.string2Integer(request.getParameter("status"), 0);
            int type = Tool.string2Integer(request.getParameter("type"), 0);
            String role[] = request.getParameterValues("role");
            if (Tool.stringIsSpace(userName)) {
                session.setAttribute("error", "Tài khoản không được có khoảng trắng");
                response.sendRedirect(request.getContextPath() + "/cms/account/add.jsp");
                return;
            }
            if (Tool.stringIsSpace(password)) {
                session.setAttribute("error", "Mật khẩu không được có khoảng trắng");
                response.sendRedirect(request.getContextPath() + "/cms/account/add.jsp");
                return;
            }
            if (!Tool.Password_Validation(password)) {
                session.setAttribute("error", "Mật khẩu phải có một chữ hoa, một chữ thường, một chữ số và một ký tự đặc biệt !@#$%&*");
                response.sendRedirect(request.getContextPath() + "/cms/account/add.jsp");
                return;
            }
            if (!password.equals(rePassword)) {
                session.setAttribute("error", "Xác nhận mật khẩu không chính xác");
                response.sendRedirect(request.getContextPath() + "/cms/account/add.jsp");
            } else {
                User user = User.getUser(userName);
                if (user != null) {
                    session.setAttribute("error", "Tài khoản đã tồn tại. Vui lòng chọn tài khoản khác để đăng ký.");
                    response.sendRedirect(request.getContextPath() + "/cms/account/add.jsp");
                } else {
                    user = new User();
                    user.setUserName(userName);
                    user.setPassword(Md5.encryptMD5(password));
                    user.setCreatedBy(userLogin.getUserName());
                    user.setCreatedAt(DateProc.createTimestamp());
                    user.setStatus(status );
                    user.setType(type);
                    String strRole = "";
                    if (role != null) {
                        for (String string : role) {
                            strRole += string + "<br/>";
                        }
                    }
                    user.setRole(strRole);                    
                    if (!user.save(user)) {
                        session.setAttribute("error", "Chức năng này hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
                        response.sendRedirect(request.getContextPath() + "/cms/account/add.jsp");
                    } else {
                        session.setAttribute("error", "Tạo tài khoản mới thành công. ");
                        response.sendRedirect(request.getContextPath() + "/cms/account/list.jsp");
                    }
                }
            }
        } catch (IOException e) {
            Tool.debug(e.getMessage());
            session.setAttribute("error", "Chức năng này hiện đang bảo trì. Vui lòng quay lại sau. Tks.");
            response.sendRedirect(request.getContextPath() + "/cms/account/list.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
        
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
