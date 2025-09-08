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
import util.PaginationUtil;

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
        
        // Get filter parameters
        String categoryId = request.getParameter("category");
        String search = request.getParameter("search");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        
        // Get pagination parameters
        String pageParam = request.getParameter("page");
        String sizeParam = request.getParameter("size");
        
        int page = 1;
        int size = 12; // Default page size for products
        
        try {
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            if (sizeParam != null && !sizeParam.trim().isEmpty()) {
                size = Integer.parseInt(sizeParam);
                // Limit page size to reasonable values
                size = Math.min(Math.max(size, 1), 100);
            }
        } catch (NumberFormatException e) {
            // Use defaults if invalid numbers
        }
        
        // Get all plants based on filters
        List<Plant> allPlants;
        
        if (search != null && !search.trim().isEmpty()) {
            // Tìm kiếm theo tên
            allPlants = plantService.searchPlantsByName(search.trim());
        } else if (categoryId != null && !categoryId.trim().isEmpty()) {
            // Lọc theo loại
            allPlants = plantService.getPlantsByCategory(Integer.parseInt(categoryId));
        } else if (minPrice != null && maxPrice != null && !minPrice.trim().isEmpty() && !maxPrice.trim().isEmpty()) {
            // Lọc theo khoảng giá
            BigDecimal min = new BigDecimal(minPrice);
            BigDecimal max = new BigDecimal(maxPrice);
            allPlants = plantService.getPlantsByPriceRange(min, max);
        } else {
            // Hiển thị tất cả
            allPlants = plantService.getAllPlants();
        }
        
        // Create pagination
        PaginationUtil<Plant> pagination = new PaginationUtil<>(allPlants, page, size);
        List<Plant> plants = pagination.getPageItems();
        
        // Build other params for pagination links
        StringBuilder otherParams = new StringBuilder();
        if (search != null && !search.trim().isEmpty()) {
            otherParams.append("search=").append(search);
        }
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("category=").append(categoryId);
        }
        if (minPrice != null && !minPrice.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("minPrice=").append(minPrice);
        }
        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("maxPrice=").append(maxPrice);
        }
        if (sizeParam != null && !sizeParam.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("size=").append(size);
        }
        
        List<Category> categories = categoryService.getAllCategories();
        
        // Set attributes
        request.setAttribute("plants", plants);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", categoryId);
        request.setAttribute("searchTerm", search);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("pagination", pagination);
        request.setAttribute("pageUrl", request.getContextPath() + "/plants?");
        request.setAttribute("otherParams", otherParams.toString());
        
        request.getRequestDispatcher("/WEB-INF/view/plant/plant-list.jsp").forward(request, response);
    }
}
