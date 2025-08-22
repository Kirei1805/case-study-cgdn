package service.cart;

import model.CartItem;
import java.util.List;

public interface CartService {
    List<CartItem> getCartItems(int userId);
    boolean addToCart(int userId, int plantId, int quantity);
    boolean updateQuantity(int userId, int plantId, int quantity);
    boolean removeFromCart(int userId, int plantId);
    boolean clearCart(int userId);
    int getCartItemCount(int userId);
    double getCartTotal(int userId);
}
