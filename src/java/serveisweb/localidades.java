/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serveisweb;

import basesdedades.dbutils.DBLocalidades;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import meujson.MeuJson;

/**
 *
 * @author mascport
 */
@WebService(serviceName = "localidades")
public class localidades {

    /**
     * Web service operation
     */
    @WebMethod(operationName = "porpais")
    public String porpais(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["ES"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "";
        DBLocalidades dbl = new DBLocalidades();
        res = dbl.getLocalidades(pars[0].toLowerCase());
        return res;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "cuantospais")
    public String cuantospais(@WebParam(name = "param") String param) {
        //  Ejemplo:   ---->      param = {"param":["ES"]};
        String[] pars = MeuJson.getArguments(param);
        String res = "";
        DBLocalidades dbl = new DBLocalidades();
        res = dbl.getCuantasLocalidades(pars[0].toLowerCase());
        return res;
    }
}
