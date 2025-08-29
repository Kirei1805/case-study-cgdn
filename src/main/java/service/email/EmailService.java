package service.email;

public interface EmailService {
    boolean sendPasswordResetEmail(String toEmail, String userName, String resetLink);
    boolean sendWelcomeEmail(String toEmail, String userName);
    boolean sendOrderConfirmationEmail(String toEmail, String userName, String orderId, double totalAmount);
}


