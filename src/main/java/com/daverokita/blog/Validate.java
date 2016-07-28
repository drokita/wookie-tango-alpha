package com.daverokita.blog;

import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;
import java.security.NoSuchAlgorithmException;

public class Validate {
    public static boolean checkUser(String email, String password) {
        boolean validated = false;
        String hash;

        try {
            Class.forName("com.mysql.jdbc.Driver");

            //create conneciton with database
            Connection con = DriverManager.getConnection
                    ("jdbc:mysql://192.168.187.159:3306/blog", "blogadmin", "tech1200");
            PreparedStatement ps = con.prepareStatement
                    ("select hash from USERS where email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            rs.next();
            hash = rs.getString("hash");
            validated = BCrypt.checkpw(password, hash);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return validated;
    }
}
