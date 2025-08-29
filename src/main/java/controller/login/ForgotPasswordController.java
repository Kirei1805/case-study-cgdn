package controller.login;

import service.user.UserService;
import service.user.UserServiceImpl;
import service.email.EmailService;
import service.email.EmailServiceImpl;
import service.auth.PasswordResetService;
import service.auth.PasswordResetServiceImpl;
import model.User;
import util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {
    private UserService userService;
    private EmailService emailService;
    private PasswordResetService passwordResetService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
        emailService = new EmailServiceImpl();
        passwordResetService = new PasswordResetServiceImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/reset-password".equals(servletPath)) {
            String token = request.getParameter("token");
            
            if (token == null || token.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/forgot-password?error=invalid_token");
                return;
            }
            
            // Verify token is valid and not expired
            if (!passwordResetService.isValidToken(token)) {
                request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn. Vui lòng yêu cầu một link mới.");
                request.getRequestDispatcher("/WEB-INF/view/login/forgot-password.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("token", token);
            request.getRequestDispatcher("/WEB-INF/view/login/reset-password.jsp").forward(request, response);
        } else {
            // Show forgot password form
            request.getRequestDispatcher("/WEB-INF/view/login/forgot-password.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/reset-password".equals(servletPath)) {
            handleResetPassword(request, response);
        } else {
            handleForgotPassword(request, response);
        }
    }
    
    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        // Validation
        if (!ValidationUtil.isNotEmpty(email)) {
            request.setAttribute("error", "Vui lòng nhập email");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/login/forgot-password.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidEmail(email.trim())) {
            request.setAttribute("error", "Email không đúng định dạng");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/view/login/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Check if email exists
        User user = userService.getUserByEmail(email.trim());
        
        // Always show success message for security (don't reveal if email exists)
        String successMessage = "Nếu email tồn tại trong hệ thống, chúng tôi đã gửi hướng dẫn đặt lại mật khẩu. " +
                               "Vui lòng kiểm tra email (kể cả thư mục spam) và làm theo hướng dẫn.";
        
        if (user != null) {
            // Generate and save reset token
            String resetToken = passwordResetService.createResetToken(user.getId());
            
            if (resetToken != null) {
                // Create reset link
                String resetLink = request.getScheme() + "://" + request.getServerName() + 
                                 (request.getServerPort() != 80 && request.getServerPort() != 443 ? ":" + request.getServerPort() : "") +
                                 request.getContextPath() + "/reset-password?token=" + resetToken;
                
                // Send email
                boolean emailSent = emailService.sendPasswordResetEmail(user.getEmail(), user.getFullName(), resetLink);
                
                if (!emailSent) {
                    // Log error but still show success message for security
                    System.err.println("Failed to send password reset email to: " + user.getEmail());
                }
            }
        }
        
        request.setAttribute("success", successMessage);
        request.getRequestDispatcher("/WEB-INF/view/login/forgot-password.jsp").forward(request, response);
    }
    
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validation
        if (!ValidationUtil.isNotEmpty(token)) {
            request.setAttribute("error", "Token không hợp lệ");
            request.getRequestDispatcher("/WEB-INF/view/login/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isNotEmpty(newPassword)) {
            request.setAttribute("error", "Vui lòng nhập mật khẩu mới");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/WEB-INF/view/login/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidPassword(newPassword)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ cái và số");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/WEB-INF/view/login/reset-password.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/WEB-INF/view/login/reset-password.jsp").forward(request, response);
            return;
        }
        
        // Reset password using the service
        boolean success = passwordResetService.resetPassword(token, newPassword);
        
        if (success) {
            request.setAttribute("success", "Mật khẩu đã được đặt lại thành công! Bạn có thể đăng nhập với mật khẩu mới.");
            request.getRequestDispatcher("/WEB-INF/view/login/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi đặt lại mật khẩu. Token có thể đã hết hạn hoặc đã được sử dụng.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/WEB-INF/view/login/reset-password.jsp").forward(request, response);
        }
    }
}
