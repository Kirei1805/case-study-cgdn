package controller;

import model.Plant;
import model.Category;
import service.IPlantService;
import service.PlantService;
import service.IRecommendationService;
import service.RecommendationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/plants/detail/*")
public class PlantDetailController extends HttpServlet {
    private IPlantService plantService;
    private IRecommendationService recommendationService;
    
    @Override
    public void init() throws ServletException {
        plantService = new PlantService();
        recommendationService = new RecommendationService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Lấy plant ID từ URL path
        String plantIdStr = pathInfo.substring(1); // Bỏ "/"
        
        try {
            int plantId = Integer.parseInt(plantIdStr);
            
            // Lấy thông tin sản phẩm
            Plant plant = plantService.getPlantById(plantId);
            
            if (plant == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            // Lấy danh sách danh mục
            List<Category> categories = plantService.getAllCategories();
            
            // Lấy sản phẩm tương tự
            List<Plant> relatedPlants = recommendationService.getSimilarPlants(plantId, 8);
            
            // Set attributes
            request.setAttribute("plant", plant);
            request.setAttribute("categories", categories);
            request.setAttribute("relatedPlants", relatedPlants);
            
            // Forward đến trang chi tiết
            request.getRequestDispatcher("/WEB-INF/view/plant-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
} 