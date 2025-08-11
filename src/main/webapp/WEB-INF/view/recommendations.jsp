<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} - Cửa hàng cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
        }
        .plant-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }
        .plant-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        .plant-image {
            height: 200px;
            object-fit: cover;
        }
        .rating {
            color: #ffc107;
        }
        .recommendation-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 193, 7, 0.9);
            color: #000;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
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
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-star me-1"></i>Gợi ý
                        </a>
                        <ul class="dropdown-menu">
                            <c:if test="${sessionScope.user != null}">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recommendations/for-user">
                                    <i class="fas fa-user me-2"></i>Cho bạn
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                            </c:if>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recommendations/popular">
                                <i class="fas fa-fire me-2"></i>Phổ biến
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recommendations/top-rated">
                                <i class="fas fa-star me-2"></i>Đánh giá cao
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recommendations/best-sellers">
                                <i class="fas fa-trophy me-2"></i>Bán chạy
                            </a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recommendations/new-arrivals">
                                <i class="fas fa-newspaper me-2"></i>Sản phẩm mới
                            </a></li>
                        </ul>
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
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                        <i class="fas fa-history me-2"></i>Đơn hàng của tôi
                                    </a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/reviews/my-reviews">
                                        <i class="fas fa-star me-2"></i>Đánh giá của tôi
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

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h1 class="display-5 fw-bold mb-3">${title}</h1>
                    <p class="lead mb-4">${subtitle}</p>
                </div>
                <div class="col-lg-4 text-center">
                    <i class="fas fa-lightbulb fa-4x mb-3"></i>
                </div>
            </div>
        </div>
    </section>

    <!-- Recommendations Grid -->
    <section class="py-5">
        <div class="container">
            <c:choose>
                <c:when test="${empty recommendedPlants}">
                    <div class="text-center py-5">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">Không có gợi ý nào</h4>
                        <p class="text-muted">Hãy thử mua sắm để nhận gợi ý phù hợp!</p>
                        <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
                            <i class="fas fa-shopping-cart me-2"></i>Mua sắm ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <c:forEach var="plant" items="${recommendedPlants}">
                            <div class="col">
                                <div class="card plant-card h-100 position-relative">
                                    <div class="recommendation-badge">
                                        <i class="fas fa-star me-1"></i>Gợi ý
                                    </div>
                                    <img src="${plant.imageUrl}" class="card-img-top plant-image" 
                                         alt="${plant.name}" onerror="this.src='https://via.placeholder.com/300x200?text=Cây+trồng'">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">${plant.name}</h5>
                                        <p class="card-text text-muted small">${plant.categoryName}</p>
                                        <div class="rating mb-2">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star${i <= plant.ratingAvg ? '' : '-o'}"></i>
                                            </c:forEach>
                                            <span class="text-muted ms-1">(${plant.ratingAvg})</span>
                                        </div>
                                        <p class="card-text flex-grow-1">${plant.description}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="h5 text-success mb-0">${plant.formattedPrice}</span>
                                            <span class="badge bg-${plant.stock > 0 ? 'success' : 'danger'}">
                                                ${plant.stock > 0 ? 'Còn hàng' : 'Hết hàng'}
                                            </span>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-transparent">
                                        <div class="d-grid gap-2">
                                            <a href="${pageContext.request.contextPath}/plants/detail/${plant.id}" 
                                               class="btn btn-outline-success">
                                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                                            </a>
                                            <c:if test="${sessionScope.user != null && plant.stock > 0}">
                                                <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-grid">
                                                    <input type="hidden" name="plantId" value="${plant.id}">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="btn btn-success">
                                                        <i class="fas fa-cart-plus me-1"></i>Thêm vào giỏ
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Load More Button -->
                    <div class="text-center mt-5">
                        <a href="${pageContext.request.contextPath}/plants" class="btn btn-outline-success btn-lg">
                            <i class="fas fa-leaf me-2"></i>Xem tất cả sản phẩm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Additional Recommendations -->
    <section class="py-5 bg-white">
        <div class="container">
            <h3 class="text-center mb-5">Khám phá thêm</h3>
            <div class="row">
                <div class="col-md-3 mb-4">
                    <div class="card text-center h-100">
                        <div class="card-body">
                            <i class="fas fa-fire fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Phổ biến</h5>
                            <p class="card-text">Những sản phẩm được nhiều người mua nhất</p>
                            <a href="${pageContext.request.contextPath}/recommendations/popular" class="btn btn-outline-warning">
                                Xem ngay
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="card text-center h-100">
                        <div class="card-body">
                            <i class="fas fa-star fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Đánh giá cao</h5>
                            <p class="card-text">Những sản phẩm được đánh giá tốt nhất</p>
                            <a href="${pageContext.request.contextPath}/recommendations/top-rated" class="btn btn-outline-warning">
                                Xem ngay
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="card text-center h-100">
                        <div class="card-body">
                            <i class="fas fa-trophy fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Bán chạy</h5>
                            <p class="card-text">Những sản phẩm bán chạy nhất trong tháng</p>
                            <a href="${pageContext.request.contextPath}/recommendations/best-sellers" class="btn btn-outline-warning">
                                Xem ngay
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="card text-center h-100">
                        <div class="card-body">
                            <i class="fas fa-newspaper fa-3x text-warning mb-3"></i>
                            <h5 class="card-title">Sản phẩm mới</h5>
                            <p class="card-text">Những sản phẩm mới nhất trong cửa hàng</p>
                            <a href="${pageContext.request.contextPath}/recommendations/new-arrivals" class="btn btn-outline-warning">
                                Xem ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-light py-4">
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