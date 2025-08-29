package controller.admin;

import model.User;
import model.Order;
import model.OrderItem;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderController extends HttpServlet {
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

        // Kiểm tra quyền admin
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !userService.isAdmin(user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "detail":
                    showOrderDetail(req, resp);
                    break;
                case "delete":
                    deleteOrder(req, resp);
                    break;
                default:
                    showOrderList(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi trong quá trình xử lý: " + e.getMessage());
        }
    }

    private void showOrderList(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        List<Order> orders = orderService.getAllOrders();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/view/admin/orders.jsp").forward(req, resp);
    }

    private void showOrderDetail(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("id"));
        Order order = orderService.getOrderById(orderId);
        List<OrderItem> items = orderService.getOrderItems(orderId);

        if (order == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
            return;
        }

        req.setAttribute("order", order);
        req.setAttribute("orderItems", items);
        req.getRequestDispatcher("/WEB-INF/view/admin/order-detail.jsp").forward(req, resp);
    }

    private void deleteOrder(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        int orderId = Integer.parseInt(req.getParameter("id"));
        orderService.deleteOrder(orderId);
        resp.sendRedirect(req.getContextPath() + "/admin/orders");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("updateStatus".equals(action)) {
            updateOrderStatus(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }

    private void updateOrderStatus(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        int orderId = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");
        
        orderService.updateOrderStatus(orderId, status);
        resp.sendRedirect(req.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
    }
}
