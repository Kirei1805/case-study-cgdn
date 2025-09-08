package repository.db;

import java.sql.*;

public class DBRepository {
	private static final String URL = "jdbc:mysql://localhost:3306/plant_shop?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "loiphan123";

	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection getConnection() throws SQLException {
		try {
			System.out.println("DEBUG: Attempting database connection...");
			Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			System.out.println("DEBUG: Database connection successful!");
			return conn;
		} catch (SQLException e) {
			System.out.println("DEBUG: Database connection failed:");
			e.printStackTrace();
			throw e;
		}
	}
} 