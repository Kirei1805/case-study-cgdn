package repository.category;

import model.Category;
import java.util.List;

public interface CategoryRepository {
    List<Category> getAllCategories();
    Category getCategoryById(int id);
    boolean createCategory(Category category);
    boolean updateCategory(Category category);
    boolean deleteCategory(int id);
}
