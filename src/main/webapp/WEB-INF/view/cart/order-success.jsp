<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Đặt hàng thành công"/>
</jsp:include>

<div class="text-center py-5">
    <div class="mb-4">
        <i class="fas fa-check-circle fa-5x text-success"></i>
    </div>
    <h2 class="mb-3">Cảm ơn bạn đã đặt hàng!</h2>
    <p class="lead">Mã đơn hàng của bạn là: <strong>#${orderId}</strong></p>
    <p>Chúng tôi sẽ liên hệ và giao hàng trong thời gian sớm nhất.</p>
    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/orders" class="btn btn-primary me-2">
            <i class="fas fa-list me-2"></i>Xem lịch sử đơn hàng
        </a>
        <a href="${pageContext.request.contextPath}/plants" class="btn btn-success">
            <i class="fas fa-leaf me-2"></i>Tiếp tục mua sắm
        </a>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
