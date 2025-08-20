package model;

import java.time.LocalDateTime;

public class WishlistItem {
	private int id;
	private int userId;
	private int plantId;
	private LocalDateTime createdAt;
	private Plant plant;

	public WishlistItem() {}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }
	public int getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }
	public int getPlantId() { return plantId; }
	public void setPlantId(int plantId) { this.plantId = plantId; }
	public LocalDateTime getCreatedAt() { return createdAt; }
	public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
	public Plant getPlant() { return plant; }
	public void setPlant(Plant plant) { this.plant = plant; }
}
