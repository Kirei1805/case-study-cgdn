package service;

import model.Plant;
import repository.RecommendationRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RecommendationService implements IRecommendationService {
    private RecommendationRepository recommendationRepository;
    
    public RecommendationService() {
        this.recommendationRepository = new RecommendationRepository();
    }
    
    @Override
    public List<Plant> getRecommendedPlantsForUser(int userId, int limit) {
        if (userId <= 0 || limit <= 0) {
            return new ArrayList<>();
        }
        
        List<Plant> recommendedPlants = new ArrayList<>();
        
        // 1. Lấy sản phẩm dựa trên lịch sử mua hàng (ưu tiên cao nhất)
        List<Plant> purchaseHistoryPlants = recommendationRepository.getPlantsByUserPurchaseHistory(userId, limit / 2);
        recommendedPlants.addAll(purchaseHistoryPlants);
        
        // 2. Lấy sản phẩm dựa trên lịch sử đánh giá
        int remainingLimit = limit - recommendedPlants.size();
        if (remainingLimit > 0) {
            List<Plant> ratingHistoryPlants = recommendationRepository.getPlantsByUserRatingHistory(userId, remainingLimit);
            recommendedPlants.addAll(ratingHistoryPlants);
        }
        
        // 3. Nếu chưa đủ, bổ sung bằng sản phẩm phổ biến
        remainingLimit = limit - recommendedPlants.size();
        if (remainingLimit > 0) {
            List<Plant> popularPlants = recommendationRepository.getPopularPlants(remainingLimit);
            // Loại bỏ những sản phẩm đã có trong danh sách
            popularPlants = popularPlants.stream()
                    .filter(plant -> recommendedPlants.stream()
                            .noneMatch(existing -> existing.getId() == plant.getId()))
                    .collect(Collectors.toList());
            recommendedPlants.addAll(popularPlants);
        }
        
        // 4. Nếu vẫn chưa đủ, bổ sung bằng sản phẩm đánh giá cao
        remainingLimit = limit - recommendedPlants.size();
        if (remainingLimit > 0) {
            List<Plant> topRatedPlants = recommendationRepository.getTopRatedPlants(remainingLimit);
            // Loại bỏ những sản phẩm đã có trong danh sách
            topRatedPlants = topRatedPlants.stream()
                    .filter(plant -> recommendedPlants.stream()
                            .noneMatch(existing -> existing.getId() == plant.getId()))
                    .collect(Collectors.toList());
            recommendedPlants.addAll(topRatedPlants);
        }
        
        return recommendedPlants.stream().limit(limit).collect(Collectors.toList());
    }
    
    @Override
    public List<Plant> getPopularPlants(int limit) {
        if (limit <= 0) {
            return new ArrayList<>();
        }
        
        return recommendationRepository.getPopularPlants(limit);
    }
    
    @Override
    public List<Plant> getPlantsByCategory(int categoryId, int limit) {
        if (categoryId <= 0 || limit <= 0) {
            return new ArrayList<>();
        }
        
        return recommendationRepository.getPlantsByCategory(categoryId, limit);
    }
    
    @Override
    public List<Plant> getPlantsByPriceRange(double minPrice, double maxPrice, int limit) {
        if (minPrice < 0 || maxPrice < 0 || minPrice > maxPrice || limit <= 0) {
            return new ArrayList<>();
        }
        
        return recommendationRepository.getPlantsByPriceRange(minPrice, maxPrice, limit);
    }
    
    @Override
    public List<Plant> getSimilarPlants(int plantId, int limit) {
        if (plantId <= 0 || limit <= 0) {
            return new ArrayList<>();
        }
        
        return recommendationRepository.getSimilarPlants(plantId, limit);
    }
    
    // Thêm các phương thức bổ sung
    public List<Plant> getTopRatedPlants(int limit) {
        if (limit <= 0) {
            return new ArrayList<>();
        }
        
        return recommendationRepository.getTopRatedPlants(limit);
    }
    
    public List<Plant> getNewArrivals(int limit) {
        if (limit <= 0) {
            return new ArrayList<>();
        }
        
        // Giả sử sản phẩm mới là những sản phẩm có ID cao nhất (mới thêm vào)
        return recommendationRepository.getTopRatedPlants(limit); // Tạm thời dùng top rated
    }
    
    public List<Plant> getBestSellers(int limit) {
        if (limit <= 0) {
            return new ArrayList<>();
        }
        
        return recommendationRepository.getPopularPlants(limit);
    }
} 