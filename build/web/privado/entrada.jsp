<%-- 
    Document   : index
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    </head>
    <body>
        <%@include  file ="/WEB-INF/cabecera.jsp" %>
        <!-- Sidebar menu-->
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <%                
                if (session.getAttribute("user") != null) {
            %>
            <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="/adiiu-dashboard/images/ninja.png" alt="User Image">
                <div>
                    <p class="app-sidebar__user-name"><% out.print(session.getAttribute("user")); %></p>
                    <p class="app-sidebar__user-designation">Admin user</p>
                </div>
            </div>
            <%
                }
            %>
            <ul class="app-menu">
                <li><a class="app-menu__item" href="<%=request.getContextPath()%>/index.jsp"><i class="app-menu__icon fa fa-dashboard"></i><span class="app-menu__label">Dashboard</span></a></li>
                <%                
                    if (session.getAttribute("user") != null) {
                %>
                <li><a class="app-menu__item active" href="<%=request.getContextPath()%>/privado/entrada.jsp"><i class="app-menu__icon fa fa-dashboard"></i><span class="app-menu__label">Admin Panel</span></a></li>
                <%
                    }
                %>
            </ul>
        </aside>
        <main class="app-content">
            <div class="app-title">
                <div>
                    <h1><i class="fa fa-dashboard"></i> Dashboard</h1>
                    <p>Dashboard ADIIU project</p>
                </div>
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">Dashboard</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="tile">
                        <h3 class="tile-title">Monthly Sales</h3>
                        <div class="embed-responsive embed-responsive-16by9">
                            <canvas class="embed-responsive-item" id="lineChartDemo"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="tile">
                        <h3 class="tile-title">Support Requests</h3>
                        <div class="embed-responsive embed-responsive-16by9">
                            <canvas class="embed-responsive-item" id="pieChartDemo"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
