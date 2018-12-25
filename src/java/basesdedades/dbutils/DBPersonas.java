/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package basesdedades.dbutils;

import java.sql.ResultSet;
import java.sql.Statement;
import java.time.Year;
import java.util.ArrayList;

/**
 *
 * @author mascport
 */
public class DBPersonas {

    public String getAnyosVividos(String A) {
        String a = A;
        String res = "";
        DBConnection dbc = new DBConnection();
        int nace;
        int muere;
        int vividos;
        nace = muere = vividos = 0;
        try {
            dbc.open();
            String sql = "select * from namebasics where primaryname like '" + a + "';";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            res = "{\"resultado\":";
            if (rs.next()) {
                nace = rs.getInt("birthyear");
                muere = rs.getInt("deathyear");
                if (muere != -1) {
                    vividos = muere - nace;
                } else {
                    vividos = (Year.now().getValue()) - nace;
                }
                res = res + vividos;
            } else {
                res = res + "null";
            }
            res = res + "}";
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }

    public String getActoreNacioMurio(String A) {
        String a = A;
        String res = "";
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select * from namebasics where primaryname like '" + a + "';";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            res = "{\"resultado\":";
            res = res + "[";
            if (rs.next()) {
                res = res + "{\"nace\":" + Integer.toString(rs.getInt("birthyear")) + "},"
                        + "{\"muere\":" + Integer.toString(rs.getInt("deathyear")) + "}";
            } else {
                res = res + "null";
            }
            res = res + "]";
            res = res + "}";
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }

    public String getActoresMuertosEn(String A) {
        return getActoresMuertosEnDeA(A, 0, Long.MAX_VALUE);
    }

    public String getActoresMuertosEnDeA(String A, long min, long max) {
        int a = Integer.parseInt(A);
        boolean first = true;
        String res = "";
        long cont = 0;
        ArrayList<String> aux = new ArrayList<>();
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select * from namebasics where (deathyear = " + a
                    + ");";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while ((rs.next()) && (cont <= max)) {
                if (cont >= min) {
                    aux.add(rs.getString("primaryname"));
                }
                cont++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        res = "{\"resultado\":";
        res = res + "[";
        for (int i = 0; i < aux.size(); i++) {
            if (!first) {
                res = res + ",";
            } else {
                first = false;
            }
            res = res + "{\"nom\":\"" + aux.get(i) + "\"}";
        }
        res = res + "]";
        res = res + "}";
        return res;
    }

    public String getCuantosActoresMuertosEn(String A) {
        int a = Integer.parseInt(A);
        String res = "";
        long cont = 0;
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select count(nconst) from namebasics where (deathyear = " + a + ");";
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

    public String getActoresNacidosEn(String A) {
        return getActoresNacidosEnDeA(A, 0, Long.MAX_VALUE);
    }

    public String getActoresNacidosEnDeA(String A, long min, long max) {
        int a = Integer.parseInt(A);
        boolean first = true;
        String res = "";
        long cont = 0;
        ArrayList<String> aux = new ArrayList<>();
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select * from namebasics where (birthyear = " + a
                    + ");";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while ((rs.next()) && (cont <= max)) {
                if (cont >= min) {
                    aux.add(rs.getString("primaryname"));
                }
                cont++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        res = "{\"resultado\":";
        res = res + "[";
        for (int i = 0; i < aux.size(); i++) {
            if (!first) {
                res = res + ",";
            } else {
                first = false;
            }
            res = res + "{\"nom\":\"" + aux.get(i) + "\"}";
        }
        res = res + "]";
        res = res + "}";
        return res;
    }

    public String getCuantosActoresNacidosEn(String A) {
        int a = Integer.parseInt(A);
        String res = "";
        long cont = 0;
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select count(nconst) from namebasics where (birthyear = " + a + ");";
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

    public String getActoresSeLlaman(String A) {
        return getActoresSeLlaman(A, 0, Long.MAX_VALUE);
    }

    public String getActoresSeLlaman(String A, long min, long max) {
        String a = A;
        boolean first = true;
        String res = "";
        long cont = 0;
        ArrayList<String> aux = new ArrayList<>();
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select * from namebasics where primaryname like '%" + a
                    + "%';";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while ((rs.next()) && (cont <= max)) {
                if (cont >= min) {
                    aux.add(rs.getString("primaryname"));
                }
                cont++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        res = "{\"resultado\":";
        res = res + "[";
        for (int i = 0; i < aux.size(); i++) {
            if (!first) {
                res = res + ",";
            } else {
                first = false;
            }
            res = res + "{\"nom\":\"" + aux.get(i) + "\"}";
        }
        res = res + "]";
        res = res + "}";
        return res;
    }

    public String getCuantosActoresSeLlaman(String A) {
        String a = A;
        String res = "";
        long cont = 0;
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select count(nconst) from namebasics where primaryname like '%" + a + "%';";
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
