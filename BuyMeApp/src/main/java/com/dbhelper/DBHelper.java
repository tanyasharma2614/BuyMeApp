
package com.dbhelper;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBHelper {
	
	public Connection getConnection(){
		
		//Create a connection string
		String connectionUrl = "jdbc:mysql://localhost:3306/buyme";
		Connection connection = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(connectionUrl,"root", "root123");
			if(connection != null){
				System.out.println("Connection Successful!");
			}else{
				System.out.println("Failed to make connection!");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	
	
	public static void main(String[] args) {
		DBHelper dao = new DBHelper();
		Connection connection = dao.getConnection();
		
//		System.out.println(connection);		
		dao.closeConnection(connection);
	}
	
	

}
