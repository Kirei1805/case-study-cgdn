<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - Admin Panel</title>
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
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(45deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        .status-badge {
            font-size: 0.75rem;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.05);
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
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
                        <i class="fas fa-users me-2"></i>Quản lý người dùng
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <div class="btn-group me-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-download me-1"></i>Xuất danh sách
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Search and Filter -->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <form action="${pageContext.request.contextPath}/admin/users" method="get" class="d-flex">
                            <input type="text" class="form-control me-2" name="search" 
                                   placeholder="Tìm kiếm theo tên, email..." value="${param.search}">
                            <button type="submit" class="btn btn-outline-primary">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex justify-content-end">
                            <select class="form-select me-2" style="width: auto;" onchange="this.form.submit()">
                                <option value="">Tất cả vai trò</option>
                                <option value="admin" ${param.role == 'admin' ? 'selected' : ''}>Admin</option>
                                <option value="customer" ${param.role == 'customer' ? 'selected' : ''}>Khách hàng</option>
                            </select>
                            <select class="form-select" style="width: auto;" onchange="this.form.submit()">
                                <option value="10" ${param.size == '10' ? 'selected' : ''}>10/trang</option>
                                <option value="25" ${param.size == '25' ? 'selected' : ''}>25/trang</option>
                                <option value="50" ${param.size == '50' ? 'selected' : ''}>50/trang</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Message -->
                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                        <i class="fas fa-${messageType == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Users Table -->
                <div class="card shadow">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Người dùng</th>
                                        <th>Email</th>
                                        <th>Số điện thoại</th>
                                        <th>Địa chỉ</th>
                                        <th>Vai trò</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty users}">
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td>${user.id}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="user-avatar me-2">
                                                                ${user.fullName.charAt(0)}
                                                            </div>
                                                            <div>
                                                                <div class="fw-bold">${user.fullName}</div>
                                                                <small class="text-muted">@${user.username}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>${user.email}</td>
                                                    <td>${user.phone}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty user.address}">
                                                                <span title="${user.address}">
                                                                    ${user.address.length() > 30 ? user.address.substring(0, 30) + '...' : user.address}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa cập nhật</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.role == 'admin'}">
                                                                <span class="badge bg-danger status-badge">
                                                                    <i class="fas fa-crown me-1"></i>Admin
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success status-badge">
                                                                    <i class="fas fa-user me-1"></i>Khách hàng
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">
                                                            ${user.createdAt}
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                    title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </button>
                                                            <c:if test="${user.role != 'admin' || user.id != sessionScope.user.id}">
                                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                        onclick="confirmDelete(${user.id}, '${user.fullName}')"
                                                                        title="Xóa người dùng">
                                                                    <i class="fas fa-trash"></i>
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center py-4">
                                                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                                    <p class="text-muted">Không tìm thấy người dùng nào</p>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="User pagination">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}&search=${param.search}&role=${param.role}&size=${param.size}">
                                            <i class="fas fa-chevron-left"></i>
                                        </a>
                                    </li>
                                    
                                    <c:forEach var="i" begin="1" end="${totalPages}">
                                        <c:choose>
                                            <c:when test="${i == currentPage}">
                                                <li class="page-item active">
                                                    <span class="page-link">${i}</span>
                                                </li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="page-item">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${i}&search=${param.search}&role=${param.role}&size=${param.size}">
                                                        ${i}
                                                    </a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}&search=${param.search}&role=${param.role}&size=${param.size}">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>

                <!-- Statistics -->
                <div class="row mt-4">
                    <div class="col-md-3">
                        <div class="card bg-primary text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Tổng người dùng</h5>
                                        <h3>${totalUsers}</h3>
                                    </div>
                                    <div>
                                        <i class="fas fa-users fa-2x"></i>
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
                                        <h5 class="card-title">Khách hàng</h5>
                                        <h3>${customerCount}</h3>
                                    </div>
                                    <div>
                                        <i class="fas fa-user fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card bg-danger text-white">
                            <div class="card-body">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h5 class="card-title">Admin</h5>
                                        <h3>${adminCount}</h3>
                                    </div>
                                    <div>
                                        <i class="fas fa-crown fa-2x"></i>
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
                                        <h5 class="card-title">Mới hôm nay</h5>
                                        <h3>${newUsersToday}</h3>
                                    </div>
                                    <div>
                                        <i class="fas fa-user-plus fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-warning me-2"></i>Xác nhận xóa
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa người dùng <strong id="userName"></strong>?</p>
                    <p class="text-muted">Hành động này không thể hoàn tác.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Hủy
                    </button>
                    <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" id="userId">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-2"></i>Xóa
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(userId, userName) {
            document.getElementById('userId').value = userId;
            document.getElementById('userName').textContent = userName;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html> 