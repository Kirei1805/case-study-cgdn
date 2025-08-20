package repository;

import model.WishlistItem;
import model.Plant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WishlistRepository {
	public List<WishlistItem> getWishlistByUser(int userId) {
		List<WishlistItem> list = new ArrayList<>();
		String sql = "SELECT w.*, p.name, p.image_url, p.price FROM wishlist w JOIN plants p ON w.plant_id = p.id WHERE w.user_id = ? ORDER BY w.created_at DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				WishlistItem item = new WishlistItem();
				item.setId(rs.getInt("id"));
				item.setUserId(rs.getInt("user_id"));
				item.setPlantId(rs.getInt("plant_id"));
				Timestamp ts = rs.getTimestamp("created_at");
				if (ts != null) item.setCreatedAt(ts.toLocalDateTime());
				Plant p = new Plant();
				p.setId(rs.getInt("plant_id"));
				p.setName(rs.getString("name"));
				p.setImageUrl(rs.getString("image_url"));
				p.setPrice(rs.getBigDecimal("price"));
				item.setPlant(p);
				list.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean addToWishlist(int userId, int plantId) {
		String sql = "INSERT INTO wishlist (user_id, plant_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE user_id = user_id";
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

	public boolean removeFromWishlist(int userId, int plantId) {
		String sql = "DELETE FROM wishlist WHERE user_id = ? AND plant_id = ?";
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
}
