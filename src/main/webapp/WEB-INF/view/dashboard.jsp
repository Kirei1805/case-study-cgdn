<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: white;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
        }
        .stat-card {
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-icon {
            font-size: 2.5rem;
            opacity: 0.8;
        }
        .recent-activity {
            max-height: 400px;
            overflow-y: auto;
        }
        .activity-item {
            border-left: 3px solid #28a745;
            padding-left: 15px;
            margin-bottom: 15px;
        }
        .activity-item.warning {
            border-left-color: #ffc107;
        }
        .activity-item.danger {
            border-left-color: #dc3545;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center mb-4">
                        <i class="fas fa-seedling fa-2x text-white mb-2"></i>
                        <h5 class="text-white">Plant Shop Admin</h5>
                        <small class="text-white-50">Quản lý hệ thống</small>
                    </div>
                    
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/plants">
                                <i class="fas fa-leaf me-2"></i>
                                Quản lý cây trồng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fas fa-tags me-2"></i>
                                Quản lý danh mục
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users me-2"></i>
                                Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="fas fa-shopping-cart me-2"></i>
                                Quản lý đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/reviews">
                                <i class="fas fa-star me-2"></i>
                                Quản lý đánh giá
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/vouchers">
                                <i class="fas fa-ticket-alt me-2"></i>
                                Quản lý mã giảm giá
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a class="nav-link" href="${pageContext.request.contextPath}/plants">
                                <i class="fas fa-external-link-alt me-2"></i>
                                Xem trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>
                                Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-download me-1"></i>Xuất báo cáo
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary shadow h-100 py-2 stat-card">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Tổng cây trồng
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalPlants}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-leaf stat-icon text-primary"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-success shadow h-100 py-2 stat-card">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Tổng người dùng
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalUsers}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-users stat-icon text-success"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-info shadow h-100 py-2 stat-card">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Đơn hàng mới
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${newOrders}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-shopping-cart stat-icon text-info"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-warning shadow h-100 py-2 stat-card">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Sắp hết hàng
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${lowStockPlants}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-exclamation-triangle stat-icon text-warning"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts and Tables -->
                <div class="row">
                    <!-- Recent Activities -->
                    <div class="col-lg-8">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-history me-2"></i>Hoạt động gần đây
                                </h6>
                            </div>
                            <div class="card-body recent-activity">
                                <c:choose>
                                    <c:when test="${not empty recentActivities}">
                                        <c:forEach var="activity" items="${recentActivities}">
                                            <div class="activity-item ${activity.type}">
                                                <div class="d-flex justify-content-between">
                                                    <div>
                                                        <strong>${activity.title}</strong>
                                                        <p class="mb-0 text-muted">${activity.description}</p>
                                                    </div>
                                                    <small class="text-muted">${activity.time}</small>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center text-muted py-4">
                                            <i class="fas fa-inbox fa-3x mb-3"></i>
                                            <p>Chưa có hoạt động nào</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="col-lg-4">
                        <div class="card shadow mb-4">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-bolt me-2"></i>Thao tác nhanh
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/admin/plants?action=add" 
                                       class="btn btn-success">
                                        <i class="fas fa-plus me-2"></i>Thêm cây trồng mới
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=add" 
                                       class="btn btn-primary">
                                        <i class="fas fa-tag me-2"></i>Thêm danh mục mới
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/orders" 
                                       class="btn btn-info">
                                        <i class="fas fa-shopping-cart me-2"></i>Xem đơn hàng
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/users" 
                                       class="btn btn-warning">
                                        <i class="fas fa-users me-2"></i>Quản lý người dùng
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- System Status -->
                        <div class="card shadow">
                            <div class="card-header py-3">
                                <h6 class="m-0 font-weight-bold text-primary">
                                    <i class="fas fa-server me-2"></i>Trạng thái hệ thống
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between">
                                        <span>Database</span>
                                        <span class="badge bg-success">Online</span>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between">
                                        <span>Server</span>
                                        <span class="badge bg-success">Running</span>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between">
                                        <span>Storage</span>
                                        <span class="badge bg-warning">75%</span>
                                    </div>
                                </div>
                                <div class="mb-0">
                                    <div class="d-flex justify-content-between">
                                        <span>Memory</span>
                                        <span class="badge bg-info">60%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 