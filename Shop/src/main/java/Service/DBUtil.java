package Service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
//		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		String url = "jdbc:mariadb://3.35.235.217:3306/shop";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(url, dbuser, dbpw);
		return conn;
	}
}