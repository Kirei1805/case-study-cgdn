<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo thống kê - Plant Shop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --admin-primary: #2d5a27;
            --admin-secondary: #4a7c59;
            --admin-accent: #7fb069;
            --admin-gradient: linear-gradient(135deg, #2d5a27 0%, #4a7c59 50%, #7fb069 100%);
            --admin-gradient-light: linear-gradient(135deg, rgba(45, 90, 39, 0.1) 0%, rgba(127, 176, 105, 0.05) 100%);
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 8px rgba(0,0,0,0.12);
            --shadow-lg: 0 8px 16px rgba(0,0,0,0.15);
            --shadow-xl: 0 12px 24px rgba(0,0,0,0.18);
            --border-radius: 12px;
            --border-radius-lg: 16px;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f8fffe 0%, #f0f8f0 100%);
            color: #2c3e50;
        }

        /* Enhanced Sidebar */
        .sidebar {
            min-height: 100vh;
            background: var(--admin-gradient);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: var(--shadow-lg);
        }
        
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.85); 
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
            border-radius: var(--border-radius); 
            margin: 4px 8px; 
            padding: 12px 16px;
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .sidebar .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s ease;
        }
        
        .sidebar .nav-link:hover::before {
            left: 100%;
        }
        
        .sidebar .nav-link:hover, .sidebar .nav-link.active { 
            color: #fff; 
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        .sidebar .nav-link i {
            width: 20px;
            text-align: center;
        }

        .sidebar h5 {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 1.4rem;
        }

        .sidebar small {
            opacity: 0.8;
            font-style: italic;
        }

        /* Modern Main Content */
        .main-content {
            background: transparent;
            min-height: 100vh;
        }

        .page-header {
            background: white;
            border-radius: var(--border-radius-lg);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(45, 90, 39, 0.1);
        }

        .page-header h1 {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            color: var(--admin-primary);
            margin: 0;
            font-size: 2rem;
        }

        /* Enhanced Stat Cards */
        .stat-card {
            border: none;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-sm);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
            position: relative;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, rgba(255,255,255,0.3), rgba(255,255,255,0.8), rgba(255,255,255,0.3));
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-xl);
        }

        .stat-card:hover::before {
            transform: scaleX(1);
        }

        .stat-card .card-title {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 1.8rem;
        }

        .stat-card .card-text {
            font-weight: 500;
            opacity: 0.9;
        }

        /* Enhanced Cards */
        .card {
            border: none;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-sm);
            background: white;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: var(--shadow-md);
            transform: translateY(-2px);
        }

        .card-header {
            background: var(--admin-gradient-light);
            border-bottom: 1px solid rgba(45, 90, 39, 0.1);
            font-weight: 600;
            color: var(--admin-primary);
            border-radius: var(--border-radius-lg) var(--border-radius-lg) 0 0;
        }

        .card-header h5 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            margin: 0;
        }

        /* Enhanced Filter Section */
        .filter-section {
            background: white;
            border-radius: var(--border-radius-lg);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(45, 90, 39, 0.1);
        }

        .filter-section .form-control, .filter-section .form-select {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .filter-section .form-control:focus, .filter-section .form-select:focus {
            border-color: var(--admin-primary);
            box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.15);
            background: white;
            transform: translateY(-1px);
        }

        /* Enhanced Buttons */
        .btn {
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-primary {
            background: var(--admin-gradient);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #234a1e 0%, #3a6b47 50%, #6da058 100%);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            color: white;
        }

        .btn-outline-secondary {
            border: 2px solid #6c757d;
            color: #6c757d;
        }

        .btn-outline-secondary:hover {
            background: #6c757d;
            color: white;
            transform: translateY(-1px);
        }

        /* Enhanced Tables */
        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: var(--admin-gradient-light);
            border: none;
            color: var(--admin-primary);
            font-weight: 600;
            padding: 1rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .table tbody tr:hover {
            background: rgba(45, 90, 39, 0.02);
        }

        .chart-container {
            position: relative;
            height: 350px;
        }

        /* Progress bars */
        .progress {
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-bar {
            transition: width 0.6s ease;
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }
            
            .page-header h1 {
                font-size: 1.5rem;
            }
            
            .filter-section {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Admin Sidebar -->
            <jsp:include page="../common/admin-sidebar.jsp">
                <jsp:param name="activePage" value="reports"/>
            </jsp:include>

            <!-- Main content -->
            <div class="main-content">
                <!-- Page Header -->
                <div class="page-header d-flex justify-content-between align-items-center">
                    <div>
                        <h1>Báo cáo thống kê</h1>
                        <p class="text-muted mb-0">Phân tích dữ liệu kinh doanh và xu hướng bán hàng</p>
                    </div>
                    <div class="btn-group">
                        <button type="button" class="btn btn-outline-secondary">
                                <i class="fas fa-download me-1"></i>Xuất PDF
                            </button>
                        <button type="button" class="btn btn-outline-secondary">
                                <i class="fas fa-file-excel me-1"></i>Xuất Excel
                            </button>
                        <button type="button" class="btn btn-primary">
                            <i class="fas fa-sync me-1"></i>Làm mới
                        </button>
                    </div>
                </div>

                <!-- Enhanced Date Range Filter -->
                <div class="filter-section">
                    <div class="d-flex align-items-center mb-3">
                        <div class="me-3">
                            <i class="fas fa-filter fa-2x text-primary"></i>
                        </div>
                        <div>
                            <h5 class="mb-1 text-primary fw-bold">Bộ lọc báo cáo</h5>
                            <p class="text-muted mb-0">Tùy chỉnh thời gian và loại báo cáo để phân tích</p>
                        </div>
                    </div>
                    <div class="row">
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
                                        <h4 class="card-title"><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol=""/></h4>
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
                                        <h4 class="card-title">${successfulOrders}</h4>
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
                                        <h4 class="card-title">${newCustomers}</h4>
                                        <p class="card-text">Tổng khách hàng</p>
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
                                        <h4 class="card-title">${totalProducts}</h4>
                                        <p class="card-text">Tổng sản phẩm</p>
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Chart color scheme
        const chartColors = {
            primary: '#2d5a27',
            secondary: '#4a7c59',
            accent: '#7fb069',
            success: '#28a745',
            info: '#17a2b8',
            warning: '#ffc107',
            danger: '#dc3545'
        };

        // Chart options
        const chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    labels: {
                        font: {
                            family: 'Inter'
                        }
                    }
                }
            },
            scales: {
                y: {
                    grid: {
                        color: 'rgba(0,0,0,0.1)'
                    },
                    ticks: {
                        font: {
                            family: 'Inter'
                        }
                    }
                },
                x: {
                    grid: {
                        color: 'rgba(0,0,0,0.1)'
                    },
                    ticks: {
                        font: {
                            family: 'Inter'
                        }
                    }
                }
            }
        };

        // Revenue Chart
        const revenueCtx = document.getElementById('revenueChart').getContext('2d');
        new Chart(revenueCtx, {
            type: 'line',
            data: {
                labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                datasets: [{
                    label: 'Doanh thu (triệu VNĐ)',
                    data: [2.5, 3.2, 4.1, 3.8, 5.2, 6.1, 7.3, 6.8, 8.2, 9.1, 10.5, 12.3],
                    borderColor: chartColors.primary,
                    backgroundColor: chartColors.primary + '20',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: chartColors.primary,
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 6
                }]
            },
            options: chartOptions
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
                        chartColors.success,
                        chartColors.info,
                        chartColors.warning,
                        chartColors.danger
                    ],
                    borderWidth: 3,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            font: {
                                family: 'Inter',
                                size: 12
                            }
                        }
                    }
                },
                cutout: '65%'
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
                        chartColors.primary + '80',
                        chartColors.secondary + '80',
                        chartColors.accent + '80',
                        chartColors.info + '80'
                    ],
                    borderColor: [
                        chartColors.primary,
                        chartColors.secondary,
                        chartColors.accent,
                        chartColors.info
                    ],
                    borderWidth: 2,
                    borderRadius: 8,
                    borderSkipped: false
                }]
            },
            options: {
                ...chartOptions,
                plugins: {
                    legend: {
                        display: false
                    }
                }
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
                    borderColor: chartColors.accent,
                    backgroundColor: chartColors.accent + '20',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointBackgroundColor: chartColors.accent,
                    pointBorderColor: '#fff',
                    pointBorderWidth: 2,
                    pointRadius: 5
                }]
            },
            options: chartOptions
        });

        // Initialize animations and interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Add fade-in animations to cards
            document.querySelectorAll('.card, .stat-card').forEach((card, index) => {
                card.classList.add('fade-in');
                card.style.animationDelay = (index * 0.1) + 's';
            });

            // Add click handlers to stat cards
            document.querySelectorAll('.stat-card').forEach(card => {
                card.style.cursor = 'pointer';
                card.addEventListener('click', function() {
                    // Add click animation
                    this.style.transform = 'scale(0.95)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });

            // Auto-refresh charts data every 10 minutes
            setInterval(() => {
                console.log('Refreshing charts data...');
                // Add AJAX call here to refresh data
            }, 600000);
        });
    </script>
</body>
</html>
