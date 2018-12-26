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
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="sidebar-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">
                                    <span data-feather="home"></span>
                                    Dashboard <span class="sr-only">(current)</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
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
                </main>
            </div>
        </div>
    </body>
</html>
