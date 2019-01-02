<%-- 
    Document   : general
    Created on : 30-oct-2014, 23:07:13
    Author     : miquel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Main CSS-->
        <link rel="stylesheet" type="text/css" href="/adiiu-dashboard/css/main.css">
        <link rel="stylesheet" type="text/css" href="/adiiu-dashboard/css/dashboard.css">
        <!-- Font-icon css-->
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--<script type="text/javascript" src="http://gc.kis.v2.scr.kaspersky-labs.com/A5EEC1E1-5267-9B48-8F5E-908EAB0BC708/main.js" charset="UTF-8"></script><link rel="stylesheet" crossorigin="anonymous" href="http://gc.kis.v2.scr.kaspersky-labs.com/96052D22-3B55-5A4C-A40B-5F5B12D1AABA/abn/main.css"/>-->
    </head>
    <body class="app sidebar-mini rtl">
        <%
            // Si es una página de la intranet y no permiso redirecciona al inicio
            String s = request.getRequestURI();
            if ((s.contains("adiiu-dashboard/privado/") && (!(s.contains("/login.jsp"))))) {
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

        <!-- Navbar-->
        <header class="app-header"><a class="app-header__logo" href="<%=request.getContextPath()%>/index.jsp">Dashboard</a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav">
                <!-- User Menu-->
                <li class="py-2 mr-2">
                    <a class="btn btn-primary btn-block" href="<%=request.getContextPath()%>/privado/login.jsp" style="background-color: blueviolet; border: 5px;">
                        User login
                    </a>
                </li>        
                <%
                    if (session.getAttribute("user") != null) {
                %>
                <li class="py-2">
                    <a class="btn btn-primary btn-block" href="<%=request.getContextPath()%>/privado/logoutprocess.jsp" style="background-color: black; border: 5px;">
                        Log out
                    </a>
                </li>
                <%
                    }
                %>
            </ul>
        </header>
    </body>
</html>
