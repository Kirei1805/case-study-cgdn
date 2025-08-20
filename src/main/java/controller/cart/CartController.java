package controller.cart;

import service.CartService;
import model.CartItem;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.math.BigDecimal;

@WebServlet("/cart/*")
public class CartController extends HttpServlet {
    private CartService cartService;

    @Override
    public void init() throws ServletException {
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<CartItem> cartItems = cartService.getCartItems(user.getId());
        BigDecimal total = cartService.calculateTotal(cartItems);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);
        
        request.getRequestDispatcher("/WEB-INF/view/cart/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addToCart(request, response, user.getId());
        } else if ("update".equals(action)) {
            updateCartItem(request, response);
        } else if ("remove".equals(action)) {
            removeFromCart(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        
        String plantId = request.getParameter("plantId");
        String quantity = request.getParameter("quantity");
        
        if (plantId != null && quantity != null) {
            try {
                int id = Integer.parseInt(plantId);
                int qty = Integer.parseInt(quantity);
                
                if (qty > 0) {
                    cartService.addToCart(userId, id, qty);
                    response.sendRedirect(request.getContextPath() + "/cart?success=added");
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart?error=invalid_quantity");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/cart?error=invalid_input");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/cart?error=missing_params");
        }
    }
    
    private void updateCartItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String cartItemId = request.getParameter("cartItemId");
        String quantity = request.getParameter("quantity");
        
        if (cartItemId != null && quantity != null) {
            try {
                int id = Integer.parseInt(cartItemId);
                int qty = Integer.parseInt(quantity);
                
                if (qty > 0) {
                    cartService.updateCartItemQuantity(id, qty);
                    response.sendRedirect(request.getContextPath() + "/cart?success=updated");
                } else {
                    cartService.removeFromCart(id);
                    response.sendRedirect(request.getContextPath() + "/cart?success=removed");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/cart?error=invalid_input");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/cart?error=missing_params");
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String cartItemId = request.getParameter("cartItemId");
        
        if (cartItemId != null) {
            try {
                int id = Integer.parseInt(cartItemId);
                cartService.removeFromCart(id);
                response.sendRedirect(request.getContextPath() + "/cart?success=removed");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/cart?error=invalid_input");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/cart?error=missing_params");
        }
    }
}
