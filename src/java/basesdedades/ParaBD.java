/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package basesdedades;

import meujson.MeuJson;

/**
 *
 * @author mascport
 */
public class ParaBD {

    private void inicio() {
        String js = "{\"param\":[\"Maria\",\"1234.35\",\"Antoni\",\"15674\"]}";
        String[] pars = MeuJson.getArguments(js);
        for (int i = 0; i < pars.length; i++) {
            System.out.println(pars[i]);
        }
    }

    public static void main(String[] args) {
        (new ParaBD()).inicio();
    }

}
