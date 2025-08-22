package controller.login;

import service.user.UserService;
import service.user.UserServiceImpl;
import model.User;
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
        
        // Validation
        if (username == null || password == null || confirmPassword == null || 
            email == null || fullName == null || 
            username.trim().isEmpty() || password.trim().isEmpty() || 
            confirmPassword.trim().isEmpty() || email.trim().isEmpty() || 
            fullName.trim().isEmpty()) {
            
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/WEB-INF/view/login/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/WEB-INF/view/login/register.jsp").forward(request, response);
            return;
        }
        
        if (userService.isUsernameExists(username.trim())) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại");
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
