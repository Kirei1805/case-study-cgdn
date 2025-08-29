<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .product-card { border:none; border-radius:15px; box-shadow:0 4px 6px rgba(0,0,0,0.1); transition:0.3s; }
        .product-card:hover { transform: translateY(-5px); }
        .product-image { height:200px; object-fit:cover; border-radius:10px; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Quản lý sản phẩm</h1>
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addProductModal">
            <i class="fas fa-plus me-2"></i>Thêm sản phẩm mới
        </button>
    </div>

    <!-- Form tìm kiếm -->
    <form action="${pageContext.request.contextPath}/admin/products" method="get" class="row mb-4">
        <input type="hidden" name="action" value="search"/>
        <div class="col-md-6">
            <input type="text" name="keyword" class="form-control" placeholder="Nhập tên sản phẩm..."
                   value="${param.keyword != null ? param.keyword : ''}">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        </div>
    </form>

    <!-- Danh sách sản phẩm -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <c:forEach var="p" items="${products}">
            <div class="col">
                <div class="card product-card h-100">
                    <img src="${p.imageUrl}" class="card-img-top product-image" alt="${p.name}">
                    <div class="card-body">
                        <h6 class="card-title">${p.name}</h6>
                        <p class="card-text text-muted small">
                            <c:forEach var="c" items="${categories}">
                                <c:if test="${c.id == p.categoryId}">${c.name}</c:if>
                            </c:forEach>
                        </p>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-success fw-bold">${p.price} VNĐ</span>
                            <span class="badge ${p.active ? 'bg-success':'bg-secondary'}">
                                    ${p.active ? 'Đang bán':'Ngừng bán'}
                            </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <small class="text-muted">Còn: ${p.stock}</small>
                            <div class="btn-group btn-group-sm">
                                <!-- Edit -->
                                <button type="button" class="btn btn-outline-primary"
                                        data-bs-toggle="modal" data-bs-target="#editProductModal${p.id}">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <!-- Delete -->
                                <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.id}"
                                   class="btn btn-outline-danger"
                                   onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Edit -->
            <div class="modal fade" id="editProductModal${p.id}" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/admin/products" method="post">
                            <input type="hidden" name="action" value="edit"/>
                            <input type="hidden" name="id" value="${p.id}"/>
                            <div class="modal-header">
                                <h5 class="modal-title">Sửa sản phẩm</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Tên sản phẩm</label>
                                            <input type="text" name="name" value="${p.name}" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Loại cây</label>
                                            <select name="categoryId" class="form-select" required>
                                                <c:forEach var="c" items="${categories}">
                                                    <option value="${c.id}" ${c.id==p.categoryId ? 'selected':''}>
                                                            ${c.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Giá (VNĐ)</label>
                                            <input type="number" name="price" value="${p.price}" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Số lượng</label>
                                            <input type="number" name="stock" value="${p.stock}" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Hình ảnh (URL)</label>
                                            <input type="text" name="imageUrl" value="${p.imageUrl}" class="form-control">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mô tả</label>
                                            <textarea name="description" class="form-control" rows="4">${p.description}</textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Trạng thái</label>
                                            <select name="isActive" class="form-select">
                                                <option value="true" ${p.active ? 'selected':''}>Đang bán</option>
                                                <option value="false" ${!p.active ? 'selected':''}>Ngừng bán</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- Modal Add -->
<div class="modal fade" id="addProductModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/products" method="post">
                <input type="hidden" name="action" value="add"/>
                <div class="modal-header">
                    <h5 class="modal-title">Thêm sản phẩm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3"><label class="form-label">Tên sản phẩm</label>
                                <input type="text" name="name" class="form-control" required></div>
                            <div class="mb-3"><label class="form-label">Loại cây</label>
                                <select name="categoryId" class="form-select" required>
                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.id}">${c.name}</option>
                                    </c:forEach>
                                </select></div>
                            <div class="mb-3"><label class="form-label">Giá (VNĐ)</label>
                                <input type="number" name="price" class="form-control" required></div>
                            <div class="mb-3"><label class="form-label">Số lượng</label>
                                <input type="number" name="stock" class="form-control" required></div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3"><label class="form-label">Hình ảnh (URL)</label>
                                <input type="text" name="imageUrl" class="form-control"></div>
                            <div class="mb-3"><label class="form-label">Mô tả</label>
                                <textarea name="description" class="form-control" rows="4"></textarea></div>
                            <div class="mb-3"><label class="form-label">Trạng thái</label>
                                <select name="isActive" class="form-select">
                                    <option value="true">Đang bán</option>
                                    <option value="false">Ngừng bán</option>
                                </select></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">Thêm sản phẩm</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
