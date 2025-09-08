<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Danh sách cây cảnh"/>
</jsp:include>

<!-- Include Pagination CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">

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

<!-- Enhanced Filter Section -->
<div class="filter-section mb-5">
    <div class="card border-0" style="background: linear-gradient(135deg, rgba(45, 90, 39, 0.05) 0%, rgba(127, 176, 105, 0.05) 100%); backdrop-filter: blur(10px);">
        <div class="card-body p-4">
            <div class="d-flex align-items-center mb-4">
                <div class="filter-icon me-3">
                    <i class="fas fa-filter fa-2x" style="color: var(--primary-color);"></i>
                </div>
                <div>
                    <h4 class="mb-1" style="color: var(--primary-color); font-weight: 600;">Tìm cây cảnh phù hợp</h4>
                    <p class="text-muted mb-0">Sử dụng bộ lọc để tìm cây cảnh ưng ý nhất</p>
                </div>
            </div>
            
            <form action="${pageContext.request.contextPath}/plants" method="GET" class="advanced-filter">
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <div class="filter-group">
                            <label for="search" class="form-label fw-semibold">
                                <i class="fas fa-search me-2 text-primary"></i>Tìm kiếm
                            </label>
                            <input type="text" class="form-control form-control-lg" id="search" name="search" 
                                   placeholder="Nhập tên cây cảnh..." value="${param.search}">
                        </div>
                    </div>
                    
                    <div class="col-lg-3 col-md-6">
                        <div class="filter-group">
                            <label for="category" class="form-label fw-semibold">
                                <i class="fas fa-tags me-2 text-primary"></i>Danh mục
                            </label>
                            <select class="form-select form-select-lg" id="category" name="category">
                                <option value="">🌿 Tất cả danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" ${selectedCategory == category.id ? 'selected' : ''}>
                                        ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    </div>
                    
                    <div class="col-lg-2 col-md-6">
                        <div class="filter-group">
                            <label for="minPrice" class="form-label fw-semibold">
                                <i class="fas fa-money-bill-wave me-2 text-primary"></i>Giá từ
                            </label>
                            <input type="number" class="form-control form-control-lg" id="minPrice" name="minPrice"
                                   placeholder="0 VNĐ" value="${minPrice}">
                        </div>
                    </div>
                    
                    <div class="col-lg-2 col-md-6">
                        <div class="filter-group">
                            <label for="maxPrice" class="form-label fw-semibold">
                                <i class="fas fa-hand-holding-usd me-2 text-primary"></i>Giá đến
                            </label>
                            <input type="number" class="form-control form-control-lg" id="maxPrice" name="maxPrice"
                                   placeholder="1,000,000 VNĐ" value="${maxPrice}">
                    </div>
                    </div>
                    
                    <div class="col-lg-2 col-md-12">
                        <div class="filter-group">
                            <label class="form-label fw-semibold text-transparent">Action</label>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-search me-2"></i>Tìm kiếm
                            </button>
                            <a href="${pageContext.request.contextPath}/plants" class="btn btn-outline-secondary">
                                    <i class="fas fa-refresh me-1"></i>Làm mới
                            </a>
                            </div>
                        </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

<style>
.filter-section .card {
    border-radius: 20px;
    box-shadow: var(--shadow-lg);
}

.filter-group {
    position: relative;
}

.filter-group .form-control:focus,
.filter-group .form-select:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 0.25rem rgba(45, 90, 39, 0.15);
    transform: translateY(-2px);
}

.filter-group .form-control,
.filter-group .form-select {
    border: 2px solid #e9ecef;
    border-radius: 12px;
    transition: all 0.3s ease;
}

.filter-icon {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: var(--gradient-secondary);
    display: flex;
    align-items: center;
    justify-content: center;
}

.text-transparent {
    color: transparent !important;
}
</style>

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

<!-- Pagination -->
<c:if test="${not empty pagination}">
    <jsp:include page="../common/pagination.jsp"/>
</c:if>

