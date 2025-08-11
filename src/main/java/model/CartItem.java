package model;

import java.math.BigDecimal;

public class CartItem {
    private int id;
    private int userId;
    private int plantId;
    private int quantity;
    private Plant plant; // Để lấy thông tin cây trồng
    
    public CartItem() {}
    
    public CartItem(int userId, int plantId, int quantity) {
        this.userId = userId;
        this.plantId = plantId;
        this.quantity = quantity;
    }
    
    public CartItem(int id, int userId, int plantId, int quantity) {
        this.id = id;
        this.userId = userId;
        this.plantId = plantId;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getPlantId() { return plantId; }
    public void setPlantId(int plantId) { this.plantId = plantId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public Plant getPlant() { return plant; }
    public void setPlant(Plant plant) { this.plant = plant; }
    
    // Tính tổng tiền cho item này
    public BigDecimal getSubtotal() {
        if (plant != null && plant.getPrice() != null) {
            return plant.getPrice().multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }
    
    @Override
    public String toString() {
        return "CartItem{" +
                "id=" + id +
                ", userId=" + userId +
                ", plantId=" + plantId +
                ", quantity=" + quantity +
                '}';
    }
} 