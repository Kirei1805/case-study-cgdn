<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm cây trồng mới - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: #2c3e50;
        }
        .sidebar .nav-link {
            color: #ecf0f1;
            padding: 12px 20px;
            border-radius: 5px;
            margin: 2px 0;
        }
        .sidebar .nav-link:hover {
            background: #34495e;
            color: #fff;
        }
        .sidebar .nav-link.active {
            background: #3498db;
            color: #fff;
        }
        .main-content {
            background: #f8f9fa;
            min-height: 100vh;
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
                        <i class="fas fa-seedling fa-2x text-success"></i>
                        <h5 class="text-white mt-2">Admin Panel</h5>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/plants">
                                <i class="fas fa-leaf me-2"></i>Quản lý cây trồng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users me-2"></i>Quản lý người dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/plants">
                                <i class="fas fa-home me-2"></i>Xem trang chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">
                        <i class="fas fa-plus me-2"></i>Thêm cây trồng mới
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/plants" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại
                        </a>
                    </div>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/plants" method="post">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">
                                            <i class="fas fa-leaf me-2"></i>Tên cây trồng <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">
                                            <i class="fas fa-tags me-2"></i>Danh mục <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="categoryId" name="categoryId" required>
                                            <option value="">Chọn danh mục</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.id}">${category.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="price" class="form-label">
                                            <i class="fas fa-money-bill me-2"></i>Giá (VNĐ) <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="price" name="price" 
                                               min="0" step="1000" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="stock" class="form-label">
                                            <i class="fas fa-boxes me-2"></i>Số lượng tồn kho <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="stock" name="stock" 
                                               min="0" required>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="imageUrl" class="form-label">
                                    <i class="fas fa-image me-2"></i>URL hình ảnh
                                </label>
                                <input type="url" class="form-control" id="imageUrl" name="imageUrl" 
                                       placeholder="https://example.com/image.jpg">
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left me-2"></i>Mô tả
                                </label>
                                <textarea class="form-control" id="description" name="description" 
                                          rows="4" placeholder="Mô tả chi tiết về cây trồng..."></textarea>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/plants" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Hủy
                                </a>
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save me-2"></i>Lưu cây trồng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 