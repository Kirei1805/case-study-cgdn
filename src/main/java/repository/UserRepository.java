package repository;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;

public class UserRepository {
    
    public UserRepository() {
        // Không cần khởi tạo DBRepository nữa vì đã dùng static method
    }
    
    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi xác thực người dùng: " + e.getMessage());
        }
        return null;
    }
    
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy người dùng theo ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email, role, full_name) " +
                    "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getFullName());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi đăng ký người dùng: " + e.getMessage());
            return false;
        }
    }
    
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra username: " + e.getMessage());
        }
        return false;
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY id DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User user = mapResultSetToUser(rs);
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách người dùng: " + e.getMessage());
        }
        return users;
    }
    
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET username = ?, email = ?, role = ?, full_name = ? WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getRole());
            stmt.setString(4, user.getFullName());
            stmt.setInt(5, user.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật người dùng: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa người dùng: " + e.getMessage());
            return false;
        }
    }
    
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        user.setFullName(rs.getString("full_name"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        return user;
    }
} 