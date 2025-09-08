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
import util.ViewUtils;
import util.PaginationUtil;

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
        
        // Get filter parameters
        String statusFilter = req.getParameter("status");
        String fromDate = req.getParameter("fromDate");
        String toDate = req.getParameter("toDate");
        
        // Get pagination parameters
        String pageParam = req.getParameter("page");
        String sizeParam = req.getParameter("size");
        
        int page = 1;
        int size = 10; // Default page size for admin orders
        
        try {
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            if (sizeParam != null && !sizeParam.trim().isEmpty()) {
                size = Integer.parseInt(sizeParam);
                // Limit page size to reasonable values
                size = Math.min(Math.max(size, 1), 100);
            }
        } catch (NumberFormatException e) {
            // Use defaults if invalid numbers
        }
        
        // Get all orders
        List<Order> allOrders = orderService.getAllOrders();
        
        // Calculate statistics from all orders (before filtering)
        long pendingCount = allOrders.stream().filter(o -> "pending".equals(o.getStatus())).count();
        long processingCount = allOrders.stream().filter(o -> "processing".equals(o.getStatus())).count();
        long shippedCount = allOrders.stream().filter(o -> "shipped".equals(o.getStatus())).count();
        long cancelledCount = allOrders.stream().filter(o -> "cancelled".equals(o.getStatus())).count();
        
        // Apply status filter
        if (statusFilter != null && !statusFilter.isEmpty()) {
            allOrders = allOrders.stream()
                .filter(o -> statusFilter.equals(o.getStatus()))
                .collect(java.util.stream.Collectors.toList());
        }
        
        // TODO: Apply date filters when needed
        // Date filtering logic can be added here in the future
        
        // Create pagination
        PaginationUtil<Order> pagination = new PaginationUtil<>(allOrders, page, size);
        List<Order> orders = pagination.getPageItems();
        
        // Build other params for pagination links
        StringBuilder otherParams = new StringBuilder();
        if (statusFilter != null && !statusFilter.isEmpty()) {
            otherParams.append("status=").append(statusFilter);
        }
        if (fromDate != null && !fromDate.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("fromDate=").append(fromDate);
        }
        if (toDate != null && !toDate.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("toDate=").append(toDate);
        }
        if (sizeParam != null && !sizeParam.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("size=").append(size);
        }
        
        req.setAttribute("orders", orders);
        req.setAttribute("pendingCount", pendingCount);
        req.setAttribute("processingCount", processingCount);
        req.setAttribute("shippedCount", shippedCount);
        req.setAttribute("cancelledCount", cancelledCount);
        req.setAttribute("pagination", pagination);
        req.setAttribute("pageUrl", req.getContextPath() + "/admin/orders?");
        req.setAttribute("otherParams", otherParams.toString());
        
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

        // Calculate total items count in backend
        int totalItems = items.stream()
                .mapToInt(OrderItem::getQuantity)
                .sum();

        req.setAttribute("order", order);
        req.setAttribute("orderItems", items);
        req.setAttribute("totalItems", totalItems);
        
        // Add helper utilities for JSP
        req.setAttribute("viewUtils", new ViewUtils());
        
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

        // Check admin auth for POST
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !userService.isAdmin(user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        if ("updateStatus".equals(action)) {
            updateOrderStatus(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }

    private void updateOrderStatus(HttpServletRequest req, HttpServletResponse resp) 
            throws IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String newStatus = req.getParameter("status");
            
            // Validate status
            if (!isValidStatus(newStatus)) {
                resp.sendRedirect(req.getContextPath() + "/admin/orders?error=invalid_status");
                return;
            }
            
            boolean updated = orderService.updateOrderStatus(orderId, newStatus);
            
            if (updated) {
                resp.sendRedirect(req.getContextPath() + "/admin/orders?success=status_updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/orders?error=update_failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/orders?error=system_error");
        }
    }
    
    private boolean isValidStatus(String status) {
        return status != null && 
               (status.equals("pending") || status.equals("processing") || 
                status.equals("shipped") || status.equals("cancelled"));
    }
}
