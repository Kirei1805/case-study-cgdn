package model;

import java.math.BigDecimal;

public class CartItem {
    private int id;
    private int userId;
    private int plantId;
    private int quantity;
    private Plant plant;

    public CartItem() {}

    public CartItem(int id, int userId, int plantId, int quantity) {
        this.id = id;
        this.userId = userId;
        this.plantId = plantId;
        this.quantity = quantity;
    }

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

    public BigDecimal getSubtotal() {
        if (plant == null || plant.getPrice() == null) return BigDecimal.ZERO;
        return plant.getPrice().multiply(new BigDecimal(quantity));
    }
}
