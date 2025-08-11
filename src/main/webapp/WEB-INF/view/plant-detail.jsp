<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${plant.name} - Chi tiết cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .product-image {
            max-height: 400px;
            object-fit: cover;
            width: 100%;
        }
        .related-product-card {
            transition: transform 0.3s ease;
        }
        .related-product-card:hover {
            transform: translateY(-5px);
        }
        .price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #28a745;
        }
        .stock-status {
            font-size: 0.9rem;
        }
        .stock-available {
            color: #28a745;
        }
        .stock-low {
            color: #ffc107;
        }
        .stock-out {
            color: #dc3545;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/plants">
                <i class="fas fa-seedling me-2"></i>Plant Shop
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
                            <i class="fas fa-tags me-1"></i>Danh mục
                        </a>
                        <ul class="dropdown-menu">
                            <c:forEach var="category" items="${categories}">
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/plants?category=${category.id}">
                                        ${category.name}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
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
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/plants">
                                                <i class="fas fa-cog me-2"></i>Quản lý cây trồng
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users">
                                                <i class="fas fa-users me-2"></i>Quản lý người dùng
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                    </c:if>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/plants">
                        <i class="fas fa-home me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/plants?category=${plant.categoryId}">
                        ${plant.categoryName}
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">${plant.name}</li>
            </ol>
        </nav>

        <div class="row">
            <!-- Product Image -->
            <div class="col-md-6">
                <div class="card">
                    <img src="${plant.imageUrl}" class="card-img-top product-image" alt="${plant.name}">
                </div>
            </div>

            <!-- Product Details -->
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">${plant.name}</h2>
                        
                        <div class="mb-3">
                            <span class="price">${plant.formattedPrice}</span>
                        </div>

                        <div class="mb-3">
                            <span class="stock-status 
                                ${plant.stock > 10 ? 'stock-available' : plant.stock > 0 ? 'stock-low' : 'stock-out'}">
                                <i class="fas fa-boxes me-1"></i>
                                <c:choose>
                                    <c:when test="${plant.stock > 10}">
                                        Còn hàng (${plant.stock} sản phẩm)
                                    </c:when>
                                    <c:when test="${plant.stock > 0}">
                                        Sắp hết hàng (${plant.stock} sản phẩm)
                                    </c:when>
                                    <c:otherwise>
                                        Hết hàng
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>

                        <div class="mb-3">
                            <span class="badge bg-secondary">
                                <i class="fas fa-tag me-1"></i>${plant.categoryName}
                            </span>
                        </div>

                        <c:if test="${not empty plant.description}">
                            <div class="mb-3">
                                <h5>Mô tả:</h5>
                                <p class="text-muted">${plant.description}</p>
                            </div>
                        </c:if>

                        <div class="d-grid gap-2">
                            <c:choose>
                                <c:when test="${plant.stock > 0}">
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null}">
                                            <form action="${pageContext.request.contextPath}/cart/add" method="post">
                                                <input type="hidden" name="plantId" value="${plant.id}">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="btn btn-success btn-lg">
                                                    <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ hàng
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/login" class="btn btn-success btn-lg">
                                                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập để mua
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <button class="btn btn-outline-primary" disabled>
                                        <i class="fas fa-heart me-2"></i>Thêm vào yêu thích
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-secondary btn-lg" disabled>
                                        <i class="fas fa-times me-2"></i>Hết hàng
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Products -->
        <div class="mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3>
                    <i class="fas fa-leaf me-2"></i>Sản phẩm tương tự
                </h3>
                <a href="${pageContext.request.contextPath}/recommendations/similar/${plant.id}" class="btn btn-outline-success">
                    <i class="fas fa-star me-1"></i>Xem thêm gợi ý
                </a>
            </div>
            <div class="row">
                <c:forEach var="relatedPlant" items="${relatedPlants}" varStatus="status">
                    <c:if test="${status.index < 4}">
                        <div class="col-md-3 mb-4">
                            <div class="card h-100 related-product-card shadow-sm">
                                <img src="${relatedPlant.imageUrl}" class="card-img-top" 
                                     alt="${relatedPlant.name}" style="height: 200px; object-fit: cover;">
                                <div class="card-body">
                                    <h6 class="card-title">${relatedPlant.name}</h6>
                                    <p class="price mb-2">${relatedPlant.formattedPrice}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="fas fa-boxes me-1"></i>${relatedPlant.stock}
                                        </small>
                                                                                 <a href="${pageContext.request.contextPath}/plants/detail/${relatedPlant.id}" 
                                            class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye me-1"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-4 mt-5">
        <div class="container">
            <p class="mb-0">
                <i class="fas fa-seedling me-2"></i>
                © 2024 Plant Shop. Tất cả quyền được bảo lưu.
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 