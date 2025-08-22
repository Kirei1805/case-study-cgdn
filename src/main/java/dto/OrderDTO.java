package dto;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class OrderDTO {
    private int id;
    private int userId;
    private int addressId;
    private BigDecimal totalAmount;
    private String status;
    private LocalDateTime orderDate;
    private String customerName;
    private String customerUsername;
    private List<OrderItemDTO> items;

    public OrderDTO() {}

    public OrderDTO(int id, int userId, int addressId, BigDecimal totalAmount, String status, 
                   LocalDateTime orderDate, String customerName, String customerUsername) {
        this.id = id;
        this.userId = userId;
        this.addressId = addressId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.orderDate = orderDate;
        this.customerName = customerName;
        this.customerUsername = customerUsername;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

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

    public List<OrderItemDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDTO> items) {
        this.items = items;
    }
}

