package repository.order;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface OrderRepository {
    List<Order> findAll();
    Order findById(int id);
    List<OrderItem> findItemsByOrderId(int orderId);
    boolean updateStatus(int id, String status);
    boolean delete(int id);
    boolean checkoutFromCart(int userId, int addressId);
    int checkoutFromCartAndGetOrderId(int userId, int addressId);
    List<Order> findByUser(int userId);
}
