package service.cart;

import model.CartItem;
import repository.cart.CartRepository;
import repository.cart.CartRepositoryImpl;
import java.util.List;
import java.math.BigDecimal;

public class CartServiceImpl implements CartService {
	private final CartRepository cartRepository;

	public CartServiceImpl() {
		this.cartRepository = new CartRepositoryImpl();
	}

	@Override
	public List<CartItem> getCartItems(int userId) {
		return cartRepository.getCartItemsByUser(userId);
	}

	@Override
	public boolean addToCart(int userId, int plantId, int quantity) {
		return cartRepository.addToCart(userId, plantId, quantity);
	}

	@Override
	public boolean updateQuantity(int userId, int plantId, int quantity) {
		return cartRepository.updateCartItemQuantity(userId, plantId, quantity);
	}

	@Override
	public boolean removeFromCart(int userId, int plantId) {
		return cartRepository.removeFromCart(userId, plantId);
	}

	@Override
	public boolean clearCart(int userId) {
		return cartRepository.clearCart(userId);
	}

	@Override
	public int getCartItemCount(int userId) {
		List<CartItem> items = getCartItems(userId);
		return items.size();
	}

	@Override
	public double getCartTotal(int userId) {
		List<CartItem> items = getCartItems(userId);
		BigDecimal total = BigDecimal.ZERO;
		for (CartItem item : items) {
			total = total.add(item.getPlant().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
		}
		return total.doubleValue();
	}
}

