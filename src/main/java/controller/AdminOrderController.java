package controller;

import model.Order;
import model.User;
import service.OrderService;
import service.IOrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderController", urlPatterns = {"/admin/orders/*"})
public class AdminOrderController extends HttpServlet {
    private IOrderService orderService;
    
    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị danh sách tất cả đơn hàng
            showAllOrders(request, response);
        } else if (pathInfo.startsWith("/detail/")) {
            // Hiển thị chi tiết đơn hàng
            String orderIdStr = pathInfo.substring(8); // Bỏ "/detail/"
            showOrderDetail(request, response, orderIdStr);
        } else if (pathInfo.startsWith("/update-status/")) {
            // Cập nhật trạng thái đơn hàng
            String orderIdStr = pathInfo.substring(14); // Bỏ "/update-status/"
            updateOrderStatus(request, response, orderIdStr);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void showAllOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Order> orders = orderService.getAllOrders();
        request.setAttribute("orders", orders);
        
        // Thống kê
        int totalOrders = orderService.getOrderCount();
        int pendingOrders = orderService.getPendingOrderCount();
        
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        
        request.getRequestDispatcher("/WEB-INF/view/admin/orders.jsp").forward(request, response);
    }
    
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, String orderIdStr) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderService.getOrderById(orderId);
            
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            request.setAttribute("order", order);
            request.getRequestDispatcher("/WEB-INF/view/admin/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response, String orderIdStr) 
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(orderIdStr);
            String newStatus = request.getParameter("status");
            
            if (newStatus == null || newStatus.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            boolean success = orderService.updateOrderStatus(orderId, newStatus);
            
            if (success) {
                request.setAttribute("message", "Cập nhật trạng thái đơn hàng thành công!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Cập nhật trạng thái đơn hàng thất bại!");
                request.setAttribute("messageType", "danger");
            }
            
            // Chuyển về trang chi tiết đơn hàng
            response.sendRedirect(request.getContextPath() + "/admin/orders/detail/" + orderId);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
} 