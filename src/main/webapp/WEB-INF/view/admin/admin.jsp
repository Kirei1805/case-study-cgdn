<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - Plant Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 2px 0;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: white;
            background: rgba(255, 255, 255, 0.1);
        }
        .main-content {
            background-color: #f8f9fa;
        }
        .stat-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: white;
        }
        .bg-primary-gradient {
            background: linear-gradient(45deg, #667eea, #764ba2);
        }
        .bg-success-gradient {
            background: linear-gradient(45deg, #11998e, #38ef7d);
        }
        .bg-warning-gradient {
            background: linear-gradient(45deg, #f093fb, #f5576c);
        }
        .bg-info-gradient {
            background: linear-gradient(45deg, #4facfe, #00f2fe);
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
                                <i class="fas fa-tachometer-alt me-2"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="fas fa-shopping-cart me-2"></i>
                                Quản lý đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-seedling me-2"></i>
                                Quản lý sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                                <i class="fas fa-chart-bar me-2"></i>
                                Báo cáo
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <i class="fas fa-cog me-2"></i>
                                Cài đặt
                            </a>
                        </li>
                        
                        <li class="nav-item mt-4">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>
                                Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">


                <!-- Welcome Message -->
                <div class="alert alert-info mb-4">
                    <h5><i class="fas fa-user me-2"></i>Chào mừng, ${adminUser.fullName}!</h5>
                    <p class="mb-0">Đây là trang quản trị Plant Shop. Bạn có thể quản lý đơn hàng, khách hàng và sản phẩm từ đây.</p>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Tổng đơn hàng
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">25</div>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat-icon bg-primary-gradient">
                                            <i class="fas fa-shopping-cart"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Tổng khách hàng
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">150</div>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat-icon bg-success-gradient">
                                            <i class="fas fa-users"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Đơn hàng mới
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">8</div>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat-icon bg-warning-gradient">
                                            <i class="fas fa-clock"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Tổng sản phẩm
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">45</div>
                                    </div>
                                    <div class="col-auto">
                                        <div class="stat-icon bg-info-gradient">
                                            <i class="fas fa-seedling"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="m-0 font-weight-bold text-primary">Thao tác nhanh</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-6 mb-3">
                                        <a href="#" class="btn btn-primary btn-block w-100">
                                            <i class="fas fa-plus me-2"></i>Thêm sản phẩm
                                        </a>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <a href="#" class="btn btn-success btn-block w-100">
                                            <i class="fas fa-eye me-2"></i>Xem đơn hàng
                                        </a>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <a href="#" class="btn btn-info btn-block w-100">
                                            <i class="fas fa-user-plus me-2"></i>Thêm khách hàng
                                        </a>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <a href="#" class="btn btn-warning btn-block w-100">
                                            <i class="fas fa-chart-bar me-2"></i>Báo cáo
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="m-0 font-weight-bold text-primary">Thông tin hệ thống</h6>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <strong>Phiên bản:</strong> 1.0.0
                                </div>
                                <div class="mb-3">
                                    <strong>Trạng thái:</strong> 
                                    <span class="badge bg-success">Hoạt động</span>
                                </div>
                                <div class="mb-3">
                                    <strong>Admin hiện tại:</strong> ${adminUser.username}
                                </div>
                                <div class="mb-3">
                                    <strong>Thời gian đăng nhập:</strong> 
                                    <span id="loginTime"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h6 class="m-0 font-weight-bold text-primary">Hoạt động gần đây</h6>
                            </div>
                            <div class="card-body">
                                <div class="list-group list-group-flush">
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-shopping-cart text-success me-2"></i>
                                            Đơn hàng mới #123 được tạo
                                        </div>
                                        <small class="text-muted">2 phút trước</small>
                                    </div>
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-user text-info me-2"></i>
                                            Khách hàng mới đăng ký
                                        </div>
                                        <small class="text-muted">15 phút trước</small>
                                    </div>
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-seedling text-warning me-2"></i>
                                            Sản phẩm "Cây Kim Tiền" được cập nhật
                                        </div>
                                        <small class="text-muted">1 giờ trước</small>
                                    </div>
                                    <div class="list-group-item d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-check-circle text-success me-2"></i>
                                            Đơn hàng #120 đã hoàn thành
                                        </div>
                                        <small class="text-muted">2 giờ trước</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Hiển thị thời gian đăng nhập
        document.getElementById('loginTime').textContent = new Date().toLocaleString('vi-VN');
    </script>
</body>
</html>
