package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbSet {
	public static Connection getConnection() {
		String url= "jdbc:oracle:thin:@localhost:1521:XE";
		String vUser = "hr";
		String vPassword = "hr";
		Connection conn = null;
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url, vUser, vPassword);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
}
