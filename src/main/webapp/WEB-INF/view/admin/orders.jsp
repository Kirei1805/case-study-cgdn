<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="mb-4">Danh sách đơn hàng</h2>

    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-light">
            <tr>
                <th>#</th>
                <th>Khách hàng</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="o" items="${orders}">
                <tr>
                    <td>#${o.id}</td>
                    <td>
                        <strong>${o.customerName}</strong><br/>
                        <small class="text-muted">${o.customerUsername}</small>
                    </td>
                    <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td><fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="VNĐ"/></td>
                    <td>
                        <span class="badge
                            ${o.status eq 'pending' ? 'bg-warning' :
                              o.status eq 'processing' ? 'bg-info' :
                              o.status eq 'shipped' ? 'bg-primary' :
                              o.status eq 'cancelled' ? 'bg-danger' : 'bg-secondary'}">
                                ${o.status}
                        </span>
                    </td>
                    <td>
                        <div class="btn-group btn-group-sm">
                            <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${o.id}"
                               class="btn btn-outline-primary" title="Chi tiết">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/orders?action=delete&id=${o.id}"
                               class="btn btn-outline-danger"
                               onclick="return confirm('Bạn chắc chắn muốn xóa đơn này?')"
                               title="Xóa">
                                <i class="fas fa-trash"></i>
                            </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
