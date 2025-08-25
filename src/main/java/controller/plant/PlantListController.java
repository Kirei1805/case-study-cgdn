package controller.plant;

import service.plant.PlantService;
import service.plant.PlantServiceImpl;
import service.category.CategoryService;
import service.category.CategoryServiceImpl;
import model.Plant;
import model.Category;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.math.BigDecimal;

@WebServlet("/plants")
public class PlantListController extends HttpServlet {
    private PlantService plantService;
    private CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        plantService = new PlantServiceImpl();
        categoryService = new CategoryServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String categoryId = request.getParameter("category");
        String search = request.getParameter("search");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        
        List<Plant> plants;
        
        if (search != null && !search.trim().isEmpty()) {
            // Tìm kiếm theo tên
            plants = plantService.searchPlantsByName(search.trim());
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
            // Lọc theo loại
            plants = plantService.getPlantsByCategory(Integer.parseInt(categoryId));
        } else if (minPrice != null && maxPrice != null && !minPrice.trim().isEmpty() && !maxPrice.trim().isEmpty()) {
            // Lọc theo khoảng giá
            BigDecimal min = new BigDecimal(minPrice);
            BigDecimal max = new BigDecimal(maxPrice);
            plants = plantService.getPlantsByPriceRange(min, max);
        } else {
            // Hiển thị tất cả
            plants = plantService.getAllPlants();
        }
        
        List<Category> categories = categoryService.getAllCategories();
        
        request.setAttribute("plants", plants);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", categoryId);
        request.setAttribute("searchTerm", search);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        
        request.getRequestDispatcher("/WEB-INF/view/plant/plant-list.jsp").forward(request, response);
    }
}
