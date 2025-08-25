package controller.admin;

import model.User;
import model.Order;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
    private UserService userService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        userService = new UserServiceImpl();
        orderService = new OrderServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !userService.isAdmin(user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Order> recentOrders = orderService.getAllOrders();

        req.setAttribute("recentOrders", recentOrders);
        req.setAttribute("totalOrders", recentOrders.size());
        req.setAttribute("totalUsers", userService.getAllUsers().size());
        req.setAttribute("pendingOrders", recentOrders.stream()
                .filter(o -> "pending".equals(o.getStatus())).count());
        req.setAttribute("totalProducts", 13); // TODO: lấy từ ProductService

        req.setAttribute("adminUser", user);
        req.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp").forward(req, resp);
    }
}
