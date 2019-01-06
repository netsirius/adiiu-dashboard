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
           <script src="../js/highcharts.js"></script>
        <script src="../js/exporting.js"></script>
        <!-- Graphs pie chart-->
        <script>

            function pintarGrafica(nombre, datos) {
                var aux = sessionStorage.getItem("classepont-datos2");
                var anyvividos = JSON.parse(datos);
                aux = aux.personas.push({name: nombre , y: anyvividos.resultado})
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
                    var init = {personas: []};
                    sessionStorage.setItem("classepont-datos2", init);
                }


            });
            //ESTA FUNCIÓN ES LA QUE TENDRÍA QUE LLAMAR AL CLICKAR UN NOMBRE EN LA NUBE
            function mostrarTarta(nombre)
            {
                //utiliza el webservice personapelis que consulta el numero de peliculas de una persona
                var webServiceURL2 = 'http://localhost:8080/adiiu-dashboard/PersonasPelis?method=personapelis';
                var soapMessage2 = '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:personapelis xmlns:ns2="http://serveisweb/"><param>{"param":["cuantas","' + nombre + '"]}</param></ns2:personapelis></S:Body></S:Envelope>';
                $.ajax({
                    url: webServiceURL2,
                    type: "POST",
                    dataType: "xml",
                    data: soapMessage2,
                    processData: false,
                    contentType: "text/xml; charset=\"utf-8\"",
                    success: function (xml) {
                        OnSuccessAnimalsPercent(nombre, xml);
                    },
                    error: OnError
                });
            }
            function OnSuccessAnimalsPercent(nombre, text) {
                var aux = new XMLSerializer().serializeToString(text);
                var resposta = aux.substring(aux.indexOf("<return>") + 8, aux.indexOf("</return>"));
                pintarGrafica(nombre, resposta);
            }
            function OnError(text) {
                console.log(text);
            }
        </script>
        
        <script src="/adiiu-dashboard/js/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="/adiiu-dashboard/js/jquery.tagcanvas.min.js" type="text/javascript"></script>
        <script>
            var webServiceURL1 = 'http://localhost:8080/adiiu-dashboard/Personas?method=actores';
            var soapMessage1 = '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:actores xmlns:ns2="http://serveisweb/"><cantidad>{"param":["25"]}</cantidad></ns2:actores></S:Body></S:Envelope>';
            function generarTags(datos) {
                $( "#tags" ).append( $( "<ul><li><a href=\"#\" onclick=\"mostrarTarta('Fred Astaire');\">Fred Astaire</a></li></ul>" ) );
            }
            $(document).ready(function () {
                if (sessionStorage.getItem("classepont-datos-actores") == null) {
                    $.ajax({
                        url: webServiceURL1,
                        type: "POST",
                        dataType: "xml",
                        data: soapMessage1,
                        processData: false,
                        contentType: "text/xml; charset=\"utf-8\"",
                        success: OnSuccess,
                        error: OnError
                    });
                } else {
                    OnSuccess(sessionStorage.getItem("classepont-datos-actores"));
                }
                if (!$('#myCanvas').tagcanvas({
                    textColour: '#ff0000',
                    outlineThickness: 1,
                    outlineColour: '#000000',
                    maxSpeed: 0.03,
                    depth: 0.75
                }, 'tags')) {
                    $('#myCanvasContainer').hide();
                }
            });
            function OnSuccess(text) {
                var aux;
                if (sessionStorage.getItem("classepont-datos-actores") == null) {
                    aux = new XMLSerializer().serializeToString(text)
                    sessionStorage.setItem("classepont-datos-actores", aux);
                } else {
                    aux = sessionStorage.getItem("classepont-datos-actores");
                }
                var resposta = aux.substring(aux.indexOf("<return>") + 8, aux.indexOf("</return>"));
                $("#parr_resp").append("<b>" + resposta + "</b>");
                $("#parr_resp").append("<br><br> traducció del JSON:<br>");
                var actores = JSON.parse(resposta);
                for (var i = 0; i < actores.resultado.length; i++) {
                    $("#parr_resp").append(actores.resultado[i].key + " --> " + actores.resultado[i].value + "<br>");
                }
                generarTags(resposta);
            }
            function OnError(text) {
                console.log(text);
            }
        </script>
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
                    <p>Administrator dashboard ADIIU project</p>
                </div>
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
                    <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp">Dashboard</a></li>
                </ul>
            </div
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12" id="wordCloud">
                    <p id="param"></p>
                    <br/>
                    <div id="myCanvasContainer">
                        <canvas width="300" height="300" id="myCanvas" style="background: ">
                            <p>In Internet Explorer versions up to 8, things inside the canvas are inaccessible!</p>
                        </canvas>
                    </div>

                    <div id="tags">
                        <!--                        <ul>
                                                    <li><a href="http://www.google.com" target="_blank">Google</a></li>
                                                    <li><a href="http://www.uib.es">primer UIB</a></li>
                                                    <li><a href="http://www.uib.es">segon UIB</a></li>
                                                    <li><a href="http://www.uib.es">tercer UIB</a></li>
                                                    <li><a href="http://www.uib.es">quart UIB</a></li>
                                                    <li><a href="index.jsp?persona=Fernández">paràmetre</a></li>
                                                </ul>-->
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12" id="pieChart2"> </div>
            </div>
        </main>
    </body>
</html>
