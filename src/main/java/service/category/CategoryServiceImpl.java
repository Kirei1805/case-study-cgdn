package service.category;

import model.Category;
import repository.category.CategoryRepository;
import repository.category.CategoryRepositoryImpl;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {
	private final CategoryRepository categoryRepository;

	public CategoryServiceImpl() {
		this.categoryRepository = new CategoryRepositoryImpl();
	}

	@Override
	public List<Category> getAllCategories() {
		return categoryRepository.getAllCategories();
	}

	@Override
	public Category getCategoryById(int id) {
		return categoryRepository.getCategoryById(id);
	}

	@Override
	public boolean createCategory(Category category) {
		return categoryRepository.createCategory(category);
	}

	@Override
	public boolean updateCategory(Category category) {
		return categoryRepository.updateCategory(category);
	}

	@Override
	public boolean deleteCategory(int id) {
		return categoryRepository.deleteCategory(id);
	}
}

