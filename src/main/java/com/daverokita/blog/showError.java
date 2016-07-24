package com.daverokita.blog;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class showError extends HttpServlet {
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

        response.sendError(407, "Need authentication!!!");
    }

    public void doPost(HttpServletRequest request,
                       HttpServletResponse response)
        throws ServletException, IOException {
        doGet(request, response);
    }
}
