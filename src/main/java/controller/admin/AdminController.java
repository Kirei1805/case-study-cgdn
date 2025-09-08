package controller.admin;

import model.User;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.plant.PlantService;
import service.plant.PlantServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private UserService userService;
    private OrderService orderService;
    private PlantService plantService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
        orderService = new OrderServiceImpl();
        plantService = new PlantServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !userService.isAdmin(user)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ✅ Lấy dữ liệu từ DB qua service
        int totalOrders = orderService.getAllOrders().size();
        int totalUsers = userService.getAllUsers().size();
        int totalProducts = plantService.getAllPlants().size();
        long newOrders = orderService.getAllOrders()
                .stream()
                .filter(o -> "pending".equals(o.getStatus()))
                .count();

        // ✅ Đẩy sang JSP
        request.setAttribute("adminUser", user);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("pendingOrders", newOrders);
        request.setAttribute("recentOrders", orderService.getAllOrders());

        request.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp").forward(request, response);
    }
}

