package service.auth;

public interface PasswordResetService {
    String createResetToken(int userId);
    boolean isValidToken(String token);
    int getUserIdByToken(String token);
    boolean markTokenAsUsed(String token);
    boolean resetPassword(String token, String newPassword);
    void cleanupExpiredTokens();
}






