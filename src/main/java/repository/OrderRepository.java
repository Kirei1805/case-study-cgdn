package repository;

import model.Order;
import model.OrderItem;
import model.Plant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class OrderRepository {
	public int createOrder(Order order) {
		String insertOrder = "INSERT INTO orders (user_id, address_id, total_amount, status) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
			stmt.setInt(1, order.getUserId());
			stmt.setInt(2, order.getAddressId());
			stmt.setBigDecimal(3, order.getTotalAmount());
			stmt.setString(4, order.getStatus());
			int affected = stmt.executeUpdate();
			if (affected > 0) {
				try (ResultSet rs = stmt.getGeneratedKeys()) {
					if (rs.next()) return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public boolean addOrderItems(int orderId, List<OrderItem> items) {
		String insertItem = "INSERT INTO order_items (order_id, plant_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(insertItem)) {
			for (OrderItem item : items) {
				stmt.setInt(1, orderId);
				stmt.setInt(2, item.getPlantId());
				stmt.setInt(3, item.getQuantity());
				stmt.setBigDecimal(4, item.getUnitPrice());
				stmt.addBatch();
			}
			stmt.executeBatch();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<Order> getOrdersByUser(int userId) {
		List<Order> orders = new ArrayList<>();
		String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Order order = mapOrder(rs);
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orders;
	}

	public List<OrderItem> getOrderItems(int orderId) {
		List<OrderItem> items = new ArrayList<>();
		String sql = "SELECT oi.*, p.name, p.image_url FROM order_items oi JOIN plants p ON oi.plant_id = p.id WHERE oi.order_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, orderId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				OrderItem item = new OrderItem();
				item.setId(rs.getInt("id"));
				item.setOrderId(rs.getInt("order_id"));
				item.setPlantId(rs.getInt("plant_id"));
				item.setQuantity(rs.getInt("quantity"));
				item.setUnitPrice(rs.getBigDecimal("unit_price"));
				Plant p = new Plant();
				p.setId(rs.getInt("plant_id"));
				p.setName(rs.getString("name"));
				p.setImageUrl(rs.getString("image_url"));
				item.setPlant(p);
				items.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return items;
	}

	private Order mapOrder(ResultSet rs) throws SQLException {
		Order order = new Order();
		order.setId(rs.getInt("id"));
		order.setUserId(rs.getInt("user_id"));
		order.setAddressId(rs.getInt("address_id"));
		order.setTotalAmount(rs.getBigDecimal("total_amount"));
		order.setStatus(rs.getString("status"));
		Timestamp ts = rs.getTimestamp("order_date");
		if (ts != null) order.setOrderDate(ts.toLocalDateTime());
		return order;
	}
}
