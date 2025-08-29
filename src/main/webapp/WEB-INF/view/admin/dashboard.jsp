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
    <style>
        .sidebar { min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.8); transition: all 0.3s; border-radius: 8px; margin: 2px 0; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background: rgba(255, 255, 255, 0.1); }
        .main-content { background-color: #f8f9fa; }
        .stat-card { border: none; border-radius: 15px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        .stat-icon { width: 60px; height: 60px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 24px; color: #fff; }
        .bg-primary-gradient { background: linear-gradient(45deg, #667eea, #764ba2); }
        .bg-success-gradient { background: linear-gradient(45deg, #11998e, #38ef7d); }
        .bg-warning-gradient { background: linear-gradient(45deg, #f093fb, #f5576c); }
        .bg-info-gradient { background: linear-gradient(45deg, #4facfe, #00f2fe); }
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
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin"><i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/products"><i class="fas fa-seedling me-2"></i>Quản lý sản phẩm</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/reports"><i class="fas fa-chart-bar me-2"></i>Báo cáo</a></li>
                    <li class="nav-item mt-4"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                </ul>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
            <!-- Welcome -->
            <div class="alert alert-info mt-3">
                <h5><i class="fas fa-user me-2"></i>Xin chào, ${adminUser.fullName}!</h5>
                <p>Chào mừng bạn đến với trang quản trị Plant Shop.</p>
            </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <div class="text-xs text-primary text-uppercase mb-1">Tổng đơn hàng</div>
                        <div class="h5 mb-0">${totalOrders}</div>
                    </div>
                    <div class="stat-icon bg-primary-gradient"><i class="fas fa-shopping-cart"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <div class="text-xs text-success text-uppercase mb-1">Tổng khách hàng</div>
                        <div class="h5 mb-0">${totalUsers}</div>
                    </div>
                    <div class="stat-icon bg-success-gradient"><i class="fas fa-users"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <div class="text-xs text-warning text-uppercase mb-1">Đơn chờ xử lý</div>
                        <div class="h5 mb-0">${pendingOrders}</div>
                    </div>
                    <div class="stat-icon bg-warning-gradient"><i class="fas fa-clock"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex justify-content-between">
                    <div>
                        <div class="text-xs text-info text-uppercase mb-1">Tổng sản phẩm</div>
                        <div class="h5 mb-0">${totalProducts}</div>
                    </div>
                    <div class="stat-icon bg-info-gradient"><i class="fas fa-seedling"></i></div>
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
                            <td>-</td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="VNĐ"/></td>
                            <td>
                                        <span class="badge
                                            ${order.status eq 'shipped' ? 'bg-success' :
                                              order.status eq 'pending' ? 'bg-warning' :
                                              order.status eq 'processing' ? 'bg-info' :
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
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

