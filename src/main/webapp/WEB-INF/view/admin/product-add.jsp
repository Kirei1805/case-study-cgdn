<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Thêm sản phẩm mới</h4>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/products" method="post">
                <input type="hidden" name="action" value="add"/>

                <div class="row">
                    <!-- Cột trái -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Loại cây</label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">-- Chọn loại cây --</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Giá (VNĐ)</label>
                            <input type="number" name="price" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Số lượng</label>
                            <input type="number" name="stock" class="form-control" required>
                        </div>
                    </div>

                    <!-- Cột phải -->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Hình ảnh (URL)</label>
                            <input type="text" name="imageUrl" class="form-control">
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description" class="form-control" rows="5"></textarea>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Trạng thái</label>
                            <select name="isActive" class="form-select">
                                <option value="true">Đang bán</option>
                                <option value="false">Ngừng bán</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Quay lại</a>
                    <button type="submit" class="btn btn-success">Lưu sản phẩm</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

