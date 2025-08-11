package repository;

import model.Review;
import model.User;
import model.Plant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepository {
    
    public ReviewRepository() {
        // Không cần khởi tạo DBRepository nữa vì đã dùng static method
    }
    
    public boolean addReview(Review review) {
        String sql = "INSERT INTO reviews (user_id, plant_id, rating, comment, review_date, is_active) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, review.getUserId());
            stmt.setInt(2, review.getPlantId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getComment());
            stmt.setTimestamp(5, Timestamp.valueOf(review.getReviewDate()));
            stmt.setBoolean(6, review.isActive());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm đánh giá: " + e.getMessage());
            return false;
        }
    }
    
    public List<Review> getReviewsByPlantId(int plantId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.full_name, p.name as plant_name " +
                    "FROM reviews r " +
                    "LEFT JOIN users u ON r.user_id = u.id " +
                    "LEFT JOIN plants p ON r.plant_id = p.id " +
                    "WHERE r.plant_id = ? AND r.is_active = true " +
                    "ORDER BY r.review_date DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, plantId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = mapResultSetToReview(rs);
                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy đánh giá theo plant ID: " + e.getMessage());
        }
        return reviews;
    }
    
    public List<Review> getReviewsByUserId(int userId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.full_name, p.name as plant_name " +
                    "FROM reviews r " +
                    "LEFT JOIN users u ON r.user_id = u.id " +
                    "LEFT JOIN plants p ON r.plant_id = p.id " +
                    "WHERE r.user_id = ? AND r.is_active = true " +
                    "ORDER BY r.review_date DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = mapResultSetToReview(rs);
                    reviews.add(review);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy đánh giá theo user ID: " + e.getMessage());
        }
        return reviews;
    }
    
    public Review getReviewByUserAndPlant(int userId, int plantId) {
        String sql = "SELECT r.*, u.username, u.full_name, p.name as plant_name " +
                    "FROM reviews r " +
                    "LEFT JOIN users u ON r.user_id = u.id " +
                    "LEFT JOIN plants p ON r.plant_id = p.id " +
                    "WHERE r.user_id = ? AND r.plant_id = ? AND r.is_active = true";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, plantId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToReview(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy đánh giá theo user và plant: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateReview(Review review) {
        String sql = "UPDATE reviews SET rating = ?, comment = ?, review_date = ? " +
                    "WHERE user_id = ? AND plant_id = ? AND is_active = true";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getComment());
            stmt.setTimestamp(3, Timestamp.valueOf(review.getReviewDate()));
            stmt.setInt(4, review.getUserId());
            stmt.setInt(5, review.getPlantId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật đánh giá: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteReview(int reviewId) {
        String sql = "UPDATE reviews SET is_active = false WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, reviewId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa đánh giá: " + e.getMessage());
            return false;
        }
    }
    
    public double getAverageRatingByPlantId(int plantId) {
        String sql = "SELECT AVG(rating) as avg_rating FROM reviews " +
                    "WHERE plant_id = ? AND is_active = true";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, plantId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("avg_rating");
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy điểm đánh giá trung bình: " + e.getMessage());
        }
        return 0.0;
    }
    
    public int getReviewCountByPlantId(int plantId) {
        String sql = "SELECT COUNT(*) as review_count FROM reviews " +
                    "WHERE plant_id = ? AND is_active = true";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, plantId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("review_count");
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đếm số đánh giá: " + e.getMessage());
        }
        return 0;
    }
    
    public boolean hasUserPurchasedPlant(int userId, int plantId) {
        String sql = "SELECT COUNT(*) as order_count FROM orders o " +
                    "JOIN order_items oi ON o.id = oi.order_id " +
                    "WHERE o.user_id = ? AND oi.plant_id = ? AND o.status != 'cancelled'";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, plantId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("order_count") > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra người dùng đã mua sản phẩm: " + e.getMessage());
        }
        return false;
    }
    
    private Review mapResultSetToReview(ResultSet rs) throws SQLException {
        Review review = new Review();
        review.setId(rs.getInt("id"));
        review.setUserId(rs.getInt("user_id"));
        review.setPlantId(rs.getInt("plant_id"));
        review.setRating(rs.getInt("rating"));
        review.setComment(rs.getString("comment"));
        review.setReviewDate(rs.getTimestamp("review_date").toLocalDateTime());
        review.setActive(rs.getBoolean("is_active"));
        
        // Set User object
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setFullName(rs.getString("full_name"));
        review.setUser(user);
        
        // Set Plant object
        Plant plant = new Plant();
        plant.setId(rs.getInt("plant_id"));
        plant.setName(rs.getString("plant_name"));
        review.setPlant(plant);
        
        return review;
    }
} 