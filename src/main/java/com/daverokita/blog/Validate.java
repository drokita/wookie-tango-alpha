package com.daverokita.blog;

import java.sql.*;

public class Validate {
    public static boolean checkUser(String email, String password) {
        boolean st = false;
        try {
            Class.forName("com.mysql.jdbc.Driver");

            //create conneciton with database
            Connection con = DriverManager.getConnection
                    ("jdbc:mysql://192.168.187.159:3306/blog", "blogadmin", "tech1200");
            PreparedStatement ps = con.prepareStatement
                    ("select * from USERS where email=? and password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            st = rs.next();
        } catch(Exception e) {
            e.printStackTrace();
        }

        return st;
    }
}
