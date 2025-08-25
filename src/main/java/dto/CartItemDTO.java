package dto;

import java.math.BigDecimal;

public class CartItemDTO {
    private int id;
    private int userId;
    private int plantId;
    private int quantity;
    private String plantName;
    private BigDecimal plantPrice;
    private String plantImageUrl;
    private String plantDescription;
    private int plantStock;
    private float plantRatingAvg;
    private String categoryName;

    public CartItemDTO() {}

    public CartItemDTO(int id, int userId, int plantId, int quantity, String plantName, 
                      BigDecimal plantPrice, String plantImageUrl, String plantDescription, 
                      int plantStock, float plantRatingAvg, String categoryName) {
        this.id = id;
        this.userId = userId;
        this.plantId = plantId;
        this.quantity = quantity;
        this.plantName = plantName;
        this.plantPrice = plantPrice;
        this.plantImageUrl = plantImageUrl;
        this.plantDescription = plantDescription;
        this.plantStock = plantStock;
        this.plantRatingAvg = plantRatingAvg;
        this.categoryName = categoryName;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPlantId() {
        return plantId;
    }

    public void setPlantId(int plantId) {
        this.plantId = plantId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPlantName() {
        return plantName;
    }

    public void setPlantName(String plantName) {
        this.plantName = plantName;
    }

    public BigDecimal getPlantPrice() {
        return plantPrice;
    }

    public void setPlantPrice(BigDecimal plantPrice) {
        this.plantPrice = plantPrice;
    }

    public String getPlantImageUrl() {
        return plantImageUrl;
    }

    public void setPlantImageUrl(String plantImageUrl) {
        this.plantImageUrl = plantImageUrl;
    }

    public String getPlantDescription() {
        return plantDescription;
    }

    public void setPlantDescription(String plantDescription) {
        this.plantDescription = plantDescription;
    }

    public int getPlantStock() {
        return plantStock;
    }

    public void setPlantStock(int plantStock) {
        this.plantStock = plantStock;
    }

    public float getPlantRatingAvg() {
        return plantRatingAvg;
    }

    public void setPlantRatingAvg(float plantRatingAvg) {
        this.plantRatingAvg = plantRatingAvg;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public BigDecimal getSubtotal() {
        return plantPrice.multiply(BigDecimal.valueOf(quantity));
    }
}

