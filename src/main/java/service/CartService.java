package service;

import model.CartItem;
import repository.CartRepository;
import java.util.List;

public class CartService implements ICartService {
    private CartRepository cartRepository;
    
    public CartService() {
        this.cartRepository = new CartRepository();
    }
    
    @Override
    public List<CartItem> getCartItemsByUserId(int userId) {
        return cartRepository.getCartItemsByUserId(userId);
    }
    
    @Override
    public boolean addToCart(int userId, int plantId, int quantity) {
        if (quantity <= 0) {
            return false;
        }
        
        CartItem cartItem = new CartItem(userId, plantId, quantity);
        return cartRepository.addToCart(cartItem);
    }
    
    @Override
    public boolean updateCartItemQuantity(int cartItemId, int newQuantity) {
        if (newQuantity <= 0) {
            // Nếu số lượng <= 0, xóa item khỏi giỏ hàng
            return cartRepository.removeFromCart(cartItemId);
        }
        
        return cartRepository.updateCartItemQuantity(cartItemId, newQuantity);
    }
    
    @Override
    public boolean removeFromCart(int cartItemId) {
        return cartRepository.removeFromCart(cartItemId);
    }
    
    @Override
    public boolean clearCart(int userId) {
        return cartRepository.clearCart(userId);
    }
    
    @Override
    public int getCartItemCount(int userId) {
        return cartRepository.getCartItemCount(userId);
    }
} 