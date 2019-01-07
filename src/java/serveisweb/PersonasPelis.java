/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serveisweb;

import basesdedades.dbutils.DBActorPeliculas;
import basesdedades.dbutils.DBPersonas;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import meujson.MeuJson;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author mascport
 */
@WebService(serviceName = "PersonasPelis")
public class PersonasPelis {

    /**
     * Web service operation
     */
    @WebMethod(operationName = "personapelis")
    public String personapelis(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["cuantas", "John Wayne"]};
        //  Ejemplo:   ---->      param = {"param":["lista", "John Wayne"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "{\"response\":{";
        DBActorPeliculas dbap = new DBActorPeliculas();
        if (pars[0].contentEquals("cuantas")) {
            res += dbap.getActorPeliculasCuantas(pars[1]) + ",";
            res += new DBPersonas().getInfoActor(pars[1]) + "}}";
        } else if (pars[0].contentEquals("lista")) {
            res = dbap.getActorPeliculas(pars[1]);
        }
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "personasPelis")
    public String personasPelis(@WebParam(name = "edades") String edades, @WebParam(name = "cantidad") String cantidad) {
        
        //obtenemos los parametros
        String[] edadesS = MeuJson.getArguments(edades);
        int cantidadS = Integer.parseInt((MeuJson.getArguments(cantidad))[0]);
        String res = "null";
        
        //obtenemos actores con edades entre 0-edades[0]
        DBPersonas dbp = new DBPersonas();
        int edad1 = 0;
        int edad2 = Integer.parseInt(edadesS[0]);
        DBActorPeliculas dbpp = new DBActorPeliculas();
        JSONObject jsonobj = new JSONObject(dbp.getPersonasAnyosVividosLista(edad1,edad2,cantidadS));
        JSONArray argum = jsonobj.getJSONArray("lista");
        //obtenemos la cantidad de peliculas hechas para cada actor. Abrimos el array
        
        jsonobj = new JSONObject(dbpp.getActorPeliculasCuantas(argum.getString(0)));
        int cant = jsonobj.getInt("resultado");
        
        res = "{\"resultado\":[{\"key\":\""+argum.getString(0)+"\",\"cantidad\":"+cant+"}";
        for(int i=1;i<argum.length();i++) {
            jsonobj = new JSONObject(dbpp.getActorPeliculasCuantas(argum.getString(i)));
            cant = jsonobj.getInt("resultado");
            res = res + ",{\"key\":\""+argum.getString(i)+"\",\"cantidad\":"+cant+"}";
        }
        
        //obtenemos actores con edades entre edades[i-1]- edades[i]
        for (int i = 1; i < edadesS.length; i++ ) 
        {
            //obtenemos la cantidad de peliculas hechas para cada actor
             edad1 = Integer.parseInt(edadesS[i-1]);
             edad2 = Integer.parseInt(edadesS[i]);
             jsonobj = new JSONObject(dbp.getPersonasAnyosVividosLista(edad1,edad2,cantidadS));
             argum = jsonobj.getJSONArray("lista");
             
             for(int j=0;j<argum.length();j++) {
                jsonobj = new JSONObject(dbpp.getActorPeliculasCuantas(argum.getString(j)));
                cant = jsonobj.getInt("resultado");
                res = res + ",{\"key\":\""+argum.getString(j)+"\",\"cantidad\":"+cant+"}";
            }
        }
        
        //obtenemos actores con edades mayor que edades[n], siendo n el último de la lista
        edad1 = Integer.parseInt(edadesS[edadesS.length - 1]);
        jsonobj = new JSONObject(dbp.getPersonasAnyosVividosLista(edad1,-1,cantidadS));
        argum = jsonobj.getJSONArray("lista");
        //obtenemos la cantidad de peliculas hechas para cada actor
        for(int j=0;j<argum.length();j++) {
            jsonobj = new JSONObject(dbpp.getActorPeliculasCuantas(argum.getString(j)));
            cant = jsonobj.getInt("resultado");
            res = res + ",{\"key\":\""+argum.getString(j)+"\",\"cantidad\":"+cant+"}";
        }
        //cerramos array
        res = res + "]}";
        
        return res;
    }
}
