package repository;

import model.CartItem;
import model.Plant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartRepository {
    
    public CartRepository() {
        // Không cần khởi tạo DBRepository nữa vì đã dùng static method
    }
    
    public List<CartItem> getCartItemsByUserId(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT ci.*, p.*, c.name as category_name FROM cart_items ci " +
                    "LEFT JOIN plants p ON ci.plant_id = p.id " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE ci.user_id = ? AND p.is_active = true";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CartItem cartItem = mapResultSetToCartItem(rs);
                    cartItems.add(cartItem);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy giỏ hàng: " + e.getMessage());
        }
        return cartItems;
    }
    
    public boolean addToCart(CartItem cartItem) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        CartItem existingItem = getCartItemByUserAndPlant(cartItem.getUserId(), cartItem.getPlantId());
        
        if (existingItem != null) {
            // Nếu đã có, cập nhật số lượng
            return updateCartItemQuantity(existingItem.getId(), existingItem.getQuantity() + cartItem.getQuantity());
        } else {
            // Nếu chưa có, thêm mới
            String sql = "INSERT INTO cart_items (user_id, plant_id, quantity) VALUES (?, ?, ?)";
            
            try (Connection conn = DBRepository.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                
                stmt.setInt(1, cartItem.getUserId());
                stmt.setInt(2, cartItem.getPlantId());
                stmt.setInt(3, cartItem.getQuantity());
                
                return stmt.executeUpdate() > 0;
            } catch (SQLException e) {
                System.err.println("Lỗi khi thêm vào giỏ hàng: " + e.getMessage());
                return false;
            }
        }
    }
    
    public boolean updateCartItemQuantity(int cartItemId, int newQuantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartItemId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật số lượng giỏ hàng: " + e.getMessage());
            return false;
        }
    }
    
    public boolean removeFromCart(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, cartItemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa khỏi giỏ hàng: " + e.getMessage());
            return false;
        }
    }
    
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa giỏ hàng: " + e.getMessage());
            return false;
        }
    }
    
    public CartItem getCartItemByUserAndPlant(int userId, int plantId) {
        String sql = "SELECT * FROM cart_items WHERE user_id = ? AND plant_id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, plantId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCartItem(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy cart item: " + e.getMessage());
        }
        return null;
    }
    
    public int getCartItemCount(int userId) {
        String sql = "SELECT COUNT(*) FROM cart_items WHERE user_id = ?";
        
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi đếm giỏ hàng: " + e.getMessage());
        }
        return 0;
    }
    
    private CartItem mapResultSetToCartItem(ResultSet rs) throws SQLException {
        CartItem cartItem = new CartItem();
        cartItem.setId(rs.getInt("id"));
        cartItem.setUserId(rs.getInt("user_id"));
        cartItem.setPlantId(rs.getInt("plant_id"));
        cartItem.setQuantity(rs.getInt("quantity"));
        
        // Tạo đối tượng Plant
        Plant plant = new Plant();
        plant.setId(rs.getInt("plant_id"));
        plant.setName(rs.getString("name"));
        plant.setPrice(rs.getBigDecimal("price"));
        plant.setImageUrl(rs.getString("image_url"));
        plant.setDescription(rs.getString("description"));
        plant.setStock(rs.getInt("stock"));
        plant.setRatingAvg(rs.getDouble("rating_avg"));
        plant.setCategoryId(rs.getInt("category_id"));
        plant.setCategoryName(rs.getString("category_name"));
        plant.setActive(rs.getBoolean("is_active"));
        
        cartItem.setPlant(plant);
        
        return cartItem;
    }
} 