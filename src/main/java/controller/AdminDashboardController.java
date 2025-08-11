package controller;

import model.User;
import service.IPlantService;
import service.IUserService;
import service.PlantService;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardController extends HttpServlet {
    private IPlantService plantService;
    private IUserService userService;

    @Override
    public void init() throws ServletException {
        plantService = new PlantService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int totalPlants = plantService.getAllPlants().size();
            int totalUsers = userService.getAllUsers().size();
            int newOrders = 0;
            int lowStockPlants = plantService.getLowStockPlants().size();

            List<User> allUsers = userService.getAllUsers();
            int customerCount = 0;
            int adminCount = 0;
            int newUsersToday = 0;

            for (User u : allUsers) {
                if ("customer".equals(u.getRole())) {
                    customerCount++;
                } else if ("admin".equals(u.getRole())) {
                    adminCount++;
                }
                newUsersToday = allUsers.size();
            }
            request.setAttribute("totalPlants", totalPlants);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("newOrders", newOrders);
            request.setAttribute("lowStockPlants", lowStockPlants);
            request.setAttribute("customerCount", customerCount);
            request.setAttribute("adminCount", adminCount);
            request.setAttribute("newUsersToday", newUsersToday);


            request.getRequestDispatcher("/WEB-INF/view/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 