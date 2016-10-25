<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript" src="includes/bootstrapTop.js"></script>
</head>

<body>
<%
    request.getRequestDispatcher("category.jsp?category=1").forward(request, response);
%>
</body>