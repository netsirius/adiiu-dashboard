<%-- 
    Document   : entradapas
    Created on : 20-nov-2018, 11:33:38
    Author     : mascport
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include  file = "/WEB-INF/cabecera.jsp" %>
        <%            // si no usuario o password redirección
            String user = (String) session.getAttribute("user");
            String pass = (String) session.getAttribute("pass");
            if ((user == null) || (pass == null)) {
                // hago fomulario de usuario y password
        %>
        <form name="input" action="entradapas-sub.jsp" method="post">
            Usuario: <input type="text" name="user"><br>
            Clave: <input type="password" name="pass"><br>
            <input type="submit" value="Enviar">
        </form>
        <%
            } else {
                //tiene permiso lo redirijo a la intranet
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", request.getContextPath() + "/privado/entrada.jsp");
            }
        %>
    </body>
</html>
