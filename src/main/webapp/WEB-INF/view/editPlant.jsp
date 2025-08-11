<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa cây trồng - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa cây trồng
                        </h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty message}">
                            <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                                <i class="fas fa-${messageType == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/admin/plants" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="plantId" value="${plant.id}">
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="name" class="form-label">
                                            <i class="fas fa-leaf me-1"></i>Tên cây trồng <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="${plant.name}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">
                                            <i class="fas fa-tags me-1"></i>Danh mục <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select" id="categoryId" name="categoryId" required>
                                            <option value="">Chọn danh mục</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category.id}" ${plant.categoryId == category.id ? 'selected' : ''}>
                                                    ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="price" class="form-label">
                                            <i class="fas fa-dollar-sign me-1"></i>Giá (VNĐ) <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="price" name="price" 
                                               value="${plant.price}" min="0" step="1000" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="stock" class="form-label">
                                            <i class="fas fa-boxes me-1"></i>Số lượng tồn kho <span class="text-danger">*</span>
                                        </label>
                                        <input type="number" class="form-control" id="stock" name="stock" 
                                               value="${plant.stock}" min="0" required>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="imageUrl" class="form-label">
                                    <i class="fas fa-image me-1"></i>URL hình ảnh <span class="text-danger">*</span>
                                </label>
                                <input type="url" class="form-control" id="imageUrl" name="imageUrl" 
                                       value="${plant.imageUrl}" required>
                                <div class="form-text">Nhập URL hình ảnh từ internet</div>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left me-1"></i>Mô tả
                                </label>
                                <textarea class="form-control" id="description" name="description" 
                                          rows="4">${plant.description}</textarea>
                            </div>

                            <div class="d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/admin/plants" class="btn btn-secondary">
                                    <i class="fas fa-times me-2"></i>Hủy
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Cập nhật cây trồng
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 