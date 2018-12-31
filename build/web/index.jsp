<%-- 
    Document   : index
    Created on : 20-nov-2018, 11:12:29
    Author     : mascport
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
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-3 border-bottom">
                        <h1 class="h2">Dashboard</h1>
                        <div class="btn-toolbar mb-2 mb-md-0">
                            <div class="btn-group mr-2">
                                <button class="btn btn-sm btn-outline-secondary">Share</button>
                                <button class="btn btn-sm btn-outline-secondary">Export</button>
                            </div>
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle">
                                <span data-feather="calendar"></span>
                                This week
                            </button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-lg-6 col-md-6" id="pieChart"> </div>
                        <div class="col-sm-12 col-lg-6 col-md-6" id="barChart"></div>
                    </div>

                    <h2>Map</h2>

                    <div class="row" id="mapcontainer">
                        <div class="col-lg-2 col-md-2 rightPanel">
                            <div class="areaLegend"></div>
                            <div class="plotLegend"></div>
                        </div>
                        <div class="col-lg-10 col-md-10">
                            <div class="map"></div>
                            <div style="clear: both;"></div>
                        </div>
                    </div>
                </main>
            </div>
        </div>



        <!-- Icons -->
        <script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
        <script>
            feather.replace()
        </script>
        <script src="js/highcharts.js"></script>
        <script src="js/exporting.js"></script>
        <!-- Graphs pie chart-->
        <script>
            var webServiceURL = 'http://localhost:8080/adiiu-dashboard/Personas?method=personasAnyosVividos';
            var soapMessage = '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:personasAnyosVividos xmlns:ns2="http://serveisweb/"><entrada>{"param":["30","60"]}</entrada></ns2:personasAnyosVividos></S:Body></S:Envelope>';
            function pintarGrafica(datos) {
                var anyvividos = JSON.parse(datos);
                var auxstr = '[';
                var auxnum = 0;
                var primer = true;
                for (var i = 0; i < anyvividos.resultado.length; i++) {
                    auxnum = auxnum + anyvividos.resultado[i].cantidad;
                }
                for (var i = 0; i < anyvividos.resultado.length; i++) {
                    auxstr = auxstr + '{"name": "';
                    auxstr = auxstr + anyvividos.resultado[i].key + '","y": ';
                    auxstr = auxstr + (anyvividos.resultado[i].cantidad * 100.0 / auxnum);
                    if (primer) {
                        auxstr = auxstr + ', "sliced": true, "selected": true';
                        primer = false;
                    }
                    auxstr = auxstr + '},';
                }
                auxstr = auxstr.substring(0, auxstr.length - 1) + ']';
                $('#pieChart').highcharts({
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
                            data: JSON.parse(auxstr)
                        }]
                });
            }

            $(document).ready(function () {
                if (sessionStorage.getItem("classepont-datos") == null) {
                    $.ajax({
                        url: webServiceURL,
                        type: "POST",
                        dataType: "xml",
                        data: soapMessage,
                        processData: false,
                        contentType: "text/xml; charset=\"utf-8\"",
                        success: OnSuccessAnimalsPercent,
                        error: OnError
                    });
                } else {
                    OnSuccessAnimalsPercent(sessionStorage.getItem("classepont-datos"));
                }
            });

            function OnSuccessAnimalsPercent(text) {
                var aux;
                if (sessionStorage.getItem("classepont-datos") == null) {
                    aux = new XMLSerializer().serializeToString(text)
                    sessionStorage.setItem("classepont-datos", aux);
                } else {
                    aux = sessionStorage.getItem("classepont-datos");
                }
                var resposta = aux.substring(aux.indexOf("<return>") + 8, aux.indexOf("</return>"));
                $("#parr_resp").append("<b>" + resposta + "</b>");
                $("#parr_resp").append("<br><br> traducció del JSON:<br>");
                var anyvividos = JSON.parse(resposta);
                for (var i = 0; i < anyvividos.resultado.length; i++) {
                    $("#parr_resp").append(anyvividos.resultado[i].key + " --> " + anyvividos.resultado[i].value + "<br>");
                }
                pintarGrafica(resposta);
            }

            function OnError(text) {
                console.log(text);
            }

        </script>

        <script>
            var webServiceURLB = 'http://localhost:8080/adiiu-dashboard/PersonasPelis?method=personasPelis';
            var soapMessageB = '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:personasPelis xmlns:ns2="http://serveisweb/"><edades>{"param":["30","60"]}</edades><cantidad>{"param":["5"]}</cantidad></ns2:personasPelis></S:Body></S:Envelope>';


            $(document).ready(function () {
                if (sessionStorage.getItem("classepont-datosb") == null) {
                    $.ajax({
                        url: webServiceURLB,
                        type: "POST",
                        dataType: "xml",
                        data: soapMessageB,
                        processData: false,
                        contentType: "text/xml; charset=\"utf-8\"",
                        success: OnSuccessBarChart,
                        error: OnErrorBar
                    });
                } else {
                    OnSuccessBarChart(sessionStorage.getItem("classepont-datosb"));
                }
            });

            function OnSuccessBarChart(text) {
                var aux;
                if (sessionStorage.getItem("classepont-datosb") == null) {
                    aux = new XMLSerializer().serializeToString(text)
                    sessionStorage.setItem("classepont-datosb", aux);
                } else {
                    aux = sessionStorage.getItem("classepont-datosb");
                }
                var resposta = aux.substring(aux.indexOf("<return>") + 8, aux.indexOf("</return>"));
                pintarGraficaBar(resposta);
            }


            function pintarGraficaBar(datos) {
                var anyvividos = JSON.parse(datos);
                var auxstr = [];
                for (var i = 0; i < anyvividos.resultado.length; i++) {
                    var auxstr2 = [];
                    auxstr2.push(anyvividos.resultado[i].key);
                    auxstr2.push(anyvividos.resultado[i].cantidad);
                    auxstr.push(auxstr2);
                }

                $('#barChart').highcharts({
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: 'Actores peliculas'
                    },
                    xAxis: {
                        type: 'Actores',
                        labels: {
                            rotation: -45,
                            style: {
                                fontSize: '13px',
                                fontFamily: 'Verdana, sans-serif'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: 'Peliculas'
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    tooltip: {
                        pointFormat: 'Population in 2017: <b>{point.y:.1f} millions</b>'
                    },
                    series: [{
                            name: 'Actores',
                            data: auxstr,
                            dataLabels: {
                                enabled: true,
                                rotation: -90,
                                color: '#FFFFFF',
                                align: 'right',
                                format: '{point.y:.1f}', // one decimal
                                y: 10, // 10 pixels down from the top
                                style: {
                                    fontSize: '13px',
                                    fontFamily: 'Verdana, sans-serif'
                                }
                            }
                        }]
                });
            }

            function OnErrorBar(text) {
                console.log(text);
            }
        </script>


        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.min.js" charset="utf-8"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.2.7/raphael.min.js" charset="utf-8"></script>
        <script type="text/javascript" src="js/jquery.mapael.js" charset="utf-8"></script>
        <script type="text/javascript" src="js/world_countries.js" charset="utf-8"></script>

        <script>
            var webServiceURLM = 'http://localhost:8080/adiiu-dashboard/localidades?method=paispeli';
            var soapMessageM = '<?xml version="1.0" encoding="UTF-8"?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"><SOAP-ENV:Header/><S:Body><ns2:paispeli xmlns:ns2="http://serveisweb/"></ns2:paispeli></S:Body></S:Envelope>';


            $(document).ready(function () {
                if (sessionStorage.getItem("classepont-datosb") == null) {
                    $.ajax({
                        url: webServiceURLM,
                        type: "POST",
                        dataType: "xml",
                        data: soapMessageM,
                        processData: false,
                        contentType: "text/xml; charset=\"utf-8\"",
                        success: OnSuccessMap,
                        error: OnErrorBar
                    });
                } else {
                    OnSuccessMap(sessionStorage.getItem("classepont-datosm"));
                }
            });

            function OnSuccessMap(text) {
                var aux;
                if (sessionStorage.getItem("classepont-datosm") == null) {
                    aux = new XMLSerializer().serializeToString(text)
                    sessionStorage.setItem("classepont-datosm", aux);
                } else {
                    aux = sessionStorage.getItem("classepont-datosm");
                }
                var resposta = aux.substring(aux.indexOf("<return>") + 8, aux.indexOf("</return>"));
                pintarMapa(resposta);
            }
            function pintarMapa(datos) {

                var mapa = JSON.parse(datos);
                var data = {};
                for (var i = 0; i < mapa.resultado.length; i++) {
                    eval("var aux = { value: " + mapa.resultado[i].cantidad + ", href: \"#\", tooltip: {content: \"<span  style=\\\"font-weight:bold;\\\">"
                            + mapa.resultado[i].key.toString().toUpperCase() + "</span><br />Actores:" + mapa.resultado[i].cantidad + "\"}}");
                    eval("data." + mapa.resultado[i].key.toString().toUpperCase() + " = aux");
                }

                $("#mapcontainer").mapael(
                        {
                            map: {
                                name: "world_countries",
                                zoom: {
                                    enabled: true,
                                    maxLevel: 10
                                }
                            },
                            legend: {
                                area: {
                                    display: true,
                                    title: "Country actors",
                                    marginBottom: 7,
                                    slices: [
                                        {
                                            max: 5,
                                            attrs: {
                                                fill: "#6ECBD4"
                                            },
                                            label: "Less than 5"
                                        },
                                        {
                                            min: 5,
                                            max: 10,
                                            attrs: {
                                                fill: "#3EC7D4"
                                            },
                                            label: "Between 5 and 10"
                                        },
                                        {
                                            min: 10,
                                            max: 50,
                                            attrs: {
                                                fill: "#028E9B"
                                            },
                                            label: "Between 10 and 50"
                                        },
                                        {
                                            min: 50,
                                            attrs: {
                                                fill: "#01565E"
                                            },
                                            label: "More than 50"
                                        }
                                    ]
                                }

                            },

                            areas: data
                        }
                );
            }
        </script>
    </body>
</html>
