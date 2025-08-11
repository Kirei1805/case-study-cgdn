package model;

import java.time.LocalDateTime;

public class Review {
    private int id;
    private int userId;
    private int plantId;
    private int rating;
    private String comment;
    private LocalDateTime reviewDate;
    private boolean isActive;
    
    // Thêm các object để hiển thị thông tin
    private User user;
    private Plant plant;
    
    public Review() {
        this.reviewDate = LocalDateTime.now();
        this.isActive = true;
    }
    
    public Review(int userId, int plantId, int rating, String comment) {
        this();
        this.userId = userId;
        this.plantId = plantId;
        this.rating = rating;
        this.comment = comment;
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
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getComment() {
        return comment;
    }
    
    public void setComment(String comment) {
        this.comment = comment;
    }
    
    public LocalDateTime getReviewDate() {
        return reviewDate;
    }
    
    public void setReviewDate(LocalDateTime reviewDate) {
        this.reviewDate = reviewDate;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public Plant getPlant() {
        return plant;
    }
    
    public void setPlant(Plant plant) {
        this.plant = plant;
    }
    
    // Helper methods
    public String getRatingDisplay() {
        switch (rating) {
            case 1: return "Rất không hài lòng";
            case 2: return "Không hài lòng";
            case 3: return "Bình thường";
            case 4: return "Hài lòng";
            case 5: return "Rất hài lòng";
            default: return "Chưa đánh giá";
        }
    }
    
    public String getRatingStars() {
        StringBuilder stars = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars.append("★");
            } else {
                stars.append("☆");
            }
        }
        return stars.toString();
    }
    
    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", userId=" + userId +
                ", plantId=" + plantId +
                ", rating=" + rating +
                ", comment='" + comment + '\'' +
                ", reviewDate=" + reviewDate +
                ", isActive=" + isActive +
                '}';
    }
} 