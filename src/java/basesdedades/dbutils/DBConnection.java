/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package basesdedades.dbutils;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author miquel
 */
public class DBConnection {

    private Connection con;

    public DBConnection() {
        con = null;
    }

    public void open() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://"
                    + DBProperties.host + ":" + DBProperties.port
                    + "/" + DBProperties.db, DBProperties.user, DBProperties.pass);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void close() {
        try {
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public Connection getConection() {
        return con;
    }
}
