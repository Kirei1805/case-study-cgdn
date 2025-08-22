package service.plant;

import model.Plant;

import java.math.BigDecimal;
import java.util.List;

public interface PlantService {
    List<Plant> getAllPlants();
    List<Plant> getPlantsByCategory(int categoryId);
    List<Plant> searchPlantsByName(String name);
    Plant getPlantById(int id);
    List<Plant> getRelatedPlants(int plantId, int categoryId, int limit);
    boolean createPlant(Plant plant);
    boolean updatePlant(Plant plant);
    boolean deletePlant(int plantId);
    List<Plant> getPlantsByStatus(boolean isActive);
    List<Plant> getPlantsByPriceRange(BigDecimal min, BigDecimal max);
}
