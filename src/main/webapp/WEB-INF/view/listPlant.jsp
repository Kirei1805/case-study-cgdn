<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa hàng cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 80px 0;
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
        .category-filter {
            background: #f8f9fa;
            padding: 20px 0;
        }
    </style>
</head>
<body>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/plants">Trang chủ</a>
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
                                    <i class="fas fa-user me-1"></i>${sessionScope.userFullName}
                                </a>
                                <ul class="dropdown-menu">
                                    <c:if test="${sessionScope.userRole == 'admin'}">
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

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Khám phá thế giới cây trồng</h1>
                    <p class="lead mb-4">Tìm kiếm và mua sắm những cây trồng đẹp nhất cho không gian của bạn</p>
                </div>
                <div class="col-lg-6">
                    <form action="${pageContext.request.contextPath}/plants" method="get" class="d-flex">
                        <input type="text" name="search" class="form-control form-control-lg me-2" 
                               placeholder="Tìm kiếm cây trồng..." value="${searchKeyword}">
                        <button type="submit" class="btn btn-light btn-lg">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Filter Section -->
    <section class="category-filter">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h5 class="mb-3">Bộ lọc tìm kiếm:</h5>
                    
                    <!-- Search and Filter Form -->
                    <form action="${pageContext.request.contextPath}/plants" method="get" class="row g-3">
                        <!-- Search -->
                        <div class="col-md-3">
                            <input type="text" name="search" class="form-control" 
                                   placeholder="Tìm kiếm cây trồng..." value="${searchKeyword}">
                        </div>
                        
                        <!-- Category Filter -->
                        <div class="col-md-3">
                            <select name="category" class="form-select">
                                <option value="">Tất cả danh mục</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" ${selectedCategory == category.id ? 'selected' : ''}>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Price Range -->
                        <div class="col-md-2">
                            <input type="number" name="minPrice" class="form-control" 
                                   placeholder="Giá từ" value="${minPrice}" min="0" step="1000">
                        </div>
                        
                        <div class="col-md-2">
                            <input type="number" name="maxPrice" class="form-control" 
                                   placeholder="Giá đến" value="${maxPrice}" min="0" step="1000">
                        </div>
                        
                        <!-- Submit Button -->
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fas fa-search me-1"></i>Tìm kiếm
                            </button>
                        </div>
                    </form>
                    
                    <!-- Quick Price Filters -->
                    <div class="mt-3">
                        <h6 class="mb-2">Lọc nhanh theo giá:</h6>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/plants?minPrice=0&maxPrice=100000" 
                               class="btn btn-sm btn-outline-primary">
                                Dưới 100k
                            </a>
                            <a href="${pageContext.request.contextPath}/plants?minPrice=100000&maxPrice=300000" 
                               class="btn btn-sm btn-outline-primary">
                                100k - 300k
                            </a>
                            <a href="${pageContext.request.contextPath}/plants?minPrice=300000&maxPrice=500000" 
                               class="btn btn-sm btn-outline-primary">
                                300k - 500k
                            </a>
                            <a href="${pageContext.request.contextPath}/plants?minPrice=500000&maxPrice=1000000" 
                               class="btn btn-sm btn-outline-primary">
                                500k - 1M
                            </a>
                            <a href="${pageContext.request.contextPath}/plants?minPrice=1000000" 
                               class="btn btn-sm btn-outline-primary">
                                Trên 1M
                            </a>
                        </div>
                    </div>
                    
                    <!-- Clear Filters -->
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/plants" class="btn btn-outline-secondary btn-sm">
                            <i class="fas fa-times me-1"></i>Xóa bộ lọc
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Plants Grid -->
    <section class="py-5">
        <div class="container">
            <!-- Search Results Summary -->
            <c:if test="${not empty searchKeyword || not empty selectedCategory || not empty minPrice || not empty maxPrice}">
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="alert alert-info">
                            <h5 class="mb-2">
                                <i class="fas fa-search me-2"></i>Kết quả tìm kiếm
                            </h5>
                            <div class="row">
                                <c:if test="${not empty searchKeyword}">
                                    <div class="col-md-3">
                                        <strong>Từ khóa:</strong> "${searchKeyword}"
                                    </div>
                                </c:if>
                                <c:if test="${not empty selectedCategory}">
                                    <div class="col-md-3">
                                        <strong>Danh mục:</strong> 
                                        <c:forEach var="category" items="${categories}">
                                            <c:if test="${category.id == selectedCategory}">${category.name}</c:if>
                                        </c:forEach>
                                    </div>
                                </c:if>
                                <c:if test="${not empty minPrice || not empty maxPrice}">
                                    <div class="col-md-3">
                                        <strong>Khoảng giá:</strong> 
                                        <c:if test="${not empty minPrice}">Từ ${minPrice}₫</c:if>
                                        <c:if test="${not empty minPrice && not empty maxPrice}"> - </c:if>
                                        <c:if test="${not empty maxPrice}">Đến ${maxPrice}₫</c:if>
                                    </div>
                                </c:if>
                                <div class="col-md-3">
                                    <strong>Tìm thấy:</strong> ${plants.size()} sản phẩm
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty plants}">
                    <div class="text-center py-5">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">Không tìm thấy cây trồng nào</h4>
                        <p class="text-muted">Hãy thử tìm kiếm với từ khóa khác hoặc chọn danh mục khác</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                        <c:forEach var="plant" items="${plants}">
                            <div class="col">
                                <div class="card plant-card h-100">
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
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
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