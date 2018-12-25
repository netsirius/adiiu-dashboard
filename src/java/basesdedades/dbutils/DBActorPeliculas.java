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
 * @author mascport
 */
public class DBActorPeliculas {

    public String getActorPeliculas(String A) {
        String a = A;
        String res = "";
        String cons = "";
        boolean first = true;
        ArrayList<String> aux = new ArrayList<>();
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select * from namebasics where primaryname like '" + a + "';";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                cons = rs.getString("nconst");
                sql = "select * from personapeli where nconst = '" + cons + "';";
                rs = stmt.executeQuery(sql);
                while (rs.next()) {
                    aux.add(rs.getString("tconst"));
                }
                ArrayList<String> temp = new ArrayList<>();
                for (int j = 0; j < aux.size(); j++) {
                    sql = "select * from peliculas where tconst = '" + aux.get(j) + "';";
                    rs = stmt.executeQuery(sql);
                    if (rs.next()) {
                        temp.add(rs.getString("originaltitle"));
                    }
                }
                aux = temp;
                res = "{\"resultado\":";
                res = res + "[";
                for (int i = 0; i < aux.size(); i++) {
                    if (!first) {
                        res = res + ",";
                    } else {
                        first = false;
                    }
                    res = res + "\"" + aux.get(i) + "\"";
                }
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

    public String getActorPeliculasCuantas(String A) {
        String a = A;
        String res = "";
        String cons = "";
        boolean first = true;
        ArrayList<String> aux = new ArrayList<>();
        DBConnection dbc = new DBConnection();
        long cont;
        try {
            dbc.open();
            String sql = "select * from namebasics where primaryname like '" + a + "';";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            cont = 0;
            if (rs.next()) {
                cons = rs.getString("nconst");
                sql = "select count(tconst) from personapeli where (nconst = '" + cons + "');";
                rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    cont = rs.getLong(1);
                }
            }
            res = "{\"resultado\":";
            res = res + cont;
            res = res + "}";
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }
}
