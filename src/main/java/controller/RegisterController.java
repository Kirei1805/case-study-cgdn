package controller;

import model.User;
import service.IUserService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    private IUserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/plants");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validation
        if (username == null || username.trim().isEmpty()) {
            setError(request, response, "Tên đăng nhập không được để trống");
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            setError(request, response, "Email không được để trống");
            return;
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            setError(request, response, "Họ và tên không được để trống");
            return;
        }

        // Phone và address sẽ được thêm sau khi đăng ký thành công

        if (password == null || password.trim().isEmpty()) {
            setError(request, response, "Mật khẩu không được để trống");
            return;
        }

        if (!password.equals(confirmPassword)) {
            setError(request, response, "Mật khẩu xác nhận không khớp");
            return;
        }

        if (password.length() < 6) {
            setError(request, response, "Mật khẩu phải có ít nhất 6 ký tự");
            return;
        }

        try {
            // Kiểm tra username đã tồn tại chưa
            if (userService.isUsernameExists(username)) {
                setError(request, response, "Tên đăng nhập đã tồn tại");
                return;
            }

            // Tạo user mới
            User newUser = new User();
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setFullName(fullName);
            newUser.setPassword(password);
            newUser.setRole("customer"); // Mặc định là customer

            // Đăng ký user
            boolean success = userService.registerUser(newUser);
            
            if (success) {
                // Đăng ký thành công, chuyển đến trang đăng nhập
                request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.setAttribute("messageType", "success");
                request.getRequestDispatcher("/WEB-INF/view/loginPage.jsp").forward(request, response);
            } else {
                setError(request, response, "Đăng ký thất bại. Vui lòng thử lại.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            setError(request, response, "Có lỗi xảy ra: " + e.getMessage());
        }
    }

    private void setError(HttpServletRequest request, HttpServletResponse response, String message) 
            throws ServletException, IOException {
        request.setAttribute("message", message);
        request.setAttribute("messageType", "danger");
        // Giữ lại thông tin đã nhập
        request.setAttribute("username", request.getParameter("username"));
        request.setAttribute("email", request.getParameter("email"));
        request.setAttribute("fullName", request.getParameter("fullName"));
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }
} 