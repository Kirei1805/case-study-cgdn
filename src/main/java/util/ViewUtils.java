package util;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;

public class ViewUtils {
    
    /**
     * Generate star rating HTML
     * @param rating Rating value (0-5)
     * @return HTML string for star display
     */
    public static String generateStarRating(float rating) {
        StringBuilder stars = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars.append("<i class=\"fas fa-star\"></i>");
            } else {
                stars.append("<i class=\"fas fa-star-o\"></i>");
            }
        }
        return stars.toString();
    }
    
    /**
     * Format currency for Vietnamese locale
     * @param amount Amount to format
     * @return Formatted currency string
     */
    public static String formatCurrency(BigDecimal amount) {
        if (amount == null) return "0 VNĐ";
        NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return formatter.format(amount).replace("₫", "VNĐ");
    }
    
    /**
     * Get status badge class for order status
     * @param status Order status
     * @return Bootstrap badge class
     */
    public static String getStatusBadgeClass(String status) {
        if (status == null) return "bg-secondary";
        
        switch (status.toLowerCase()) {
            case "pending":
                return "bg-warning";
            case "processing":
                return "bg-info";
            case "shipped":
            case "delivered":
                return "bg-success";
            case "cancelled":
                return "bg-danger";
            default:
                return "bg-secondary";
        }
    }
    
    /**
     * Get Vietnamese status text
     * @param status Order status
     * @return Vietnamese status text
     */
    public static String getStatusText(String status) {
        if (status == null) return "Không xác định";
        
        switch (status.toLowerCase()) {
            case "pending":
                return "Chờ xử lý";
            case "processing":
                return "Đang xử lý";
            case "shipped":
                return "Đã giao hàng";
            case "delivered":
                return "Đã nhận hàng";
            case "cancelled":
                return "Đã hủy";
            default:
                return "Không xác định";
        }
    }
    
    /**
     * Generate product status badge
     * @param isActive Product active status
     * @return Status badge HTML
     */
    public static String getProductStatusBadge(boolean isActive) {
        if (isActive) {
            return "<span class=\"badge bg-success\">Đang bán</span>";
        } else {
            return "<span class=\"badge bg-secondary\">Ngừng bán</span>";
        }
    }
}

