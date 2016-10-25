package com.daverokita.blog;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import java.sql.Date;
import java.util.Calendar;

@WebServlet("/saveBlog")
public class saveBlog extends HttpServlet {
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String title = request.getParameter("title");
        String body = request.getParameter("body");
        String published = "0";
        String category = request.getParameter("category");
        String email = request.getParameter("email");
        String userid = null;
        java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());

        if ("true".equals(request.getParameter("published"))) {
            published = "1";
        }

        Connection con = dbConnection.createConnection();
        ResultSet rs = null;

        try {
            PreparedStatement ps;
            ps = con.prepareStatement("select id from USERS where email=?");
            ps.setString(1, email);
            rs = ps.executeQuery();
            rs.next();
            userid = rs.getString("id");

            ps = con.prepareStatement("insert into BLOGS (title, body, published, created, userid, category) values (?, ?, ?, ?, ?, ?)");
            ps.setString(1, title);
            ps.setString(2, body);
            ps.setString(3, published);
            ps.setTimestamp(4, date);
            ps.setString(5, userid);
            ps.setString(6, category);
            ps.executeUpdate();
            response.sendRedirect("./category.jsp?category=" + category);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        out.println(title);
        out.println(body);
        out.println(published);
        out.println(category);
        out.println(date);
    }
}