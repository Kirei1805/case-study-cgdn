<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="${plant.name}"/>
</jsp:include>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/plants">Cây cảnh</a></li>
        <li class="breadcrumb-item active" aria-current="page">${plant.name}</li>
    </ol>
</nav>

<!-- Plant Detail -->
<div class="row">
    <!-- Plant Image -->
    <div class="col-md-6 mb-4">
        <div class="card">
            <img src="${plant.imageUrl}" class="card-img-top" alt="${plant.name}" 
                 style="height: 400px; object-fit: cover;"
                 onerror="this.src='https://via.placeholder.com/500x400?text=Không+có+ảnh'">
        </div>
    </div>
    
    <!-- Plant Info -->
    <div class="col-md-6 mb-4">
        <div class="card">
            <div class="card-body">
                <h2 class="card-title text-success">${plant.name}</h2>
                <p class="text-muted">Danh mục: <span class="badge bg-success">${plant.category.name}</span></p>
                
                <!-- Rating -->
                <div class="rating mb-3">
                    <c:forEach begin="1" end="5" var="i">
                        <i class="fas fa-star${i <= plant.ratingAvg ? '' : '-o'} fa-lg"></i>
                    </c:forEach>
                    <span class="ms-2">${plant.ratingAvg}/5 (${plant.ratingAvg} sao)</span>
                </div>
                
                <!-- Price -->
                <div class="mb-3">
                    <span class="price fs-3">
                        <fmt:formatNumber value="${plant.price}" type="currency" currencySymbol="VNĐ"/>
                    </span>
                </div>
                
                <!-- Stock Status -->
                <div class="mb-3">
                    <c:choose>
                        <c:when test="${plant.stock > 0}">
                            <span class="badge bg-success">Còn hàng (${plant.stock} sản phẩm)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger">Hết hàng</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Description -->
                <div class="mb-4">
                    <h5>Mô tả sản phẩm:</h5>
                    <p class="card-text">${plant.description}</p>
                </div>
                
                <!-- Add to Cart Form -->
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <c:if test="${plant.stock > 0}">
                            <form action="${pageContext.request.contextPath}/cart" method="POST" class="mb-3">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="plantId" value="${plant.id}">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label for="quantity" class="form-label">Số lượng:</label>
                                        <input type="number" class="form-control" id="quantity" name="quantity" 
                                               value="1" min="1" max="${plant.stock}">
                                    </div>
                                    <div class="col-md-8">
                                        <label class="form-label">&nbsp;</label>
                                        <div>
                                            <button type="submit" class="btn btn-success btn-lg me-2">
                                                <i class="fas fa-cart-plus me-1"></i>Thêm vào giỏ hàng
                                            </button>
                                            <button type="button" class="btn btn-outline-primary btn-lg">
                                                <i class="fas fa-heart me-1"></i>Yêu thích
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Vui lòng <a href="${pageContext.request.contextPath}/login" class="alert-link">đăng nhập</a> 
                            để thêm sản phẩm vào giỏ hàng.
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <!-- Product Features -->
                <div class="row mt-4">
                    <div class="col-md-6">
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-truck text-success me-2"></i>
                            <span>Miễn phí vận chuyển</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-shield-alt text-success me-2"></i>
                            <span>Bảo hành 30 ngày</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-undo text-success me-2"></i>
                            <span>Đổi trả trong 7 ngày</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-headset text-success me-2"></i>
                            <span>Hỗ trợ 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Related Products -->
<div class="row mt-5">
    <div class="col-12">
        <h3 class="mb-4">Sản phẩm liên quan</h3>
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
            <!-- Placeholder for related products -->
            <div class="col">
                <div class="card">
                    <img src="https://via.placeholder.com/300x200?text=Sản+phẩm+liên+quan" class="card-img-top plant-image" alt="Related Product">
                    <div class="card-body">
                        <h6 class="card-title">Cây cảnh liên quan</h6>
                        <p class="price">150,000 VNĐ</p>
                        <a href="#" class="btn btn-outline-success btn-sm">Xem chi tiết</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
