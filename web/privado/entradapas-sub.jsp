<%-- 
    Document   : entradapas-sub
    Created on : 30-oct-2014, 23:38:43
    Author     : miquel
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String user = request.getParameter("user");
            String pass = request.getParameter("pass");
            ArrayList<String> aux = new ArrayList();
            aux.add("Juan");
            aux.add("patata");
            aux.add("0");
            if (aux.size() > 0) {
                if ((user.contentEquals(aux.get(0))) && (pass.contentEquals(aux.get(1)))) {
                    // el usuario password es válido. Abrimos la sesión
                    session.setAttribute("user", user);
                    session.setAttribute("pass", pass);
                    session.setAttribute("level", aux.get(2));
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", request.getContextPath() + "/privado/entrada.jsp");
                } else {
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", request.getContextPath() + "/index.jsp");
                }
            }
        %>
    </body>
</html>
