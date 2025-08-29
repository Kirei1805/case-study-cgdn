<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Chi tiết đơn hàng"/>
</jsp:include>

<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/orders">Đơn hàng</a></li>
        <li class="breadcrumb-item active" aria-current="page">Đơn #${order.id}</li>
    </ol>
</nav>

<!-- Order Header -->
<div class="card mb-4">
    <div class="card-body">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h4 class="mb-0"><i class="fas fa-receipt me-2"></i>Đơn hàng #${order.id}</h4>
                <small class="text-muted">
                    Đặt lúc: ${order.formattedDateTime}
                </small>
            </div>
            <div class="col-md-6 text-md-end">
                <c:choose>
                    <c:when test="${order.status == 'pending'}">
                        <span class="badge bg-warning text-dark fs-6 px-3 py-2">
                            <i class="fas fa-clock me-1"></i>Chờ xử lý
                        </span>
                    </c:when>
                    <c:when test="${order.status == 'processing'}">
                        <span class="badge bg-info fs-6 px-3 py-2">
                            <i class="fas fa-cog me-1"></i>Đang xử lý
                        </span>
                    </c:when>
                    <c:when test="${order.status == 'shipped'}">
                        <span class="badge bg-primary fs-6 px-3 py-2">
                            <i class="fas fa-truck me-1"></i>Đang giao
                        </span>
                    </c:when>
                    <c:when test="${order.status == 'delivered'}">
                        <span class="badge bg-success fs-6 px-3 py-2">
                            <i class="fas fa-check-circle me-1"></i>Đã giao
                        </span>
                    </c:when>
                    <c:when test="${order.status == 'cancelled'}">
                        <span class="badge bg-danger fs-6 px-3 py-2">
                            <i class="fas fa-times-circle me-1"></i>Đã hủy
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary fs-6 px-3 py-2">${order.status}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-8">
        <!-- Order Items -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Sản phẩm đã đặt</h5>
            </div>
            <div class="card-body p-0">
                <c:forEach var="it" items="${items}" varStatus="status">
                    <div class="d-flex align-items-center p-3 ${!status.last ? 'border-bottom' : ''}">
                        <img src="${it.plant.imageUrl}" alt="${it.plant.name}" 
                             class="rounded me-3" 
                             style="width:80px;height:80px;object-fit:cover" 
                             onerror="this.src='https://via.placeholder.com/80x80?text=Không+có+ảnh'">
                        <div class="flex-grow-1">
                            <h6 class="mb-1">${it.plant.name}</h6>
                            <p class="text-muted mb-1 small">${it.plant.category.name}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-muted">Số lượng: <strong>${it.quantity}</strong></span>
                                <div class="text-end">
                                    <div class="text-muted small">
                                        <fmt:formatNumber value="${it.unitPrice}" type="currency" currencySymbol="VNĐ"/> x ${it.quantity}
                                    </div>
                                    <div class="fw-bold text-success">
                                        <fmt:formatNumber value="${it.unitPrice * it.quantity}" type="currency" currencySymbol="VNĐ"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <div class="col-lg-4">
        <!-- Order Summary -->
        <div class="card mb-3">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-calculator me-2"></i>Tổng kết đơn hàng</h5>
            </div>
            <div class="card-body">
                <div class="d-flex justify-content-between mb-2">
                    <span>Tạm tính:</span>
                    <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/></span>
                </div>
                <div class="d-flex justify-content-between mb-2">
                    <span>Phí vận chuyển:</span>
                    <span class="text-success">Miễn phí</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between fw-bold fs-5">
                    <span>Tổng cộng:</span>
                    <span class="text-success">
                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/>
                    </span>
                </div>
            </div>
        </div>
        
        <!-- Order Actions -->
        <div class="card">
            <div class="card-body">
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                    </a>
                    <c:if test="${order.status == 'delivered'}">
                        <button class="btn btn-success" onclick="reorderItems()">
                            <i class="fas fa-redo me-2"></i>Đặt lại đơn hàng này
                        </button>
                    </c:if>
                    <c:if test="${order.status == 'pending'}">
                        <button class="btn btn-outline-danger" onclick="cancelOrder('${order.id}')">
                            <i class="fas fa-times me-2"></i>Hủy đơn hàng
                        </button>
                    </c:if>
                </div>
                
                <!-- Contact Support -->
                <div class="mt-3 pt-3 border-top text-center">
                    <small class="text-muted">Cần hỗ trợ?</small><br>
                    <a href="tel:0909123456" class="text-decoration-none">
                        <i class="fas fa-phone me-1"></i>0909 123 456
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function cancelOrder(orderId) {
    if (confirm('Bạn có chắc muốn hủy đơn hàng #' + orderId + '?')) {
        // TODO: Implement cancel order functionality
        alert('Tính năng hủy đơn sẽ được phát triển trong phiên bản tới!');
    }
}

function reorderItems() {
    if (confirm('Thêm tất cả sản phẩm trong đơn hàng này vào giỏ hàng?')) {
        // TODO: Implement reorder functionality
        alert('Tính năng đặt lại sẽ được phát triển trong phiên bản tới!');
    }
}
</script>

<jsp:include page="../common/footer.jsp"/>

