package repository.order;

import model.Order;
import model.OrderItem;
import model.Plant;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderRepositoryImpl implements OrderRepository {
	
	@Override
	public boolean createOrderWithItemsAndAdjustStock(Order order, List<OrderItem> items) {
		String insertOrder = "INSERT INTO orders (user_id, address_id, total_amount, status) VALUES (?, ?, ?, ?)";
		String selectStockForUpdate = "SELECT stock FROM plants WHERE id = ? FOR UPDATE";
		String updateStock = "UPDATE plants SET stock = stock - ? WHERE id = ?";
		String insertItem = "INSERT INTO order_items (order_id, plant_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

		try (Connection conn = DBRepository.getConnection()) {
			conn.setAutoCommit(false);
			int orderId;
			try (PreparedStatement orderStmt = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
				orderStmt.setInt(1, order.getUserId());
				orderStmt.setInt(2, order.getAddressId());
				orderStmt.setBigDecimal(3, order.getTotalAmount());
				orderStmt.setString(4, order.getStatus());
				int affected = orderStmt.executeUpdate();
				if (affected <= 0) {
					conn.rollback();
					return false;
				}
				try (ResultSet rs = orderStmt.getGeneratedKeys()) {
					if (!rs.next()) {
						conn.rollback();
						return false;
					}
					orderId = rs.getInt(1);
				}
			}

			try (PreparedStatement stockStmt = conn.prepareStatement(selectStockForUpdate);
				 PreparedStatement updStockStmt = conn.prepareStatement(updateStock);
				 PreparedStatement itemStmt = conn.prepareStatement(insertItem)) {
				for (OrderItem item : items) {
					stockStmt.setInt(1, item.getPlantId());
					try (ResultSet rs = stockStmt.executeQuery()) {
						if (!rs.next()) {
							conn.rollback();
							return false;
						}
						int currentStock = rs.getInt(1);
						if (currentStock < item.getQuantity()) {
							conn.rollback();
							return false;
						}
					}
					updStockStmt.setInt(1, item.getQuantity());
					updStockStmt.setInt(2, item.getPlantId());
					updStockStmt.executeUpdate();
					itemStmt.setInt(1, orderId);
					itemStmt.setInt(2, item.getPlantId());
					itemStmt.setInt(3, item.getQuantity());
					itemStmt.setBigDecimal(4, item.getUnitPrice());
					itemStmt.addBatch();
				}
				itemStmt.executeBatch();
			}

			conn.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public Order getOrderById(int orderId) {
		String sql = "SELECT * FROM orders WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, orderId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return mapOrder(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
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

	@Override
	public List<Order> getAllOrders() {
		List<Order> orders = new ArrayList<>();
		String sql = "SELECT o.*, u.username, u.full_name FROM orders o " +
					"JOIN users u ON o.user_id = u.id " +
					"ORDER BY o.order_date DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Order order = mapOrder(rs);
				// Handle null values safely
				String fullName = rs.getString("full_name");
				String username = rs.getString("username");
				order.setCustomerName(fullName != null ? fullName : "Unknown");
				order.setCustomerUsername(username != null ? username : "Unknown");
				orders.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return orders;
	}

	@Override
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

	@Override
	public boolean updateOrderStatus(int orderId, String status) {
		String sql = "UPDATE orders SET status = ? WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, status);
			stmt.setInt(2, orderId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteOrder(int orderId) {
		String sql = "DELETE FROM orders WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, orderId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private Order mapOrder(ResultSet rs) throws SQLException {
		Order order = new Order();
		order.setId(rs.getInt("id"));
		order.setUserId(rs.getInt("user_id"));
		order.setAddressId(rs.getInt("address_id"));
		order.setTotalAmount(rs.getBigDecimal("total_amount"));
		order.setStatus(rs.getString("status"));
		Timestamp ts = rs.getTimestamp("order_date");
		if (ts != null) {
			order.setOrderDate(ts.toLocalDateTime());
		} else {
			order.setOrderDate(null);
		}
		return order;
	}
}

