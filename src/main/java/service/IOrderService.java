package service;

import model.Order;
import model.OrderItem;
import java.util.List;

public interface IOrderService {
    boolean createOrder(Order order, List<OrderItem> orderItems);
    List<Order> getOrdersByUserId(int userId);
    List<Order> getAllOrders();
    Order getOrderById(int orderId);
    boolean updateOrderStatus(int orderId, String status);
    int getOrderCount();
    int getPendingOrderCount();
} 