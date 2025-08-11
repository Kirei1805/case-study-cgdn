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

@WebServlet(name = "OrderController", urlPatterns = {"/orders/*"})
public class OrderController extends HttpServlet {
    private IOrderService orderService;
    
    @Override
    public void init() throws ServletException {
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị danh sách đơn hàng của khách hàng
            showUserOrders(request, response);
        } else if (pathInfo.startsWith("/detail/")) {
            // Hiển thị chi tiết đơn hàng
            String orderIdStr = pathInfo.substring(8); // Bỏ "/detail/"
            showOrderDetail(request, response, orderIdStr);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void showUserOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<Order> orders = orderService.getOrdersByUserId(user.getId());
        request.setAttribute("orders", orders);
        
        request.getRequestDispatcher("/WEB-INF/view/user-orders.jsp").forward(request, response);
    }
    
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, String orderIdStr) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            Order order = orderService.getOrderById(orderId);
            
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            // Kiểm tra xem đơn hàng có thuộc về user này không
            if (order.getUserId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            
            request.setAttribute("order", order);
            request.getRequestDispatcher("/WEB-INF/view/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
} 