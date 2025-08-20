package model;

import java.math.BigDecimal;

public class Plant {
    private int id;
    private String name;
    private BigDecimal price;
    private String imageUrl;
    private String description;
    private int stock;
    private float ratingAvg;
    private int categoryId;
    private boolean isActive;
    private Category category;

    public Plant() {}

    public Plant(int id, String name, BigDecimal price, String imageUrl, String description, 
                 int stock, float ratingAvg, int categoryId, boolean isActive) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.description = description;
        this.stock = stock;
        this.ratingAvg = ratingAvg;
        this.categoryId = categoryId;
        this.isActive = isActive;
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

    public float getRatingAvg() { return ratingAvg; }
    public void setRatingAvg(float ratingAvg) { this.ratingAvg = ratingAvg; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public Category getCategory() { return category; }
    public void setCategory(Category category) { this.category = category; }
}
