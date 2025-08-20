<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Không tìm thấy trang"/>
</jsp:include>

<div class="text-center py-5">
    <div class="mb-4">
        <i class="fas fa-exclamation-triangle fa-5x text-warning"></i>
    </div>
    <h1 class="display-1 text-muted">404</h1>
    <h2 class="mb-4">Không tìm thấy trang</h2>
    <p class="lead text-muted mb-4">
        Trang bạn đang tìm kiếm không tồn tại hoặc đã được di chuyển.
    </p>
    <div class="d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/" class="btn btn-success">
            <i class="fas fa-home me-2"></i>Về trang chủ
        </a>
        <a href="${pageContext.request.contextPath}/plants" class="btn btn-outline-primary">
            <i class="fas fa-leaf me-2"></i>Xem cây cảnh
        </a>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
