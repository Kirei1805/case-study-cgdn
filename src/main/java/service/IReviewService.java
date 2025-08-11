package service;

import model.Review;
import java.util.List;

public interface IReviewService {
    boolean addReview(Review review);
    boolean updateReview(Review review);
    boolean deleteReview(int reviewId);
    List<Review> getReviewsByPlantId(int plantId);
    List<Review> getReviewsByUserId(int userId);
    Review getReviewByUserAndPlant(int userId, int plantId);
    double getAverageRatingByPlantId(int plantId);
    int getReviewCountByPlantId(int plantId);
    boolean hasUserPurchasedPlant(int userId, int plantId);
    boolean canUserReview(int userId, int plantId);
} 