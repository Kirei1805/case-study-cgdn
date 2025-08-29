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

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra đăng nhập + quyền admin
        if (user == null || !userService.isAdmin(user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "detail": {
                // Xem chi tiết đơn hàng
                int orderId = Integer.parseInt(req.getParameter("id"));
                Order order = orderService.getOrderById(orderId);
                List<OrderItem> items = orderService.getOrderItems(orderId);

                if (order == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/orders");
                    return;
                }

                req.setAttribute("order", order);
                req.setAttribute("orderItems", items);
                req.getRequestDispatcher("/WEB-INF/view/admin/order-detail.jsp")
                        .forward(req, resp);
                break;
            }

            case "delete": {
                // Xóa đơn hàng
                int orderId = Integer.parseInt(req.getParameter("id"));
                orderService.deleteOrder(orderId);
                resp.sendRedirect(req.getContextPath() + "/admin/orders");
                break;
            }

            default: {
                // Danh sách đơn hàng
                List<Order> orders = orderService.getAllOrders();
                req.setAttribute("orders", orders);
                req.getRequestDispatcher("/WEB-INF/view/admin/orders.jsp")
                        .forward(req, resp);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");

            // Chỉ cho phép update 4 trạng thái trong DB
            if (status.equals("pending") || status.equals("processing") ||
                    status.equals("shipped") || status.equals("cancelled")) {
                orderService.updateOrderStatus(orderId, status);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }
}
