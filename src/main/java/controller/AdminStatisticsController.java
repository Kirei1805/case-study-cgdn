package controller;

import model.User;
import service.IStatisticsService;
import service.StatisticsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/statistics/*")
public class AdminStatisticsController extends HttpServlet {
    private IStatisticsService statisticsService;
    
    @Override
    public void init() throws ServletException {
        statisticsService = new StatisticsService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            showDashboard(request, response);
        } else if (pathInfo.equals("/best-sellers")) {
            showBestSellers(request, response);
        } else if (pathInfo.equals("/top-rated")) {
            showTopRated(request, response);
        } else if (pathInfo.equals("/low-stock")) {
            showLowStock(request, response);
        } else if (pathInfo.equals("/category-stats")) {
            showCategoryStats(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy thống kê tổng quan
        Map<String, Object> salesStats = statisticsService.getSalesStatistics();
        Map<String, Object> categoryStats = statisticsService.getCategorySalesStatistics();
        
        // Lấy top 5 sản phẩm bán chạy
        List<Map<String, Object>> bestSellers = statisticsService.getBestSellingProducts(5);
        
        // Lấy top 5 sản phẩm đánh giá cao
        List<Map<String, Object>> topRated = statisticsService.getTopRatedProducts(5);
        
        // Lấy top 5 sản phẩm sắp hết hàng
        List<Map<String, Object>> lowStock = statisticsService.getLowStockProducts(5);
        
        request.setAttribute("salesStats", salesStats);
        request.setAttribute("categoryStats", categoryStats);
        request.setAttribute("bestSellers", bestSellers);
        request.setAttribute("topRated", topRated);
        request.setAttribute("lowStock", lowStock);
        
        request.getRequestDispatcher("/WEB-INF/view/admin/statistics-dashboard.jsp").forward(request, response);
    }
    
    private void showBestSellers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String period = request.getParameter("period");
        String categoryId = request.getParameter("category");
        String limitStr = request.getParameter("limit");
        
        int limit = 20; // Mặc định 20 sản phẩm
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 100) limit = 100; // Giới hạn tối đa
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        List<Map<String, Object>> bestSellers;
        
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryId);
                bestSellers = statisticsService.getBestSellingProductsByCategory(catId, limit);
            } catch (NumberFormatException e) {
                bestSellers = statisticsService.getBestSellingProducts(limit);
            }
        } else if (period != null && !period.trim().isEmpty()) {
            bestSellers = statisticsService.getBestSellingProductsByPeriod(period, limit);
        } else {
            bestSellers = statisticsService.getBestSellingProducts(limit);
        }
        
        request.setAttribute("bestSellers", bestSellers);
        request.setAttribute("period", period);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("limit", limit);
        
        request.getRequestDispatcher("/WEB-INF/view/admin/best-sellers.jsp").forward(request, response);
    }
    
    private void showTopRated(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String limitStr = request.getParameter("limit");
        int limit = 20;
        
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 100) limit = 100;
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        List<Map<String, Object>> topRated = statisticsService.getTopRatedProducts(limit);
        
        request.setAttribute("topRated", topRated);
        request.setAttribute("limit", limit);
        
        request.getRequestDispatcher("/WEB-INF/view/admin/top-rated.jsp").forward(request, response);
    }
    
    private void showLowStock(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String limitStr = request.getParameter("limit");
        int limit = 20;
        
        if (limitStr != null && !limitStr.trim().isEmpty()) {
            try {
                limit = Integer.parseInt(limitStr);
                if (limit > 100) limit = 100;
            } catch (NumberFormatException e) {
                // Sử dụng giá trị mặc định
            }
        }
        
        List<Map<String, Object>> lowStock = statisticsService.getLowStockProducts(limit);
        
        request.setAttribute("lowStock", lowStock);
        request.setAttribute("limit", limit);
        
        request.getRequestDispatcher("/WEB-INF/view/admin/low-stock.jsp").forward(request, response);
    }
    
    private void showCategoryStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Map<String, Object> categoryStats = statisticsService.getCategorySalesStatistics();
        
        request.setAttribute("categoryStats", categoryStats);
        
        request.getRequestDispatcher("/WEB-INF/view/admin/category-stats.jsp").forward(request, response);
    }
} 