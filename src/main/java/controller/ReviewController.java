package controller;

import model.Review;
import model.User;
import service.IReviewService;
import service.ReviewService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "ReviewController", urlPatterns = {"/reviews/*"})
public class ReviewController extends HttpServlet {
    private IReviewService reviewService;
    
    @Override
    public void init() throws ServletException {
        reviewService = new ReviewService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        if (pathInfo.startsWith("/plant/")) {
            // Hiển thị đánh giá của một sản phẩm
            String plantIdStr = pathInfo.substring(7); // Bỏ "/plant/"
            showPlantReviews(request, response, plantIdStr);
        } else if (pathInfo.startsWith("/my-reviews")) {
            // Hiển thị đánh giá của user hiện tại
            showUserReviews(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        if (pathInfo.equals("/add")) {
            addReview(request, response);
        } else if (pathInfo.equals("/update")) {
            updateReview(request, response);
        } else if (pathInfo.equals("/delete")) {
            deleteReview(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void showPlantReviews(HttpServletRequest request, HttpServletResponse response, String plantIdStr)
            throws ServletException, IOException {
        try {
            int plantId = Integer.parseInt(plantIdStr);
            
            // Lấy danh sách đánh giá của sản phẩm
            java.util.List<Review> reviews = reviewService.getReviewsByPlantId(plantId);
            double averageRating = reviewService.getAverageRatingByPlantId(plantId);
            int reviewCount = reviewService.getReviewCountByPlantId(plantId);
            
            request.setAttribute("reviews", reviews);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("reviewCount", reviewCount);
            request.setAttribute("plantId", plantId);
            
            // Kiểm tra xem user hiện tại có thể đánh giá không
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user != null) {
                boolean canReview = reviewService.canUserReview(user.getId(), plantId);
                request.setAttribute("canReview", canReview);
                
                // Nếu đã đánh giá rồi, lấy đánh giá hiện tại
                if (!canReview) {
                    Review existingReview = reviewService.getReviewByUserAndPlant(user.getId(), plantId);
                    request.setAttribute("existingReview", existingReview);
                }
            }
            
            request.getRequestDispatcher("/WEB-INF/view/plant-reviews.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void showUserReviews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        java.util.List<Review> reviews = reviewService.getReviewsByUserId(user.getId());
        request.setAttribute("reviews", reviews);
        
        request.getRequestDispatcher("/WEB-INF/view/user-reviews.jsp").forward(request, response);
    }
    
    private void addReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String plantIdStr = request.getParameter("plantId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");
        
        try {
            int plantId = Integer.parseInt(plantIdStr);
            int rating = Integer.parseInt(ratingStr);
            
            // Kiểm tra xem user có thể đánh giá không
            if (!reviewService.canUserReview(user.getId(), plantId)) {
                request.setAttribute("message", "Bạn không thể đánh giá sản phẩm này!");
                request.setAttribute("messageType", "danger");
                response.sendRedirect(request.getContextPath() + "/plants/detail/" + plantId);
                return;
            }
            
            // Tạo đánh giá mới
            Review review = new Review(user.getId(), plantId, rating, comment);
            review.setReviewDate(LocalDateTime.now());
            
            boolean success = reviewService.addReview(review);
            
            if (success) {
                request.setAttribute("message", "Đánh giá của bạn đã được gửi thành công!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Có lỗi xảy ra khi gửi đánh giá!");
                request.setAttribute("messageType", "danger");
            }
            
            response.sendRedirect(request.getContextPath() + "/plants/detail/" + plantId);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void updateReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String plantIdStr = request.getParameter("plantId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");
        
        try {
            int plantId = Integer.parseInt(plantIdStr);
            int rating = Integer.parseInt(ratingStr);
            
            // Kiểm tra xem user đã đánh giá sản phẩm này chưa
            Review existingReview = reviewService.getReviewByUserAndPlant(user.getId(), plantId);
            if (existingReview == null) {
                request.setAttribute("message", "Bạn chưa đánh giá sản phẩm này!");
                request.setAttribute("messageType", "danger");
                response.sendRedirect(request.getContextPath() + "/plants/detail/" + plantId);
                return;
            }
            
            // Cập nhật đánh giá
            existingReview.setRating(rating);
            existingReview.setComment(comment);
            existingReview.setReviewDate(LocalDateTime.now());
            
            boolean success = reviewService.updateReview(existingReview);
            
            if (success) {
                request.setAttribute("message", "Đánh giá của bạn đã được cập nhật thành công!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Có lỗi xảy ra khi cập nhật đánh giá!");
                request.setAttribute("messageType", "danger");
            }
            
            response.sendRedirect(request.getContextPath() + "/plants/detail/" + plantId);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String reviewIdStr = request.getParameter("reviewId");
        String plantIdStr = request.getParameter("plantId");
        
        try {
            int reviewId = Integer.parseInt(reviewIdStr);
            int plantId = Integer.parseInt(plantIdStr);
            
            // Kiểm tra xem review có thuộc về user này không
            Review review = reviewService.getReviewByUserAndPlant(user.getId(), plantId);
            if (review == null || review.getId() != reviewId) {
                request.setAttribute("message", "Bạn không có quyền xóa đánh giá này!");
                request.setAttribute("messageType", "danger");
                response.sendRedirect(request.getContextPath() + "/plants/detail/" + plantId);
                return;
            }
            
            boolean success = reviewService.deleteReview(reviewId);
            
            if (success) {
                request.setAttribute("message", "Đánh giá đã được xóa thành công!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Có lỗi xảy ra khi xóa đánh giá!");
                request.setAttribute("messageType", "danger");
            }
            
            response.sendRedirect(request.getContextPath() + "/plants/detail/" + plantId);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
} 