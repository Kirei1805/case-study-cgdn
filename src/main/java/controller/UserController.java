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
import java.util.List;

@WebServlet("/admin/users")
public class UserController extends HttpServlet {
    private IUserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null || 
            !"admin".equalsIgnoreCase((String) session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<User> users = userService.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/WEB-INF/view/list-users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null || 
            !"admin".equalsIgnoreCase((String) session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteUser(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            if (userService.deleteUser(id)) {
                response.sendRedirect(request.getContextPath() + "/admin/users?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users?error=delete");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
} 