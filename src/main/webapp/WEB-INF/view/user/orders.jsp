<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Lịch sử đơn hàng"/>
</jsp:include>

<!-- Include Pagination CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item active" aria-current="page">Lịch sử đơn hàng</li>
    </ol>
</nav>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h3><i class="fas fa-history me-2"></i>Lịch sử đơn hàng</h3>
    <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
        <i class="fas fa-plus me-2"></i>Tiếp tục mua sắm
    </a>
</div>

<c:choose>
    <c:when test="${empty orders}">
        <div class="text-center py-5">
            <i class="fas fa-shopping-bag fa-3x text-muted mb-3"></i>
            <h4 class="text-muted">Chưa có đơn hàng nào</h4>
            <p class="text-muted">Bạn chưa có đơn hàng nào. Hãy khám phá và mua sắm những cây cảnh đẹp nhất!</p>
            <a href="${pageContext.request.contextPath}/plants" class="btn btn-success btn-lg">
                <i class="fas fa-leaf me-2"></i>Mua sắm ngay
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="row">
            <c:forEach var="o" items="${orders}">
                <div class="col-lg-6 mb-4">
                    <div class="card h-100">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h6 class="mb-0"><i class="fas fa-receipt me-2"></i>Đơn hàng #${o.id}</h6>
                            <c:choose>
                                <c:when test="${o.status == 'pending'}">
                                    <span class="badge bg-warning text-dark">
                                        <i class="fas fa-clock me-1"></i>Chờ xử lý
                                    </span>
                                </c:when>
                                <c:when test="${o.status == 'processing'}">
                                    <span class="badge bg-info">
                                        <i class="fas fa-cog me-1"></i>Đang xử lý
                                    </span>
                                </c:when>
                                <c:when test="${o.status == 'shipped'}">
                                    <span class="badge bg-primary">
                                        <i class="fas fa-truck me-1"></i>Đang giao
                                    </span>
                                </c:when>
                                <c:when test="${o.status == 'delivered'}">
                                    <span class="badge bg-success">
                                        <i class="fas fa-check-circle me-1"></i>Đã giao
                                    </span>
                                </c:when>
                                <c:when test="${o.status == 'cancelled'}">
                                    <span class="badge bg-danger">
                                        <i class="fas fa-times-circle me-1"></i>Đã hủy
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${o.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-6">
                                    <small class="text-muted">Ngày đặt:</small>
                                    <div class="fw-semibold">
                                        ${o.formattedDate}
                                    </div>
                                    <small class="text-muted">
                                        ${o.formattedTime}
                                    </small>
                                </div>
                                <div class="col-6 text-end">
                                    <small class="text-muted">Tổng tiền:</small>
                                    <div class="fw-bold text-success fs-5">
                                        <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="VNĐ"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent text-end">
                            <a href="${pageContext.request.contextPath}/order-detail?id=${o.id}" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-eye me-1"></i>Xem chi tiết
                            </a>
                            <c:if test="${o.status == 'pending'}">
                                <button class="btn btn-outline-danger btn-sm ms-2" onclick="cancelOrder('${o.id}')">
                                    <i class="fas fa-times me-1"></i>Hủy đơn
                                </button>
                            </c:if>
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

<script>
function cancelOrder(orderId) {
    if (confirm('Bạn có chắc muốn hủy đơn hàng #' + orderId + '?')) {
        // TODO: Implement cancel order functionality
        alert('Tính năng hủy đơn sẽ được phát triển trong phiên bản tới!');
    }
}
</script>

<jsp:include page="../common/footer.jsp"/>
