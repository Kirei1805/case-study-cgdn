package service;

import model.Plant;
import model.Category;
import repository.PlantRepository;
import repository.CategoryRepository;
import java.util.List;
import java.math.BigDecimal;

public class PlantService {
	private final PlantRepository plantRepository;
	private final CategoryRepository categoryRepository;

	public PlantService() {
		this.plantRepository = new PlantRepository();
		this.categoryRepository = new CategoryRepository();
	}

	public List<Plant> getAllPlants() {
		return plantRepository.getAllPlants();
	}

	public List<Plant> getPlantsByCategory(int categoryId) {
		return plantRepository.getPlantsByCategory(categoryId);
	}

	public List<Plant> searchPlantsByName(String searchTerm) {
		return plantRepository.searchPlantsByName(searchTerm);
	}

	public List<Plant> getPlantsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
		return plantRepository.getPlantsByPriceRange(minPrice, maxPrice);
	}

	public Plant getPlantById(int id) {
		return plantRepository.getPlantById(id);
	}

	public List<Category> getAllCategories() {
		return categoryRepository.getAllCategories();
	}
}
