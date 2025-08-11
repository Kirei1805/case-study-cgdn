package service;

import java.util.List;
import java.util.Map;

public interface IStatisticsService {
    List<Map<String, Object>> getBestSellingProducts(int limit);
    List<Map<String, Object>> getBestSellingProductsByCategory(int categoryId, int limit);
    List<Map<String, Object>> getBestSellingProductsByPeriod(String period, int limit);
    Map<String, Object> getSalesStatistics();
    Map<String, Object> getCategorySalesStatistics();
    List<Map<String, Object>> getTopRatedProducts(int limit);
    List<Map<String, Object>> getLowStockProducts(int limit);
} 