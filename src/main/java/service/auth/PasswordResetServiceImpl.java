package service.auth;

import repository.db.DBRepository;
import service.user.UserService;
import service.user.UserServiceImpl;
import org.mindrot.jbcrypt.BCrypt;

import java.security.SecureRandom;
import java.sql.*;
import java.time.LocalDateTime;

public class PasswordResetServiceImpl implements PasswordResetService {
    
    private final UserService userService;
    
    public PasswordResetServiceImpl() {
        this.userService = new UserServiceImpl();
    }
    
    @Override
    public String createResetToken(int userId) {
        String token = generateSecureToken();
        LocalDateTime expiresAt = LocalDateTime.now().plusMinutes(15); // 15 minutes expiry
        
        String sql = "INSERT INTO password_reset_tokens (user_id, token, expires_at) VALUES (?, ?, ?)";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, token);
            stmt.setTimestamp(3, Timestamp.valueOf(expiresAt));
            
            int result = stmt.executeUpdate();
            return result > 0 ? token : null;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    @Override
    public boolean isValidToken(String token) {
        String sql = "SELECT id FROM password_reset_tokens WHERE token = ? AND expires_at > NOW() AND used = FALSE";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public int getUserIdByToken(String token) {
        String sql = "SELECT user_id FROM password_reset_tokens WHERE token = ? AND expires_at > NOW() AND used = FALSE";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("user_id");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    @Override
    public boolean markTokenAsUsed(String token) {
        String sql = "UPDATE password_reset_tokens SET used = TRUE WHERE token = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, token);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean resetPassword(String token, String newPassword) {
        // Verify token is valid
        int userId = getUserIdByToken(token);
        if (userId == -1) {
            return false;
        }
        
        Connection conn = null;
        try {
            conn = DBRepository.getConnection();
            conn.setAutoCommit(false);
            
            // Hash new password
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            
            // Update password
            String updatePasswordSql = "UPDATE users SET password = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updatePasswordSql)) {
                stmt.setString(1, hashedPassword);
                stmt.setInt(2, userId);
                stmt.executeUpdate();
            }
            
            // Mark token as used
            String markTokenSql = "UPDATE password_reset_tokens SET used = TRUE WHERE token = ?";
            try (PreparedStatement stmt = conn.prepareStatement(markTokenSql)) {
                stmt.setString(1, token);
                stmt.executeUpdate();
            }
            
            conn.commit();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    @Override
    public void cleanupExpiredTokens() {
        String sql = "DELETE FROM password_reset_tokens WHERE expires_at < NOW() OR used = TRUE";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            int deleted = stmt.executeUpdate();
            System.out.println("Cleaned up " + deleted + " expired/used reset tokens");
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private String generateSecureToken() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[32]; // 256 bits
        random.nextBytes(bytes);
        
        StringBuilder token = new StringBuilder();
        for (byte b : bytes) {
            token.append(String.format("%02x", b));
        }
        return token.toString();
    }
}





