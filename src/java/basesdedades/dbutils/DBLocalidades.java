/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package basesdedades.dbutils;

import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author mascport
 */
public class DBLocalidades {

    public String getLocalidades(String A) {
        String a = A;
        String res = "";
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select * from poblaciones where pais like '" + a + "';";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            res = "{\"resultado\":";
            res = res + "[";
            while (rs.next()) {
                res = res + "\"" + rs.getString("poblacion") + "\",";
                res = res + "\"" + rs.getFloat("lat") + "\",";
                res = res + "\"" + rs.getFloat("lon") + "\",";
            }
            res = res.substring(0, res.length() - 1);  // quito la última ','
            res = res + "]";
            res = res + "}";
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }
    
        public String getCuantasLocalidades(String A) {
        String res = "";
        long cont = 0;
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select count(poblacion) from poblaciones where (pais = '" + A + "');";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            cont = rs.getLong(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        res = "{\"resultado\":" + cont + "}";
        return res;
    }
}
