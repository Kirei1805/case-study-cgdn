<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Trang không tìm thấy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            text-align: center;
            color: white;
            max-width: 600px;
            padding: 2rem;
        }
        .error-code {
            font-size: 8rem;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            margin-bottom: 1rem;
        }
        .error-message {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        .error-description {
            font-size: 1.1rem;
            margin-bottom: 3rem;
            opacity: 0.8;
        }
        .btn-home {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 12px 30px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        .btn-home:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            color: white;
            transform: translateY(-2px);
        }
        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }
        .floating-element {
            position: absolute;
            opacity: 0.1;
            animation: float 6s ease-in-out infinite;
        }
        .floating-element:nth-child(1) {
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }
        .floating-element:nth-child(2) {
            top: 60%;
            right: 10%;
            animation-delay: 2s;
        }
        .floating-element:nth-child(3) {
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }
        .search-box {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 15px 25px;
            color: white;
            backdrop-filter: blur(10px);
            margin-bottom: 2rem;
        }
        .search-box::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        .search-box:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body>
    <!-- Floating Elements -->
    <div class="floating-elements">
        <div class="floating-element">
            <i class="fas fa-seedling fa-3x"></i>
        </div>
        <div class="floating-element">
            <i class="fas fa-leaf fa-2x"></i>
        </div>
        <div class="floating-element">
            <i class="fas fa-tree fa-2x"></i>
        </div>
    </div>

    <div class="error-container">
        <div class="error-code">404</div>
        <div class="error-message">
            <i class="fas fa-search me-2"></i>Trang không tìm thấy
        </div>
        <div class="error-description">
            Rất tiếc, trang bạn đang tìm kiếm không tồn tại hoặc đã được di chuyển.
        </div>

        <!-- Search Box -->
        <div class="mb-4">
            <form action="${pageContext.request.contextPath}/plants" method="get" class="d-flex justify-content-center">
                <input type="text" class="form-control search-box" name="search" 
                       placeholder="Tìm kiếm cây trồng..." style="max-width: 400px;">
                <button type="submit" class="btn btn-home ms-2">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>

        <!-- Action Buttons -->
        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <a href="${pageContext.request.contextPath}/plants" class="btn btn-home">
                <i class="fas fa-home me-2"></i>Về trang chủ
            </a>
            <a href="javascript:history.back()" class="btn btn-home">
                <i class="fas fa-arrow-left me-2"></i>Quay lại
            </a>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-home">
                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
            </a>
        </div>

        <!-- Quick Links -->
        <div class="mt-5">
            <h6 class="mb-3" style="opacity: 0.8;">Có thể bạn quan tâm:</h6>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/plants" class="text-white text-decoration-none" 
                   style="opacity: 0.7; transition: opacity 0.3s ease;" onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0.7'">
                    <i class="fas fa-leaf me-1"></i>Cây trồng
                </a>
                <a href="${pageContext.request.contextPath}/plants?category=1" class="text-white text-decoration-none" 
                   style="opacity: 0.7; transition: opacity 0.3s ease;" onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0.7'">
                    <i class="fas fa-seedling me-1"></i>Cây cảnh
                </a>
                <a href="${pageContext.request.contextPath}/plants?category=2" class="text-white text-decoration-none" 
                   style="opacity: 0.7; transition: opacity 0.3s ease;" onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0.7'">
                    <i class="fas fa-tree me-1"></i>Cây ăn quả
                </a>
                <a href="${pageContext.request.contextPath}/register" class="text-white text-decoration-none" 
                   style="opacity: 0.7; transition: opacity 0.3s ease;" onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0.7'">
                    <i class="fas fa-user-plus me-1"></i>Đăng ký
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 