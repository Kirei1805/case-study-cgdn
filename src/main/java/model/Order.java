package model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private int addressId;
    private BigDecimal totalAmount;
    private String status;
    private LocalDateTime orderDate;
    private String customerName;
    private String customerUsername;
    private User user;
    private List<OrderItem> orderItems;

    public Order() {}

    public Order(int id, int userId, int addressId, BigDecimal totalAmount, String status, LocalDateTime orderDate) {
        this.id = id;
        this.userId = userId;
        this.addressId = addressId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderDate = orderDate;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getAddressId() { return addressId; }
    public void setAddressId(int addressId) { this.addressId = addressId; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerUsername() {
        return customerUsername;
    }

    public void setCustomerUsername(String customerUsername) {
        this.customerUsername = customerUsername;
    }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }
    
    // Helper methods for JSP formatting
    public String getFormattedDate() {
        if (orderDate == null) return "";
        return String.format("%02d/%02d/%d", 
            orderDate.getDayOfMonth(), 
            orderDate.getMonthValue(), 
            orderDate.getYear());
    }
    
    public String getFormattedTime() {
        if (orderDate == null) return "";
        return String.format("%02d:%02d", 
            orderDate.getHour(), 
            orderDate.getMinute());
    }
    
    public String getFormattedDateTime() {
        if (orderDate == null) return "";
        return String.format("%02d/%02d/%d %02d:%02d", 
            orderDate.getDayOfMonth(), 
            orderDate.getMonthValue(), 
            orderDate.getYear(),
            orderDate.getHour(), 
            orderDate.getMinute());
    }
}
