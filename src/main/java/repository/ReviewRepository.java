package repository;

import model.Review;
import model.User;
import model.Plant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepository {
	public List<Review> getReviewsByPlant(int plantId) {
		List<Review> reviews = new ArrayList<>();
		String sql = "SELECT r.*, u.full_name FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.plant_id = ? ORDER BY r.review_date DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, plantId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Review review = new Review();
				review.setId(rs.getInt("id"));
				review.setUserId(rs.getInt("user_id"));
				review.setPlantId(rs.getInt("plant_id"));
				review.setRating(rs.getInt("rating"));
				review.setComment(rs.getString("comment"));
				Timestamp ts = rs.getTimestamp("review_date");
				if (ts != null) review.setReviewDate(ts.toLocalDateTime());
				User u = new User();
				u.setId(rs.getInt("user_id"));
				u.setFullName(rs.getString("full_name"));
				review.setUser(u);
				reviews.add(review);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reviews;
	}

	public boolean addReview(Review review) {
		String sql = "INSERT INTO reviews (user_id, plant_id, rating, comment) VALUES (?, ?, ?, ?)";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, review.getUserId());
			stmt.setInt(2, review.getPlantId());
			stmt.setInt(3, review.getRating());
			stmt.setString(4, review.getComment());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
