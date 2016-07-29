package com.daverokita.blog;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;

@WebServlet("/Login")
public class Login extends HttpServlet {
    protected void doPost (HttpServletRequest request,
                       HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if(Validate.checkUser(email, password)) {
            RequestDispatcher rs = request.getRequestDispatcher("Welcome");
            rs.forward(request, response);
        } else {
            out.println("Email Address or Password Incorrect");
            RequestDispatcher rs = request.getRequestDispatcher("index.htm");
            rs.include(request, response);
        }
    }
}
