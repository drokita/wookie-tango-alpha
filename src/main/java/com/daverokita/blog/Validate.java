package com.daverokita.blog;

import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;

public class Validate {

    public static boolean checkUser(String email, String password) {
        boolean validated = false;
        String hash = null;
        ResultSet rs = null;
        Connection con = dbConnection.createConnection();

        try {
            PreparedStatement ps = con.prepareStatement
                    ("select hash from USERS where email=?");
            ps.setString(1, email);
            rs = ps.executeQuery();
            rs.next();
            hash = rs.getString("hash");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        validated = BCrypt.checkpw(password, hash);

        return validated;
    }
}
