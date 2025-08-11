package service;

import model.Review;
import repository.ReviewRepository;
import repository.PlantRepository;
import java.util.List;

public class ReviewService implements IReviewService {
    private ReviewRepository reviewRepository;
    private PlantRepository plantRepository;
    
    public ReviewService() {
        this.reviewRepository = new ReviewRepository();
        this.plantRepository = new PlantRepository();
    }
    
    @Override
    public boolean addReview(Review review) {
        if (review == null || !validateReview(review)) {
            return false;
        }
        
        // Kiểm tra xem user đã đánh giá sản phẩm này chưa
        Review existingReview = reviewRepository.getReviewByUserAndPlant(review.getUserId(), review.getPlantId());
        if (existingReview != null) {
            return false; // Đã đánh giá rồi, không cho phép đánh giá lại
        }
        
        boolean success = reviewRepository.addReview(review);
        if (success) {
            // Cập nhật rating trung bình của sản phẩm
            updatePlantAverageRating(review.getPlantId());
        }
        return success;
    }
    
    @Override
    public boolean updateReview(Review review) {
        if (review == null || !validateReview(review)) {
            return false;
        }
        
        boolean success = reviewRepository.updateReview(review);
        if (success) {
            // Cập nhật rating trung bình của sản phẩm
            updatePlantAverageRating(review.getPlantId());
        }
        return success;
    }
    
    @Override
    public boolean deleteReview(int reviewId) {
        if (reviewId <= 0) {
            return false;
        }
        
        // Lấy thông tin review trước khi xóa để biết plantId
        Review review = reviewRepository.getReviewByUserAndPlant(0, 0); // Tạm thời
        boolean success = reviewRepository.deleteReview(reviewId);
        if (success && review != null) {
            // Cập nhật rating trung bình của sản phẩm
            updatePlantAverageRating(review.getPlantId());
        }
        return success;
    }
    
    @Override
    public List<Review> getReviewsByPlantId(int plantId) {
        if (plantId <= 0) {
            return new java.util.ArrayList<>();
        }
        
        return reviewRepository.getReviewsByPlantId(plantId);
    }
    
    @Override
    public List<Review> getReviewsByUserId(int userId) {
        if (userId <= 0) {
            return new java.util.ArrayList<>();
        }
        
        return reviewRepository.getReviewsByUserId(userId);
    }
    
    @Override
    public Review getReviewByUserAndPlant(int userId, int plantId) {
        if (userId <= 0 || plantId <= 0) {
            return null;
        }
        
        return reviewRepository.getReviewByUserAndPlant(userId, plantId);
    }
    
    @Override
    public double getAverageRatingByPlantId(int plantId) {
        if (plantId <= 0) {
            return 0.0;
        }
        
        return reviewRepository.getAverageRatingByPlantId(plantId);
    }
    
    @Override
    public int getReviewCountByPlantId(int plantId) {
        if (plantId <= 0) {
            return 0;
        }
        
        return reviewRepository.getReviewCountByPlantId(plantId);
    }
    
    @Override
    public boolean hasUserPurchasedPlant(int userId, int plantId) {
        if (userId <= 0 || plantId <= 0) {
            return false;
        }
        
        return reviewRepository.hasUserPurchasedPlant(userId, plantId);
    }
    
    @Override
    public boolean canUserReview(int userId, int plantId) {
        if (userId <= 0 || plantId <= 0) {
            return false;
        }
        
        // Kiểm tra xem user đã mua sản phẩm chưa
        boolean hasPurchased = hasUserPurchasedPlant(userId, plantId);
        if (!hasPurchased) {
            return false;
        }
        
        // Kiểm tra xem user đã đánh giá sản phẩm này chưa
        Review existingReview = getReviewByUserAndPlant(userId, plantId);
        return existingReview == null; // Chỉ cho phép đánh giá nếu chưa đánh giá
    }
    
    private boolean validateReview(Review review) {
        return review.getUserId() > 0 &&
               review.getPlantId() > 0 &&
               review.getRating() >= 1 && review.getRating() <= 5 &&
               review.getComment() != null && !review.getComment().trim().isEmpty() &&
               review.getComment().length() <= 1000; // Giới hạn độ dài comment
    }
    
    private void updatePlantAverageRating(int plantId) {
        double averageRating = reviewRepository.getAverageRatingByPlantId(plantId);
        plantRepository.updatePlantRating(plantId, averageRating);
    }
} 