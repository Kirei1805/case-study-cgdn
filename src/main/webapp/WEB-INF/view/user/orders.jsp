<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Lịch sử đơn hàng"/>
</jsp:include>

<h3 class="mb-4">Lịch sử đơn hàng</h3>

<c:choose>
    <c:when test="${empty orders}">
        <div class="alert alert-info">
            Bạn chưa có đơn hàng nào.
            <a href="${pageContext.request.contextPath}/plants" class="alert-link">Mua sắm ngay</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Ngày đặt</th>
                        <th>Trạng thái</th>
                        <th>Tổng tiền</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>${o.id}</td>
                            <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <span class="badge bg-secondary">${o.status}</span>
                            </td>
                            <td>
                                <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="VNĐ"/>
                            </td>
                            <td class="text-end">
                                <a href="${pageContext.request.contextPath}/order-detail?id=${o.id}" class="btn btn-sm btn-outline-primary">
                                    Xem chi tiết
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../common/footer.jsp"/>
