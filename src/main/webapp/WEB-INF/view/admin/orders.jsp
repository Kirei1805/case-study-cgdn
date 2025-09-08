<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng - Plant Shop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-compact.css">
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

        .sidebar .nav-link:hover, .sidebar .nav-link.active { 
            color: #fff; 
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(4px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        .sidebar h5 {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 1.4rem;
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

        .btn-outline-primary {
            border: 2px solid var(--admin-primary);
            color: var(--admin-primary);
        }

        .btn-outline-primary:hover {
            background: var(--admin-primary);
            color: white;
            transform: translateY(-1px);
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

        /* Status Cards */
        .stat-card {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .border-warning { border-color: #ffc107 !important; }
        .border-info { border-color: #17a2b8 !important; }
        .border-success { border-color: #28a745 !important; }
        .border-danger { border-color: #dc3545 !important; }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }
            
            .page-header h1 {
                font-size: 1.5rem;
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
                    <h1>Quản lý đơn hàng</h1>
                    <p class="text-muted mb-0">Theo dõi và xử lý tất cả đơn hàng từ khách hàng</p>
                </div>
                <div class="btn-group">
                    <button type="button" class="btn btn-outline-primary" onclick="refreshOrders()">
                        <i class="fas fa-sync me-1"></i>Làm mới
                    </button>
                    <button type="button" class="btn btn-outline-secondary">
                        <i class="fas fa-download me-1"></i>Xuất Excel
                    </button>
                </div>
            </div>

            <!-- Order Statistics -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card border-warning">
                        <div class="card-body text-center">
                            <h5 class="card-title text-warning">Chờ xử lý</h5>
                            <h3 class="card-text">${pendingCount}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-info">
                        <div class="card-body text-center">
                            <h5 class="card-title text-info">Đang xử lý</h5>
                            <h3 class="card-text">${processingCount}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-success">
                        <div class="card-body text-center">
                            <h5 class="card-title text-success">Đã giao</h5>
                            <h3 class="card-text">${shippedCount}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-danger">
                        <div class="card-body text-center">
                            <h5 class="card-title text-danger">Đã hủy</h5>
                            <h3 class="card-text">${cancelledCount}</h3>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-filter me-2"></i>Lọc đơn hàng</h5>
                </div>
                <div class="card-body">
                    <form method="GET" action="${pageContext.request.contextPath}/admin/orders">
                        <div class="row">
                            <div class="col-md-3">
                                <label class="form-label">Trạng thái</label>
                                <select name="status" class="form-select">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="processing" ${param.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                    <option value="shipped" ${param.status == 'shipped' ? 'selected' : ''}>Đã giao</option>
                                    <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Từ ngày</label>
                                <input type="date" name="fromDate" class="form-control" value="${param.fromDate}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Đến ngày</label>
                                <input type="date" name="toDate" class="form-control" value="${param.toDate}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">&nbsp;</label>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-search me-1"></i>Lọc
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
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
                        <select class="form-select form-select-sm" onchange="updateOrderStatus(${o.id}, this.value)" 
                                style="width: auto; display: inline-block;">
                            <option value="pending" ${o.status == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
                            <option value="processing" ${o.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                            <option value="shipped" ${o.status == 'shipped' ? 'selected' : ''}>Đã giao</option>
                            <option value="cancelled" ${o.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                        </select>
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
    
    <!-- Pagination -->
    <c:if test="${not empty pagination}">
        <jsp:include page="../common/pagination.jsp"/>
    </c:if>
    
        </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Update order status
function updateOrderStatus(orderId, newStatus) {
    if (confirm('Bạn có chắc muốn cập nhật trạng thái đơn hàng #' + orderId + '?')) {
        // Create form and submit
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/admin/orders';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'updateStatus';
        
        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'orderId';
        idInput.value = orderId;
        
        const statusInput = document.createElement('input');
        statusInput.type = 'hidden';
        statusInput.name = 'status';
        statusInput.value = newStatus;
        
        form.appendChild(actionInput);
        form.appendChild(idInput);
        form.appendChild(statusInput);
        
        document.body.appendChild(form);
        form.submit();
    } else {
        // Reset select to original value
        location.reload();
    }
}



// Refresh orders
function refreshOrders() {
    location.reload();
}

// Auto-refresh every 30 seconds
setInterval(function() {
    // Only refresh if no modals are open
    if (!document.querySelector('.modal.show')) {
        const lastRefresh = localStorage.getItem('lastOrderRefresh');
        const now = Date.now();
        if (!lastRefresh || now - lastRefresh > 30000) {
            localStorage.setItem('lastOrderRefresh', now);
            // Add subtle indicator that data is refreshing
            const refreshBtn = document.querySelector('[onclick="refreshOrders()"]');
            if (refreshBtn) {
                refreshBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Đang làm mới...';
                setTimeout(() => {
                    refreshBtn.innerHTML = '<i class="fas fa-sync me-1"></i>Làm mới';
                }, 1000);
            }
        }
    }
}, 30000);
</script>
</body>
</html>
