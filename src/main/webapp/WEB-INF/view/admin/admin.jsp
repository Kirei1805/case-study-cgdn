<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - Plant Shop</title>
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

        <!-- Main -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">

            <!-- Welcome -->
            <div class="alert alert-info mt-3">
                <h5><i class="fas fa-user me-2"></i>Xin chào, ${adminUser.fullName}!</h5>
                <p>Chào mừng bạn đến với trang quản trị Plant Shop.</p>
            </div>

            <!-- Stats -->
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
                                <div class="text-xs text-warning text-uppercase mb-1">Đơn hàng mới</div>
                                <div class="h5 mb-0">${newOrders}</div>
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

            <!-- Quick actions + System info -->
            <div class="row">
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">Thao tác nhanh</div>
                        <div class="card-body row">
                            <!-- Nút thêm sản phẩm đã chỉnh -->
                            <div class="col-6 mb-3">
                                <a href="${pageContext.request.contextPath}/admin/products?action=add"
                                   class="btn btn-primary w-100">
                                    <i class="fas fa-plus me-2"></i>Thêm sản phẩm
                                </a>
                            </div>
                            <div class="col-6 mb-3">
                                <a href="${pageContext.request.contextPath}/admin/orders"
                                   class="btn btn-success w-100">
                                    <i class="fas fa-eye me-2"></i>Xem đơn hàng
                                </a>
                            </div>
                            <div class="col-6 mb-3">
                                <a href="#" class="btn btn-info w-100">
                                    <i class="fas fa-user-plus me-2"></i>Thêm khách hàng
                                </a>
                            </div>
                            <div class="col-6 mb-3">
                                <a href="${pageContext.request.contextPath}/admin/reports"
                                   class="btn btn-warning w-100">
                                    <i class="fas fa-chart-bar me-2"></i>Báo cáo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- System info -->
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header">Thông tin hệ thống</div>
                        <div class="card-body">
                            <p><strong>Phiên bản:</strong> 1.0.0</p>
                            <p><strong>Trạng thái:</strong> <span class="badge bg-success">Hoạt động</span></p>
                            <p><strong>Admin hiện tại:</strong> ${adminUser.username}</p>
                            <p><strong>Thời gian đăng nhập:</strong> <span id="loginTime"></span></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent activity -->
            <div class="row mt-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">Hoạt động gần đây</div>
                        <div class="card-body list-group list-group-flush">
                            <c:forEach var="o" items="${recentOrders}">
                                <div class="list-group-item d-flex justify-content-between align-items-center">
                                    <div><i class="fas fa-shopping-cart text-success me-2"></i>
                                        Đơn hàng mới #${o.id} - ${o.customerName}
                                    </div>
                                    <small class="text-muted"><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></small>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>document.getElementById('loginTime').textContent = new Date().toLocaleString('vi-VN');</script>
</body>
</html>
