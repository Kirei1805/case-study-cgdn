<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .order-row {
            transition: background-color 0.3s ease;
        }
        .order-row:hover {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-home me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/plants">
                            <i class="fas fa-leaf me-1"></i>Quản lý cây trồng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/orders">
                            <i class="fas fa-shopping-cart me-1"></i>Quản lý đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users me-1"></i>Quản lý người dùng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/statistics">
                            <i class="fas fa-chart-bar me-1"></i>Thống kê
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/plants">
                            <i class="fas fa-store me-1"></i>Xem cửa hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-1"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>
                        <i class="fas fa-shopping-cart me-2"></i>Quản lý đơn hàng
                    </h2>
                </div>
                
                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="mb-0">${totalOrders}</h4>
                                        <p class="mb-0">Tổng đơn hàng</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-shopping-cart fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-warning text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="mb-0">${pendingOrders}</h4>
                                        <p class="mb-0">Chờ xử lý</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-clock fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-info text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="mb-0">0</h4>
                                        <p class="mb-0">Đang xử lý</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-cogs fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-success text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h4 class="mb-0">0</h4>
                                        <p class="mb-0">Đã giao</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-check-circle fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Orders Table -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-list me-2"></i>Danh sách đơn hàng
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="text-center py-5">
                                    <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                                    <h4 class="text-muted">Chưa có đơn hàng nào</h4>
                                    <p class="text-muted">Khi có đơn hàng mới, chúng sẽ xuất hiện ở đây</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Mã đơn hàng</th>
                                                <th>Khách hàng</th>
                                                <th>Ngày đặt</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders}">
                                                <tr class="order-row">
                                                    <td>
                                                        <strong>#${order.id}</strong>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <strong>${order.user.fullName}</strong><br>
                                                            <small class="text-muted">${order.user.username}</small>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                    <td>
                                                        <strong class="text-success">
                                                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                                                        </strong>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-${order.statusBadgeClass}">
                                                            ${order.statusDisplay}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="${pageContext.request.contextPath}/admin/orders/detail/${order.id}" 
                                                               class="btn btn-sm btn-outline-primary">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <button type="button" class="btn btn-sm btn-outline-success" 
                                                                    data-bs-toggle="modal" data-bs-target="#updateStatusModal" 
                                                                    data-order-id="${order.id}" data-order-status="${order.status}">
                                                                <i class="fas fa-edit"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Status Modal -->
    <div class="modal fade" id="updateStatusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Cập nhật trạng thái đơn hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/orders/update-status/" method="post">
                    <div class="modal-body">
                        <input type="hidden" id="orderId" name="orderId">
                        <div class="mb-3">
                            <label for="status" class="form-label">Trạng thái mới:</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="pending">Chờ xử lý</option>
                                <option value="processing">Đang xử lý</option>
                                <option value="shipped">Đã giao hàng</option>
                                <option value="cancelled">Đã hủy</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Update modal with order data
        document.getElementById('updateStatusModal').addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var orderId = button.getAttribute('data-order-id');
            var orderStatus = button.getAttribute('data-order-status');
            
            var modal = this;
            modal.querySelector('#orderId').value = orderId;
            modal.querySelector('#status').value = orderStatus;
            
            // Update form action
            var form = modal.querySelector('form');
            form.action = '${pageContext.request.contextPath}/admin/orders/update-status/' + orderId;
        });
    </script>
</body>
</html> 