package controller.login;

import service.user.UserService;
import service.user.UserServiceImpl;
import model.User;
import util.ValidationUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/view/login/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        
        // Enhanced Validation
        StringBuilder errors = new StringBuilder();
        
        // Check required fields
        if (!ValidationUtil.isNotEmpty(username)) {
            errors.append("Tên đăng nhập không được để trống. ");
        } else if (!ValidationUtil.isValidUsername(username.trim())) {
            errors.append("Tên đăng nhập phải có 3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới. ");
        }
        
        if (!ValidationUtil.isNotEmpty(fullName)) {
            errors.append("Họ tên không được để trống. ");
        } else if (!ValidationUtil.isValidFullName(fullName.trim())) {
            errors.append("Họ tên phải có 2-50 ký tự và chỉ chứa chữ cái. ");
        }
        
        if (!ValidationUtil.isNotEmpty(email)) {
            errors.append("Email không được để trống. ");
        } else if (!ValidationUtil.isValidEmail(email.trim())) {
            errors.append("Email không đúng định dạng. ");
        }
        
        if (!ValidationUtil.isNotEmpty(password)) {
            errors.append("Mật khẩu không được để trống. ");
        } else if (!ValidationUtil.isValidPassword(password)) {
            errors.append("Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ cái và số. ");
        }
        
        if (!ValidationUtil.isNotEmpty(confirmPassword)) {
            errors.append("Xác nhận mật khẩu không được để trống. ");
        } else if (!password.equals(confirmPassword)) {
            errors.append("Mật khẩu xác nhận không khớp. ");
        }
        
        // Check if username already exists
        if (ValidationUtil.isNotEmpty(username) && ValidationUtil.isValidUsername(username.trim()) 
            && userService.isUsernameExists(username.trim())) {
            errors.append("Tên đăng nhập đã tồn tại. ");
        }
        
        // Check if email already exists
        if (ValidationUtil.isNotEmpty(email) && ValidationUtil.isValidEmail(email.trim()) 
            && userService.isEmailExists(email.trim())) {
            errors.append("Email đã được sử dụng. ");
        }
        
        // If there are validation errors
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString().trim());
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/WEB-INF/view/login/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User newUser = new User();
        newUser.setUsername(username.trim());
        newUser.setPassword(password);
        newUser.setEmail(email.trim());
        newUser.setFullName(fullName.trim());
        
        if (userService.register(newUser)) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/WEB-INF/view/login/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/WEB-INF/view/login/register.jsp").forward(request, response);
        }
    }
}
