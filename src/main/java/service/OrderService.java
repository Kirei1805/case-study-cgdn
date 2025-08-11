package service;

import model.Order;
import model.OrderItem;
import repository.OrderRepository;
import java.util.List;

public class OrderService implements IOrderService {
    private OrderRepository orderRepository;
    
    public OrderService() {
        this.orderRepository = new OrderRepository();
    }
    
    @Override
    public boolean createOrder(Order order, List<OrderItem> orderItems) {
        // Tạo đơn hàng
        boolean orderCreated = orderRepository.createOrder(order);
        
        if (orderCreated && orderItems != null) {
            // Tạo các order items
            for (OrderItem item : orderItems) {
                item.setOrderId(order.getId());
                boolean itemCreated = orderRepository.createOrderItem(item);
                if (!itemCreated) {
                    return false;
                }
            }
            return true;
        }
        
        return orderCreated;
    }
    
    @Override
    public List<Order> getOrdersByUserId(int userId) {
        return orderRepository.getOrdersByUserId(userId);
    }
    
    @Override
    public List<Order> getAllOrders() {
        return orderRepository.getAllOrders();
    }
    
    @Override
    public Order getOrderById(int orderId) {
        return orderRepository.getOrderById(orderId);
    }
    
    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        return orderRepository.updateOrderStatus(orderId, status);
    }
    
    @Override
    public int getOrderCount() {
        return orderRepository.getOrderCount();
    }
    
    @Override
    public int getPendingOrderCount() {
        return orderRepository.getPendingOrderCount();
    }
} 