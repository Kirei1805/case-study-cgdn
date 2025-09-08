<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${mode == 'edit' ? 'Chỉnh sửa' : 'Thêm mới'} sản phẩm - Plant Shop Admin</title>
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --admin-primary: #2d5a27;
            --admin-secondary: #4a7c59;
            --admin-accent: #7fb069;
            --admin-gradient: linear-gradient(135deg, #2d5a27 0%, #4a7c59 50%, #7fb069 100%);
            --shadow-md: 0 4px 8px rgba(0,0,0,0.12);
            --shadow-lg: 0 8px 16px rgba(0,0,0,0.15);
            --border-radius: 12px;
            --border-radius-lg: 16px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fffe 0%, #f0f9f3 100%);
            color: #2c3e50;
            line-height: 1.6;
            min-height: 100vh;
            padding: 2rem 0;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }

        .form-header {
            background: var(--admin-gradient);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .form-header h1 {
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .form-header p {
            opacity: 0.9;
            margin: 0;
        }

        .form-body {
            padding: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--admin-primary);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: var(--border-radius);
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--admin-accent);
            box-shadow: 0 0 0 0.2rem rgba(127, 176, 105, 0.25);
        }

        .form-text {
            color: #6c757d;
            font-size: 0.875rem;
        }

        .image-preview {
            max-width: 200px;
            max-height: 200px;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            margin-top: 1rem;
            display: none;
        }

        .form-check {
            margin-top: 0.5rem;
        }

        .form-check-input:checked {
            background-color: var(--admin-primary);
            border-color: var(--admin-primary);
        }

        .form-check-label {
            color: var(--admin-primary);
            font-weight: 500;
        }

        .btn {
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--admin-gradient);
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #244622 0%, #3d6b4a 50%, #6ba05a 100%);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: #6c757d;
            border: none;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            padding-top: 1rem;
            border-top: 1px solid #e9ecef;
            margin-top: 2rem;
        }

        .required {
            color: #dc3545;
        }

        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .form-body {
                padding: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        /* Animation */
        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container fade-in">
            <!-- Form Header -->
            <div class="form-header">
                <h1>
                    <i class="fas fa-${mode == 'edit' ? 'edit' : 'plus'} me-2"></i>
                    ${mode == 'edit' ? 'Chỉnh sửa sản phẩm' : 'Thêm sản phẩm mới'}
                </h1>
                <p>${mode == 'edit' ? 'Cập nhật thông tin sản phẩm' : 'Nhập thông tin sản phẩm mới'}</p>
            </div>

            <!-- Form Body -->
            <div class="form-body">
                <form method="POST" action="${pageContext.request.contextPath}/admin/products" id="productForm">
                    <input type="hidden" name="action" value="${mode}">
                    <c:if test="${mode == 'edit'}">
                        <input type="hidden" name="id" value="${plant.id}">
                    </c:if>

                    <div class="row">
                        <!-- Product Name -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    Tên sản phẩm <span class="required">*</span>
                                </label>
                                <input type="text" 
                                       name="name" 
                                       class="form-control" 
                                       placeholder="Nhập tên sản phẩm..."
                                       value="${plant.name}"
                                       required>
                                <div class="form-text">Tên sản phẩm sẽ hiển thị cho khách hàng</div>
                            </div>
                        </div>

                        <!-- Category -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    Loại cây <span class="required">*</span>
                                </label>
                                <select name="categoryId" class="form-select" required>
                                    <option value="">Chọn loại cây</option>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" 
                                                ${plant.categoryId == category.id ? 'selected' : ''}>
                                            ${category.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <!-- Price -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    Giá bán (VNĐ) <span class="required">*</span>
                                </label>
                                <input type="number" 
                                       name="price" 
                                       class="form-control" 
                                       placeholder="0"
                                       min="0"
                                       step="1000"
                                       value="${plant.price}"
                                       required>
                                <div class="form-text">Giá bán cho khách hàng</div>
                            </div>
                        </div>

                        <!-- Stock -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label">
                                    Số lượng tồn kho <span class="required">*</span>
                                </label>
                                <input type="number" 
                                       name="stock" 
                                       class="form-control" 
                                       placeholder="0"
                                       min="0"
                                       value="${plant.stock}"
                                       required>
                                <div class="form-text">Số lượng sản phẩm có sẵn</div>
                            </div>
                        </div>

                        <!-- Image URL -->
                        <div class="col-12">
                            <div class="form-group">
                                <label class="form-label">URL hình ảnh</label>
                                <input type="url" 
                                       name="imageUrl" 
                                       class="form-control" 
                                       placeholder="https://example.com/image.jpg"
                                       value="${plant.imageUrl}"
                                       id="imageUrl">
                                <div class="form-text">Đường dẫn đến hình ảnh sản phẩm</div>
                                <img id="imagePreview" class="image-preview" alt="Preview">
                            </div>
                        </div>

                        <!-- Description -->
                        <div class="col-12">
                            <div class="form-group">
                                <label class="form-label">Mô tả sản phẩm</label>
                                <textarea name="description" 
                                          class="form-control" 
                                          rows="4" 
                                          placeholder="Nhập mô tả chi tiết về sản phẩm...">${plant.description}</textarea>
                                <div class="form-text">Mô tả chi tiết sẽ giúp khách hàng hiểu rõ hơn về sản phẩm</div>
                            </div>
                        </div>

                        <!-- Active Status -->
                        <div class="col-12">
                            <div class="form-group">
                                <div class="form-check">
                                    <input type="checkbox" 
                                           name="active" 
                                           class="form-check-input" 
                                           id="activeCheck"
                                           value="true"
                                           ${plant.active || mode == 'add' ? 'checked' : ''}>
                                    <label class="form-check-label" for="activeCheck">
                                        Sản phẩm đang hoạt động
                                    </label>
                                    <div class="form-text">Sản phẩm sẽ hiển thị cho khách hàng khi được kích hoạt</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>
                            ${mode == 'edit' ? 'Cập nhật' : 'Thêm mới'}
                        </button>
                        
                        <a href="${pageContext.request.contextPath}/admin/products" 
                           class="btn btn-secondary">
                            <i class="fas fa-times me-2"></i>Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Image preview functionality
        document.getElementById('imageUrl').addEventListener('input', function() {
            const imageUrl = this.value;
            const preview = document.getElementById('imagePreview');
            
            if (imageUrl) {
                preview.src = imageUrl;
                preview.style.display = 'block';
                preview.onerror = function() {
                    this.style.display = 'none';
                };
            } else {
                preview.style.display = 'none';
            }
        });

        // Trigger preview on page load if image URL exists
        document.addEventListener('DOMContentLoaded', function() {
            const imageUrl = document.getElementById('imageUrl').value;
            if (imageUrl) {
                document.getElementById('imageUrl').dispatchEvent(new Event('input'));
            }
        });

        // Form validation
        document.getElementById('productForm').addEventListener('submit', function(e) {
            const name = document.querySelector('input[name="name"]').value.trim();
            const price = document.querySelector('input[name="price"]').value;
            const stock = document.querySelector('input[name="stock"]').value;
            const category = document.querySelector('select[name="categoryId"]').value;

            if (!name) {
                alert('Vui lòng nhập tên sản phẩm');
                e.preventDefault();
                return;
            }

            if (!category) {
                alert('Vui lòng chọn loại cây');
                e.preventDefault();
                return;
            }

            if (!price || parseFloat(price) < 0) {
                alert('Vui lòng nhập giá hợp lệ');
                e.preventDefault();
                return;
            }

            if (!stock || parseInt(stock) < 0) {
                alert('Vui lòng nhập số lượng hợp lệ');
                e.preventDefault();
                return;
            }
        });

        // Auto-format price input
        document.querySelector('input[name="price"]').addEventListener('input', function() {
            let value = this.value.replace(/[^\d]/g, '');
            if (value) {
                // Round to nearest thousand
                value = Math.round(value / 1000) * 1000;
                this.value = value;
            }
        });
    </script>
</body>
</html>



