<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Hồ sơ"/>
</jsp:include>

<c:if test="${not empty success}">
    <div class="alert alert-success">${success}</div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<div class="row g-4">
    <div class="col-lg-6">
        <div class="card h-100">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-user me-2"></i>Thông tin cá nhân</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/profile" method="POST">
                    <input type="hidden" name="action" value="updateProfile">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" name="fullName" value="${userProfile.fullName}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" value="${userProfile.email}" required>
                    </div>
                    <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="card h-100">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-key me-2"></i>Đổi mật khẩu</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/profile" method="POST">
                    <input type="hidden" name="action" value="changePassword">
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu hiện tại</label>
                        <input type="password" class="form-control" name="oldPassword" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Mật khẩu mới</label>
                        <input type="password" class="form-control" name="newPassword" required minlength="6">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Xác nhận mật khẩu mới</label>
                        <input type="password" class="form-control" name="confirmPassword" required minlength="6">
                    </div>
                    <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-address-book me-2"></i>Địa chỉ giao hàng</h5>
                <a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/checkout">Thêm địa chỉ</a>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty addresses}">
                        <div class="alert alert-info">Bạn chưa có địa chỉ nào.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="list-group">
                            <c:forEach var="a" items="${addresses}">
                                <div class="list-group-item">
                                    <strong>${a.recipientName}</strong> - ${a.phone}
                                    <div class="text-muted small">${a.addressLine}</div>
                                    <c:if test="${a['default']}">
                                        <span class="badge bg-success mt-2">Mặc định</span>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>

