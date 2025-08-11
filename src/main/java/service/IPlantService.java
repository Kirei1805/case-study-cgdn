package service;

import model.Plant;
import model.Category;
import java.util.List;

public interface IPlantService {
    List<Plant> getAllPlants();
    Plant getPlantById(int id);
    List<Plant> getPlantsByCategory(int categoryId);
    List<Plant> searchPlants(String keyword);
    List<Plant> getPlantsByPriceRange(java.math.BigDecimal minPrice, java.math.BigDecimal maxPrice);
    List<Plant> getPlantsByCategoryAndPriceRange(int categoryId, java.math.BigDecimal minPrice, java.math.BigDecimal maxPrice);
    List<Plant> searchPlantsWithFilters(String keyword, Integer categoryId, java.math.BigDecimal minPrice, java.math.BigDecimal maxPrice);
    List<Plant> getLowStockPlants();
    boolean addPlant(Plant plant);
    boolean updatePlant(Plant plant);
    boolean deletePlant(int id);
    List<Category> getAllCategories();
} 