<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Plant Shop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
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

        /* Welcome Alert */
        .welcome-alert {
            background: var(--admin-gradient-light);
            border: 1px solid rgba(45, 90, 39, 0.2);
            border-radius: var(--border-radius-lg);
            border-left: 4px solid var(--admin-primary);
            margin-bottom: 2rem;
        }

        .welcome-alert h5 {
            color: var(--admin-primary);
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
        }

        /* Enhanced Stat Cards */
        .stat-card { 
            border: none; 
            border-radius: var(--border-radius-lg); 
            box-shadow: var(--shadow-sm);
            background: white;
            overflow: hidden;
            position: relative;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--admin-gradient);
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

        .stat-icon { 
            width: 70px; 
            height: 70px; 
            border-radius: 50%; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 28px; 
            color: #fff;
            position: relative;
            overflow: hidden;
        }

        .stat-icon::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, rgba(255,255,255,0.1), rgba(255,255,255,0.3), rgba(255,255,255,0.1));
            border-radius: 50%;
            transform: scale(0);
            transition: transform 0.3s ease;
        }

        .stat-card:hover .stat-icon::before {
            transform: scale(1);
        }

        .bg-primary-gradient { background: linear-gradient(135deg, #2d5a27, #4a7c59); }
        .bg-success-gradient { background: linear-gradient(135deg, #28a745, #20c997); }
        .bg-warning-gradient { background: linear-gradient(135deg, #ffc107, #fd7e14); }
        .bg-info-gradient { background: linear-gradient(135deg, #17a2b8, #6f42c1); }

        .stat-number {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 2.2rem;
            color: var(--admin-primary);
        }

        .stat-label {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
            color: var(--admin-secondary);
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

        /* Enhanced Buttons */
        .btn {
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-outline-primary {
            border: 2px solid var(--admin-primary);
            color: var(--admin-primary);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--admin-primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        /* Enhanced Badge */
        .badge {
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            font-size: 0.85rem;
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
            
            .stat-number {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Admin Sidebar -->
        <jsp:include page="../common/admin-sidebar.jsp">
            <jsp:param name="activePage" value="dashboard"/>
        </jsp:include>

        <!-- Main content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h1>Dashboard</h1>
                        <p class="text-muted mb-0">Tổng quan về hệ thống Plant Shop</p>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-clock me-2 text-muted"></i>
                        <span class="text-muted" id="currentDateTime"></span>
                    </div>
                </div>
            </div>

            <!-- Welcome Alert -->
            <div class="alert welcome-alert fade-in">
                <div class="d-flex align-items-center">
                    <div class="me-3">
                        <i class="fas fa-user-shield fa-2x text-primary"></i>
                    </div>
                    <div>
                        <h5><i class="fas fa-hand-wave me-2"></i>Xin chào, ${adminUser.fullName}!</h5>
                        <p class="mb-0">Chào mừng bạn trở lại với trang quản trị Plant Shop. Hãy bắt đầu ngày làm việc hiệu quả!</p>
                    </div>
                </div>
            </div>

            <!-- Enhanced Statistics Cards -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card fade-in">
                        <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                                <div class="stat-label">Tổng đơn hàng</div>
                                <div class="stat-number">${totalOrders}</div>
                                <small class="text-muted">
                                    <i class="fas fa-chart-line me-1"></i>
                                    Tất cả đơn hàng
                                </small>
                            </div>
                            <div class="stat-icon bg-primary-gradient">
                                <i class="fas fa-shopping-cart"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card fade-in" style="animation-delay: 0.1s">
                        <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                                <div class="stat-label">Tổng khách hàng</div>
                                <div class="stat-number">${totalUsers}</div>
                                <small class="text-muted">
                                    <i class="fas fa-user-plus me-1"></i>
                                    Đã đăng ký
                                </small>
                            </div>
                            <div class="stat-icon bg-success-gradient">
                                <i class="fas fa-users"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card fade-in" style="animation-delay: 0.2s">
                        <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                                <div class="stat-label">Đơn chờ xử lý</div>
                                <div class="stat-number text-warning">${pendingOrders}</div>
                                <small class="text-muted">
                                    <i class="fas fa-hourglass-half me-1"></i>
                                    Cần xử lý
                                </small>
                            </div>
                            <div class="stat-icon bg-warning-gradient">
                                <i class="fas fa-clock"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card stat-card fade-in" style="animation-delay: 0.3s">
                        <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                                <div class="stat-label">Tổng sản phẩm</div>
                                <div class="stat-number">${totalProducts}</div>
                                <small class="text-muted">
                                    <i class="fas fa-seedling me-1"></i>
                                    Đang bán
                                </small>
                            </div>
                            <div class="stat-icon bg-info-gradient">
                                <i class="fas fa-leaf"></i>
                    </div>
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
        </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Dashboard JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Update current date/time
    function updateDateTime() {
        const now = new Date();
        const options = { 
            weekday: 'long', 
            year: 'numeric', 
            month: 'long', 
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        };
        document.getElementById('currentDateTime').textContent = now.toLocaleDateString('vi-VN', options);
    }
    
    updateDateTime();
    setInterval(updateDateTime, 60000); // Update every minute
    
    // Add click handlers to stat cards for navigation
    document.querySelectorAll('.stat-card').forEach((card, index) => {
        card.style.cursor = 'pointer';
        card.addEventListener('click', function() {
            const links = [
                '${pageContext.request.contextPath}/admin/orders',     // Orders
                '${pageContext.request.contextPath}/admin/users',      // Users (if exists)
                '${pageContext.request.contextPath}/admin/orders?status=pending', // Pending
                '${pageContext.request.contextPath}/admin/products'    // Products
            ];
            
            if (links[index]) {
                window.location.href = links[index];
            }
        });
        
        // Add hover effect for clickable indication
        card.addEventListener('mouseenter', function() {
            this.style.cursor = 'pointer';
        });
    });
    
    // Animate counters
    function animateCounter(element, target) {
        let start = 0;
        const increment = target / 50;
        const timer = setInterval(() => {
            start += increment;
            if (start >= target) {
                element.textContent = target;
                clearInterval(timer);
            } else {
                element.textContent = Math.ceil(start);
            }
        }, 30);
    }
    
    // Start counter animations after a delay
    setTimeout(() => {
        document.querySelectorAll('.stat-number').forEach(el => {
            const target = parseInt(el.textContent) || 0;
            if (target > 0) {
                el.textContent = '0';
                animateCounter(el, target);
            }
        });
    }, 500);
    
    // Auto-refresh dashboard data every 5 minutes
    setInterval(() => {
        // You can add AJAX call here to refresh data
        console.log('Dashboard data refresh...');
    }, 300000);
});

// Utility function for smooth scrolling
function smoothScrollTo(element) {
    element.scrollIntoView({
        behavior: 'smooth'
    });
}
</script>
</body>
</html>

