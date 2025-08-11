<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .stats-card {
            transition: transform 0.3s ease;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .chart-container {
            position: relative;
            height: 300px;
        }
    </style>
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
                    <i class="fas fa-chart-bar me-2"></i>Thống kê tổng quan
                </h1>
                <p class="text-muted">Bảng điều khiển thống kê bán hàng và quản lý kho</p>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-primary shadow h-100 py-2 stats-card">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Tổng đơn hàng
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    ${salesStats.totalOrders}
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-success shadow h-100 py-2 stats-card">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                    Tổng doanh thu
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    <fmt:formatNumber value="${salesStats.totalRevenue}" type="currency" currencySymbol="₫"/>
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-info shadow h-100 py-2 stats-card">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                    Khách hàng
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    ${salesStats.totalCustomers}
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-users fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-warning shadow h-100 py-2 stats-card">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                    Sản phẩm đã bán
                                </div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800">
                                    ${salesStats.totalItemsSold}
                                </div>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-boxes fa-2x text-gray-300"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts Row -->
        <div class="row mb-4">
            <div class="col-xl-8 col-lg-7">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Thống kê theo danh mục</h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="categoryChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-4 col-lg-5">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-primary">Top sản phẩm bán chạy</h6>
                        <a href="${pageContext.request.contextPath}/admin/statistics/best-sellers" class="btn btn-sm btn-primary">
                            Xem tất cả
                        </a>
                    </div>
                    <div class="card-body">
                        <c:forEach var="product" items="${bestSellers}" varStatus="status">
                            <div class="d-flex align-items-center mb-3">
                                <div class="flex-shrink-0">
                                    <span class="badge bg-primary rounded-pill">${status.index + 1}</span>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="mb-0">${product.name}</h6>
                                    <small class="text-muted">
                                        ${product.totalQuantity} sản phẩm đã bán
                                    </small>
                                </div>
                                <div class="flex-shrink-0">
                                    <span class="text-success fw-bold">
                                        <fmt:formatNumber value="${product.totalRevenue}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tables Row -->
        <div class="row">
            <div class="col-lg-6">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-success">Sản phẩm đánh giá cao</h6>
                        <a href="${pageContext.request.contextPath}/admin/statistics/top-rated" class="btn btn-sm btn-success">
                            Xem tất cả
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Đánh giá</th>
                                        <th>Số đánh giá</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${topRated}">
                                        <tr>
                                            <td>${product.name}</td>
                                            <td>
                                                <span class="text-warning">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star${i <= product.ratingAvg ? '' : '-o'}"></i>
                                                    </c:forEach>
                                                </span>
                                                <span class="ms-1">(${product.ratingAvg})</span>
                                            </td>
                                            <td>${product.reviewCount}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                        <h6 class="m-0 font-weight-bold text-warning">Sản phẩm sắp hết hàng</h6>
                        <a href="${pageContext.request.contextPath}/admin/statistics/low-stock" class="btn btn-sm btn-warning">
                            Xem tất cả
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Tồn kho</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${lowStock}">
                                        <tr>
                                            <td>${product.name}</td>
                                            <td>${product.stock}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.stock == 0}">
                                                        <span class="badge bg-danger">Hết hàng</span>
                                                    </c:when>
                                                    <c:when test="${product.stock <= 5}">
                                                        <span class="badge bg-warning">Sắp hết</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-info">Thấp</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Chart.js configuration
        const ctx = document.getElementById('categoryChart').getContext('2d');
        
        const categoryData = [
            <c:forEach var="category" items="${categoryStats.categoryStats}">
            {
                label: '${category.categoryName}',
                data: ${category.totalRevenue},
                backgroundColor: getRandomColor(),
            },
            </c:forEach>
        ];

        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: categoryData.map(item => item.label),
                datasets: [{
                    data: categoryData.map(item => item.data),
                    backgroundColor: categoryData.map(item => item.backgroundColor),
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        function getRandomColor() {
            const letters = '0123456789ABCDEF';
            let color = '#';
            for (let i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }
    </script>
</body>
</html> 