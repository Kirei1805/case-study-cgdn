<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quản lý sản phẩm - Plant Shop Admin</title>
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pagination.css">
    
    <style>
        :root {
            --admin-primary: #2d5a27;
            --admin-secondary: #4a7c59;
            --admin-accent: #7fb069;
            --admin-gradient: linear-gradient(135deg, #2d5a27 0%, #4a7c59 50%, #7fb069 100%);
            --admin-gradient-light: linear-gradient(135deg, rgba(45, 90, 39, 0.1) 0%, rgba(127, 176, 105, 0.05) 100%);
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 8px rgba(0,0,0,0.12);
            --shadow-lg: 0 8px 16px rgba(0,0,0,0.15);
            --shadow-xl: 0 12px 24px rgba(0,0,0,0.18);
            --border-radius: 12px;
            --border-radius-lg: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fffe 0%, #f0f9f3 100%);
            color: #2c3e50;
            line-height: 1.6;
        }

        /* Admin Sidebar */
        .admin-sidebar {
            min-height: 100vh;
            background: var(--admin-gradient);
            box-shadow: var(--shadow-lg);
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .admin-sidebar .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .admin-sidebar .sidebar-header h4 {
            color: white;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .admin-sidebar .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 0.75rem 1.5rem;
            border-radius: 0;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .admin-sidebar .nav-link:hover,
        .admin-sidebar .nav-link.active {
            color: white;
            background: rgba(255,255,255,0.1);
            border-left-color: #7fb069;
        }

        .admin-sidebar .nav-link i {
            width: 20px;
            margin-right: 0.5rem;
        }

        /* Main Content */
        .main-content {
            margin-left: 250px;
            min-height: 100vh;
            padding: 2rem;
        }

        /* Page Header */
        .page-header {
            background: white;
            padding: 2rem;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            border-left: 4px solid var(--admin-primary);
        }

        .page-header h1 {
            color: var(--admin-primary);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #6c757d;
            margin: 0;
        }

        /* Filter Card */
        .filter-card {
            background: white;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .filter-card h5 {
            color: var(--admin-primary);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        /* Products Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .product-card {
            background: white;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            transition: all 0.3s ease;
            position: relative;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: #f8f9fa;
        }

        .product-info {
            padding: 1.5rem;
        }

        .product-name {
            font-weight: 600;
            color: var(--admin-primary);
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .product-category {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .product-price {
            font-weight: 700;
            color: var(--admin-secondary);
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .product-stock {
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .product-status {
            position: absolute;
            top: 1rem;
            right: 1rem;
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-active {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .status-inactive {
            background: linear-gradient(135deg, #6c757d, #adb5bd);
            color: white;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.375rem 0.75rem;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 500;
            border: none;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .btn-edit {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, #0056b3, #004085);
            color: white;
            transform: translateY(-1px);
        }

        .btn-toggle {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            color: #212529;
        }

        .btn-toggle:hover {
            background: linear-gradient(135deg, #e0a800, #d39e00);
            color: #212529;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            color: white;
            transform: translateY(-1px);
        }

        /* Add Button */
        .btn-add {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--admin-gradient);
            color: white;
            border: none;
            box-shadow: var(--shadow-lg);
            font-size: 1.5rem;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .btn-add:hover {
            transform: scale(1.1);
            box-shadow: var(--shadow-xl);
            color: white;
        }

        /* Alert Messages */
        .alert-custom {
            border-radius: var(--border-radius);
            border: none;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }

        .alert-success {
            background: linear-gradient(135deg, rgba(40, 167, 69, 0.1), rgba(32, 201, 151, 0.05));
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-danger {
            background: linear-gradient(135deg, rgba(220, 53, 69, 0.1), rgba(200, 35, 51, 0.05));
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #adb5bd;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .admin-sidebar {
                transform: translateX(-100%);
            }

            .main-content {
                margin-left: 0;
                padding: 1rem;
            }

            .products-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .page-header {
                padding: 1.5rem;
            }

            .filter-card {
                padding: 1rem;
            }
        }

        /* Animation for page load */
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
    <!-- Admin Sidebar -->
    <jsp:include page="../common/admin-sidebar.jsp">
        <jsp:param name="activePage" value="products"/>
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header fade-in">
            <h1><i class="fas fa-seedling me-3"></i>Quản lý sản phẩm</h1>
            <p>Quản lý toàn bộ sản phẩm trong cửa hàng cây cảnh</p>
        </div>

        <!-- Alert Messages -->
        <c:if test="${param.success != null}">
            <div class="alert alert-success alert-custom fade-in">
                <i class="fas fa-check-circle me-2"></i>
                <c:choose>
                    <c:when test="${param.success == 'added'}">Thêm sản phẩm thành công!</c:when>
                    <c:when test="${param.success == 'updated'}">Cập nhật sản phẩm thành công!</c:when>
                    <c:when test="${param.success == 'deleted'}">Xóa sản phẩm thành công!</c:when>
                    <c:when test="${param.success == 'activated'}">Kích hoạt sản phẩm thành công!</c:when>
                    <c:when test="${param.success == 'deactivated'}">Vô hiệu hóa sản phẩm thành công!</c:when>
                    <c:otherwise>Thao tác thành công!</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${param.error != null}">
            <div class="alert alert-danger alert-custom fade-in">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'missing-id'}">Thiếu ID sản phẩm!</c:when>
                    <c:when test="${param.error == 'invalid-id'}">ID sản phẩm không hợp lệ!</c:when>
                    <c:when test="${param.error == 'not-found'}">Không tìm thấy sản phẩm!</c:when>
                    <c:when test="${param.error == 'add-failed'}">Thêm sản phẩm thất bại!</c:when>
                    <c:when test="${param.error == 'update-failed'}">Cập nhật sản phẩm thất bại!</c:when>
                    <c:when test="${param.error == 'delete-failed'}">Xóa sản phẩm thất bại!</c:when>
                    <c:when test="${param.error == 'toggle-failed'}">Thay đổi trạng thái thất bại!</c:when>
                    <c:when test="${param.error == 'missing-name'}">Tên sản phẩm là bắt buộc!</c:when>
                    <c:otherwise>Có lỗi xảy ra!</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- Filter Section -->
        <div class="filter-card fade-in">
            <h5><i class="fas fa-filter me-2"></i>Bộ lọc và tìm kiếm</h5>
            <form method="GET" action="${pageContext.request.contextPath}/admin/products">
                <div class="row">
                    <div class="col-md-4">
                        <label class="form-label">Tìm kiếm sản phẩm</label>
                        <input type="text" name="search" class="form-control" 
                               placeholder="Nhập tên sản phẩm..." 
                               value="${currentSearch}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Loại cây</label>
                        <select name="category" class="form-select">
                            <option value="">Tất cả loại</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}" 
                                        ${currentCategory == category.id ? 'selected' : ''}>
                                    ${category.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active" ${currentStatus == 'active' ? 'selected' : ''}>Đang bán</option>
                            <option value="inactive" ${currentStatus == 'inactive' ? 'selected' : ''}>Ngừng bán</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label">&nbsp;</label>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search me-1"></i>Lọc
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Products Grid -->
        <div class="fade-in">
            <c:choose>
                <c:when test="${empty products}">
                    <div class="empty-state">
                        <i class="fas fa-seedling"></i>
                        <h4>Chưa có sản phẩm nào</h4>
                        <p>Bấm nút "+" để thêm sản phẩm đầu tiên</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="products-grid">
                        <c:forEach var="product" items="${products}">
                            <div class="product-card">
                                <!-- Product Status Badge -->
                                <div class="product-status">
                                    <span class="status-badge ${product.active ? 'status-active' : 'status-inactive'}">
                                        ${product.active ? 'Đang bán' : 'Ngừng bán'}
                                    </span>
                                </div>

                                <!-- Product Image -->
                                <img src="${product.imageUrl}" 
                                     class="product-image" 
                                     alt="${product.name}"
                                     onerror="this.src='https://via.placeholder.com/300x200?text=Không+có+ảnh'">

                                <!-- Product Info -->
                                <div class="product-info">
                                    <h6 class="product-name">${product.name}</h6>
                                    
                                    <div class="product-category">
                                        <i class="fas fa-tag me-1"></i>
                                        <c:forEach var="category" items="${categories}">
                                            <c:if test="${category.id == product.categoryId}">
                                                ${category.name}
                                            </c:if>
                                        </c:forEach>
                                    </div>

                                    <div class="product-price">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol=""/> VNĐ
                                    </div>

                                    <div class="product-stock">
                                        <i class="fas fa-boxes me-1"></i>
                                        Còn lại: <strong>${product.stock}</strong> cây
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}" 
                                           class="btn-action btn-edit">
                                            <i class="fas fa-edit"></i>Sửa
                                        </a>
                                        
                                        <a href="${pageContext.request.contextPath}/admin/products?action=toggle-status&id=${product.id}" 
                                           class="btn-action btn-toggle"
                                           onclick="return confirm('Bạn có chắc muốn ${product.active ? 'vô hiệu hóa' : 'kích hoạt'} sản phẩm này?')">
                                            <i class="fas fa-${product.active ? 'eye-slash' : 'eye'}"></i>
                                            ${product.active ? 'Ẩn' : 'Hiện'}
                                        </a>
                                        
                                        <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${product.id}" 
                                           class="btn-action btn-delete"
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này? Hành động này không thể hoàn tác!')">
                                            <i class="fas fa-trash"></i>Xóa
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty pagination && pagination.totalPages > 1}">
            <jsp:include page="../common/pagination.jsp"/>
        </c:if>
    </div>

    <!-- Add Product Button -->
    <a href="${pageContext.request.contextPath}/admin/products?action=add" 
       class="btn btn-add" 
       title="Thêm sản phẩm mới">
        <i class="fas fa-plus"></i>
    </a>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Add animation delays for product cards
        document.addEventListener('DOMContentLoaded', function() {
            const productCards = document.querySelectorAll('.product-card');
            productCards.forEach((card, index) => {
                card.style.animationDelay = (index * 0.1) + 's';
                card.classList.add('fade-in');
            });
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);
    </script>
</body>
</html>
