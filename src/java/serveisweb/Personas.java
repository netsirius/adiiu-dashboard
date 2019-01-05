/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serveisweb;

import basesdedades.dbutils.DBPeliculas;
import basesdedades.dbutils.DBPersonas;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import meujson.MeuJson;

/**
 *
 * @author mascport
 */
@WebService(serviceName = "Personas")
public class Personas {

    /**
     * Web service operation
     */
    @WebMethod(operationName = "anyosvividos")
    public String anyosvividos(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["John Wayne"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "";
        DBPersonas dbp = new DBPersonas();
        res = dbp.getAnyosVividos(pars[0]);
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "naciomurio")
    public String naciomurio(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["John Wayne"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "";
        DBPersonas dbp = new DBPersonas();
        res = dbp.getActoreNacioMurio(pars[0]);
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "actoresmuertosen")
    public String actoresmuertosen(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["cuantos", "1990"]};
        //  Ejemplo:   ---->      param = {"param":["lista", "1990"]};
        //  Ejemplo:   ---->      param = {"param":["lista", "1990","3", "8"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "null";
        DBPersonas dbp = new DBPersonas();
        if ((pars.length >= 2) && (pars.length <= 4)) {
            if (pars[0].contentEquals("cuantos")) {
                res = dbp.getCuantosActoresMuertosEn(pars[1]);
            } else if (pars[0].contentEquals("lista")) {
                if (pars.length == 4) {
                    res = dbp.getActoresMuertosEnDeA(pars[1], Long.parseLong(pars[2]), Long.parseLong(pars[3]));
                } else {
                    res = dbp.getActoresMuertosEn(pars[1]);
                }
            }
        }
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "actoresnacidosen")
    public String actoresnacidosen(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["cuantos", "1990"]};
        //  Ejemplo:   ---->      param = {"param":["lista", "1990"]};
        //  Ejemplo:   ---->      param = {"param":["lista", "1990","3", "8"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "null";
        DBPersonas dbp = new DBPersonas();
        if ((pars.length >= 2) && (pars.length <= 4)) {
            if (pars[0].contentEquals("cuantos")) {
                res = dbp.getCuantosActoresNacidosEn(pars[1]);
            } else if (pars[0].contentEquals("lista")) {
                if (pars.length == 4) {
                    res = dbp.getActoresNacidosEnDeA(pars[1], Long.parseLong(pars[2]), Long.parseLong(pars[3]));
                } else {
                    res = dbp.getActoresNacidosEn(pars[1]);
                }
            }
        }
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "actoressellaman")
    public String actoressellaman(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["cuantos", "James"]};
        //  Ejemplo:   ---->      param = {"param":["lista", "James"]};
        //  Ejemplo:   ---->      param = {"param":["lista", "James","1", "8"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "null";
        DBPersonas dbp = new DBPersonas();
        if ((pars.length >= 2) && (pars.length <= 4)) {
            if (pars[0].contentEquals("cuantos")) {
                res = dbp.getCuantosActoresSeLlaman(pars[1]);
            } else if (pars[0].contentEquals("lista")) {
                if (pars.length == 4) {
                    res = dbp.getActoresSeLlaman(pars[1], Long.parseLong(pars[2]), Long.parseLong(pars[3]));
                } else {
                    res = dbp.getActoresSeLlaman(pars[1]);
                }
            }
        }
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "personasAnyosVividos")
    public String personasAnyosVividos(@WebParam(name = "entrada") String entrada) {
        String[] pars = MeuJson.getArguments(entrada);
        String res = "null";
        DBPersonas dbp = new DBPersonas();
        int edad1 = 0;
        int edad2 = Integer.parseInt(pars[0]);
        res = "{\"resultado\":[" + dbp.getPersonasAnyosVividos(edad1, edad2);
        for (int i = 1; i < pars.length; i++) {
            edad1 = Integer.parseInt(pars[i - 1]);
            edad2 = Integer.parseInt(pars[i]);
            res = res + "," + dbp.getPersonasAnyosVividos(edad1, edad2);
        }

        edad1 = Integer.parseInt(pars[pars.length - 1]);
        res = res + "," + dbp.getPersonasAnyosVividos(edad1, -1) + "]}";
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "actores")
    public String actores(@WebParam(name = "cantidad") String cantidad) {
        String[] pars = MeuJson.getArguments(cantidad);
        String res = "";
        DBPersonas dbp = new DBPersonas();
        res = dbp.getActores(Integer.parseInt(pars[0]));
        return res;
    }

}
