package repository.cart;

import model.CartItem;
import java.util.List;

public interface CartRepository {
    List<CartItem> getCartItemsByUser(int userId);
    boolean addToCart(int userId, int plantId, int quantity);
    boolean updateCartItemQuantity(int userId, int plantId, int quantity);
    boolean removeFromCart(int userId, int plantId);
    boolean clearCart(int userId);
    CartItem getCartItem(int userId, int plantId);
    boolean isItemInCart(int userId, int plantId);
}
