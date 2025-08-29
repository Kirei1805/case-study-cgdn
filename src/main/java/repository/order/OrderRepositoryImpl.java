package repository.order;

import model.Order;
import model.OrderItem;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepositoryImpl implements OrderRepository {

    @Override
    public List<Order> findAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.id, o.total_amount, o.status, o.order_date, u.full_name, u.username " +
                "FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setTotalAmount(rs.getBigDecimal("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                o.setCustomerName(rs.getString("full_name"));
                o.setCustomerUsername(rs.getString("username"));
                list.add(o);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public Order findById(int id) {
        String sql = "SELECT o.id, o.user_id, o.total_amount, o.status, o.order_date, u.full_name, u.username " +
                "FROM orders o JOIN users u ON o.user_id = u.id WHERE o.id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setTotalAmount(rs.getBigDecimal("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                o.setCustomerName(rs.getString("full_name"));
                o.setCustomerUsername(rs.getString("username"));
                return o;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public List<OrderItem> findItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT oi.id, oi.order_id, oi.plant_id, oi.quantity, oi.unit_price, " +
                    "p.name, p.image_url, p.description, p.category_id, " +
                    "c.name as category_name " +
                    "FROM order_items oi " +
                    "JOIN plants p ON oi.plant_id = p.id " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE oi.order_id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setPlantId(rs.getInt("plant_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getBigDecimal("unit_price"));

                // Create Plant object
                model.Plant plant = new model.Plant();
                plant.setId(rs.getInt("plant_id"));
                plant.setName(rs.getString("name"));
                plant.setImageUrl(rs.getString("image_url"));
                plant.setDescription(rs.getString("description"));
                plant.setCategoryId(rs.getInt("category_id"));
                
                // Create Category object
                model.Category category = new model.Category();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("category_name"));
                plant.setCategory(category);
                
                item.setPlant(plant);
                list.add(item);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM orders WHERE id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean checkoutFromCart(int userId, int addressId) {
        return checkoutFromCartAndGetOrderId(userId, addressId) > 0;
    }
    
    public int checkoutFromCartAndGetOrderId(int userId, int addressId) {
        Connection conn = null;
        try {
            conn = DBRepository.getConnection();
            conn.setAutoCommit(false);
            
            // 1. Calculate total from cart
            String totalSql = "SELECT SUM(ci.quantity * p.price) as total " +
                            "FROM cart_items ci JOIN plants p ON ci.plant_id = p.id " +
                            "WHERE ci.user_id = ?";
            double total = 0;
            try (PreparedStatement ps = conn.prepareStatement(totalSql)) {
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    total = rs.getDouble("total");
                }
            }
            
            if (total <= 0) {
                conn.rollback();
                return 0;
            }
            
            // 2. Create order
            String orderSql = "INSERT INTO orders (user_id, address_id, total_amount, status) VALUES (?, ?, ?, 'pending')";
            int orderId = 0;
            try (PreparedStatement ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setInt(2, addressId);
                ps.setDouble(3, total);
                ps.executeUpdate();
                
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) {
                    orderId = keys.getInt(1);
                }
            }
            
            if (orderId <= 0) {
                conn.rollback();
                return 0;
            }
            
            // 3. Copy cart items to order items
            String itemsSql = "INSERT INTO order_items (order_id, plant_id, quantity, unit_price) " +
                            "SELECT ?, ci.plant_id, ci.quantity, p.price " +
                            "FROM cart_items ci JOIN plants p ON ci.plant_id = p.id " +
                            "WHERE ci.user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(itemsSql)) {
                ps.setInt(1, orderId);
                ps.setInt(2, userId);
                ps.executeUpdate();
            }
            
            // 4. Clear cart
            String clearSql = "DELETE FROM cart_items WHERE user_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(clearSql)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }
            
            conn.commit();
            return orderId;
            
        } catch (SQLException e) {
            e.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }

    @Override
    public List<Order> findByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT id, user_id, total_amount, status, order_date FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setTotalAmount(rs.getBigDecimal("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                list.add(o);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
