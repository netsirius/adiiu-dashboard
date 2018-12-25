/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package meujson;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author mascport
 */
public class MeuJson {
    static public String[] getArguments(String s) {
        JSONObject jsonobj = new JSONObject(s);
        JSONArray argum = jsonobj.getJSONArray("param");
        String[] res = new String[argum.length()];
        for(int i=0;i<argum.length();i++) {
            res[i] = argum.getString(i);
        }
        return res;
    }
}
