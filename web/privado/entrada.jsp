<%-- 
    Document   : entrada
    Created on : 30-oct-2014, 22:00:41
    Author     : miquel
--%>

<%@page import="basesdedades.dbutils.DBActorPeliculas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include  file="/WEB-INF/cabecera.jsp" %>
        <h1>Las películas de John Wayne son:</h1>
        <br/>
        <%= (new DBActorPeliculas()).getActorPeliculas("John Wayne")%>
    </body>
</html>
