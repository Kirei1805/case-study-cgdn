package repository;

import java.sql.*;
import java.util.*;

public class StatisticsRepository {
    
    public StatisticsRepository() {
        // Không cần khởi tạo DBRepository nữa vì đã dùng static method
    }
    
    public List<Map<String, Object>> getBestSellingProducts(int limit) {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price, p.stock, c.name as category_name, " +
                    "COUNT(oi.id) as total_orders, SUM(oi.quantity) as total_quantity, " +
                    "SUM(oi.quantity * oi.unit_price) as total_revenue " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "LEFT JOIN order_items oi ON p.id = oi.plant_id " +
                    "LEFT JOIN orders o ON oi.order_id = o.id " +
                    "WHERE p.is_active = true " +
                    "AND (o.status IS NULL OR o.status != 'cancelled') " +
                    "GROUP BY p.id " +
                    "ORDER BY total_quantity DESC, total_revenue DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("id", rs.getInt("id"));
                    product.put("name", rs.getString("name"));
                    product.put("price", rs.getBigDecimal("price"));
                    product.put("stock", rs.getInt("stock"));
                    product.put("categoryName", rs.getString("category_name"));
                    product.put("totalOrders", rs.getInt("total_orders"));
                    product.put("totalQuantity", rs.getInt("total_quantity"));
                    product.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                    results.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm bán chạy: " + e.getMessage());
        }
        return results;
    }
    
    public List<Map<String, Object>> getBestSellingProductsByCategory(int categoryId, int limit) {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price, p.stock, c.name as category_name, " +
                    "COUNT(oi.id) as total_orders, SUM(oi.quantity) as total_quantity, " +
                    "SUM(oi.quantity * oi.unit_price) as total_revenue " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "LEFT JOIN order_items oi ON p.id = oi.plant_id " +
                    "LEFT JOIN orders o ON oi.order_id = o.id " +
                    "WHERE p.is_active = true AND p.category_id = ? " +
                    "AND (o.status IS NULL OR o.status != 'cancelled') " +
                    "GROUP BY p.id " +
                    "ORDER BY total_quantity DESC, total_revenue DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            stmt.setInt(2, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("id", rs.getInt("id"));
                    product.put("name", rs.getString("name"));
                    product.put("price", rs.getBigDecimal("price"));
                    product.put("stock", rs.getInt("stock"));
                    product.put("categoryName", rs.getString("category_name"));
                    product.put("totalOrders", rs.getInt("total_orders"));
                    product.put("totalQuantity", rs.getInt("total_quantity"));
                    product.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                    results.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm bán chạy theo danh mục: " + e.getMessage());
        }
        return results;
    }
    
    public List<Map<String, Object>> getBestSellingProductsByPeriod(String period, int limit) {
        List<Map<String, Object>> results = new ArrayList<>();
        String dateFilter = "";
        
        switch (period.toLowerCase()) {
            case "week":
                dateFilter = "AND o.order_date >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
                break;
            case "month":
                dateFilter = "AND o.order_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)";
                break;
            case "quarter":
                dateFilter = "AND o.order_date >= DATE_SUB(NOW(), INTERVAL 90 DAY)";
                break;
            case "year":
                dateFilter = "AND o.order_date >= DATE_SUB(NOW(), INTERVAL 365 DAY)";
                break;
            default:
                dateFilter = "";
        }
        
        String sql = "SELECT p.id, p.name, p.price, p.stock, c.name as category_name, " +
                    "COUNT(oi.id) as total_orders, SUM(oi.quantity) as total_quantity, " +
                    "SUM(oi.quantity * oi.unit_price) as total_revenue " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "LEFT JOIN order_items oi ON p.id = oi.plant_id " +
                    "LEFT JOIN orders o ON oi.order_id = o.id " +
                    "WHERE p.is_active = true " +
                    "AND (o.status IS NULL OR o.status != 'cancelled') " +
                    dateFilter + " " +
                    "GROUP BY p.id " +
                    "ORDER BY total_quantity DESC, total_revenue DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("id", rs.getInt("id"));
                    product.put("name", rs.getString("name"));
                    product.put("price", rs.getBigDecimal("price"));
                    product.put("stock", rs.getInt("stock"));
                    product.put("categoryName", rs.getString("category_name"));
                    product.put("totalOrders", rs.getInt("total_orders"));
                    product.put("totalQuantity", rs.getInt("total_quantity"));
                    product.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                    results.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm bán chạy theo thời gian: " + e.getMessage());
        }
        return results;
    }
    
    public Map<String, Object> getSalesStatistics() {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT " +
                    "COUNT(DISTINCT o.id) as total_orders, " +
                    "COUNT(DISTINCT o.user_id) as total_customers, " +
                    "SUM(oi.quantity * oi.unit_price) as total_revenue, " +
                    "AVG(oi.quantity * oi.unit_price) as avg_order_value, " +
                    "SUM(oi.quantity) as total_items_sold " +
                    "FROM orders o " +
                    "LEFT JOIN order_items oi ON o.id = oi.order_id " +
                    "WHERE o.status != 'cancelled'";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                stats.put("totalOrders", rs.getInt("total_orders"));
                stats.put("totalCustomers", rs.getInt("total_customers"));
                stats.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                stats.put("avgOrderValue", rs.getBigDecimal("avg_order_value"));
                stats.put("totalItemsSold", rs.getInt("total_items_sold"));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy thống kê bán hàng: " + e.getMessage());
        }
        return stats;
    }
    
    public Map<String, Object> getCategorySalesStatistics() {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT c.name as category_name, " +
                    "COUNT(DISTINCT o.id) as total_orders, " +
                    "SUM(oi.quantity) as total_quantity, " +
                    "SUM(oi.quantity * oi.unit_price) as total_revenue " +
                    "FROM categories c " +
                    "LEFT JOIN plants p ON c.id = p.category_id " +
                    "LEFT JOIN order_items oi ON p.id = oi.plant_id " +
                    "LEFT JOIN orders o ON oi.order_id = o.id " +
                    "WHERE (o.status IS NULL OR o.status != 'cancelled') " +
                    "GROUP BY c.id " +
                    "ORDER BY total_revenue DESC";
        
        List<Map<String, Object>> categoryStats = new ArrayList<>();
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> category = new HashMap<>();
                category.put("categoryName", rs.getString("category_name"));
                category.put("totalOrders", rs.getInt("total_orders"));
                category.put("totalQuantity", rs.getInt("total_quantity"));
                category.put("totalRevenue", rs.getBigDecimal("total_revenue"));
                categoryStats.add(category);
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy thống kê theo danh mục: " + e.getMessage());
        }
        
        stats.put("categoryStats", categoryStats);
        return stats;
    }
    
    public List<Map<String, Object>> getTopRatedProducts(int limit) {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price, p.stock, c.name as category_name, " +
                    "p.rating_avg, COUNT(r.id) as review_count " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "LEFT JOIN reviews r ON p.id = r.plant_id AND r.is_active = true " +
                    "WHERE p.is_active = true AND p.rating_avg > 0 " +
                    "GROUP BY p.id " +
                    "ORDER BY p.rating_avg DESC, review_count DESC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("id", rs.getInt("id"));
                    product.put("name", rs.getString("name"));
                    product.put("price", rs.getBigDecimal("price"));
                    product.put("stock", rs.getInt("stock"));
                    product.put("categoryName", rs.getString("category_name"));
                    product.put("ratingAvg", rs.getDouble("rating_avg"));
                    product.put("reviewCount", rs.getInt("review_count"));
                    results.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm đánh giá cao: " + e.getMessage());
        }
        return results;
    }
    
    public List<Map<String, Object>> getLowStockProducts(int limit) {
        List<Map<String, Object>> results = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price, p.stock, c.name as category_name " +
                    "FROM plants p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.is_active = true AND p.stock <= 10 " +
                    "ORDER BY p.stock ASC " +
                    "LIMIT ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> product = new HashMap<>();
                    product.put("id", rs.getInt("id"));
                    product.put("name", rs.getString("name"));
                    product.put("price", rs.getBigDecimal("price"));
                    product.put("stock", rs.getInt("stock"));
                    product.put("categoryName", rs.getString("category_name"));
                    results.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sản phẩm sắp hết hàng: " + e.getMessage());
        }
        return results;
    }
} 