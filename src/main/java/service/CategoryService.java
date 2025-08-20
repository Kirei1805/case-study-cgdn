package service;

import model.Category;
import repository.CategoryRepository;
import java.util.List;

public class CategoryService {
	private final CategoryRepository categoryRepository;

	public CategoryService() {
		this.categoryRepository = new CategoryRepository();
	}

	public List<Category> getAllCategories() {
		return categoryRepository.getAllCategories();
	}
}
