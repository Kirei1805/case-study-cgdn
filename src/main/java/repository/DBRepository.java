package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBRepository {
    private static final String jdbcURL = "jdbc:mysql://localhost:3306/plant_shop?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String jdbcUsername = "root";
    private static final String jdbcPassword = "loiphan123";
    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            System.out.println("Kết nối database thành công!");
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Lỗi kết nối database: " + e.getMessage());
        }
    }

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                System.out.println("Tạo kết nối database mới thành công!");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo kết nối database: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
    
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Đã đóng kết nối database");
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng kết nối database: " + e.getMessage());
            }
        }
    }
} 