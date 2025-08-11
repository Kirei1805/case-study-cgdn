<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử đơn hàng - Cửa hàng cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .order-card {
            transition: transform 0.3s ease;
        }
        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/plants">
                <i class="fas fa-seedling me-2"></i>Cửa hàng cây trồng
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/plants">
                            <i class="fas fa-home me-1"></i>Trang chủ
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <i class="fas fa-shopping-cart me-1"></i>Giỏ hàng
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${sessionScope.user.username}
                                </a>
                                <ul class="dropdown-menu">
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/plants">
                                            <i class="fas fa-leaf me-2"></i>Quản lý cây trồng
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">
                                            <i class="fas fa-users me-2"></i>Quản lý người dùng
                                        </a></li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus me-1"></i>Đăng ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <h2 class="mb-4">
                    <i class="fas fa-history me-2"></i>Lịch sử đơn hàng
                </h2>
                
                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="text-center py-5">
                            <i class="fas fa-shopping-bag fa-3x text-muted mb-3"></i>
                            <h4 class="text-muted">Bạn chưa có đơn hàng nào</h4>
                            <p class="text-muted">Hãy mua sắm để có đơn hàng đầu tiên!</p>
                            <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
                                <i class="fas fa-shopping-bag me-2"></i>Mua sắm ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="order" items="${orders}">
                                <div class="col-lg-6 mb-4">
                                    <div class="card order-card h-100">
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0">
                                                <i class="fas fa-receipt me-2"></i>Đơn hàng #${order.id}
                                            </h6>
                                            <span class="badge bg-${order.statusBadgeClass}">
                                                ${order.statusDisplay}
                                            </span>
                                        </div>
                                        <div class="card-body">
                                            <div class="row mb-3">
                                                <div class="col-6">
                                                    <small class="text-muted">Ngày đặt:</small><br>
                                                    <strong>
                                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </strong>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted">Tổng tiền:</small><br>
                                                    <strong class="text-success">
                                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                    </strong>
                                                </div>
                                            </div>
                                            
                                            <div class="d-grid">
                                                <a href="${pageContext.request.contextPath}/orders/detail/${order.id}" 
                                                   class="btn btn-outline-primary btn-sm">
                                                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-seedling me-2"></i>Cửa hàng cây trồng</h5>
                    <p class="mb-0">Mang thiên nhiên đến với không gian của bạn</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">&copy; 2024 Cửa hàng cây trồng. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 