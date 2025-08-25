<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Plant Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="fas fa-leaf me-2"></i>Plant Shop Admin
        </a>
        <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user me-1"></i>${adminUser.fullName}
                </span>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
            </a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h2 class="mb-4">Dashboard</h2>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">${totalOrders}</h4>
                        <p class="card-text">Tổng đơn hàng</p>
                    </div>
                    <div class="align-self-center"><i class="fas fa-shopping-cart fa-2x"></i></div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-warning text-white">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">${pendingOrders}</h4>
                        <p class="card-text">Đơn chờ xử lý</p>
                    </div>
                    <div class="align-self-center"><i class="fas fa-clock fa-2x"></i></div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">${totalUsers}</h4>
                        <p class="card-text">Tổng khách hàng</p>
                    </div>
                    <div class="align-self-center"><i class="fas fa-users fa-2x"></i></div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-info text-white">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">${totalProducts}</h4>
                        <p class="card-text">Tổng sản phẩm</p>
                    </div>
                    <div class="align-self-center"><i class="fas fa-seedling fa-2x"></i></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Orders -->
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0"><i class="fas fa-list me-2"></i>Đơn hàng gần đây</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
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
                    <c:forEach var="order" items="${recentOrders}">
                        <tr>
                            <td>${order.id}</td>
                            <td>
                                <strong>${order.customerName}</strong><br/>
                                <small class="text-muted">${order.customerUsername}</small>
                            </td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/></td>
                            <td>
                                        <span class="badge
                                            ${order.status eq 'completed' ? 'bg-success' :
                                              order.status eq 'pending' ? 'bg-warning' :
                                              order.status eq 'shipped' ? 'bg-primary' :
                                              order.status eq 'cancelled' ? 'bg-danger' : 'bg-secondary'}">
                                                ${order.status}
                                        </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${order.id}"
                                   class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-eye"></i> Xem
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

