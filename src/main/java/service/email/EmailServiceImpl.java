package service.email;

import java.util.logging.Logger;

/**
 * Email service implementation
 * Trong môi trường demo, chỉ log email thay vì gửi thật
 * Để gửi email thật, cần cấu hình SMTP server và JavaMail
 */
public class EmailServiceImpl implements EmailService {
    
    private static final Logger logger = Logger.getLogger(EmailServiceImpl.class.getName());
    
    // Email configuration - trong production sẽ đọc từ config file
    private static final String FROM_EMAIL = "loiphan1805@gmil.com";
    private static final String FROM_NAME = "Plant Shop";
    
    @Override
    public boolean sendPasswordResetEmail(String toEmail, String userName, String resetLink) {
        try {
            String subject = "Đặt lại mật khẩu - Plant Shop";
            String emailContent = createPasswordResetEmailContent(userName, resetLink);
            
            // Trong demo, chỉ log email content
            logEmail(toEmail, subject, emailContent);
            
            // Trong production, thay bằng JavaMail để gửi email thật
            // return sendEmailWithJavamail(toEmail, subject, emailContent);
            
            return true;
            
        } catch (Exception e) {
            logger.severe("Error sending password reset email: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean sendWelcomeEmail(String toEmail, String userName) {
        try {
            String subject = "Chào mừng đến với Plant Shop!";
            String emailContent = createWelcomeEmailContent(userName);
            
            logEmail(toEmail, subject, emailContent);
            return true;
            
        } catch (Exception e) {
            logger.severe("Error sending welcome email: " + e.getMessage());
            return false;
        }
    }
    
    @Override
    public boolean sendOrderConfirmationEmail(String toEmail, String userName, String orderId, double totalAmount) {
        try {
            String subject = "Xác nhận đơn hàng #" + orderId + " - Plant Shop";
            String emailContent = createOrderConfirmationEmailContent(userName, orderId, totalAmount);
            
            logEmail(toEmail, subject, emailContent);
            return true;
            
        } catch (Exception e) {
            logger.severe("Error sending order confirmation email: " + e.getMessage());
            return false;
        }
    }
    
    private void logEmail(String toEmail, String subject, String content) {
        System.out.println("=== EMAIL DEMO ===");
        System.out.println("From: " + FROM_NAME + " <" + FROM_EMAIL + ">");
        System.out.println("To: " + toEmail);
        System.out.println("Subject: " + subject);
        System.out.println("--- Content ---");
        System.out.println(content);
        System.out.println("=== END EMAIL ===");
        
        logger.info("Email sent to: " + toEmail + " with subject: " + subject);
    }
    
    private String createPasswordResetEmailContent(String userName, String resetLink) {
        StringBuilder html = new StringBuilder();
        html.append("<!DOCTYPE html>");
        html.append("<html>");
        html.append("<head><meta charset='UTF-8'>");
        html.append("<style>");
        html.append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }");
        html.append(".container { max-width: 600px; margin: 0 auto; padding: 20px; }");
        html.append(".header { background: #28a745; color: white; padding: 20px; text-align: center; border-radius: 5px 5px 0 0; }");
        html.append(".content { background: #f8f9fa; padding: 30px; border-radius: 0 0 5px 5px; }");
        html.append(".button { display: inline-block; background: #28a745; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; margin: 20px 0; }");
        html.append(".security-notice { background: #fff3cd; border: 1px solid #ffeaa7; padding: 15px; margin: 20px 0; border-radius: 5px; }");
        html.append("</style></head>");
        html.append("<body>");
        html.append("<div class='container'>");
        html.append("<div class='header'>");
        html.append("<h1>🌱 Plant Shop</h1>");
        html.append("<p>Đặt lại mật khẩu</p>");
        html.append("</div>");
        html.append("<div class='content'>");
        html.append("<h2>Xin chào ").append(userName).append("!</h2>");
        html.append("<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn.</p>");
        html.append("<p>Nhấn vào nút bên dưới để đặt lại mật khẩu:</p>");
        html.append("<div style='text-align: center;'>");
        html.append("<a href='").append(resetLink).append("' class='button'>Đặt lại mật khẩu</a>");
        html.append("</div>");
        html.append("<div class='security-notice'>");
        html.append("<strong>⚠️ Lưu ý bảo mật:</strong>");
        html.append("<ul>");
        html.append("<li>Link này chỉ có hiệu lực trong <strong>15 phút</strong></li>");
        html.append("<li>Nếu bạn không yêu cầu đặt lại mật khẩu, hãy bỏ qua email này</li>");
        html.append("<li>Không chia sẻ link này với bất kỳ ai</li>");
        html.append("</ul>");
        html.append("</div>");
        html.append("<p>Nếu nút không hoạt động, bạn có thể copy link sau vào trình duyệt:</p>");
        html.append("<p style='word-break: break-all; background: #e9ecef; padding: 10px; font-family: monospace;'>").append(resetLink).append("</p>");
        html.append("<p>Cảm ơn bạn đã sử dụng Plant Shop!</p>");
        html.append("<p><strong>Đội ngũ Plant Shop</strong></p>");
        html.append("</div>");
        html.append("<div style='text-align: center; margin-top: 20px; font-size: 12px; color: #666;'>");
        html.append("<p>© 2024 Plant Shop. Tất cả quyền được bảo lưu.</p>");
        html.append("<p>📞 Hotline: 0909 123 456 | 📧 Email: support@plantshop.com</p>");
        html.append("</div>");
        html.append("</div>");
        html.append("</body></html>");
        
        return html.toString();
    }
    
    private String createWelcomeEmailContent(String userName) {
        return "<h2>Chào mừng " + userName + " đến với Plant Shop!</h2>" +
               "<p>Cảm ơn bạn đã đăng ký tài khoản. Chúng tôi rất vui khi bạn tham gia cộng đồng yêu cây cảnh!</p>";
    }
    
    private String createOrderConfirmationEmailContent(String userName, String orderId, double totalAmount) {
        return "<h2>Xin chào " + userName + "!</h2>" +
               "<p>Đơn hàng #" + orderId + " của bạn đã được xác nhận.</p>" +
               "<p>Tổng tiền: " + String.format("%,.0f", totalAmount) + " VNĐ</p>" +
               "<p>Thời gian giao hàng dự kiến: 2-3 ngày làm việc</p>";
    }
}