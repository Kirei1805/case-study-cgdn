package service;

import model.Plant;
import java.util.List;

public interface IRecommendationService {
    List<Plant> getRecommendedPlantsForUser(int userId, int limit);
    List<Plant> getPopularPlants(int limit);
    List<Plant> getPlantsByCategory(int categoryId, int limit);
    List<Plant> getPlantsByPriceRange(double minPrice, double maxPrice, int limit);
    List<Plant> getSimilarPlants(int plantId, int limit);
} 