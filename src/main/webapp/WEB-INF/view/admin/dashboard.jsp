<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <style>
        body { font-family: 'Segoe UI', sans-serif; }
        .sidebar {
            min-height: 100vh;
            background: #212529;
        }
        .sidebar .nav-link {
            color: #adb5bd;
            border-radius: 6px;
        }
        .sidebar .nav-link.active,
        .sidebar .nav-link:hover {
            color: #fff;
            background: rgba(255,255,255,0.1);
        }
        .stat-card {
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .stat-icon {
            font-size: 2rem;
            padding: 12px;
            border-radius: 50%;
            color: #fff;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 sidebar p-3">
            <div class="text-center text-white mb-4">
                <i class="fas fa-seedling fa-2x mb-2"></i>
                <h5>Plant Shop Admin</h5>
                <small class="text-secondary">Quản lý hệ thống</small>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item mt-3">
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Dashboard</h2>
                <button class="btn btn-sm btn-outline-secondary">
                    <i class="fas fa-file-export me-1"></i> Xuất báo cáo
                </button>
            </div>

            <!-- Stats cards -->
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="card stat-card p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="text-muted small">Tổng cây trồng</div>
                                <h4>${totalPlants}</h4>
                            </div>
                            <div class="stat-icon bg-primary">
                                <i class="fas fa-leaf"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card stat-card p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="text-muted small">Tổng người dùng</div>
                                <h4>${totalUsers}</h4>
                            </div>
                            <div class="stat-icon bg-success">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card stat-card p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="text-muted small">Đơn hàng mới</div>
                                <h4>${newOrders}</h4>
                            </div>
                            <div class="stat-icon bg-warning">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card stat-card p-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="text-muted small">Sắp hết hàng</div>
                                <h4>${lowStockPlants}</h4>
                            </div>
                            <div class="stat-icon bg-danger">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User statistics -->
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <div class="card stat-card p-3">
                        <h6 class="text-primary">Thống kê người dùng</h6>
                        <div class="row text-center mt-3">
                            <div class="col">
                                <h4 class="text-primary">${customerCount}</h4>
                                <small class="text-muted">Khách hàng</small>
                            </div>
                            <div class="col">
                                <h4 class="text-success">${adminCount}</h4>
                                <small class="text-muted">Admin</small>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card stat-card p-3">
                        <h6 class="text-primary">Người dùng mới hôm nay</h6>
                        <div class="text-center mt-3">
                            <h2 class="text-info">${newUsersToday}</h2>
                            <small class="text-muted">người dùng mới</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick action -->
            <div class="card stat-card p-3">
                <h6 class="text-primary">Thao tác nhanh</h6>
                <div class="alert alert-info mt-3 mb-0">
                    <i class="fas fa-info-circle me-2"></i> Chỉ giữ lại Dashboard.
                    Các chức năng quản trị khác đã được vô hiệu hóa theo yêu cầu.
                </div>
            </div>

        </main>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
