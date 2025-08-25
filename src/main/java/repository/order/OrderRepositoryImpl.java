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
        String sql = "SELECT o.id, o.total_amount, o.status, o.order_date, u.full_name, u.username " +
                "FROM orders o JOIN users u ON o.user_id = u.id WHERE o.id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
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
        String sql = "SELECT oi.quantity, oi.unit_price, p.name, p.image_url " +
                "FROM order_items oi JOIN plants p ON oi.plant_id = p.id WHERE oi.order_id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getBigDecimal("unit_price"));

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
        // TODO: implement theo business logic
        return false;
    }

    @Override
    public List<Order> findByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT id, total_amount, status, order_date FROM orders WHERE user_id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setTotalAmount(rs.getBigDecimal("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setOrderDate(rs.getTimestamp("order_date").toLocalDateTime());
                list.add(o);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
