<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - Cửa hàng cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .success-icon {
            font-size: 4rem;
            color: #28a745;
        }
        .order-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
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
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="text-center mb-5">
                    <i class="fas fa-check-circle success-icon mb-3"></i>
                    <h2 class="text-success">Đặt hàng thành công!</h2>
                    <p class="lead text-muted">Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi</p>
                </div>
                
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-receipt me-2"></i>Thông tin đơn hàng
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="order-details">
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Mã đơn hàng:</strong> #${orderId}</p>
                                    <p><strong>Ngày đặt:</strong> ${orderDate}</p>
                                    <p><strong>Trạng thái:</strong> <span class="badge bg-warning">Chờ xử lý</span></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Tổng tiền:</strong> <span class="text-success fw-bold">
                                        <fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="₫"/>
                                    </span></p>
                                    <p><strong>Phương thức thanh toán:</strong> Thanh toán khi nhận hàng</p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-info mt-3">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Lưu ý:</strong> Chúng tôi sẽ liên hệ với bạn trong vòng 24 giờ để xác nhận đơn hàng và thông báo thời gian giao hàng.
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-4">
                    <div class="d-grid gap-2 d-md-block">
                        <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
                            <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                        </a>
                        <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary">
                            <i class="fas fa-list me-2"></i>Xem đơn hàng của tôi
                        </a>
                    </div>
                </div>
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