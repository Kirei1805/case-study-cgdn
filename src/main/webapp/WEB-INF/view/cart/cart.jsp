<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Giỏ hàng"/>
</jsp:include>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
    </ol>
</nav>

<!-- Success/Error Messages -->
<c:if test="${param.success == 'added'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle me-2"></i>Sản phẩm đã được thêm vào giỏ hàng thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.success == 'updated'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle me-2"></i>Số lượng sản phẩm đã được cập nhật!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.success == 'removed'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle me-2"></i>Sản phẩm đã được xóa khỏi giỏ hàng!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.error == 'invalid_quantity'}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-circle me-2"></i>Số lượng không hợp lệ!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Cart Content -->
<c:choose>
    <c:when test="${empty cartItems}">
        <div class="text-center py-5">
            <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
            <h4 class="text-muted">Giỏ hàng trống</h4>
            <p class="text-muted">Bạn chưa có sản phẩm nào trong giỏ hàng</p>
            <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
                <i class="fas fa-shopping-bag me-1"></i>Tiếp tục mua sắm
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row">
            <!-- Cart Items -->
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-shopping-cart me-2"></i>Giỏ hàng của bạn</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="row mb-3 border-bottom pb-3">
                                <div class="col-md-2">
                                    <img src="${item.plant.imageUrl}" class="img-fluid rounded" alt="${item.plant.name}"
                                         onerror="this.src='https://via.placeholder.com/100x100?text=Không+có+ảnh'">
                                </div>
                                <div class="col-md-4">
                                    <h6 class="mb-1">${item.plant.name}</h6>
                                    <p class="text-muted small mb-0">${item.plant.category.name}</p>
                                    <div class="rating">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star${i <= item.plant.ratingAvg ? '' : '-o'} fa-sm"></i>
                                        </c:forEach>
                                        <span class="ms-1 text-muted small">(${item.plant.ratingAvg})</span>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <span class="price">
                                        <fmt:formatNumber value="${item.plant.price}" type="currency" currencySymbol="VNĐ"/>
                                    </span>
                                </div>
                                <div class="col-md-2">
                                    <form action="${pageContext.request.contextPath}/cart" method="POST" class="d-flex align-items-center">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="plantId" value="${item.plant.id}">
                                        <input type="number" class="form-control form-control-sm" name="quantity" 
                                               value="${item.quantity}" min="1" max="${item.plant.stock}" style="width: 60px;">
                                        <button type="submit" class="btn btn-outline-primary btn-sm ms-2">
                                            <i class="fas fa-sync-alt"></i>
                                        </button>
                                    </form>
                                </div>
                                <div class="col-md-2">
                                    <div class="d-flex flex-column">
                                        <span class="price fw-bold">
                                            <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="VNĐ"/>
                                        </span>
                                        <form action="${pageContext.request.contextPath}/cart" method="POST" class="mt-1">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="plantId" value="${item.plant.id}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm" 
                                                    onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                <i class="fas fa-trash me-1"></i>Xóa
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <!-- Cart Summary -->
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-calculator me-2"></i>Tổng đơn hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="VNĐ"/></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Phí vận chuyển:</span>
                            <span class="text-success">Miễn phí</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="fw-bold">Tổng cộng:</span>
                            <span class="price fw-bold fs-5">
                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="VNĐ"/>
                            </span>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success btn-lg">
                                <i class="fas fa-credit-card me-2"></i>Thanh toán
                            </a>
                            <a href="${pageContext.request.contextPath}/plants" class="btn btn-outline-primary">
                                <i class="fas fa-arrow-left me-2"></i>Tiếp tục mua sắm
                            </a>
                        </div>
                        
                        <!-- Coupon Code -->
                        <div class="mt-3">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="Mã giảm giá">
                                <button class="btn btn-outline-secondary" type="button">Áp dụng</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Shipping Info -->
                <div class="card mt-3">
                    <div class="card-body">
                        <h6><i class="fas fa-truck me-2"></i>Thông tin vận chuyển</h6>
                        <ul class="list-unstyled small">
                            <li><i class="fas fa-check text-success me-2"></i>Miễn phí vận chuyển cho đơn hàng từ 500,000 VNĐ</li>
                            <li><i class="fas fa-check text-success me-2"></i>Giao hàng trong 2-3 ngày làm việc</li>
                            <li><i class="fas fa-check text-success me-2"></i>Hỗ trợ giao hàng toàn quốc</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../common/footer.jsp"/>
