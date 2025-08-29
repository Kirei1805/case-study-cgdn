<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar { min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); transition: all 0.3s; border-radius: 8px; margin: 2px 0; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background: rgba(255, 255, 255, 0.1); }
        .main-content { background-color: #f8f9fa; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
            <div class="position-sticky pt-3 text-center text-white">
                <i class="fas fa-seedling fa-2x mb-2"></i>
                <h5>Plant Shop Admin</h5>
                <small class="text-white-50">Quản lý hệ thống</small>
                <ul class="nav flex-column mt-3">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-seedling me-2"></i>Quản lý sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/reports"><i class="fas fa-chart-bar me-2"></i>Báo cáo</a></li>
                    <li class="nav-item mt-4"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Chi tiết đơn hàng #${order.id}</h1>
            </div>

    <!-- Thông tin khách hàng -->
    <div class="card mb-4">
        <div class="card-body">
            <p><strong>Khách hàng:</strong> ${order.customerName} (${order.customerUsername})</p>
            <p><strong>Ngày đặt:</strong> -</p>
            <p><strong>Trạng thái hiện tại:</strong>
                <span class="badge
                    ${order.status eq 'shipped' ? 'bg-success' :
                      order.status eq 'pending' ? 'bg-warning' :
                      order.status eq 'processing' ? 'bg-info' :
                      order.status eq 'cancelled' ? 'bg-danger' : 'bg-secondary'}">
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
                        <option value="processing" ${order.status eq 'processing' ? 'selected' : ''}>Đang xử lý</option>
                        <option value="shipped" ${order.status eq 'shipped' ? 'selected' : ''}>Đã giao</option>
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
        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
    </a>
        </main>
    </div>
</div>
</body>
</html>
