package service.plant;

import model.Plant;
import model.Category;
import repository.plant.PlantRepository;
import repository.plant.PlantRepositoryImpl;
import repository.category.CategoryRepository;
import repository.category.CategoryRepositoryImpl;
import java.util.List;
import java.math.BigDecimal;

public class PlantServiceImpl implements PlantService {
	private final PlantRepository plantRepository;
	private final CategoryRepository categoryRepository;

	public PlantServiceImpl() {
		this.plantRepository = new PlantRepositoryImpl();
		this.categoryRepository = new CategoryRepositoryImpl();
	}

	@Override
	public List<Plant> getAllPlants() {
		return plantRepository.getAllPlants();
	}

	@Override
	public List<Plant> getAllPlantsForAdmin() {
		return plantRepository.getAllPlantsForAdmin();
	}

	@Override
	public List<Plant> getPlantsByCategory(int categoryId) {
		return plantRepository.getPlantsByCategory(categoryId);
	}

	@Override
	public List<Plant> searchPlantsByName(String searchTerm) {
		return plantRepository.searchPlantsByName(searchTerm);
	}

	@Override
	public Plant getPlantById(int id) {
		return plantRepository.getPlantById(id);
	}

	@Override
	public List<Plant> getRelatedPlants(int plantId, int categoryId, int limit) {
		return plantRepository.getRelatedPlants(plantId, categoryId, limit);
	}

	@Override
	public boolean createPlant(Plant plant) {
		return plantRepository.createPlant(plant);
	}

	@Override
	public boolean updatePlant(Plant plant) {
		return plantRepository.updatePlant(plant);
	}

	@Override
	public boolean deletePlant(int plantId) {
		return plantRepository.deletePlant(plantId);
	}

	@Override
	public List<Plant> getPlantsByStatus(boolean isActive) {
		return plantRepository.getPlantsByStatus(isActive);
	}

	// Additional methods for backward compatibility
	public List<Category> getAllCategories() {
		return categoryRepository.getAllCategories();
	}

	@Override
	public List<Plant> getPlantsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
		return plantRepository.getPlantsByPriceRange(minPrice, maxPrice);
	}
}
