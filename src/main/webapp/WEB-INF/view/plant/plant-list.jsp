<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Danh sách cây cảnh"/>
</jsp:include>

<!-- Carousel Section -->
<div id="mainCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <div class="carousel-image" style="background-image: url('https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');">
                <div class="carousel-overlay">
                    <div class="container">
                        <div class="row align-items-center min-vh-50">
                            <div class="col-md-6">
                                <h1 class="display-4 fw-bold text-white mb-3">Khám phá thế giới cây cảnh</h1>
                                <p class="lead text-white mb-4">Tìm kiếm và chọn lựa những cây cảnh đẹp nhất cho không gian sống của bạn</p>
                                <a href="#plants-section" class="btn btn-success btn-lg">
                                    <i class="fas fa-seedling me-2"></i>Khám phá ngay
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="carousel-image" style="background-image: url('https://images.unsplash.com/photo-1485955900006-10f4d324d411?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');">
                <div class="carousel-overlay">
                    <div class="container">
                        <div class="row align-items-center min-vh-50">
                            <div class="col-md-6">
                                <h1 class="display-4 fw-bold text-white mb-3">Cây cảnh văn phòng</h1>
                                <p class="lead text-white mb-4">Tạo không gian làm việc xanh mát và thư giãn với những cây cảnh phù hợp</p>
                                <a href="#plants-section" class="btn btn-success btn-lg">
                                    <i class="fas fa-building me-2"></i>Xem cây văn phòng
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="carousel-image" style="background-image: url('https://images.unsplash.com/photo-1416879595882-3373a0480b5b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');">
                <div class="carousel-overlay">
                    <div class="container">
                        <div class="row align-items-center min-vh-50">
                            <div class="col-md-6">
                                <h1 class="display-4 fw-bold text-white mb-3">Cây cảnh trang trí nhà</h1>
                                <p class="lead text-white mb-4">Biến ngôi nhà thành không gian sống xanh với những cây cảnh đẹp mắt</p>
                                <a href="#plants-section" class="btn btn-success btn-lg">
                                    <i class="fas fa-home me-2"></i>Xem cây trang trí
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<!-- Plants Section -->
<div id="plants-section">

<!-- Filter Section -->
<div class="row mb-4">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title"><i class="fas fa-filter me-2"></i>Bộ lọc</h5>
                <form action="${pageContext.request.contextPath}/plants" method="GET" class="row g-3">
                    <div class="col-md-3">
                        <label for="category" class="form-label">Danh mục</label>
                        <select class="form-select" id="category" name="category">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${selectedCategory == category.id ? 'selected' : ''}>
                                        ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="minPrice" class="form-label">Giá từ</label>
                        <input type="number" class="form-control" id="minPrice" name="minPrice"
                               placeholder="0" value="${minPrice}">
                    </div>
                    <div class="col-md-3">
                        <label for="maxPrice" class="form-label">Giá đến</label>
                        <input type="number" class="form-control" id="maxPrice" name="maxPrice"
                               placeholder="1000000" value="${maxPrice}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <div>
                            <button type="submit" class="btn btn-success me-2">
                                <i class="fas fa-search me-1"></i>Lọc
                            </button>
                            <a href="${pageContext.request.contextPath}/plants" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-1"></i>Xóa lọc
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Results Info -->
<div class="row mb-3">
    <div class="col-md-6">
        <p class="text-muted">
            <c:if test="${not empty searchTerm}">
                Kết quả tìm kiếm cho: <strong>"${searchTerm}"</strong>
            </c:if>
            <c:if test="${not empty selectedCategory}">
                <c:forEach var="category" items="${categories}">
                    <c:if test="${category.id == selectedCategory}">
                        Danh mục: <strong>${category.name}</strong>
                    </c:if>
                </c:forEach>
            </c:if>
            <c:if test="${not empty minPrice or not empty maxPrice}">
                Khoảng giá: <strong>
                <c:if test="${not empty minPrice}">${minPrice}</c:if>
                <c:if test="${not empty minPrice and not empty maxPrice}"> - </c:if>
                <c:if test="${not empty maxPrice}">${maxPrice}</c:if>
                VNĐ</strong>
            </c:if>
        </p>
    </div>
    <div class="col-md-6 text-end">
        <p class="text-muted">Tìm thấy <strong>${plants.size()}</strong> sản phẩm</p>
    </div>
</div>

<!-- Plants Grid -->
<c:choose>
    <c:when test="${empty plants}">
        <div class="text-center py-5">
            <i class="fas fa-search fa-3x text-muted mb-3"></i>
            <h4 class="text-muted">Không tìm thấy sản phẩm nào</h4>
            <p class="text-muted">Hãy thử tìm kiếm với từ khóa khác hoặc thay đổi bộ lọc</p>
            <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
                <i class="fas fa-home me-1"></i>Về trang chủ
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
            <c:forEach var="plant" items="${plants}">
                <div class="col">
                    <div class="card h-100">
                        <img src="${plant.imageUrl}" class="card-img-top plant-image" alt="${plant.name}"
                             onerror="this.src='https://via.placeholder.com/300x200?text=Không+có+ảnh'">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">${plant.name}</h5>
                            <p class="card-text text-muted small">${plant.category.name}</p>
                            <div class="rating mb-2">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fas fa-star${i <= plant.ratingAvg ? '' : '-o'}"></i>
                                </c:forEach>
                                <span class="ms-1 text-muted">(${plant.ratingAvg})</span>
                            </div>
                            <p class="card-text flex-grow-1">${plant.description}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="price">
                                    <fmt:formatNumber value="${plant.price}" type="currency" currencySymbol="VNĐ"/>
                                </span>
                                <c:choose>
                                    <c:when test="${sessionScope.user != null}">
                                        <form action="${pageContext.request.contextPath}/cart" method="POST" class="d-inline">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="plantId" value="${plant.id}">
                                            <input type="hidden" name="quantity" value="1">
                                            <button type="submit" class="btn btn-success btn-sm">
                                                <i class="fas fa-cart-plus me-1"></i>Thêm
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-success btn-sm">
                                            <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <a href="${pageContext.request.contextPath}/plant-detail?id=${plant.id}"
                               class="btn btn-outline-primary btn-sm w-100">
                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../common/footer.jsp"/>
