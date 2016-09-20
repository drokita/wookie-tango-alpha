<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="includes/bootstrapTop.js"></script>
</head>

<body>
<%@ page import="com.daverokita.blog.JWT" %>
<%@ page import="com.daverokita.blog.dbConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page session="false" %>

<%
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    String validated = null;
    String header = "includes/loginHeader.js";
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
                    response.sendRedirect("index.jsp");
                }
            }
        }
    }
    if (found == false) {
        header = "includes/loginHeader.js";
        response.sendRedirect("index.jsp");
    }
%>

<div>
    <script type="text/javascript">var subject = "<%= validated %>";</script>
    <script type="text/javascript" src="<%= header %>"></script>
    <div class="jumbotron">
        <div class="container">
            <h1>Create Blog</h1>
        </div>
    </div>
    <p></p>
    <form class="container" action="saveBlog" method="POST">
        <div class="container">
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-8">
                    <div class="container">

                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label for="title">Title:</label>
                                    <input type="text" class="form-control" name="title" id="title">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label for="url">Url:</label>
                                    <input type="text" class="form-control" name="url" id="url">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label for="body">Body:</label>
                                    <textarea type="text" rows="20" class="form-control" name="body" id="body"></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-1">
                                <div class="checkbox">
                                    <label><input type="checkbox" id="published" name="published" value="true">Published</label>
                                    <input type="hidden" value="<%=validated%>" name="email">
                                </div>
                            </div>
                            <div class="col-md-5"></div>
                            <div class="col-md-1">
                                <div class="dropdown-open">
                                    <button class="btn btn-success dropdown-toggle" type="button" data-toggle="dropdown" id="dropdownMenuButton">Category</button>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <%
                                            Connection con = dbConnection.createConnection();
                                            ResultSet rs = null;

                                            try {
                                                PreparedStatement ps = con.prepareStatement("select name, id from CATEGORY");
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                                    String category = rs.getString(1);
                                                    String catId = rs.getString(2);
                                                    out.println("<li>&nbsp<input type=\"radio\" name=\"category\" value=\"" + catId + "\"/>&nbsp" + category + "</li>");
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            } finally {
                                                try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                                try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                                            }
                                        %>

                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-1">
                                <button class="btn btn-success">Save</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <img src="images/biscuits.jpg" class="img-circle" width="300" height="250">
                </div>
            </div>
        </div>
    </form>

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
