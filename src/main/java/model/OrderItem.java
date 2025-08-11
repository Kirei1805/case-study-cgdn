package model;

import java.math.BigDecimal;

public class OrderItem {
    private int id;
    private int orderId;
    private int plantId;
    private int quantity;
    private BigDecimal unitPrice;
    private Plant plant;
    
    public OrderItem() {}
    
    public OrderItem(int orderId, int plantId, int quantity, BigDecimal unitPrice) {
        this.orderId = orderId;
        this.plantId = plantId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    
    public int getPlantId() { return plantId; }
    public void setPlantId(int plantId) { this.plantId = plantId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    
    public Plant getPlant() { return plant; }
    public void setPlant(Plant plant) { this.plant = plant; }
    
    // Tính tổng tiền cho item này
    public BigDecimal getSubtotal() {
        if (unitPrice != null) {
            return unitPrice.multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }
    
    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", orderId=" + orderId +
                ", plantId=" + plantId +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                '}';
    }
} 