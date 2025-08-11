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

@WebServlet("/login")
public class LoginController extends HttpServlet {
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
            String userRole = (String) session.getAttribute("userRole");
            if ("admin".equalsIgnoreCase(userRole)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/plants");
            }
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/view/loginPage.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || 
            username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập");
            request.getRequestDispatcher("/WEB-INF/view/loginPage.jsp").forward(request, response);
            return;
        }
        
        User user = userService.authenticate(username.trim(), password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user.getUsername());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userId", user.getId());
            session.setAttribute("userFullName", user.getFullName());

            if (user.isAdmin()) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/plants");
            }
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/WEB-INF/view/loginPage.jsp").forward(request, response);
        }
    }
} 