<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
            border-radius: 8px;
            margin: 2px 0;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: white;
            background: rgba(255, 255, 255, 0.1);
        }
        .main-content {
            background-color: #f8f9fa;
        }
        .product-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-image {
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                <i class="fas fa-tachometer-alt me-2"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="fas fa-shopping-cart me-2"></i>
                                Quản lý đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/products">
                                <i class="fas fa-seedling me-2"></i>
                                Quản lý sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/reports">
                                <i class="fas fa-chart-bar me-2"></i>
                                Báo cáo
                            </a>
                        </li>
                        
                        <li class="nav-item mt-4">
                            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>
                                Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 main-content">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Quản lý sản phẩm</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addProductModal">
                            <i class="fas fa-plus me-2"></i>Thêm sản phẩm mới
                        </button>
                    </div>
                </div>

                <!-- Search and Filter -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Tìm kiếm sản phẩm theo tên..." id="searchProduct">
                            <button class="btn btn-outline-secondary" type="button">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="categoryFilter">
                            <option value="">Tất cả loại</option>
                            <option value="1">Cây văn phòng</option>
                            <option value="2">Cây thủy sinh</option>
                            <option value="3">Cây bonsai</option>
                            <option value="4">Sen đá - Xương rồng</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" id="statusFilter">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active">Đang bán</option>
                            <option value="inactive">Ngừng bán</option>
                        </select>
                    </div>
                </div>

                <!-- Products Grid -->
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-4">
                    <!-- Sample Product Cards -->
                    <div class="col">
                        <div class="card product-card h-100">
                            <img src="https://via.placeholder.com/300x200?text=Cây+Kim+Tiền" class="card-img-top product-image" alt="Cây Kim Tiền">
                            <div class="card-body">
                                <h6 class="card-title">Cây Kim Tiền</h6>
                                <p class="card-text text-muted small">Cây văn phòng</p>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-success fw-bold">150,000 VNĐ</span>
                                    <span class="badge bg-success">Đang bán</span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">Còn: 20</small>
                                    <div class="btn-group btn-group-sm">
                                        <button class="btn btn-outline-primary" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-outline-danger" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="card product-card h-100">
                            <img src="https://via.placeholder.com/300x200?text=Cây+Lưỡi+Hổ" class="card-img-top product-image" alt="Cây Lưỡi Hổ">
                            <div class="card-body">
                                <h6 class="card-title">Cây Lưỡi Hổ</h6>
                                <p class="card-text text-muted small">Cây văn phòng</p>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-success fw-bold">100,000 VNĐ</span>
                                    <span class="badge bg-success">Đang bán</span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">Còn: 30</small>
                                    <div class="btn-group btn-group-sm">
                                        <button class="btn btn-outline-primary" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-outline-danger" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="card product-card h-100">
                            <img src="https://via.placeholder.com/300x200?text=Sen+Đá+Nâu" class="card-img-top product-image" alt="Sen Đá Nâu">
                            <div class="card-body">
                                <h6 class="card-title">Sen Đá Nâu</h6>
                                <p class="card-text text-muted small">Sen đá - Xương rồng</p>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-success fw-bold">50,000 VNĐ</span>
                                    <span class="badge bg-warning">Hết hàng</span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">Còn: 0</small>
                                    <div class="btn-group btn-group-sm">
                                        <button class="btn btn-outline-primary" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-outline-danger" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="card product-card h-100">
                            <img src="https://via.placeholder.com/300x200?text=Bonsai+Tùng+La+Hán" class="card-img-top product-image" alt="Bonsai Tùng La Hán">
                            <div class="card-body">
                                <h6 class="card-title">Bonsai Tùng La Hán</h6>
                                <p class="card-text text-muted small">Cây bonsai</p>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-success fw-bold">350,000 VNĐ</span>
                                    <span class="badge bg-success">Đang bán</span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">Còn: 10</small>
                                    <div class="btn-group btn-group-sm">
                                        <button class="btn btn-outline-primary" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-outline-danger" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <nav aria-label="Product pagination" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Trước</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Sau</a>
                        </li>
                    </ul>
                </nav>
            </main>
        </div>
    </div>

    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm sản phẩm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Tên sản phẩm</label>
                                    <input type="text" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Loại cây</label>
                                    <select class="form-select" required>
                                        <option value="">Chọn loại</option>
                                        <option value="1">Cây văn phòng</option>
                                        <option value="2">Cây thủy sinh</option>
                                        <option value="3">Cây bonsai</option>
                                        <option value="4">Sen đá - Xương rồng</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Giá (VNĐ)</label>
                                    <input type="number" class="form-control" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số lượng</label>
                                    <input type="number" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Hình ảnh</label>
                                    <input type="file" class="form-control" accept="image/*">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Mô tả</label>
                                    <textarea class="form-control" rows="4"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Trạng thái</label>
                                    <select class="form-select">
                                        <option value="active">Đang bán</option>
                                        <option value="inactive">Ngừng bán</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-success">Thêm sản phẩm</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
