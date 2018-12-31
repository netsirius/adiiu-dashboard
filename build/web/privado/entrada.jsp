<%-- 
    Document   : entrada
    Created on : 30-oct-2014, 22:00:41
    Author     : miquel
--%>

<%@page import="basesdedades.dbutils.DBPeliculas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include  file="/WEB-INF/cabecera.jsp" %>
        <h1>Los ratings de las 10 primer apelículas son:</h1>
        <br/>
        <%=(new DBPeliculas()).getRatingsPeliculas(10)%>
    </body>
</html>
