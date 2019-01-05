/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package basesdedades.dbutils;

import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.Year;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author mascport
 */
public class DBPersonas {

    public String getPersonasAnyosVividosLista(int edad1, int edad2, int cantidad) {
        int birthyear1 = LocalDateTime.now().getYear() - edad1;
        int birthyear2 = LocalDateTime.now().getYear() - edad2;
        String res = "";
        DBConnection dbc = new DBConnection();
        int nace;
        int muere;
        int vividos;
        res = "";
        int menorQueParam = 0;
        nace = muere = vividos = 0;
        try {
            dbc.open();
            String sql;
            if (edad2 != -1) {
                sql = "select primaryname from namebasics where birthyear <= " + birthyear1 + " and birthyear >=" + birthyear2 + " limit " + cantidad + ";";
            } else {
                sql = "select primaryname from namebasics where birthyear >= " + birthyear1 + " limit " + cantidad + ";";
            }
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            res = "";
            String lista = "";

            if (rs.next()) {
                lista = lista + "[" + rs.getString("primaryname");
                while (rs.next()) {
                    lista = lista + "," + rs.getString("primaryname");
                }
                lista = lista + "]";
            }

            if (edad2 != -1) {
                res = res + "{\"key\":\"" + edad1 + "-" + edad2 + "\",\"lista\": " + lista + "}";
            } else {
                res = res + "{\"key\":\"" + edad1 + " plus\",\"lista\": " + lista + "}";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }

    public String getPersonasAnyosVividos(int edad1, int edad2) {
        int birthyear1 = LocalDateTime.now().getYear() - edad1;
        int birthyear2 = LocalDateTime.now().getYear() - edad2;
        String res = "";
        DBConnection dbc = new DBConnection();
        int nace;
        int muere;
        int vividos;
        res = "";
        int menorQueParam = 0;
        nace = muere = vividos = 0;
        try {
            dbc.open();
            String sql;
            if (edad2 != -1) {
                sql = "select count(*) from namebasics where birthyear <= " + birthyear1 + " and birthyear >=" + birthyear2 + ";";
            } else {
                sql = "select count(*) from namebasics where birthyear >= " + birthyear1;
            }
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            res = "";
            int count = 0;
            if (rs.next()) {
                count = rs.getInt("count(*)");
            }
            if (edad2 != -1) {
                res = res + "{\"key\":\"" + edad1 + "-" + edad2 + "\",\"cantidad\": " + count + "}";
            } else {
                res = res + "{\"key\":\"" + edad1 + " plus\",\"cantidad\": " + count + "}";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }

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

    public String getActores(int cantidadPeliculas) {
        String res = "";
        String cons = "";
        boolean first = true;
        ArrayList<String> aux = new ArrayList<>();
        DBConnection dbc = new DBConnection();
        try {
            dbc.open();
            String sql = "select namebasics.primaryname from namebasics limit " + cantidadPeliculas + ";";
            Statement stmt = dbc.getConection().createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            res = "{\"resultado\":";
            res = res + "[";
            while (rs.next()) {
                res = res + "{\"primaryname\":" + "\"" + rs.getString("primaryname") + "\"" + "},";
            }
            res = res.substring(0, res.length() - 1);
            res = res + "]";
            res = res + "}";
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbc.close();
        }
        return res;
    }
}
