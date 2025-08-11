package repository;

import model.Order;
import model.OrderItem;
import model.Plant;
import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepository {
    
    public OrderRepository() {
        // Không cần khởi tạo DBRepository nữa vì đã dùng static method
    }
    
    public boolean createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, address_id, total_amount, status, order_date) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, order.getUserId());
            stmt.setInt(2, order.getAddressId());
            stmt.setBigDecimal(3, order.getTotalAmount());
            stmt.setString(4, order.getStatus());
            stmt.setTimestamp(5, Timestamp.valueOf(order.getOrderDate()));
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        order.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo đơn hàng: " + e.getMessage());
        }
        return false;
    }
    
    public boolean createOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, plant_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getPlantId());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setBigDecimal(4, orderItem.getUnitPrice());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi tạo order item: " + e.getMessage());
            return false;
        }
    }
    
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username, u.full_name FROM orders o " +
                    "LEFT JOIN users u ON o.user_id = u.id " +
                    "WHERE o.user_id = ? ORDER BY o.order_date DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy đơn hàng: " + e.getMessage());
        }
        return orders;
    }
    
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username, u.full_name FROM orders o " +
                    "LEFT JOIN users u ON o.user_id = u.id " +
                    "ORDER BY o.order_date DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tất cả đơn hàng: " + e.getMessage());
        }
        return orders;
    }
    
    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, u.username, u.full_name FROM orders o " +
                    "LEFT JOIN users u ON o.user_id = u.id " +
                    "WHERE o.id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    // Lấy order items
                    order.setOrderItems(getOrderItemsByOrderId(orderId));
                    return order;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy đơn hàng theo ID: " + e.getMessage());
        }
        return null;
    }
    
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT oi.*, p.*, c.name as category_name FROM order_items oi " +
                    "LEFT JOIN plants p ON oi.plant_id = p.id " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE oi.order_id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem orderItem = mapResultSetToOrderItem(rs);
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy order items: " + e.getMessage());
        }
        return orderItems;
    }
    
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật trạng thái đơn hàng: " + e.getMessage());
            return false;
        }
    }
    
    public int getOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đếm đơn hàng: " + e.getMessage());
        }
        return 0;
    }
    
    public int getPendingOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 'pending'";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đếm đơn hàng chờ xử lý: " + e.getMessage());
        }
        return 0;
    }
    
    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setAddressId(rs.getInt("address_id"));
        order.setTotalAmount(rs.getBigDecimal("total_amount"));
        order.setStatus(rs.getString("status"));
        
        Timestamp orderDate = rs.getTimestamp("order_date");
        if (orderDate != null) {
            order.setOrderDate(orderDate.toLocalDateTime());
        }
        
        // Tạo user object
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setFullName(rs.getString("full_name"));
        order.setUser(user);
        
        return order;
    }
    
    private OrderItem mapResultSetToOrderItem(ResultSet rs) throws SQLException {
        OrderItem orderItem = new OrderItem();
        orderItem.setId(rs.getInt("id"));
        orderItem.setOrderId(rs.getInt("order_id"));
        orderItem.setPlantId(rs.getInt("plant_id"));
        orderItem.setQuantity(rs.getInt("quantity"));
        orderItem.setUnitPrice(rs.getBigDecimal("unit_price"));
        
        // Tạo đối tượng Plant
        Plant plant = new Plant();
        plant.setId(rs.getInt("plant_id"));
        plant.setName(rs.getString("name"));
        plant.setPrice(rs.getBigDecimal("price"));
        plant.setImageUrl(rs.getString("image_url"));
        plant.setDescription(rs.getString("description"));
        plant.setStock(rs.getInt("stock"));
        plant.setRatingAvg(rs.getDouble("rating_avg"));
        plant.setCategoryId(rs.getInt("category_id"));
        plant.setCategoryName(rs.getString("category_name"));
        plant.setActive(rs.getBoolean("is_active"));
        
        orderItem.setPlant(plant);
        
        return orderItem;
    }
} 