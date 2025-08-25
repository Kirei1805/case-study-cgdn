package repository.review;

import model.Review;
import model.User;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepositoryImpl implements ReviewRepository {
	
	@Override
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

	@Override
	public List<Review> getReviewsByUser(int userId) {
		List<Review> reviews = new ArrayList<>();
		String sql = "SELECT r.*, p.name as plant_name FROM reviews r JOIN plants p ON r.plant_id = p.id WHERE r.user_id = ? ORDER BY r.review_date DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
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
				reviews.add(review);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reviews;
	}

	@Override
	public Review getReviewById(int reviewId) {
		String sql = "SELECT r.*, u.full_name FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, reviewId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
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
				return review;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean createReview(Review review) {
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

	@Override
	public boolean updateReview(Review review) {
		String sql = "UPDATE reviews SET rating = ?, comment = ? WHERE id = ? AND user_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, review.getRating());
			stmt.setString(2, review.getComment());
			stmt.setInt(3, review.getId());
			stmt.setInt(4, review.getUserId());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteReview(int reviewId) {
		String sql = "DELETE FROM reviews WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, reviewId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updatePlantRating(int plantId) {
		String sql = "UPDATE plants SET rating_avg = (SELECT AVG(rating) FROM reviews WHERE plant_id = ?) WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, plantId);
			stmt.setInt(2, plantId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public double getAverageRating(int plantId) {
		String sql = "SELECT AVG(rating) FROM reviews WHERE plant_id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, plantId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getDouble(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0.0;
	}
}

