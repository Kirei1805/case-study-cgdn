<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Thanh toán"/>
</jsp:include>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
        <li class="breadcrumb-item active" aria-current="page">Thanh toán</li>
    </ol>
</nav>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<div class="row">
    <div class="col-lg-8">
        <div class="card mb-3">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-map-marker-alt me-2"></i>Địa chỉ giao hàng</h5>
                <button class="btn btn-sm btn-outline-primary" type="button" data-bs-toggle="collapse" data-bs-target="#createAddress">Thêm địa chỉ</button>
            </div>
            <div class="card-body">
                <div class="collapse mb-3" id="createAddress">
                    <form action="${pageContext.request.contextPath}/checkout" method="POST" class="border rounded p-3 bg-light">
                        <input type="hidden" name="action" value="createAddress">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Họ tên người nhận</label>
                                <input type="text" class="form-control" name="recipientName" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" name="phone" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Địa chỉ</label>
                                <textarea class="form-control" name="addressLine" rows="2" required></textarea>
                            </div>
                            <div class="col-12 form-check">
                                <input class="form-check-input" type="checkbox" name="setDefault" id="setDefault">
                                <label class="form-check-label" for="setDefault">Đặt làm mặc định</label>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i>Lưu địa chỉ
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                <c:choose>
                    <c:when test="${empty addresses}">
                        <div class="alert alert-info">
                            Bạn chưa có địa chỉ nào. Hãy thêm địa chỉ mới.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/checkout" method="POST">
                            <div class="list-group">
                                <c:forEach var="a" items="${addresses}">
                                    <label class="list-group-item d-flex gap-2 align-items-start">
                                        <input class="form-check-input mt-1" type="radio" name="addressId" value="${a.id}" ${a.id == defaultAddressId ? 'checked' : ''}>
                                        <span>
                                            <strong>${a.recipientName}</strong> - ${a.phone}
                                            <br>
                                            <span class="text-muted">${a.addressLine}</span>
                                            <c:if test="${a['default']}">
                                                <span class="badge bg-success ms-2">Mặc định</span>
                                            </c:if>
                                        </span>
                                    </label>
                                </c:forEach>
                            </div>
                            <div class="mt-3">
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="fas fa-check me-2"></i>Đặt hàng
                                </button>
                                <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-primary ms-2">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại giỏ hàng
                                </a>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-shield-alt me-2"></i>Phương thức thanh toán</h5>
            </div>
            <div class="card-body">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment" id="cod" checked>
                    <label class="form-check-label" for="cod">
                        Thanh toán khi nhận hàng (COD)
                    </label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="payment" id="bank" disabled>
                    <label class="form-check-label text-muted" for="bank">
                        Chuyển khoản (sắp ra mắt)
                    </label>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Lưu ý</h5>
                <ul class="small">
                    <li>Vui lòng kiểm tra kỹ địa chỉ và số điện thoại nhận hàng</li>
                    <li>Thời gian giao hàng dự kiến: 2-3 ngày làm việc</li>
                    <li>Hỗ trợ đổi trả trong 7 ngày</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
