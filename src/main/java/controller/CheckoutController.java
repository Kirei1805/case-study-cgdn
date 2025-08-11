package controller;

import model.*;
import service.CartService;
import service.ICartService;
import service.OrderService;
import service.IOrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CheckoutController", urlPatterns = {"/checkout/*"})
public class CheckoutController extends HttpServlet {
    private ICartService cartService;
    private IOrderService orderService;
    
    @Override
    public void init() throws ServletException {
        cartService = new CartService();
        orderService = new OrderService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị trang checkout
            showCheckout(request, response);
        } else if (pathInfo.equals("/confirm")) {
            // Xác nhận đơn hàng
            confirmOrder(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void showCheckout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<CartItem> cartItems = cartService.getCartItemsByUserId(user.getId());
        
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Tính tổng tiền
        double total = cartItems.stream()
                .mapToDouble(item -> item.getSubtotal().doubleValue())
                .sum();
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);
        
        request.getRequestDispatcher("/WEB-INF/view/checkout.jsp").forward(request, response);
    }
    
    private void confirmOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Lấy thông tin địa chỉ từ form
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            
            // Validate dữ liệu
            if (fullName == null || fullName.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                city == null || city.trim().isEmpty()) {
                
                request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
                request.setAttribute("messageType", "danger");
                showCheckout(request, response);
                return;
            }
            
            // Lấy giỏ hàng
            List<CartItem> cartItems = cartService.getCartItemsByUserId(user.getId());
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Tính tổng tiền
            BigDecimal totalAmount = cartItems.stream()
                    .map(CartItem::getSubtotal)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Tạo đơn hàng
            Order order = new Order(user.getId(), 1, totalAmount); // address_id = 1 tạm thời
            
            // Tạo order items
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem cartItem : cartItems) {
                OrderItem orderItem = new OrderItem();
                orderItem.setPlantId(cartItem.getPlantId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setUnitPrice(cartItem.getPlant().getPrice());
                orderItems.add(orderItem);
            }
            
            // Lưu đơn hàng
            boolean success = orderService.createOrder(order, orderItems);
            
            if (success) {
                // Xóa giỏ hàng
                cartService.clearCart(user.getId());
                
                // Chuyển đến trang thành công
                request.setAttribute("orderId", order.getId());
                request.setAttribute("totalAmount", totalAmount);
                request.getRequestDispatcher("/WEB-INF/view/order-success.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Đặt hàng thất bại! Vui lòng thử lại.");
                request.setAttribute("messageType", "danger");
                showCheckout(request, response);
            }
            
        } catch (Exception e) {
            System.err.println("Lỗi khi đặt hàng: " + e.getMessage());
            request.setAttribute("message", "Có lỗi xảy ra! Vui lòng thử lại.");
            request.setAttribute("messageType", "danger");
            showCheckout(request, response);
        }
    }
} 