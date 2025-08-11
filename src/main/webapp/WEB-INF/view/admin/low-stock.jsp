<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm sắp hết hàng - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Admin Navigation -->
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/plants">
                            <i class="fas fa-leaf me-1"></i>Quản lý cây trồng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users me-1"></i>Quản lý người dùng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                            <i class="fas fa-shopping-cart me-1"></i>Quản lý đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/statistics">
                            <i class="fas fa-chart-bar me-1"></i>Thống kê
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user me-1"></i>${sessionScope.user.username}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/plants">
                                <i class="fas fa-home me-2"></i>Về trang chủ
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                            </a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid py-4">
        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <h1 class="h3 mb-0">
                    <i class="fas fa-exclamation-triangle me-2"></i>Sản phẩm sắp hết hàng
                </h1>
                <p class="text-muted">Cảnh báo sản phẩm có tồn kho thấp (≤ 10 sản phẩm)</p>
            </div>
        </div>

        <!-- Filters -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <form method="get" class="row g-3">
                            <div class="col-md-3">
                                <label for="limit" class="form-label">Số lượng hiển thị</label>
                                <select name="limit" id="limit" class="form-select">
                                    <option value="10" ${limit == 10 ? 'selected' : ''}>10 sản phẩm</option>
                                    <option value="20" ${limit == 20 ? 'selected' : ''}>20 sản phẩm</option>
                                    <option value="50" ${limit == 50 ? 'selected' : ''}>50 sản phẩm</option>
                                    <option value="100" ${limit == 100 ? 'selected' : ''}>100 sản phẩm</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">&nbsp;</label>
                                <div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-filter me-1"></i>Lọc
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/statistics/low-stock" class="btn btn-secondary">
                                        <i class="fas fa-times me-1"></i>Xóa bộ lọc
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Low Stock Table -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-exclamation-triangle me-2"></i>Top ${limit} sản phẩm sắp hết hàng
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty lowStock}">
                                <div class="text-center py-5">
                                    <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                                    <h4 class="text-success">Tuyệt vời!</h4>
                                    <p class="text-muted">Không có sản phẩm nào sắp hết hàng</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>#</th>
                                                <th>Sản phẩm</th>
                                                <th>Danh mục</th>
                                                <th>Giá</th>
                                                <th>Tồn kho</th>
                                                <th>Trạng thái</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${lowStock}" varStatus="status">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-danger">${status.index + 1}</span>
                                                    </td>
                                                    <td>
                                                        <strong>${product.name}</strong>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-secondary">${product.categoryName}</span>
                                                    </td>
                                                    <td>
                                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${product.stock == 0}">
                                                                <span class="badge bg-danger">Hết hàng</span>
                                                            </c:when>
                                                            <c:when test="${product.stock <= 5}">
                                                                <span class="badge bg-danger">${product.stock}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-warning">${product.stock}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${product.stock == 0}">
                                                                <span class="badge bg-danger">Cần nhập hàng ngay</span>
                                                            </c:when>
                                                            <c:when test="${product.stock <= 5}">
                                                                <span class="badge bg-warning">Cần nhập hàng sớm</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-info">Theo dõi</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/admin/plants/edit?id=${product.id}" 
                                                           class="btn btn-sm btn-primary">
                                                            <i class="fas fa-edit me-1"></i>Cập nhật
                                                        </a>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 