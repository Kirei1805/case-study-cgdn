package repository.review;

import model.Review;
import java.util.List;

public interface ReviewRepository {
    List<Review> getReviewsByPlant(int plantId);
    List<Review> getReviewsByUser(int userId);
    Review getReviewById(int reviewId);
    boolean createReview(Review review);
    boolean updateReview(Review review);
    boolean deleteReview(int reviewId);
    boolean updatePlantRating(int plantId);
    double getAverageRating(int plantId);
}
