package repository;

import java.sql.*;

public class DBRepository {
	private static final String URL = "jdbc:mysql://localhost:3306/plant_shop?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "123456";

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}
} 