<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - Cửa hàng cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .cart-item {
            transition: all 0.3s ease;
        }
        .cart-item:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        .quantity-input {
            width: 80px;
        }
        .empty-cart {
            text-align: center;
            padding: 60px 0;
        }
        .empty-cart i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 20px;
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
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${sessionScope.user.username}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                        <i class="fas fa-history me-2"></i>Đơn hàng của tôi
                                    </a></li>
                                    <c:if test="${sessionScope.user.role == 'admin'}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">
                                            <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/plants">
                                            <i class="fas fa-leaf me-2"></i>Quản lý cây trồng
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">
                                            <i class="fas fa-users me-2"></i>Quản lý người dùng
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/orders">
                                            <i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng
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
                    <i class="fas fa-shopping-cart me-2"></i>Giỏ hàng
                </h2>
                
                <!-- Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="empty-cart">
                            <i class="fas fa-shopping-cart"></i>
                            <h4 class="text-muted">Giỏ hàng trống</h4>
                            <p class="text-muted">Bạn chưa có sản phẩm nào trong giỏ hàng</p>
                            <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
                                <i class="fas fa-shopping-bag me-2"></i>Tiếp tục mua sắm
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="card">
                                    <div class="card-body">
                                        <c:forEach var="item" items="${cartItems}">
                                            <div class="cart-item border-bottom py-3">
                                                <div class="row align-items-center">
                                                    <div class="col-md-2">
                                                        <img src="${item.plant.imageUrl}" class="product-image rounded" 
                                                             alt="${item.plant.name}" 
                                                             onerror="this.src='https://via.placeholder.com/80x80?text=Cây+trồng'">
                                                    </div>
                                                    <div class="col-md-4">
                                                        <h6 class="mb-1">${item.plant.name}</h6>
                                                        <p class="text-muted small mb-0">${item.plant.categoryName}</p>
                                                        <p class="text-success fw-bold mb-0">
                                                            <fmt:formatNumber value="${item.plant.price}" type="currency" currencySymbol="₫"/>
                                                        </p>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="d-flex align-items-center">
                                                            <label class="me-2">Số lượng:</label>
                                                            <form action="${pageContext.request.contextPath}/cart/update" method="post" class="d-flex align-items-center">
                                                                <input type="hidden" name="cartItemId" value="${item.id}">
                                                                <input type="number" name="quantity" value="${item.quantity}" 
                                                                       min="1" max="${item.plant.stock}" class="form-control quantity-input me-2">
                                                                <button type="submit" class="btn btn-sm btn-outline-primary">
                                                                    <i class="fas fa-sync-alt"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                        <small class="text-muted">Còn ${item.plant.stock} sản phẩm</small>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <p class="fw-bold text-success">
                                                            <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫"/>
                                                        </p>
                                                    </div>
                                                    <div class="col-md-1">
                                                        <form action="${pageContext.request.contextPath}/cart/remove" method="post" 
                                                              onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                            <input type="hidden" name="cartItemId" value="${item.id}">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </form>
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
                                        <h5 class="mb-0">Tổng đơn hàng</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3">
                                            <span>Tạm tính:</span>
                                            <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/></span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-3">
                                            <span>Phí vận chuyển:</span>
                                            <span>Miễn phí</span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between mb-3">
                                            <strong>Tổng cộng:</strong>
                                            <strong class="text-success">
                                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/>
                                            </strong>
                                        </div>
                                        
                                        <div class="d-grid gap-2">
                                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success">
                                                <i class="fas fa-credit-card me-2"></i>Thanh toán
                                            </a>
                                            <a href="${pageContext.request.contextPath}/plants" class="btn btn-outline-secondary">
                                                <i class="fas fa-arrow-left me-2"></i>Tiếp tục mua sắm
                                            </a>
                                            <form action="${pageContext.request.contextPath}/cart/clear" method="post" 
                                                  onsubmit="return confirm('Bạn có chắc muốn xóa toàn bộ giỏ hàng?')">
                                                <button type="submit" class="btn btn-outline-danger w-100">
                                                    <i class="fas fa-trash me-2"></i>Xóa giỏ hàng
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
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