package com.daverokita.blog;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.*;
import java.util.Calendar;
import java.util.Map;

@WebServlet("/Login")
public class Login extends HttpServlet {
    protected void doPost (HttpServletRequest request,
                       HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection con = dbConnection.createConnection();

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String subject = email;
        String id = email;
        ResultSet rs = null;

        int cookieAge = 1440;
        long expiry = 60;

        if(Validate.checkUser(email, password)) {
            String jwt = JWT.createJWT(id, subject, expiry);
            Cookie cookie = new Cookie("session", jwt);
            cookie.setMaxAge(cookieAge);
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
            response.sendRedirect("./index.jsp");
        } else {
            response.sendRedirect("./index.jsp");
        }
    }
}
