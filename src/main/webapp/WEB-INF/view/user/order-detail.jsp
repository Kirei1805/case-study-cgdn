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

<div class="row g-4">
    <div class="col-lg-8">
        <div class="card">
            <div class="card-header d-flex justify-content-between">
                <span><strong>Đơn hàng #${order.id}</strong></span>
                <span class="badge bg-secondary text-uppercase">${order.status}</span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">SL</th>
                                <th class="text-end">Đơn giá</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="sum" value="0"/>
                            <c:forEach var="it" items="${items}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${it.plant.imageUrl}" alt="${it.plant.name}" class="rounded me-3" style="width:60px;height:60px;object-fit:cover" onerror="this.src='https://via.placeholder.com/60x60?text=Img'">
                                            <div>
                                                <div class="fw-semibold">${it.plant.name}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">${it.quantity}</td>
                                    <td class="text-end"><fmt:formatNumber value="${it.unitPrice}" type="currency" currencySymbol="VNĐ"/></td>
                                    <td class="text-end"><fmt:formatNumber value="${it.unitPrice * it.quantity}" type="currency" currencySymbol="VNĐ"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="card">
            <div class="card-header">
                <strong>Tổng kết</strong>
            </div>
            <div class="card-body">
                <div class="d-flex justify-content-between mb-2">
                    <span>Tổng đơn hàng</span>
                    <span class="fw-bold"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/></span>
                </div>
                <div class="text-end">
                    <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline-primary">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>

