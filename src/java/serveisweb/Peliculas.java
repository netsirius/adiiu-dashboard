/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serveisweb;

import basesdedades.dbutils.DBPeliculas;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import meujson.MeuJson;

/**
 *
 * @author hectorsantos
 */
@WebService(serviceName = "Peliculas")
public class Peliculas {

     /**
     * Web service operation
     */
    @WebMethod(operationName = "ratingpeliculas")
    public String ratingpeliculas(@WebParam(name = "cantidad") String cantidad) {
        String[] pars = MeuJson.getArguments(cantidad);
        String res = "";
        DBPeliculas dbp = new DBPeliculas();
        res = dbp.getRatingsPeliculas(Integer.parseInt(pars[0]));
        return res;
    }
}
