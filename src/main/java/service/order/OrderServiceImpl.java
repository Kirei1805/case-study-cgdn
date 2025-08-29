package service.order;

import model.Order;
import model.OrderItem;
import model.Plant;
import repository.order.OrderRepository;
import repository.order.OrderRepositoryImpl;

import java.util.List;

public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository = new OrderRepositoryImpl();

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @Override
    public Order getOrderById(int id) {
        return orderRepository.findById(id);
    }

    @Override
    public List<OrderItem> getOrderItems(int orderId) {
        return orderRepository.findItemsByOrderId(orderId);
    }

    @Override
    public boolean updateOrderStatus(int id, String status) {
        return orderRepository.updateStatus(id, status);
    }

    @Override
    public boolean deleteOrder(int id) {
        return orderRepository.delete(id);
    }

    @Override
    public boolean checkoutFromCart(int userId, int addressId) {
        return orderRepository.checkoutFromCart(userId, addressId);
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {
        return orderRepository.findByUser(userId);
    }



}
