<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id} - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .order-item {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }
        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-home me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/plants">
                            <i class="fas fa-leaf me-1"></i>Quản lý cây trồng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders">
                            <i class="fas fa-shopping-cart me-1"></i>Quản lý đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users me-1"></i>Quản lý người dùng
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/plants">
                            <i class="fas fa-store me-1"></i>Xem cửa hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/admin/orders">
                                <i class="fas fa-shopping-cart me-1"></i>Quản lý đơn hàng
                            </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Đơn hàng #${order.id}</li>
                    </ol>
                </nav>
                
                <!-- Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-shopping-bag me-2"></i>Chi tiết đơn hàng #${order.id}
                                </h5>
                            </div>
                            <div class="card-body">
                                <c:forEach var="item" items="${order.orderItems}">
                                    <div class="order-item">
                                        <div class="row align-items-center">
                                            <div class="col-md-2">
                                                <img src="${item.plant.imageUrl}" class="product-image rounded" 
                                                     alt="${item.plant.name}" 
                                                     onerror="this.src='https://via.placeholder.com/60x60?text=Cây+trồng'">
                                            </div>
                                            <div class="col-md-4">
                                                <h6 class="mb-1">${item.plant.name}</h6>
                                                <p class="text-muted small mb-0">${item.plant.categoryName}</p>
                                                <p class="text-success fw-bold mb-0">
                                                    <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫"/>
                                                </p>
                                            </div>
                                            <div class="col-md-2">
                                                <p class="mb-0">Số lượng: <strong>${item.quantity}</strong></p>
                                            </div>
                                            <div class="col-md-2">
                                                <p class="fw-bold text-success mb-0">
                                                    <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫"/>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-info-circle me-2"></i>Thông tin đơn hàng
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Mã đơn hàng:</strong><br>
                                    <span class="text-primary">#${order.id}</span>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Ngày đặt:</strong><br>
                                    <span>
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Trạng thái hiện tại:</strong><br>
                                    <span class="badge bg-${order.statusBadgeClass}">
                                        ${order.statusDisplay}
                                    </span>
                                </div>
                                
                                <div class="mb-3">
                                    <strong>Khách hàng:</strong><br>
                                    <span>${order.user.fullName}</span><br>
                                    <small class="text-muted">${order.user.username}</small>
                                </div>
                                
                                <hr>
                                
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Tạm tính:</span>
                                    <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/></span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span>Phí vận chuyển:</span>
                                    <span>Miễn phí</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between mb-3">
                                    <strong>Tổng cộng:</strong>
                                    <strong class="text-success">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                    </strong>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-primary" 
                                            data-bs-toggle="modal" data-bs-target="#updateStatusModal" 
                                            data-order-id="${order.id}" data-order-status="${order.status}">
                                        <i class="fas fa-edit me-2"></i>Cập nhật trạng thái
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary">
                                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Status Modal -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật trạng thái đơn hàng #${order.id}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/orders/update-status/${order.id}" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="status" class="form-label">Trạng thái mới:</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Đã giao hàng</option>
                                <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 