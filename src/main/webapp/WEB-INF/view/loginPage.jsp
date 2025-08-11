<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Cửa hàng cây trồng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
        }
        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        .btn-login {
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="login-card p-4">
                    <div class="text-center mb-4">
                        <i class="fas fa-seedling fa-3x text-success mb-3"></i>
                        <h2 class="fw-bold">Đăng nhập</h2>
                        <p class="text-muted">Chào mừng bạn trở lại!</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">
                                <i class="fas fa-user me-2"></i>Tên đăng nhập
                            </label>
                            <input type="text" class="form-control" id="username" name="username" 
                                   placeholder="Nhập tên đăng nhập" required>
                        </div>
                        
                        <div class="mb-4">
                            <label for="password" class="form-label">
                                <i class="fas fa-lock me-2"></i>Mật khẩu
                            </label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Nhập mật khẩu" required>
                        </div>
                        
                        <div class="d-grid mb-3">
                            <button type="submit" class="btn btn-success btn-login">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                            </button>
                        </div>
                    </form>

                    <div class="text-center">
                        <p class="mb-0">Chưa có tài khoản? 
                            <a href="${pageContext.request.contextPath}/register" class="text-success fw-bold">
                                Đăng ký ngay
                            </a>
                        </p>
                    </div>

                    <hr class="my-4">

                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/plants" class="text-decoration-none">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 