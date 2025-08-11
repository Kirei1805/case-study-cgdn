package repository;

import model.Plant;
import model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class PlantRepository {
    
    public PlantRepository() {
        // Không cần khởi tạo DBRepository nữa vì đã dùng static method
    }
    
    public List<Plant> getAllPlants() {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.is_active = true ORDER BY p.id DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Plant plant = mapResultSetToPlant(rs);
                plants.add(plant);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách cây trồng: " + e.getMessage());
        }
        return plants;
    }
    
    public Plant getPlantById(int id) {
        String sql = "SELECT p.*, c.name as category_name FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.id = ? AND p.is_active = true";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPlant(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy cây trồng theo ID: " + e.getMessage());
        }
        return null;
    }
    
    public List<Plant> getPlantsByCategory(int categoryId) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.category_id = ? AND p.is_active = true ORDER BY p.id DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy cây trồng theo danh mục: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> searchPlants(String keyword) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.is_active = true AND (p.name LIKE ? OR p.description LIKE ?) " +
                    "ORDER BY p.id DESC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm cây trồng: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getPlantsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.is_active = true AND p.price >= ? AND p.price <= ? " +
                    "ORDER BY p.price ASC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setBigDecimal(1, minPrice);
            stmt.setBigDecimal(2, maxPrice);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy cây trồng theo khoảng giá: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> getPlantsByCategoryAndPriceRange(int categoryId, BigDecimal minPrice, BigDecimal maxPrice) {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.is_active = true AND p.category_id = ? AND p.price >= ? AND p.price <= ? " +
                    "ORDER BY p.price ASC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            stmt.setBigDecimal(2, minPrice);
            stmt.setBigDecimal(3, maxPrice);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy cây trồng theo danh mục và khoảng giá: " + e.getMessage());
        }
        return plants;
    }
    
    public List<Plant> searchPlantsWithFilters(String keyword, Integer categoryId, BigDecimal minPrice, BigDecimal maxPrice) {
        List<Plant> plants = new ArrayList<>();
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("SELECT p.*, c.name as category_name FROM plants p ");
        sqlBuilder.append("LEFT JOIN categories c ON p.category_id = c.id ");
        sqlBuilder.append("WHERE p.is_active = true ");
        
        List<Object> parameters = new ArrayList<>();
        int paramIndex = 1;
        
        // Thêm điều kiện tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sqlBuilder.append("AND (p.name LIKE ? OR p.description LIKE ?) ");
            parameters.add("%" + keyword + "%");
            parameters.add("%" + keyword + "%");
        }
        
        // Thêm điều kiện danh mục
        if (categoryId != null && categoryId > 0) {
            sqlBuilder.append("AND p.category_id = ? ");
            parameters.add(categoryId);
        }
        
        // Thêm điều kiện khoảng giá
        if (minPrice != null) {
            sqlBuilder.append("AND p.price >= ? ");
            parameters.add(minPrice);
        }
        
        if (maxPrice != null) {
            sqlBuilder.append("AND p.price <= ? ");
            parameters.add(maxPrice);
        }
        
        sqlBuilder.append("ORDER BY p.id DESC");
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBuilder.toString())) {
            
            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Plant plant = mapResultSetToPlant(rs);
                    plants.add(plant);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm cây trồng với bộ lọc: " + e.getMessage());
        }
        return plants;
    }
    
    public boolean addPlant(Plant plant) {
        String sql = "INSERT INTO plants (name, price, image_url, description, stock, category_id, is_active) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, plant.getName());
            stmt.setBigDecimal(2, plant.getPrice());
            stmt.setString(3, plant.getImageUrl());
            stmt.setString(4, plant.getDescription());
            stmt.setInt(5, plant.getStock());
            stmt.setInt(6, plant.getCategoryId());
            stmt.setBoolean(7, plant.isActive());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm cây trồng: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updatePlant(Plant plant) {
        String sql = "UPDATE plants SET name = ?, price = ?, image_url = ?, description = ?, " +
                    "stock = ?, category_id = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, plant.getName());
            stmt.setBigDecimal(2, plant.getPrice());
            stmt.setString(3, plant.getImageUrl());
            stmt.setString(4, plant.getDescription());
            stmt.setInt(5, plant.getStock());
            stmt.setInt(6, plant.getCategoryId());
            stmt.setBoolean(7, plant.isActive());
            stmt.setInt(8, plant.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật cây trồng: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updatePlantRating(int plantId, double rating) {
        String sql = "UPDATE plants SET rating_avg = ? WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDouble(1, rating);
            stmt.setInt(2, plantId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật rating trung bình: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deletePlant(int id) {
        String sql = "UPDATE plants SET is_active = false WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa cây trồng: " + e.getMessage());
            return false;
        }
    }
    
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY name";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách danh mục: " + e.getMessage());
        }
        return categories;
    }
    
    public List<Plant> getLowStockPlants() {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.stock <= 10 AND p.is_active = true " +
                    "ORDER BY p.stock ASC";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Plant plant = mapResultSetToPlant(rs);
                plants.add(plant);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách cây trồng sắp hết hàng: " + e.getMessage());
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
        plant.setRatingAvg(rs.getDouble("rating_avg"));
        plant.setCategoryId(rs.getInt("category_id"));
        plant.setCategoryName(rs.getString("category_name"));
        plant.setActive(rs.getBoolean("is_active"));
        
        return plant;
    }
} 