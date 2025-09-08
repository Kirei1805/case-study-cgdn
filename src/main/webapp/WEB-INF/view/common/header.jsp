<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Plant Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2d5a27;
            --secondary-color: #4a7c59;
            --accent-color: #7fb069;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
            --gradient-primary: linear-gradient(135deg, #2d5a27 0%, #4a7c59 50%, #7fb069 100%);
            --gradient-secondary: linear-gradient(135deg, #7fb069 0%, #bfd8bd 100%);
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
            --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
            --shadow-xl: 0 20px 25px rgba(0,0,0,0.1);
            --border-radius: 12px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
            background-color: #fafbfc;
        }

        .plant-image {
            height: 220px;
            object-fit: cover;
            border-radius: var(--border-radius);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .plant-image:hover {
            transform: scale(1.05);
            box-shadow: var(--shadow-lg);
        }

        .price {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 1.25rem;
            font-family: 'Poppins', sans-serif;
        }

        /* Enhanced Card Styles */
        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl);
        }

        .card-body {
            padding: 1.5rem;
        }

        /* Modern Button Styles */
        .btn {
            border-radius: 8px;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            border: none;
            text-transform: none;
            letter-spacing: 0.025em;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #234a1e 0%, #3a6b47 50%, #6da058 100%);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-success {
            background: var(--gradient-secondary);
            color: var(--dark-color);
            font-weight: 600;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #6da058 0%, #a8c99a 100%);
            color: var(--dark-color);
            transform: translateY(-2px);
        }

        .btn-outline-primary {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }
        /* Enhanced Navbar */
        .navbar {
            background: var(--gradient-primary) !important;
            padding: 1rem 0;
            box-shadow: var(--shadow-md);
            backdrop-filter: blur(10px);
            z-index: 9998 !important;
            position: relative;
        }

        .navbar-brand {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 1.5rem;
            color: white !important;
            text-decoration: none;
        }

        .navbar-brand:hover {
            color: var(--accent-color) !important;
            transform: scale(1.05);
            transition: all 0.3s ease;
        }

        .nav-link {
            font-weight: 500;
            color: rgba(255, 255, 255, 0.9) !important;
            padding: 0.5rem 1rem !important;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white !important;
            transform: translateY(-1px);
        }

        .dropdown-menu {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-lg);
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
            z-index: 9999 !important;
            position: absolute !important;
        }

        .dropdown-item {
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            border-radius: 6px;
            margin: 0.25rem;
        }

        .dropdown-item:hover {
            background: var(--gradient-secondary);
            color: var(--dark-color);
            transform: translateX(5px);
        }

        /* Fix dropdown visibility issues */
        .dropdown {
            position: static !important;
        }

        .navbar-nav .dropdown {
            position: relative !important;
        }

        .navbar-collapse {
            overflow: visible !important;
        }

        .container {
            overflow: visible !important;
        }

        .dropdown-toggle::after {
            transition: transform 0.3s ease;
        }

        .dropdown.show .dropdown-toggle::after {
            transform: rotate(180deg);
        }

        .dropdown-menu.show {
            display: block !important;
            animation: fadeInDown 0.3s ease;
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Modern Carousel */
        .carousel {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-xl);
            margin: 2rem 0;
            z-index: 1;
            position: relative;
        }
        
        .carousel-image {
            height: 550px;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }
        
        .carousel-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(45, 90, 39, 0.7) 0%, rgba(74, 124, 89, 0.5) 50%, rgba(127, 176, 105, 0.3) 100%);
            display: flex;
            align-items: center;
        }
        
        .carousel-item h1 {
            font-family: 'Poppins', sans-serif;
            font-weight: 700;
            font-size: 3.5rem;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
            margin-bottom: 1.5rem;
            line-height: 1.2;
        }
        
        .carousel-item p {
            font-size: 1.25rem;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.3);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .carousel-item .btn {
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.9);
            color: var(--primary-color);
            border: none;
            backdrop-filter: blur(10px);
        }

        .carousel-item .btn:hover {
            background: white;
            transform: translateY(-3px) scale(1.05);
            box-shadow: var(--shadow-lg);
        }
        
        .carousel-indicators {
            bottom: 30px;
        }
        
        .carousel-indicators button {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin: 0 8px;
            border: 2px solid white;
            background: rgba(255, 255, 255, 0.5);
            transition: all 0.3s ease;
        }

        .carousel-indicators button.active {
            background: white;
            transform: scale(1.2);
        }
        
        .carousel-control-prev,
        .carousel-control-next {
            width: 8%;
            opacity: 0.8;
        }

        .carousel-control-prev:hover,
        .carousel-control-next:hover {
            opacity: 1;
        }
        
        /* Form Enhancements */
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.25);
        }

        .form-select {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m1 6 7 7 7-7'/%3e%3c/svg%3e");
        }

        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(45, 90, 39, 0.25);
        }
        
        .min-vh-50 {
            min-height: 50vh;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .carousel-image {
                height: 350px;
            }
            .carousel-item h1 {
                font-size: 2.5rem;
            }
            .carousel-item p {
                font-size: 1rem;
            }
            .carousel-item .btn {
                padding: 0.75rem 1.5rem;
                font-size: 1rem;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }

        /* Loading States */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid var(--primary-color);
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-success">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-leaf me-2"></i>Plant Shop
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/plants">
                            <i class="fas fa-seedling me-1"></i>Sản phẩm
                        </a>
                    </li>
                    <c:if test="${not empty user && user.role == 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-1"></i>Admin
                            </a>
                        </li>
                    </c:if>
                </ul>
                
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${empty user}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus me-1"></i>Đăng ký
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                                    <i class="fas fa-shopping-cart me-1"></i>Giỏ hàng
                                </a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-1"></i>${user.fullName}
                                </a>
                                <ul class="dropdown-menu">
                                    <c:if test="${user.role == 'customer'}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                            <i class="fas fa-user-edit me-2"></i>Hồ sơ
                                        </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">
                                            <i class="fas fa-list me-2"></i>Đơn hàng
                                        </a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                                    </a></li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

