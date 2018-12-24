<%-- 
    Document   : general
    Created on : 30-oct-2014, 23:07:13
    Author     : miquel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Adiiu project">
        <meta name="author" content="Renz Beltran and Hector Santos">
        <link rel="icon" href="images/favicon.ico">

        <title>Dashboard Template for Bootstrap</title>

        <!-- Bootstrap core CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
    </head>
    <body>
        <%
            // Si es una página de la intranet y no permiso redirecciona al inicio
            String s = request.getRequestURI();
            if ((s.contains("Curs1819/privado/") && (!(s.contains("/entradapas.jsp"))))) {
                String user = (String) session.getAttribute("user");
                String pass = (String) session.getAttribute("pass");
                if ((user == null) || (pass == null)) {
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", request.getContextPath() + "/index.jsp");
                } else {
                    String level = (String) session.getAttribute("level");
                    if (Integer.parseInt(level) > 0) {
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", request.getContextPath() + "/index.jsp");
                    }
                }
            }
        %>

        <nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0">
            <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="<%=request.getContextPath()%>/privado/entradapas.jsp">Dashboard adiiu</a>
            <ul class="navbar-nav px-3" wfd-id="22">
                <li class="nav-item text-nowrap" wfd-id="23">
                    <a class="nav-link" href="#">Sign in</a>
                </li>
            </ul>
        </nav>
    </body>
</html>
