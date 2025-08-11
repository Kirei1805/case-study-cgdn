package controller;

import model.Plant;
import model.Category;
import service.IPlantService;
import service.PlantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/plants")
public class PlantController extends HttpServlet {
    private IPlantService plantService;
    
    @Override
    public void init() throws ServletException {
        plantService = new PlantService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String categoryId = request.getParameter("category");
        String search = request.getParameter("search");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        
        List<Plant> plants;
        List<Category> categories = plantService.getAllCategories();
        
        // Xử lý các tham số tìm kiếm và lọc
        String searchKeyword = (search != null && !search.trim().isEmpty()) ? search.trim() : null;
        Integer selectedCategory = null;
        java.math.BigDecimal minPriceValue = null;
        java.math.BigDecimal maxPriceValue = null;
        
        // Xử lý category
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                selectedCategory = Integer.parseInt(categoryId);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu category không hợp lệ
            }
        }
        
        // Xử lý khoảng giá
        if (minPrice != null && !minPrice.trim().isEmpty()) {
            try {
                minPriceValue = new java.math.BigDecimal(minPrice);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu giá không hợp lệ
            }
        }
        
        if (maxPrice != null && !maxPrice.trim().isEmpty()) {
            try {
                maxPriceValue = new java.math.BigDecimal(maxPrice);
            } catch (NumberFormatException e) {
                // Bỏ qua nếu giá không hợp lệ
            }
        }
        
        // Sử dụng phương thức tìm kiếm với bộ lọc
        plants = plantService.searchPlantsWithFilters(searchKeyword, selectedCategory, minPriceValue, maxPriceValue);
        
        // Set các thuộc tính để hiển thị lại trên form
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        
        request.setAttribute("plants", plants);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/view/listPlant.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 