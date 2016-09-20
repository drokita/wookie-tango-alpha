package com.daverokita.blog;

import java.sql.Connection;
import java.sql.DriverManager;

public class dbConnection {
    public static Connection createConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //create conneciton with database
            con = DriverManager.getConnection
                    ("jdbc:mysql://192.168.187.159:3306/blog", "blogadmin", "tech1200");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
