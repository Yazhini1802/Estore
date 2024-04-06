package com.estore;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserActions {
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/demo?useSSL=false","root","Yazhini@2712");
		return connection;
	
	}
	public boolean validate (String username,String password) throws ClassNotFoundException, SQLException {
		Connection con = getConnection();
		PreparedStatement ps = con.prepareStatement("select * from user where username = ? and Password = ? ");
		 ps.setString(1, username);
         ps.setString(2, password);
         
         System.out.println(ps);
         ResultSet rs = ps.executeQuery();
         boolean status = rs.next();
		return status;
	}
	public boolean userExist(User user) {
		if((phoneNumberExist(user.getPhone()))||(usernameExist(user.getUsername()))|| (emailExist(user.getEmail()))){
			return true;
		}
		return false;
	}
	
	public boolean phoneNumberExist(String phone) {
		try {
			Connection con =getConnection();
			String query = "select * from user where Phone =" +phone;
			PreparedStatement preparedStatement=con.prepareStatement(query);
			ResultSet rt = preparedStatement.executeQuery();
			if(rt.next()) {
				return true;
			}
			else {
				return false;
			}	
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public boolean usernameExist(String username) {
		try {
			Connection con =getConnection();
			String query = "select * from user where username =" +username;
			PreparedStatement preparedStatement=con.prepareStatement(query);
			ResultSet rt = preparedStatement.executeQuery();
			if(rt.next()) {
				return true;
			}
			else {
				return false;
			}
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
		}
	public boolean emailExist(String email) {
		try {
			Connection con =getConnection();
			String query = "select * from user where email = ";
			PreparedStatement preparedStatement=con.prepareStatement(query);
			ResultSet rt = preparedStatement.executeQuery();
			if(rt.next()) {
				return true;
			}
			else {
				return false;
			}
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return false;
		}
		
	
public int insertuser(User user) throws ClassNotFoundException {

		
			String INSERT_USER_SQL = "INSERT INTO user" + "(first_name,last_name,username,password,phone,email) VALUES"
		+"(?,?,?,?,?,?);";
			int result=0;
			Class.forName("com.mysql.cj.jdbc.Driver");
			try(Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/demo","root","Yazhini@2712");
			
				PreparedStatement preparedStatement=connection.prepareStatement(INSERT_USER_SQL)){
				preparedStatement.setString(1, user.getFirst_name());
				preparedStatement.setString(2, user.getLast_name());
				preparedStatement.setString(3, user.getUsername());
				preparedStatement.setString(4, user.getPassword());
				preparedStatement.setString(5, user.getPhone());
				preparedStatement.setString(6, user.getEmail());
				
				System.out.println(preparedStatement);
				result=preparedStatement.executeUpdate();
				
			}catch (SQLException e) {
				e.printStackTrace();
			}
			return result;
}
}
