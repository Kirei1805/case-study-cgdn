package repository.cart;

import model.CartItem;
import model.Category;
import model.Plant;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartRepositoryImpl implements CartRepository {
	
	@Override
	public List<CartItem> getCartItemsByUser(int userId) {
		List<CartItem> cartItems = new ArrayList<>();
		String sql = "SELECT ci.id as ci_id, ci.user_id, ci.plant_id, ci.quantity, " +
					"p.id as p_id, p.name as p_name, p.price as p_price, p.image_url, p.description, p.stock, p.rating_avg, p.category_id, p.is_active, " +
					"c.name as category_name " +
					"FROM cart_items ci " +
					"JOIN plants p ON ci.plant_id = p.id " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE ci.user_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				CartItem cartItem = new CartItem();
				cartItem.setId(rs.getInt("ci_id"));
				cartItem.setUserId(rs.getInt("user_id"));
				cartItem.setPlantId(rs.getInt("plant_id"));
				cartItem.setQuantity(rs.getInt("quantity"));

				Plant plant = new Plant();
				plant.setId(rs.getInt("p_id"));
				plant.setName(rs.getString("p_name"));
				plant.setPrice(rs.getBigDecimal("p_price"));
				plant.setImageUrl(rs.getString("image_url"));
				plant.setDescription(rs.getString("description"));
				plant.setStock(rs.getInt("stock"));
				plant.setRatingAvg(rs.getFloat("rating_avg"));
				plant.setCategoryId(rs.getInt("category_id"));
				plant.setActive(rs.getBoolean("is_active"));

				Category category = new Category();
				category.setId(rs.getInt("category_id"));
				category.setName(rs.getString("category_name"));
				plant.setCategory(category);

				cartItem.setPlant(plant);
				cartItems.add(cartItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cartItems;
	}

	@Override
	public boolean addToCart(int userId, int plantId, int quantity) {
		String sql = "INSERT INTO cart_items (user_id, plant_id, quantity) VALUES (?, ?, ?) " +
					"ON DUPLICATE KEY UPDATE quantity = quantity + ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, plantId);
			stmt.setInt(3, quantity);
			stmt.setInt(4, quantity);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateCartItemQuantity(int userId, int plantId, int quantity) {
		String sql = "UPDATE cart_items SET quantity = ? WHERE user_id = ? AND plant_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, quantity);
			stmt.setInt(2, userId);
			stmt.setInt(3, plantId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean removeFromCart(int userId, int plantId) {
		String sql = "DELETE FROM cart_items WHERE user_id = ? AND plant_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, plantId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean clearCart(int userId) {
		String sql = "DELETE FROM cart_items WHERE user_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public CartItem getCartItem(int userId, int plantId) {
		String sql = "SELECT ci.id as ci_id, ci.user_id, ci.plant_id, ci.quantity, " +
					"p.id as p_id, p.name as p_name, p.price as p_price, p.image_url, p.description, p.stock, p.rating_avg, p.category_id, p.is_active, " +
					"c.name as category_name " +
					"FROM cart_items ci " +
					"JOIN plants p ON ci.plant_id = p.id " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE ci.user_id = ? AND ci.plant_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, plantId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				CartItem cartItem = new CartItem();
				cartItem.setId(rs.getInt("ci_id"));
				cartItem.setUserId(rs.getInt("user_id"));
				cartItem.setPlantId(rs.getInt("plant_id"));
				cartItem.setQuantity(rs.getInt("quantity"));

				Plant plant = new Plant();
				plant.setId(rs.getInt("p_id"));
				plant.setName(rs.getString("p_name"));
				plant.setPrice(rs.getBigDecimal("p_price"));
				plant.setImageUrl(rs.getString("image_url"));
				plant.setDescription(rs.getString("description"));
				plant.setStock(rs.getInt("stock"));
				plant.setRatingAvg(rs.getFloat("rating_avg"));
				plant.setCategoryId(rs.getInt("category_id"));
				plant.setActive(rs.getBoolean("is_active"));

				Category category = new Category();
				category.setId(rs.getInt("category_id"));
				category.setName(rs.getString("category_name"));
				plant.setCategory(category);

				cartItem.setPlant(plant);
				return cartItem;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean isItemInCart(int userId, int plantId) {
		String sql = "SELECT COUNT(*) FROM cart_items WHERE user_id = ? AND plant_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, plantId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}

