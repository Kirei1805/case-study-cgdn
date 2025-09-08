<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng - Plant Shop Admin</title>
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

        /* Enhanced Cards */
        .card {
            border: none;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-sm);
            background: white;
            overflow: hidden;
            transition: all 0.3s ease;
            margin-bottom: 2rem;
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
            padding: 1.5rem;
        }

        .card-header h5 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            margin: 0;
        }

        .card-body {
            padding: 2rem;
        }

        /* Order Info Cards */
        .order-info-card {
            background: var(--admin-gradient-light);
            border-left: 4px solid var(--admin-primary);
            padding: 1.5rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid rgba(45, 90, 39, 0.1);
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: var(--admin-secondary);
            display: flex;
            align-items: center;
        }

        .info-label i {
            margin-right: 0.5rem;
            width: 20px;
            text-align: center;
        }

        .info-value {
            font-weight: 500;
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

        .product-image {
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            transition: transform 0.3s ease;
        }

        .product-image:hover {
            transform: scale(1.1);
        }

        /* Enhanced Buttons */
        .btn {
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            padding: 0.75rem 1.5rem;
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

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #545b62;
            transform: translateY(-2px);
            color: white;
        }

        /* Enhanced Form Controls */
        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--admin-primary);
            box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.15);
            background: white;
            transform: translateY(-1px);
        }

        /* Enhanced Badge */
        .badge {
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            font-size: 0.85rem;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-badge i {
            font-size: 0.8rem;
        }

        /* Order Timeline */
        .order-timeline {
            position: relative;
            padding-left: 2rem;
        }

        .timeline-item {
            position: relative;
            padding-bottom: 2rem;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -2rem;
            top: 0.5rem;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--admin-primary);
        }

        .timeline-item::after {
            content: '';
            position: absolute;
            left: -1.75rem;
            top: 1.25rem;
            width: 2px;
            height: calc(100% - 1rem);
            background: rgba(45, 90, 39, 0.2);
        }

        .timeline-item:last-child::after {
            display: none;
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
            
            .card-body {
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
            <jsp:param name="activePage" value="orders"/>
        </jsp:include>

        <!-- Main content -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="page-header d-flex justify-content-between align-items-center">
                <div>
                    <h1>Chi tiết đơn hàng #${order.id}</h1>
                    <p class="text-muted mb-0">Thông tin chi tiết và quản lý đơn hàng</p>
                </div>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-1"></i>Quay lại
                    </a>
                    <button class="btn btn-primary" onclick="window.print()">
                        <i class="fas fa-print me-1"></i>In đơn hàng
                    </button>
                </div>
            </div>

    <!-- Enhanced Order Information -->
    <div class="row mb-4">
        <div class="col-lg-8">
            <div class="card fade-in">
                <div class="card-header">
                    <h5><i class="fas fa-info-circle me-2"></i>Thông tin đơn hàng</h5>
                </div>
        <div class="card-body">
                    <div class="order-info-card">
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-user text-primary"></i>
                                Khách hàng
                            </div>
                            <div class="info-value">
                                <strong>${order.customerName}</strong>
                                <br><small class="text-muted">${order.customerUsername}</small>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-calendar text-info"></i>
                                Ngày đặt hàng
                            </div>
                            <div class="info-value">
                                <strong>-</strong>
                                <br><small class="text-muted">Chưa có thông tin</small>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-flag text-warning"></i>
                                Trạng thái hiện tại
                            </div>
                            <div class="info-value">
                                <span class="badge status-badge
                    ${order.status eq 'shipped' ? 'bg-success' :
                      order.status eq 'pending' ? 'bg-warning' :
                      order.status eq 'processing' ? 'bg-info' :
                      order.status eq 'cancelled' ? 'bg-danger' : 'bg-secondary'}">
                                    <i class="fas fa-${order.status eq 'shipped' ? 'check-circle' :
                                                     order.status eq 'pending' ? 'clock' :
                                                     order.status eq 'processing' ? 'spinner' :
                                                     order.status eq 'cancelled' ? 'times-circle' : 'question-circle'}"></i>
                                    ${order.status eq 'shipped' ? 'Đã giao hàng' :
                                      order.status eq 'pending' ? 'Chờ xử lý' :
                                      order.status eq 'processing' ? 'Đang xử lý' :
                                      order.status eq 'cancelled' ? 'Đã hủy' : 'Không xác định'}
                </span>
                            </div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-money-bill-wave text-success"></i>
                                Tổng tiền
                            </div>
                            <div class="info-value">
                                <strong class="text-success fs-5">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol=""/> VNĐ
                                </strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card fade-in" style="animation-delay: 0.1s">
                <div class="card-header">
                    <h5><i class="fas fa-route me-2"></i>Tiến trình đơn hàng</h5>
                </div>
                <div class="card-body">
                    <div class="order-timeline">
                        <div class="timeline-item">
                            <h6 class="fw-bold">Đơn hàng được tạo</h6>
                            <small class="text-muted">Khách hàng đã đặt hàng thành công</small>
                        </div>
                        <div class="timeline-item">
                            <h6 class="fw-bold ${order.status eq 'pending' ? 'text-warning' : 'text-success'}">
                                Chờ xử lý
                            </h6>
                            <small class="text-muted">Đơn hàng đang chờ được xác nhận</small>
                        </div>
                        <div class="timeline-item">
                            <h6 class="fw-bold ${order.status eq 'processing' ? 'text-info' : order.status eq 'shipped' ? 'text-success' : 'text-muted'}">
                                Đang xử lý
                            </h6>
                            <small class="text-muted">Chuẩn bị và đóng gói sản phẩm</small>
                        </div>
                        <div class="timeline-item">
                            <h6 class="fw-bold ${order.status eq 'shipped' ? 'text-success' : 'text-muted'}">
                                Đã giao hàng
                            </h6>
                            <small class="text-muted">Sản phẩm đã được giao đến khách hàng</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Enhanced Status Update Form -->
    <div class="card fade-in" style="animation-delay: 0.2s">
        <div class="card-header">
            <h5><i class="fas fa-edit me-2"></i>Cập nhật trạng thái đơn hàng</h5>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/orders" method="post" class="row g-3" id="statusUpdateForm">
                <input type="hidden" name="action" value="updateStatus"/>
                <input type="hidden" name="id" value="${order.id}"/>
                <div class="col-md-8">
                    <label class="form-label fw-bold">
                        <i class="fas fa-flag me-1"></i>Chọn trạng thái mới
                    </label>
                    <select name="status" class="form-select" required>
                        <option value="pending" ${order.status eq 'pending' ? 'selected' : ''}>
                            🕐 Chờ xử lý - Đơn hàng mới được tạo
                        </option>
                        <option value="processing" ${order.status eq 'processing' ? 'selected' : ''}>
                            ⚙️ Đang xử lý - Chuẩn bị và đóng gói
                        </option>
                        <option value="shipped" ${order.status eq 'shipped' ? 'selected' : ''}>
                            ✅ Đã giao - Hoàn thành giao hàng
                        </option>
                        <option value="cancelled" ${order.status eq 'cancelled' ? 'selected' : ''}>
                            ❌ Đã hủy - Đơn hàng bị hủy bỏ
                        </option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">&nbsp;</label>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="fas fa-save me-2"></i>Cập nhật trạng thái
                        </button>
                    </div>
                </div>
            </form>
            <div class="mt-3 p-3 bg-light rounded">
                <div class="d-flex align-items-center">
                    <i class="fas fa-info-circle text-info me-2"></i>
                    <small class="text-muted">
                        <strong>Lưu ý:</strong> Việc thay đổi trạng thái đơn hàng sẽ được ghi lại và không thể hoàn tác.
                        Hãy đảm bảo trạng thái mới phù hợp với tình trạng thực tế của đơn hàng.
                    </small>
                </div>
            </div>
        </div>
    </div>

    <!-- Enhanced Product List -->
    <div class="card fade-in" style="animation-delay: 0.3s">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5><i class="fas fa-shopping-bag me-2"></i>Sản phẩm trong đơn hàng</h5>
            <span class="badge bg-primary">
                ${totalItems} sản phẩm
            </span>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                <thead>
                <tr>
                        <th style="width: 80px;">Ảnh</th>
                    <th>Tên sản phẩm</th>
                        <th style="width: 120px;">Số lượng</th>
                        <th style="width: 150px;">Đơn giá</th>
                        <th style="width: 150px;">Thành tiền</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${orderItems}" varStatus="status">
                        <tr>
                            <td>
                                <img src="${item.plant.imageUrl}" alt="${item.plant.name}" 
                                     class="product-image" width="60" height="60"/>
                            </td>
                            <td>
                                <div>
                                    <strong>${item.plant.name}</strong>
                                    <br>
                                    <small class="text-muted">
                                        <i class="fas fa-tag me-1"></i>Mã: SP${item.plant.id}
                                    </small>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <span class="badge bg-light text-dark border px-3 py-2">
                                        <i class="fas fa-times me-1"></i>${item.quantity}
                                    </span>
                                </div>
                            </td>
                            <td>
                                <strong class="text-primary">
                                    <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol=""/> VNĐ
                                </strong>
                            </td>
                            <td>
                                <strong class="text-success">
                                    <fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol=""/> VNĐ
                                </strong>
                            </td>
                    </tr>
                </c:forEach>
                </tbody>
                    <tfoot>
                        <tr class="table-active">
                            <td colspan="4" class="text-end fw-bold fs-5">
                                <i class="fas fa-calculator me-2"></i>Tổng cộng:
                            </td>
                            <td>
                                <strong class="text-success fs-4">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol=""/> VNĐ
                                </strong>
                            </td>
                        </tr>
                    </tfoot>
            </table>
            </div>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="mt-4 d-flex justify-content-between align-items-center">
        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary btn-lg">
        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
    </a>
        <div class="d-flex gap-2">
            <button class="btn btn-outline-primary" onclick="exportOrder()">
                <i class="fas fa-download me-2"></i>Xuất Excel
            </button>
            <button class="btn btn-primary" onclick="window.print()">
                <i class="fas fa-print me-2"></i>In đơn hàng
            </button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Enhanced Order Detail JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Add fade-in animations
    document.querySelectorAll('.fade-in').forEach((element, index) => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            element.style.transition = 'all 0.6s ease-out';
            element.style.opacity = '1';
            element.style.transform = 'translateY(0)';
        }, index * 100);
    });
    
    // Status update form enhancement
    const statusForm = document.getElementById('statusUpdateForm');
    if (statusForm) {
        statusForm.addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            
            // Show loading state
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang cập nhật...';
            submitBtn.disabled = true;
            
            // Show confirmation
            const selectedStatus = this.querySelector('select[name="status"]').value;
            const statusNames = {
                'pending': 'Chờ xử lý',
                'processing': 'Đang xử lý', 
                'shipped': 'Đã giao',
                'cancelled': 'Đã hủy'
            };
            
            if (!confirm(`Bạn có chắc muốn cập nhật trạng thái đơn hàng thành "${statusNames[selectedStatus]}"?`)) {
                e.preventDefault();
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
                return false;
            }
        });
    }
    
    // Product image hover effects
    document.querySelectorAll('.product-image').forEach(img => {
        img.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.1)';
        });
        
        img.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
        });
    });
    
    // Timeline animation based on order status
    const currentStatus = '${order.status}';
    animateTimeline(currentStatus);
});

function animateTimeline(status) {
    const timelineItems = document.querySelectorAll('.timeline-item');
    const statusOrder = ['created', 'pending', 'processing', 'shipped'];
    const currentIndex = statusOrder.indexOf(status);
    
    timelineItems.forEach((item, index) => {
        setTimeout(() => {
            if (index <= currentIndex) {
                item.style.opacity = '1';
                item.style.transform = 'translateX(0)';
            }
        }, index * 200);
    });
}

function exportOrder() {
    // Add export functionality
    alert('Tính năng xuất Excel đang được phát triển...');
}

// Print specific styling
window.addEventListener('beforeprint', function() {
    document.body.classList.add('printing');
});

window.addEventListener('afterprint', function() {
    document.body.classList.remove('printing');
});
</script>

<style>
@media print {
    .sidebar, .btn, .card-header .badge, .no-print {
        display: none !important;
    }
    
    .main-content {
        margin: 0 !important;
        padding: 0 !important;
    }
    
    .card {
        border: 1px solid #dee2e6 !important;
        box-shadow: none !important;
    }
    
    .page-header {
        background: white !important;
        padding: 1rem !important;
    }
}
</style>
</body>
</html>
