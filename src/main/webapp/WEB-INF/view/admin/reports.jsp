<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo thống kê - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .chart-container {
            position: relative;
            height: 300px;
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin">
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/reports">
                                <i class="fas fa-chart-bar me-2"></i>
                                Báo cáo
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
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Báo cáo thống kê</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-download me-1"></i>Xuất PDF
                            </button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-file-excel me-1"></i>Xuất Excel
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Date Range Filter -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <label class="form-label">Từ ngày</label>
                        <input type="date" class="form-control" id="startDate">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Đến ngày</label>
                        <input type="date" class="form-control" id="endDate">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Loại báo cáo</label>
                        <select class="form-select" id="reportType">
                            <option value="sales">Báo cáo doanh thu</option>
                            <option value="products">Báo cáo sản phẩm</option>
                            <option value="customers">Báo cáo khách hàng</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <button class="btn btn-primary w-100">
                            <i class="fas fa-search me-1"></i>Tạo báo cáo
                        </button>
                    </div>
                </div>

                <!-- Summary Statistics -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card stat-card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="card-title">15,500,000</h4>
                                        <p class="card-text">Tổng doanh thu (VNĐ)</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-money-bill-wave fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="card-title">156</h4>
                                        <p class="card-text">Đơn hàng thành công</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-check-circle fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="card-title">89</h4>
                                        <p class="card-text">Khách hàng mới</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-user-plus fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="card-title">45</h4>
                                        <p class="card-text">Sản phẩm bán chạy</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-fire fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row mb-4">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-chart-line me-2"></i>Biểu đồ doanh thu theo tháng</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="revenueChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-chart-pie me-2"></i>Phân bố đơn hàng</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="orderChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Top Selling Products -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-trophy me-2"></i>Sản phẩm bán chạy nhất</h5>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>#</th>
                                                <th>Sản phẩm</th>
                                                <th>Loại</th>
                                                <th>Số lượng bán</th>
                                                <th>Doanh thu</th>
                                                <th>Tỷ lệ</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="https://via.placeholder.com/40x40?text=Cây+Kim+Tiền" class="rounded me-2" alt="Cây Kim Tiền">
                                                        <div>
                                                            <strong>Cây Kim Tiền</strong>
                                                            <br>
                                                            <small class="text-muted">150,000 VNĐ</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Cây văn phòng</td>
                                                <td>45</td>
                                                <td>6,750,000 VNĐ</td>
                                                <td>
                                                    <div class="progress" style="height: 20px;">
                                                        <div class="progress-bar bg-success" style="width: 85%">85%</div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>2</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="https://via.placeholder.com/40x40?text=Sen+Đá+Nâu" class="rounded me-2" alt="Sen Đá Nâu">
                                                        <div>
                                                            <strong>Sen Đá Nâu</strong>
                                                            <br>
                                                            <small class="text-muted">50,000 VNĐ</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Sen đá - Xương rồng</td>
                                                <td>38</td>
                                                <td>1,900,000 VNĐ</td>
                                                <td>
                                                    <div class="progress" style="height: 20px;">
                                                        <div class="progress-bar bg-info" style="width: 70%">70%</div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>3</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="https://via.placeholder.com/40x40?text=Bonsai+Tùng+La+Hán" class="rounded me-2" alt="Bonsai Tùng La Hán">
                                                        <div>
                                                            <strong>Bonsai Tùng La Hán</strong>
                                                            <br>
                                                            <small class="text-muted">350,000 VNĐ</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>Cây bonsai</td>
                                                <td>12</td>
                                                <td>4,200,000 VNĐ</td>
                                                <td>
                                                    <div class="progress" style="height: 20px;">
                                                        <div class="progress-bar bg-warning" style="width: 55%">55%</div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Category Performance -->
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Hiệu suất theo loại sản phẩm</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="categoryChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="mb-0"><i class="fas fa-users me-2"></i>Khách hàng theo tháng</h5>
                            </div>
                            <div class="card-body">
                                <div class="chart-container">
                                    <canvas id="customerChart"></canvas>
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
        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [{
                    label: 'Doanh thu (triệu VNĐ)',
                    data: [2.5, 3.2, 4.1, 3.8, 5.2, 6.1, 7.3, 6.8, 8.2, 9.1, 10.5, 12.3],
                    borderColor: 'rgb(75, 192, 192)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });

        // Order Status Chart
        const orderCtx = document.getElementById('orderChart').getContext('2d');
        new Chart(orderCtx, {
            type: 'doughnut',
            data: {
                labels: ['Hoàn thành', 'Đang giao', 'Chờ xử lý', 'Đã hủy'],
                datasets: [{
                    data: [65, 20, 10, 5],
                    backgroundColor: [
                        'rgb(75, 192, 192)',
                        'rgb(54, 162, 235)',
                        'rgb(255, 205, 86)',
                        'rgb(255, 99, 132)'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });

        // Category Performance Chart
        const categoryCtx = document.getElementById('categoryChart').getContext('2d');
        new Chart(categoryCtx, {
            type: 'bar',
            data: {
                labels: ['Cây văn phòng', 'Cây thủy sinh', 'Cây bonsai', 'Sen đá - Xương rồng'],
                datasets: [{
                    label: 'Số lượng bán',
                    data: [120, 85, 45, 95],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.8)',
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(255, 205, 86, 0.8)',
                        'rgba(75, 192, 192, 0.8)'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });

        // Customer Growth Chart
        const customerCtx = document.getElementById('customerChart').getContext('2d');
        new Chart(customerCtx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [{
                    label: 'Khách hàng mới',
                    data: [15, 22, 18, 25, 30, 35, 28, 32, 40, 45, 50, 55],
                    borderColor: 'rgb(255, 99, 132)',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
    </script>
</body>
</html>
