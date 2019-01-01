<%-- 
    Document   : login page
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include  file ="/WEB-INF/cabecera.jsp" %>

        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <ul class="app-menu">
                <li><a class="app-menu__item active" href="<%=request.getContextPath()%>/index.jsp"><i class="app-menu__icon fa fa-dashboard"></i><span class="app-menu__label">Dashboard</span></a></li>
                <li><a class="app-menu__item" href="<%=request.getContextPath()%>/index.jsp"><i class="app-menu__icon fa fa-dashboard"></i><span class="app-menu__label">Public panel</span></a></li>
            </ul>
        </aside>
        <main class="app-content">
            <div class="row">
                <div class="login-form">
                    <%            // si no usuario o password redirección
                        String user = (String) session.getAttribute("user");
                        String pass = (String) session.getAttribute("pass");
                        if ((user == null) || (pass == null)) {
                        // hago fomulario de usuario y password
                    %>
                    <form name="input" action="/adiiu-dashboard/privado/entradapas-sub.jsp" method="post">
                        <div class="avatar">
                            <img src="/adiiu-dashboard/images/avatar.png" alt="Avatar">
                        </div>
                        <h2 class="text-center">Member Login</h2>   
                        <div class="form-group">
                            <input type="text" class="form-control" name="user" placeholder="Username" required="required">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" name="pass" placeholder="Password" required="required">
                        </div>        
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-lg btn-block">Sign in</button>
                        </div>
                    </form>
                    <%
                        } else {
                            //tiene permiso lo redirijo a la intranet
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", request.getContextPath() + "/privado/entrada.jsp");
                        }
                    %>
                </div>
            </div>
    </body>
</html>
