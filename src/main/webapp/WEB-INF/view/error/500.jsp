<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Lỗi máy chủ"/>
</jsp:include>

<div class="text-center py-5">
    <div class="mb-4">
        <i class="fas fa-bug fa-5x text-danger"></i>
    </div>
    <h1 class="display-1 text-muted">500</h1>
    <h2 class="mb-4">Lỗi máy chủ</h2>
    <p class="lead text-muted mb-4">
        Đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn. Vui lòng thử lại sau.
    </p>
    <div class="d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/" class="btn btn-success">
            <i class="fas fa-home me-2"></i>Về trang chủ
        </a>
        <button onclick="history.back()" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Quay lại
        </button>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
