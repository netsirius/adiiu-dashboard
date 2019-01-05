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

                
        <div  id="pieChart2"> </div>
                
        <script src="../js/highcharts.js"></script>
        <script src="../js/exporting.js"></script>
        <!-- Graphs pie chart-->
        <script>
            
            function pintarGrafica(nombre, datos) {
                var aux = sessionStorage.getItem("classepont-datos2");
                var anyvividos = JSON.parse(datos);
                
                aux = aux.personas.push( {name:\""+nombre+"\", y:\""+anyvividos.resultado+"\""})
                sessionStorage.setItem("classepont-datos2", aux);

                $('#pieChart2').highcharts({
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                    },
                    title: {
                        text: 'Porcentaje edad de actores   total:' + auxnum
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                style: {
                                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                }
                            }
                        }
                    },
                    series: [{
                            name: "Brands",
                            colorByPoint: true,
                            data: aux
                        }]
                });
            }
            
            //cuando se carga la pagina por primera vez inicializa el array de personas a mostrar en la tarta
            $(document).ready(function () {
                
                
                if (sessionStorage.getItem("classepont-datos2") == null) {
                    var init = {personas:[]};
                    sessionStorage.setItem("classepont-datos2", init);
                } 
                
                
            });
            //ESTA FUNCIÓN ES LA QUE TENDRÍA QUE LLAMAR AL CLICKAR UN NOMBRE EN LA NUBE
            function mostrarTarta(nombre)
            {
                //utiliza el webservice personapelis que consulta el numero de peliculas de una persona
                var webServiceURL2 = 'http://localhost:8080/adiiu-dashboard/PersonasPelis?method=personapelis';
                var soapMessage2 = '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:personapelis xmlns:ns2="http://serveisweb/"><entrada>{"param":["cuantas","'+nombre+'"]}</entrada></ns2:personapelis></S:Body></S:Envelope>';
                $.ajax({
                        url: webServiceURL2,
                        type: "POST",
                        dataType: "xml",
                        data: soapMessage2,
                        processData: false,
                        contentType: "text/xml; charset=\"utf-8\"",
                        success: function(xml) {
                            OnSuccessAnimalsPercent(nombre, xml);
                        },
                        error: OnError
                    });
            }
            function OnSuccessAnimalsPercent(nombre, text) {
                var aux =  new XMLSerializer().serializeToString(text);
                var resposta = aux.substring(aux.indexOf("<return>") + 8, aux.indexOf("</return>"));
                pintarGrafica(nombre, resposta);
            }
            function OnError(text) {
                console.log(text);
            }
        </script>
    </body>
</html>
