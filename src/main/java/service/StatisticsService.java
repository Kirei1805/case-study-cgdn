package service;

import repository.StatisticsRepository;
import java.util.List;
import java.util.Map;

public class StatisticsService implements IStatisticsService {
    private StatisticsRepository statisticsRepository;
    
    public StatisticsService() {
        this.statisticsRepository = new StatisticsRepository();
    }
    
    @Override
    public List<Map<String, Object>> getBestSellingProducts(int limit) {
        if (limit <= 0) {
            limit = 10; // Mặc định 10 sản phẩm
        }
        return statisticsRepository.getBestSellingProducts(limit);
    }
    
    @Override
    public List<Map<String, Object>> getBestSellingProductsByCategory(int categoryId, int limit) {
        if (categoryId <= 0 || limit <= 0) {
            return new java.util.ArrayList<>();
        }
        return statisticsRepository.getBestSellingProductsByCategory(categoryId, limit);
    }
    
    @Override
    public List<Map<String, Object>> getBestSellingProductsByPeriod(String period, int limit) {
        if (period == null || period.trim().isEmpty() || limit <= 0) {
            return new java.util.ArrayList<>();
        }
        return statisticsRepository.getBestSellingProductsByPeriod(period, limit);
    }
    
    @Override
    public Map<String, Object> getSalesStatistics() {
        return statisticsRepository.getSalesStatistics();
    }
    
    @Override
    public Map<String, Object> getCategorySalesStatistics() {
        return statisticsRepository.getCategorySalesStatistics();
    }
    
    @Override
    public List<Map<String, Object>> getTopRatedProducts(int limit) {
        if (limit <= 0) {
            limit = 10; // Mặc định 10 sản phẩm
        }
        return statisticsRepository.getTopRatedProducts(limit);
    }
    
    @Override
    public List<Map<String, Object>> getLowStockProducts(int limit) {
        if (limit <= 0) {
            limit = 10; // Mặc định 10 sản phẩm
        }
        return statisticsRepository.getLowStockProducts(limit);
    }
} 