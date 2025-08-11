package controller;

import model.CartItem;
import model.User;
import service.CartService;
import service.ICartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartController", urlPatterns = {"/cart/*"})
public class CartController extends HttpServlet {
    private ICartService cartService;
    
    @Override
    public void init() throws ServletException {
        cartService = new CartService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Hiển thị giỏ hàng
            showCart(request, response);
        } else if (pathInfo.equals("/add")) {
            // Thêm vào giỏ hàng
            addToCart(request, response);
        } else if (pathInfo.equals("/update")) {
            // Cập nhật số lượng
            updateQuantity(request, response);
        } else if (pathInfo.equals("/remove")) {
            // Xóa khỏi giỏ hàng
            removeFromCart(request, response);
        } else if (pathInfo.equals("/clear")) {
            // Xóa toàn bộ giỏ hàng
            clearCart(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void showCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<CartItem> cartItems = cartService.getCartItemsByUserId(user.getId());
        request.setAttribute("cartItems", cartItems);
        
        // Tính tổng tiền
        double total = cartItems.stream()
                .mapToDouble(item -> item.getSubtotal().doubleValue())
                .sum();
        request.setAttribute("total", total);
        
        request.getRequestDispatcher("/WEB-INF/view/cart.jsp").forward(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int plantId = Integer.parseInt(request.getParameter("plantId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            boolean success = cartService.addToCart(user.getId(), plantId, quantity);
            
            if (success) {
                request.setAttribute("message", "Đã thêm vào giỏ hàng thành công!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Thêm vào giỏ hàng thất bại!");
                request.setAttribute("messageType", "danger");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Dữ liệu không hợp lệ!");
            request.setAttribute("messageType", "danger");
        }
        
        // Chuyển về trang chi tiết sản phẩm
        String plantId = request.getParameter("plantId");
        response.sendRedirect(request.getContextPath() + "/plants/detail/" + plantId);
    }
    
    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            
            boolean success = cartService.updateCartItemQuantity(cartItemId, newQuantity);
            
            if (success) {
                request.setAttribute("message", "Cập nhật số lượng thành công!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Cập nhật số lượng thất bại!");
                request.setAttribute("messageType", "danger");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Dữ liệu không hợp lệ!");
            request.setAttribute("messageType", "danger");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            
            boolean success = cartService.removeFromCart(cartItemId);
            
            if (success) {
                request.setAttribute("message", "Đã xóa sản phẩm khỏi giỏ hàng!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Xóa sản phẩm thất bại!");
                request.setAttribute("messageType", "danger");
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Dữ liệu không hợp lệ!");
            request.setAttribute("messageType", "danger");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        boolean success = cartService.clearCart(user.getId());
        
        if (success) {
            request.setAttribute("message", "Đã xóa toàn bộ giỏ hàng!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Xóa giỏ hàng thất bại!");
            request.setAttribute("messageType", "danger");
        }
        
        response.sendRedirect(request.getContextPath() + "/cart");
    }
} 