<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá sản phẩm - Cửa hàng cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .rating-stars {
            color: #ffc107;
            font-size: 1.2rem;
        }
        .review-card {
            transition: transform 0.3s ease;
        }
        .review-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .rating-input {
            display: none;
        }
        .rating-label {
            cursor: pointer;
            font-size: 1.5rem;
            color: #ddd;
        }
        .rating-input:checked ~ .rating-label {
            color: #ffc107;
        }
        .rating-label:hover,
        .rating-label:hover ~ .rating-label {
            color: #ffc107;
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

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/plants">
                                <i class="fas fa-home me-1"></i>Trang chủ
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/plants/detail/${plantId}">
                                Chi tiết sản phẩm
                            </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Đánh giá</li>
                    </ol>
                </nav>

                <!-- Rating Summary -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body text-center">
                                <h3 class="text-warning mb-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star${i <= averageRating ? '' : '-o'}"></i>
                                    </c:forEach>
                                </h3>
                                <h4 class="mb-1">${averageRating}</h4>
                                <p class="text-muted mb-0">${reviewCount} đánh giá</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Thống kê đánh giá</h5>
                                <div class="row">
                                    <div class="col-6">
                                        <p class="mb-1">5 sao: <span class="text-warning">★★★★★</span></p>
                                        <p class="mb-1">4 sao: <span class="text-warning">★★★★☆</span></p>
                                        <p class="mb-1">3 sao: <span class="text-warning">★★★☆☆</span></p>
                                    </div>
                                    <div class="col-6">
                                        <p class="mb-1">2 sao: <span class="text-warning">★★☆☆☆</span></p>
                                        <p class="mb-1">1 sao: <span class="text-warning">★☆☆☆☆</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Add Review Form -->
                <c:if test="${sessionScope.user != null}">
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-star me-2"></i>Viết đánh giá
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${canReview}">
                                    <form action="${pageContext.request.contextPath}/reviews/add" method="post">
                                        <input type="hidden" name="plantId" value="${plantId}">
                                        
                                        <div class="mb-3">
                                            <label class="form-label">Đánh giá của bạn:</label>
                                            <div class="rating-input-group">
                                                <input type="radio" name="rating" value="5" id="star5" class="rating-input" required>
                                                <label for="star5" class="rating-label">★</label>
                                                <input type="radio" name="rating" value="4" id="star4" class="rating-input">
                                                <label for="star4" class="rating-label">★</label>
                                                <input type="radio" name="rating" value="3" id="star3" class="rating-input">
                                                <label for="star3" class="rating-label">★</label>
                                                <input type="radio" name="rating" value="2" id="star2" class="rating-input">
                                                <label for="star2" class="rating-label">★</label>
                                                <input type="radio" name="rating" value="1" id="star1" class="rating-input">
                                                <label for="star1" class="rating-label">★</label>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="comment" class="form-label">Nhận xét:</label>
                                            <textarea class="form-control" id="comment" name="comment" rows="4" 
                                                      placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..." 
                                                      maxlength="1000" required></textarea>
                                            <div class="form-text">Tối đa 1000 ký tự</div>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-paper-plane me-2"></i>Gửi đánh giá
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <c:choose>
                                            <c:when test="${existingReview != null}">
                                                Bạn đã đánh giá sản phẩm này rồi. 
                                                <a href="#review-${existingReview.id}" class="alert-link">Xem đánh giá của bạn</a>
                                            </c:when>
                                            <c:otherwise>
                                                Bạn cần mua sản phẩm này để có thể đánh giá.
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>

                <!-- Reviews List -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-comments me-2"></i>Đánh giá từ khách hàng (${reviewCount})
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty reviews}">
                                <div class="text-center py-5">
                                    <i class="fas fa-star fa-3x text-muted mb-3"></i>
                                    <h4 class="text-muted">Chưa có đánh giá nào</h4>
                                    <p class="text-muted">Hãy là người đầu tiên đánh giá sản phẩm này!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="review" items="${reviews}">
                                    <div class="review-card border-bottom py-3" id="review-${review.id}">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="d-flex align-items-center mb-2">
                                                    <div class="rating-stars me-2">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas fa-star${i <= review.rating ? '' : '-o'}"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <span class="text-muted">${review.ratingDisplay}</span>
                                                </div>
                                                <p class="mb-2">${review.comment}</p>
                                                <small class="text-muted">
                                                    <i class="fas fa-user me-1"></i>${review.user.fullName} - 
                                                    <i class="fas fa-calendar me-1"></i>
                                                    <fmt:formatDate value="${review.reviewDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                </small>
                                            </div>
                                            <div class="col-md-4 text-md-end">
                                                <c:if test="${sessionScope.user != null && sessionScope.user.id == review.userId}">
                                                    <div class="btn-group" role="group">
                                                        <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                onclick="editReview(${review.id}, ${review.rating}, '${review.comment}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                onclick="deleteReview(${review.id})">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
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
    <script>
        function editReview(reviewId, rating, comment) {
            // Implement edit functionality
            console.log('Edit review:', reviewId, rating, comment);
        }
        
        function deleteReview(reviewId) {
            if (confirm('Bạn có chắc muốn xóa đánh giá này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/reviews/delete';
                
                const reviewIdInput = document.createElement('input');
                reviewIdInput.type = 'hidden';
                reviewIdInput.name = 'reviewId';
                reviewIdInput.value = reviewId;
                
                const plantIdInput = document.createElement('input');
                plantIdInput.type = 'hidden';
                plantIdInput.name = 'plantId';
                plantIdInput.value = ${plantId};
                
                form.appendChild(reviewIdInput);
                form.appendChild(plantIdInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html> 