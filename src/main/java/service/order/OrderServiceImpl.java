package service.order;

import model.Order;
import model.OrderItem;
import model.CartItem;
import repository.order.OrderRepository;
import repository.order.OrderRepositoryImpl;
import repository.cart.CartRepository;
import repository.cart.CartRepositoryImpl;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class OrderServiceImpl implements OrderService {
	private final OrderRepository orderRepository;
	private final CartRepository cartRepository;

	public OrderServiceImpl() {
		this.orderRepository = new OrderRepositoryImpl();
		this.cartRepository = new CartRepositoryImpl();
	}

	@Override
	public boolean checkout(int userId, int addressId, List<OrderItem> items) {
		if (items == null || items.isEmpty()) return false;

		BigDecimal total = BigDecimal.ZERO;
		for (OrderItem item : items) {
			total = total.add(item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
		}

		Order order = new Order();
		order.setUserId(userId);
		order.setAddressId(addressId);
		order.setTotalAmount(total);
		order.setStatus("pending");

		boolean success = orderRepository.createOrderWithItemsAndAdjustStock(order, items);
		if (success) {
			cartRepository.clearCart(userId);
		}
		return success;
	}

	@Override
	public Order getOrderById(int orderId) {
		return orderRepository.getOrderById(orderId);
	}

	@Override
	public List<Order> getOrdersByUser(int userId) {
		return orderRepository.getOrdersByUser(userId);
	}

	@Override
	public List<Order> getAllOrders() {
		return orderRepository.getAllOrders();
	}

	@Override
	public List<OrderItem> getOrderItems(int orderId) {
		return orderRepository.getOrderItems(orderId);
	}

	@Override
	public boolean updateOrderStatus(int orderId, String status) {
		return orderRepository.updateOrderStatus(orderId, status);
	}

	@Override
	public boolean deleteOrder(int orderId) {
		return orderRepository.deleteOrder(orderId);
	}

	// Helper method for checkout from cart
	public boolean checkoutFromCart(int userId, int addressId) {
		List<CartItem> cartItems = cartRepository.getCartItemsByUser(userId);
		if (cartItems == null || cartItems.isEmpty()) return false;

		List<OrderItem> orderItems = new ArrayList<>();
		for (CartItem ci : cartItems) {
			OrderItem oi = new OrderItem();
			oi.setPlantId(ci.getPlantId());
			oi.setQuantity(ci.getQuantity());
			oi.setUnitPrice(ci.getPlant().getPrice());
			orderItems.add(oi);
		}

		return checkout(userId, addressId, orderItems);
	}
}

