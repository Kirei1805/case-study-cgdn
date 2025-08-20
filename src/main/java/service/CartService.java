package service;

import model.CartItem;
import repository.CartRepository;
import java.util.List;
import java.math.BigDecimal;

public class CartService {
	private final CartRepository cartRepository;

	public CartService() {
		this.cartRepository = new CartRepository();
	}

	public List<CartItem> getCartItems(int userId) {
		return cartRepository.getCartItemsByUserId(userId);
	}

	public boolean addToCart(int userId, int plantId, int quantity) {
		return cartRepository.addToCart(userId, plantId, quantity);
	}

	public boolean updateCartItemQuantity(int cartItemId, int quantity) {
		return cartRepository.updateCartItemQuantity(cartItemId, quantity);
	}

	public boolean removeFromCart(int cartItemId) {
		return cartRepository.removeFromCart(cartItemId);
	}

	public boolean clearCart(int userId) {
		return cartRepository.clearCart(userId);
	}

	public BigDecimal calculateTotal(List<CartItem> cartItems) {
		BigDecimal total = BigDecimal.ZERO;
		for (CartItem item : cartItems) {
			total = total.add(item.getPlant().getPrice().multiply(new BigDecimal(item.getQuantity())));
		}
		return total;
	}
}
