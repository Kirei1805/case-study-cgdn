package service;

import model.Plant;
import model.Category;
import repository.PlantRepository;
import java.util.List;

public class PlantService implements IPlantService {
    private PlantRepository plantRepository;
    
    public PlantService() {
        this.plantRepository = new PlantRepository();
    }
    
    @Override
    public List<Plant> getAllPlants() {
        return plantRepository.getAllPlants();
    }
    
    @Override
    public Plant getPlantById(int id) {
        if (id <= 0) {
            return null;
        }
        return plantRepository.getPlantById(id);
    }
    
    @Override
    public List<Plant> getPlantsByCategory(int categoryId) {
        if (categoryId <= 0) {
            return plantRepository.getAllPlants();
        }
        return plantRepository.getPlantsByCategory(categoryId);
    }
    
    @Override
    public List<Plant> searchPlants(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return plantRepository.getAllPlants();
        }
        return plantRepository.searchPlants(keyword.trim());
    }
    
    @Override
    public List<Plant> getPlantsByPriceRange(java.math.BigDecimal minPrice, java.math.BigDecimal maxPrice) {
        if (minPrice == null || maxPrice == null || minPrice.compareTo(maxPrice) > 0) {
            return plantRepository.getAllPlants();
        }
        return plantRepository.getPlantsByPriceRange(minPrice, maxPrice);
    }
    
    @Override
    public List<Plant> getPlantsByCategoryAndPriceRange(int categoryId, java.math.BigDecimal minPrice, java.math.BigDecimal maxPrice) {
        if (categoryId <= 0 || minPrice == null || maxPrice == null || minPrice.compareTo(maxPrice) > 0) {
            return plantRepository.getAllPlants();
        }
        return plantRepository.getPlantsByCategoryAndPriceRange(categoryId, minPrice, maxPrice);
    }
    
    @Override
    public List<Plant> searchPlantsWithFilters(String keyword, Integer categoryId, java.math.BigDecimal minPrice, java.math.BigDecimal maxPrice) {
        return plantRepository.searchPlantsWithFilters(keyword, categoryId, minPrice, maxPrice);
    }
    
    @Override
    public List<Plant> getLowStockPlants() {
        return plantRepository.getLowStockPlants();
    }
    
    @Override
    public boolean addPlant(Plant plant) {
        if (plant == null || !validatePlant(plant)) {
            return false;
        }
        return plantRepository.addPlant(plant);
    }
    
    @Override
    public boolean updatePlant(Plant plant) {
        if (plant == null || plant.getId() <= 0 || !validatePlant(plant)) {
            return false;
        }
        return plantRepository.updatePlant(plant);
    }
    
    @Override
    public boolean deletePlant(int id) {
        if (id <= 0) {
            return false;
        }
        return plantRepository.deletePlant(id);
    }
    
    @Override
    public List<Category> getAllCategories() {
        return plantRepository.getAllCategories();
    }
    
    private boolean validatePlant(Plant plant) {
        return plant.getName() != null && !plant.getName().trim().isEmpty() &&
               plant.getPrice() != null && plant.getPrice().doubleValue() > 0 &&
               plant.getStock() >= 0 &&
               plant.getCategoryId() > 0;
    }
} 