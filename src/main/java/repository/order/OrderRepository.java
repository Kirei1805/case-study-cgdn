package repository.order;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface OrderRepository {
    boolean createOrderWithItemsAndAdjustStock(Order order, List<OrderItem> items);
    Order getOrderById(int orderId);
    List<Order> getOrdersByUser(int userId);
    List<Order> getAllOrders();
    List<OrderItem> getOrderItems(int orderId);
    boolean updateOrderStatus(int orderId, String status);
    boolean deleteOrder(int orderId);
}
