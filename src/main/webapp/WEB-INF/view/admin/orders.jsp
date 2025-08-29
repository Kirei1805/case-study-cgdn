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
    <style>
        .sidebar { min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); transition: all 0.3s; border-radius: 8px; margin: 2px 0; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background: rgba(255, 255, 255, 0.1); }
        .main-content { background-color: #f8f9fa; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
            <div class="position-sticky pt-3 text-center text-white">
                <i class="fas fa-seedling fa-2x mb-2"></i>
                <h5>Plant Shop Admin</h5>
                <small class="text-white-50">Quản lý hệ thống</small>
                <ul class="nav flex-column mt-3">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-seedling me-2"></i>Quản lý sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/reports"><i class="fas fa-chart-bar me-2"></i>Báo cáo</a></li>
                    <li class="nav-item mt-4"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Danh sách đơn hàng</h1>
            </div>

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
                    <td>-</td>
                    <td><fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="VNĐ"/></td>
                    <td>
                        <span class="badge
                            ${o.status eq 'shipped' ? 'bg-success' :
                              o.status eq 'pending' ? 'bg-warning' :
                              o.status eq 'processing' ? 'bg-info' :
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
        </main>
    </div>
</div>
</body>
</html>
