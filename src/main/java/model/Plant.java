package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Plant {
    private int id;
    private String name;
    private BigDecimal price;
    private String imageUrl;
    private String description;
    private int stock;
    private double ratingAvg;
    private int categoryId;
    private String categoryName;
    private boolean isActive;
    private LocalDateTime createdAt;
    
    public Plant() {}
    
    public Plant(int id, String name, BigDecimal price, String imageUrl, String description, 
                 int stock, double ratingAvg, int categoryId, String categoryName, 
                 boolean isActive, LocalDateTime createdAt) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = description;
        this.stock = stock;
        this.ratingAvg = ratingAvg;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.isActive = isActive;
        this.createdAt = createdAt;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    
    public double getRatingAvg() { return ratingAvg; }
    public void setRatingAvg(double ratingAvg) { this.ratingAvg = ratingAvg; }
    
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public String getFormattedPrice() {
        return String.format("%,.0f VNĐ", price.doubleValue());
    }
    
    @Override
    public String toString() {
        return "Plant{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", categoryName='" + categoryName + '\'' +
                ", isActive=" + isActive +
                '}';
    }
} 