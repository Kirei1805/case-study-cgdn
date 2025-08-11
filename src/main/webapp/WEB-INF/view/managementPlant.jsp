<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý cây trồng - Admin</title>
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
        .plant-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
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
                        <i class="fas fa-leaf me-2"></i>Quản lý cây trồng
                    </h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/plants?action=add" 
                           class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Thêm cây trồng mới
                        </a>
                    </div>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${param.success == 'add'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>Thêm cây trồng thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.success == 'edit'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>Cập nhật cây trồng thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.success == 'delete'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>Xóa cây trồng thành công!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${param.error == 'delete'}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>Có lỗi xảy ra khi xóa cây trồng!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Plants Table -->
                <div class="card">
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>Hình ảnh</th>
                                        <th>Tên cây trồng</th>
                                        <th>Danh mục</th>
                                        <th>Giá</th>
                                        <th>Tồn kho</th>
                                        <th>Đánh giá</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="plant" items="${plants}">
                                        <tr>
                                            <td>
                                                <img src="${plant.imageUrl}" alt="${plant.name}" 
                                                     class="plant-image" 
                                                     onerror="this.src='https://via.placeholder.com/60x60?text=Cây+trồng'">
                                            </td>
                                            <td>
                                                <strong>${plant.name}</strong>
                                                <br>
                                                <small class="text-muted">${plant.description}</small>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${plant.categoryName}</span>
                                            </td>
                                            <td>
                                                <span class="text-success fw-bold">${plant.formattedPrice}</span>
                                            </td>
                                            <td>
                                                <span class="badge bg-${plant.stock > 0 ? 'success' : 'danger'}">
                                                    ${plant.stock}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="text-warning">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star${i <= plant.ratingAvg ? '' : '-o'}"></i>
                                                    </c:forEach>
                                                </div>
                                                <small class="text-muted">(${plant.ratingAvg})</small>
                                            </td>
                                            <td>
                                                <span class="badge bg-${plant.active ? 'success' : 'secondary'}">
                                                    ${plant.active ? 'Hoạt động' : 'Không hoạt động'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="${pageContext.request.contextPath}/admin/plants/edit/${plant.id}" 
                                                       class="btn btn-sm btn-outline-primary" title="Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="confirmDelete(${plant.id}, '${plant.name}')" title="Xóa">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa cây trồng "<span id="plantName"></span>"?</p>
                    <p class="text-danger"><small>Hành động này không thể hoàn tác!</small></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form action="${pageContext.request.contextPath}/admin/plants" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" id="plantId">
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(plantId, plantName) {
            document.getElementById('plantId').value = plantId;
            document.getElementById('plantName').textContent = plantName;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
    </script>
</body>
</html> 