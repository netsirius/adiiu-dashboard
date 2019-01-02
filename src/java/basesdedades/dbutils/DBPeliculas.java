/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package basesdedades.dbutils;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author hectorsantos
 */
public class DBPeliculas {
    
        public String getRatingsPeliculas(int cantidadPeliculas) {
        String res = "";
        String cons = "";
        boolean first = true;
        ArrayList<String> aux = new ArrayList<>();
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select peliculas.originaltitle, ratingpelis.ratio,ratingpelis.votes from ratingpelis inner join peliculas on ratingpelis.tconst=peliculas.tconst order by ratingpelis.votes desc limit "+ cantidadPeliculas + ";";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                res = "{\"resultado\":";
                res = res + "[";
                while (rs.next()) {
                    res = res + "{\"originaltitle\":" + "\"" + rs.getString("originaltitle") + "\"" +",";
                    res = res + "\"ratio\":" + rs.getString("ratio") +",";
                    res = res + "\"votes\":" + rs.getString("votes") +"},";
                }
                res = res.substring(0, res.length() - 1);
                res = res + "]";
                res = res + "}";
            } else {
                res = res + "null";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }
    
}
