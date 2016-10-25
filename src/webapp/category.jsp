<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="includes/bootstrapTop.js"></script>
</head>

<body>
<%@ page import="com.daverokita.blog.JWT" %>
<%@ page import="com.daverokita.blog.dbConnection" %>
<%@ page import="java.sql.*" %>
<%@ page session="false" %>

<%
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    String validated = null;
    String header = "includes/loginHeader.js";
    String uri = request.getRequestURI();
    String params = request.getQueryString();
    String pageName = uri.substring(uri.lastIndexOf("/")+1);
    String origin = null;
    if (request.getAttribute("javax.servlet.forward.request_uri") != null) {
        String forward = request.getAttribute("javax.servlet.forward.request_uri").toString();
        origin = forward.substring(forward.lastIndexOf("/") + 1);
    }
    String redirect = pageName + "?" + params;
    boolean found = false;
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {
            cookie = cookies[i];
            String jwt = cookie.getValue();
            if(cookie.getName().equals("session")) {
                validated = JWT.checkJWT(jwt);
                if (validated != null ) {
                    header = "includes/defaultHeader.js";
                    found = true;
                } else {
                    header = "includes/loginHeader.js";
                    response.sendRedirect(redirect);
                }
            }
        }
    }
    if (found == false) {
        header = "includes/loginHeader.js";
    }
%>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rsCat = null;
    ResultSet rsBlog = null;
    String catId = request.getParameter("category");
    String blogId = request.getParameter("id");
    String catName = null;

    try {
        con = dbConnection.createConnection();
        ps = con.prepareStatement(
                "select name from CATEGORY where id=?");
        ps.setString(1, catId);
        rsCat = ps.executeQuery();
        while(rsCat.next()) {
            catName = rsCat.getString("name");
        }

        if (blogId != null) {
            ps = con.prepareStatement(
                    "select id, title, body, created, updated, userid, category from BLOGS where id=?");
            ps.setString(1, blogId);
        } else {
            ps = con.prepareStatement(
                    "select BLOGS.id, BLOGS.title, BLOGS.body, BLOGS.created, " +
                            "BLOGS.updated, BLOGS.userid, USERS.email from BLOGS " +
                            "INNER JOIN USERS on BLOGS.userid=USERS.id " +
                            "where BLOGS.category=? and BLOGS.published=1");
            ps.setString(1, catId);
        }

        rsBlog = ps.executeQuery();

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try { rsCat.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<div>
    <script type="text/javascript"> var source = "<%= redirect %>";</script>
    <script type="text/javascript">var subject = "<%= validated %>";</script>
    <script type="text/javascript" src="<%= header %>"></script>
    <div class="jumbotron">
        <div class="container">
            <%
            if (origin != null && origin.equals("index.jsp")) {
                out.println("<script type=\"text/javascript\" src=\"includes/welcome.js\"></script>");
            } else {
                out.println("<h1>" + catName + "</h1>");
            }
            %>
        </div>
    </div>
    <p></p>
    <div class="container">
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-7">
                <div class="container">

    <%
        while (rsBlog.next()) {
            if (blogId == null) {
                blogId = rsBlog.getString(1);
            }
            String title = rsBlog.getString(2);
            String body = rsBlog.getString(3);
            String created = rsBlog.getString(4);
            String updated = rsBlog.getString(5);
            String userid = rsBlog.getString(6);
            String email = rsBlog.getString(7);
            out.println("<div class=\"row\">"); // row
            out.println("<div class=\"col-md-6\" id=\"blogview\">"); // title left
            out.println("<h2><a href=\"./category.jsp?category=" + catId + "&id=" + blogId + "\">" + title + "</a></h2>");
            out.println("</div>"); // title left
            out.println("<div class=\"col-md-1\"></div>"); //title right
            out.println("</div>"); // row close
            out.println("<div class=\"row\">"); // row2
            out.println("<div class=\"col-md-6\" id=\"blogview\">"); // body left
            out.println(body);
            out.println("</div>"); // body left
            out.println("<div class=\"col-md-1\"></div>"); // body right
            out.println("</div>");  // row2 close
            out.println("<p></p>");
            out.println("<div class=\"row\">"); // underline open
            out.println("<div class=\"col-md-6\" id=\"blogview\">");
            out.println("<div style=\"border-bottom:1px solid #ccc;\"></div>");
            out.println("</div>");
            out.println("</div>"); // underline close
            out.println("<p></p>");
            out.println("<div class=\"row\">"); // row3 open
            out.println("<div class=\"col-md-6\" id=\"blogview\">"); // created
            out.println("Created: " + created);
            out.println("</div>"); // created close
            out.println("</div>"); // row3 close
            out.println("<div class=\"row\">"); // row 4 open
            out.println("<div class=\"col-md-6\" id=\"blogview\">"); // username
            out.println("User: " + email);
            //out.println("User: " + userid);
            out.println("</div>"); // username close
            out.println("</div>"); // row 4 close
            out.println("<p></p>");
        }

        try { rsBlog.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    %>
                    <!-- </div> -->
                </div>
            </div>
            <div class="col-md-3">
                <img src="images/biscuits.jpg" class="img-circle" width="300" height="250">
            </div>
        </div>
    </div>

    <hr>
    <footer>
        <div class="col-md-1"></div>
        <div class="col-md-8">
            <p>&copy; 2016 daverokita.com</p>
        </div>
        <div class="col-md-3"></div>
    </footer>
    </hr>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
