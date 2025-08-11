package controller;

import model.Plant;
import model.User;
import service.IRecommendationService;
import service.RecommendationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "RecommendationController", urlPatterns = {"/recommendations/*"})
public class RecommendationController extends HttpServlet {
    private IRecommendationService recommendationService;
    
    @Override
    public void init() throws ServletException {
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
        
        if (pathInfo.equals("/for-user")) {
            showUserRecommendations(request, response);
        } else if (pathInfo.equals("/popular")) {
            showPopularPlants(request, response);
        } else if (pathInfo.equals("/top-rated")) {
            showTopRatedPlants(request, response);
        } else if (pathInfo.equals("/best-sellers")) {
            showBestSellers(request, response);
        } else if (pathInfo.equals("/new-arrivals")) {
            showNewArrivals(request, response);
        } else if (pathInfo.startsWith("/similar/")) {
            String plantIdStr = pathInfo.substring(9); // Bỏ "/similar/"
            showSimilarPlants(request, response, plantIdStr);
        } else if (pathInfo.startsWith("/category/")) {
            String categoryIdStr = pathInfo.substring(10); // Bỏ "/category/"
            showCategoryRecommendations(request, response, categoryIdStr);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void showUserRecommendations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String limitStr = request.getParameter("limit");
        int limit = 8; // Mặc định 8 sản phẩm
        
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 20) limit = 20; // Giới hạn tối đa 20 sản phẩm
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        List<Plant> recommendedPlants = recommendationService.getRecommendedPlantsForUser(user.getId(), limit);
        request.setAttribute("recommendedPlants", recommendedPlants);
        request.setAttribute("title", "Gợi ý cho bạn");
        request.setAttribute("subtitle", "Dựa trên sở thích và lịch sử mua hàng của bạn");
        
        request.getRequestDispatcher("/WEB-INF/view/recommendations.jsp").forward(request, response);
    }
    
    private void showPopularPlants(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String limitStr = request.getParameter("limit");
        int limit = 8;
        
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 20) limit = 20;
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        List<Plant> popularPlants = recommendationService.getPopularPlants(limit);
        request.setAttribute("recommendedPlants", popularPlants);
        request.setAttribute("title", "Sản phẩm phổ biến");
        request.setAttribute("subtitle", "Những sản phẩm được nhiều người mua nhất");
        
        request.getRequestDispatcher("/WEB-INF/view/recommendations.jsp").forward(request, response);
    }
    
    private void showTopRatedPlants(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String limitStr = request.getParameter("limit");
        int limit = 8;
        
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 20) limit = 20;
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        RecommendationService service = (RecommendationService) recommendationService;
        List<Plant> topRatedPlants = service.getTopRatedPlants(limit);
        request.setAttribute("recommendedPlants", topRatedPlants);
        request.setAttribute("title", "Sản phẩm đánh giá cao");
        request.setAttribute("subtitle", "Những sản phẩm được đánh giá tốt nhất");
        
        request.getRequestDispatcher("/WEB-INF/view/recommendations.jsp").forward(request, response);
    }
    
    private void showBestSellers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String limitStr = request.getParameter("limit");
        int limit = 8;
        
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 20) limit = 20;
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        RecommendationService service = (RecommendationService) recommendationService;
        List<Plant> bestSellers = service.getBestSellers(limit);
        request.setAttribute("recommendedPlants", bestSellers);
        request.setAttribute("title", "Bán chạy nhất");
        request.setAttribute("subtitle", "Những sản phẩm bán chạy nhất trong tháng");
        
        request.getRequestDispatcher("/WEB-INF/view/recommendations.jsp").forward(request, response);
    }
    
    private void showNewArrivals(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String limitStr = request.getParameter("limit");
        int limit = 8;
        
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 20) limit = 20;
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        RecommendationService service = (RecommendationService) recommendationService;
        List<Plant> newArrivals = service.getNewArrivals(limit);
        request.setAttribute("recommendedPlants", newArrivals);
        request.setAttribute("title", "Sản phẩm mới");
        request.setAttribute("subtitle", "Những sản phẩm mới nhất trong cửa hàng");
        
        request.getRequestDispatcher("/WEB-INF/view/recommendations.jsp").forward(request, response);
    }
    
    private void showSimilarPlants(HttpServletRequest request, HttpServletResponse response, String plantIdStr)
            throws ServletException, IOException {
        try {
            int plantId = Integer.parseInt(plantIdStr);
            String limitStr = request.getParameter("limit");
            int limit = 6;
            
            if (limitStr != null && !limitStr.trim().isEmpty()) {
                try {
                    limit = Integer.parseInt(limitStr);
                    if (limit > 12) limit = 12;
                } catch (NumberFormatException e) {
                    // Sử dụng giá trị mặc định
                }
            }
            
            List<Plant> similarPlants = recommendationService.getSimilarPlants(plantId, limit);
            request.setAttribute("recommendedPlants", similarPlants);
            request.setAttribute("title", "Sản phẩm tương tự");
            request.setAttribute("subtitle", "Những sản phẩm có thể bạn sẽ thích");
            
            request.getRequestDispatcher("/WEB-INF/view/recommendations.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void showCategoryRecommendations(HttpServletRequest request, HttpServletResponse response, String categoryIdStr)
            throws ServletException, IOException {
        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            String limitStr = request.getParameter("limit");
            int limit = 8;
            
            if (limitStr != null && !limitStr.trim().isEmpty()) {
                try {
                    limit = Integer.parseInt(limitStr);
                    if (limit > 20) limit = 20;
                } catch (NumberFormatException e) {
                    // Sử dụng giá trị mặc định
                }
            }
            
            List<Plant> categoryPlants = recommendationService.getPlantsByCategory(categoryId, limit);
            request.setAttribute("recommendedPlants", categoryPlants);
            request.setAttribute("title", "Sản phẩm trong danh mục");
            request.setAttribute("subtitle", "Những sản phẩm tốt nhất trong danh mục này");
            
            request.getRequestDispatcher("/WEB-INF/view/recommendations.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
} 