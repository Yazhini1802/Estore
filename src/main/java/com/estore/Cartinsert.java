package com.estore;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Cartinsert {
  
    public void addToCart(int productid, int quantity) throws ClassNotFoundException {
    	UserActions ua=new UserActions();
		try {
			Connection con=ua.getConnection();
            String sql = "INSERT INTO cart (productid, quantity) VALUES (?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, productid);
                stmt.setInt(2, quantity);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle any exceptions
        }
    }
}
