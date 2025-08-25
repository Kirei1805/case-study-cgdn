<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Chi tiết đơn hàng #${order.id}</h2>

    <!-- Thông tin khách hàng -->
    <div class="card mb-4">
        <div class="card-body">
            <p><strong>Khách hàng:</strong> ${order.customerName} (${order.customerUsername})</p>
            <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></p>
            <p><strong>Trạng thái hiện tại:</strong>
                <span class="badge
                    ${order.status eq 'completed' ? 'bg-success' :
                      order.status eq 'pending' ? 'bg-warning' :
                      order.status eq 'shipped' ? 'bg-primary' : 'bg-secondary'}">
                    ${order.status}
                </span>
            </p>
            <p><strong>Tổng tiền:</strong>
                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/>
            </p>
        </div>
    </div>

    <!-- Form cập nhật trạng thái -->
    <div class="card mb-4">
        <div class="card-header">Cập nhật trạng thái đơn hàng</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="row g-3">
                <input type="hidden" name="action" value="updateStatus"/>
                <input type="hidden" name="id" value="${order.id}"/>
                <div class="col-md-6">
                    <select name="status" class="form-select" required>
                        <option value="pending" ${order.status eq 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                        <option value="shipped" ${order.status eq 'shipped' ? 'selected' : ''}>Đang giao</option>
                        <option value="completed" ${order.status eq 'completed' ? 'selected' : ''}>Hoàn thành</option>
                        <option value="cancelled" ${order.status eq 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div class="card">
        <div class="card-header">
            <h5>Sản phẩm trong đơn</h5>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Ảnh</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${orderItems}">
                    <tr>
                        <td>${item.plant.name}</td>
                        <td><img src="${item.plant.imageUrl}" alt="${item.plant.name}" width="60"/></td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="VNĐ"/></td>
                        <td><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="currency" currencySymbol="VNĐ"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Quay lại -->
    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary mt-3">
        Quay lại danh sách
    </a>
</div>
</body>
</html>
