package service;

import model.CartItem;
import java.util.List;

public interface ICartService {
    List<CartItem> getCartItemsByUserId(int userId);
    boolean addToCart(int userId, int plantId, int quantity);
    boolean updateCartItemQuantity(int cartItemId, int newQuantity);
    boolean removeFromCart(int cartItemId);
    boolean clearCart(int userId);
    int getCartItemCount(int userId);
} 