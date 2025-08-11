package repository;

import model.Plant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RecommendationRepository {
    
    public RecommendationRepository() {
        // Không cần khởi tạo DBRepository nữa vì đã dùng static method
    }
    
    public List<Plant> getPlantsByUserPurchaseHistory(int userId, int limit) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT DISTINCT p.*, c.name as category_name " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.id IN ( " +
                    "    SELECT DISTINCT oi.plant_id " +
                    "    FROM order_items oi " +
                    "    JOIN orders o ON oi.order_id = o.id " +
                    "    WHERE o.user_id = ? AND o.status != 'cancelled' " +
                    ") " +
                    "AND p.is_active = true " +
                    "ORDER BY p.rating_avg DESC, p.id DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm theo lịch sử mua hàng: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getPlantsByUserRatingHistory(int userId, int limit) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT DISTINCT p.*, c.name as category_name " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.category_id IN ( " +
                    "    SELECT DISTINCT p2.category_id " +
                    "    FROM reviews r " +
                    "    JOIN plants p2 ON r.plant_id = p2.id " +
                    "    WHERE r.user_id = ? AND r.rating >= 4 " +
                    ") " +
                    "AND p.is_active = true " +
                    "AND p.id NOT IN ( " +
                    "    SELECT DISTINCT oi.plant_id " +
                    "    FROM order_items oi " +
                    "    JOIN orders o ON oi.order_id = o.id " +
                    "    WHERE o.user_id = ? AND o.status != 'cancelled' " +
                    ") " +
                    "ORDER BY p.rating_avg DESC, p.id DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);
            stmt.setInt(3, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm theo lịch sử đánh giá: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getPopularPlants(int limit) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name, " +
                    "COUNT(oi.id) as order_count " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "LEFT JOIN order_items oi ON p.id = oi.plant_id " +
                    "LEFT JOIN orders o ON oi.order_id = o.id " +
                    "WHERE p.is_active = true " +
                    "AND (o.status IS NULL OR o.status != 'cancelled') " +
                    "GROUP BY p.id " +
                    "ORDER BY order_count DESC, p.rating_avg DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm phổ biến: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getPlantsByCategory(int categoryId, int limit) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.category_id = ? AND p.is_active = true " +
                    "ORDER BY p.rating_avg DESC, p.id DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            stmt.setInt(2, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm theo danh mục: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getPlantsByPriceRange(double minPrice, double maxPrice, int limit) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.price >= ? AND p.price <= ? AND p.is_active = true " +
                    "ORDER BY p.rating_avg DESC, p.id DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDouble(1, minPrice);
            stmt.setDouble(2, maxPrice);
            stmt.setInt(3, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm theo khoảng giá: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getSimilarPlants(int plantId, int limit) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.category_id = ( " +
                    "    SELECT category_id FROM plants WHERE id = ? " +
                    ") " +
                    "AND p.id != ? AND p.is_active = true " +
                    "ORDER BY p.rating_avg DESC, p.id DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, plantId);
            stmt.setInt(2, plantId);
            stmt.setInt(3, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm tương tự: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getTopRatedPlants(int limit) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.is_active = true AND p.rating_avg > 0 " +
                    "ORDER BY p.rating_avg DESC, p.id DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm đánh giá cao: " + e.getMessage());
        }
        return plants;
    }
    
    private Plant mapResultSetToPlant(ResultSet rs) throws SQLException {
        Plant plant = new Plant();
        plant.setId(rs.getInt("id"));
        plant.setName(rs.getString("name"));
        plant.setPrice(rs.getBigDecimal("price"));
        plant.setImageUrl(rs.getString("image_url"));
        plant.setDescription(rs.getString("description"));
        plant.setStock(rs.getInt("stock"));
        plant.setCategoryId(rs.getInt("category_id"));
        plant.setActive(rs.getBoolean("is_active"));
        plant.setRatingAvg(rs.getDouble("rating_avg"));
        plant.setCategoryName(rs.getString("category_name"));
        return plant;
    }
} 