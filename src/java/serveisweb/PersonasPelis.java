/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serveisweb;

import basesdedades.dbutils.DBActorPeliculas;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import meujson.MeuJson;

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
        String res = "null";
        DBActorPeliculas dbap = new DBActorPeliculas();
        if (pars[0].contentEquals("cuantas")) {
            res = dbap.getActorPeliculasCuantas(pars[1]);
        } else if (pars[0].contentEquals("lista")) {
            res = dbap.getActorPeliculas(pars[1]);
        }
        return res;
    }
}
