package model;

import java.time.LocalDateTime;

public class Review {
	private int id;
	private int userId;
	private int plantId;
	private int rating;
	private String comment;
	private LocalDateTime reviewDate;
	private User user;
	private Plant plant;

	public Review() {}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }
	public int getPlantId() { return plantId; }
	public void setPlantId(int plantId) { this.plantId = plantId; }
	public int getRating() { return rating; }
	public void setRating(int rating) { this.rating = rating; }
	public String getComment() { return comment; }
	public void setComment(String comment) { this.comment = comment; }
	public LocalDateTime getReviewDate() { return reviewDate; }
	public void setReviewDate(LocalDateTime reviewDate) { this.reviewDate = reviewDate; }
	public User getUser() { return user; }
	public void setUser(User user) { this.user = user; }
	public Plant getPlant() { return plant; }
	public void setPlant(Plant plant) { this.plant = plant; }
}