<!-- Enhanced Product Styles -->
<style>
/* Enhanced Product Grid */
.products-grid .card {
    border: none;
    border-radius: 16px;
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    background: white;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

.products-grid .card:hover {
    transform: translateY(-15px) scale(1.02);
    box-shadow: 0 25px 50px rgba(45, 90, 39, 0.15);
}

.products-grid .plant-image {
    height: 280px;
    object-fit: cover;
    transition: transform 0.6s ease;
}

.products-grid .card:hover .plant-image {
    transform: scale(1.1);
}

/* Product Info Styling */
.card-title {
    font-family: 'Poppins', sans-serif;
    font-weight: 600;
    font-size: 1.15rem;
    color: var(--dark-color);
    margin-bottom: 0.5rem;
    line-height: 1.3;
}

.card-text {
    font-size: 0.9rem;
    line-height: 1.5;
    color: #6c757d;
}

/* Enhanced Rating Stars */
.rating {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 1rem;
}

.rating .fas {
    color: #ffc107;
    font-size: 0.9rem;
}

.rating .fa-star-o {
    color: #e9ecef;
}

/* Price Styling */
.price {
    font-family: 'Poppins', sans-serif;
    font-weight: 700;
    font-size: 1.4rem;
    color: var(--primary-color);
    text-shadow: 0 1px 2px rgba(0,0,0,0.1);
}

/* Button Enhancements */
.btn-success {
    background: var(--gradient-primary);
    border: none;
    border-radius: 12px;
    font-weight: 600;
    padding: 0.75rem 1.5rem;
    transition: all 0.3s ease;
}

.btn-success:hover {
    background: linear-gradient(135deg, #234a1e 0%, #3a6b47 50%, #6da058 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(45, 90, 39, 0.3);
}

.btn-outline-success {
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-outline-success:hover {
    background: var(--primary-color);
    border-color: var(--primary-color);
    transform: translateY(-2px);
}

/* Category Badge */
.text-muted.small {
    background: var(--gradient-secondary);
    color: var(--dark-color) !important;
    padding: 0.25rem 0.75rem;
    border-radius: 20px;
    font-size: 0.8rem !important;
    font-weight: 500;
    display: inline-block;
    margin-bottom: 0.5rem;
}

/* Loading Animation */
@keyframes productSlideIn {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.card {
    animation: productSlideIn 0.6s ease-out forwards;
}

.card:nth-child(1) { animation-delay: 0.1s; }
.card:nth-child(2) { animation-delay: 0.2s; }
.card:nth-child(3) { animation-delay: 0.3s; }
.card:nth-child(4) { animation-delay: 0.4s; }
.card:nth-child(5) { animation-delay: 0.5s; }
.card:nth-child(6) { animation-delay: 0.6s; }
.card:nth-child(7) { animation-delay: 0.7s; }
.card:nth-child(8) { animation-delay: 0.8s; }

/* Mobile Responsive */
@media (max-width: 768px) {
    .products-grid .plant-image {
        height: 220px;
    }
    
    .card-title {
        font-size: 1rem;
    }
    
    .price {
        font-size: 1.2rem;
    }
    
    .btn {
        padding: 0.6rem 1.2rem;
        font-size: 0.9rem;
    }
}

/* Empty State */
.text-center.py-5 {
    background: linear-gradient(135deg, rgba(127, 176, 105, 0.1) 0%, rgba(45, 90, 39, 0.05) 100%);
    border-radius: 20px;
    border: 2px dashed rgba(127, 176, 105, 0.3);
    margin: 3rem 0;
}

.text-center.py-5 i {
    color: var(--primary-color);
    opacity: 0.6;
}
</style>

<!-- Enhanced JavaScript -->
<script>
// Add to cart animation
document.querySelectorAll('form[action*="/cart"]').forEach(form => {
    form.addEventListener('submit', function(e) {
        const btn = this.querySelector('button[type="submit"]');
        if (btn) {
            const originalContent = btn.innerHTML;
            
            // Loading state
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang thêm...';
            btn.disabled = true;
            btn.style.opacity = '0.7';
            
            // Add loading class to card
            const card = this.closest('.card');
            card.classList.add('loading');
            
            setTimeout(() => {
                // Success state
                btn.innerHTML = '<i class="fas fa-check me-2"></i>Thành công!';
                btn.classList.remove('btn-success');
                btn.classList.add('btn-outline-success');
                
                setTimeout(() => {
                    // Submit the form
                    this.submit();
                }, 500);
            }, 800);
        }
    });
});

// Smooth scroll to products section
document.querySelectorAll('a[href="#plants-section"]').forEach(link => {
    link.addEventListener('click', function(e) {
        e.preventDefault();
        document.getElementById('plants-section').scrollIntoView({
            behavior: 'smooth'
        });
    });
});

// Filter form enhancements
const filterForm = document.querySelector('.advanced-filter');
if (filterForm) {
    const inputs = filterForm.querySelectorAll('input, select');
    
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'translateY(-2px)';
        });
        
        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'translateY(0)';
        });
    });
}

// Price range validation
const minPriceInput = document.getElementById('minPrice');
const maxPriceInput = document.getElementById('maxPrice');

if (minPriceInput && maxPriceInput) {
    function validatePriceRange() {
        const minPrice = parseInt(minPriceInput.value) || 0;
        const maxPrice = parseInt(maxPriceInput.value) || Infinity;
        
        if (minPrice > maxPrice) {
            maxPriceInput.setCustomValidity('Giá tối đa phải lớn hơn giá tối thiểu');
        } else {
            maxPriceInput.setCustomValidity('');
        }
    }
    
    minPriceInput.addEventListener('input', validatePriceRange);
    maxPriceInput.addEventListener('input', validatePriceRange);
}

// Intersection Observer for scroll animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.animationPlayState = 'running';
        }
    });
}, observerOptions);

// Observe product cards
document.querySelectorAll('.card').forEach(card => {
    observer.observe(card);
});
</script>

<jsp:include page="../common/footer.jsp"/>
