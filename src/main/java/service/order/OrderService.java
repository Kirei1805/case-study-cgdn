package service.order;

import model.Order;
import model.OrderItem;
import model.Plant;

import java.util.List;

public interface OrderService {
    List<Order> getAllOrders();
    Order getOrderById(int id);
    List<OrderItem> getOrderItems(int orderId);
    boolean updateOrderStatus(int id, String status);
    boolean deleteOrder(int id);
    boolean checkoutFromCart(int userId, int addressId);
    List<Order> getOrdersByUser(int userId);


}
