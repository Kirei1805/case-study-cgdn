 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Plant Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        .register-card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }
        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        .btn-success {
            background: linear-gradient(45deg, #28a745, #20c997);
            border: none;
        }
        .btn-success:hover {
            background: linear-gradient(45deg, #218838, #1ea085);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-6 col-lg-5">
                <div class="card register-card shadow-lg">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="fas fa-seedling fa-3x text-success mb-3"></i>
                            <h2 class="card-title">Đăng ký tài khoản</h2>
                            <p class="text-muted">Tạo tài khoản mới để mua sắm cây trồng</p>
                        </div>

                        <c:if test="${not empty message}">
                            <div class="alert alert-${messageType} alert-dismissible fade show" role="alert">
                                <i class="fas fa-${messageType == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                            <div class="mb-3">
                                <label for="username" class="form-label">
                                    <i class="fas fa-user me-1"></i>Tên đăng nhập <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="username" name="username" 
                                       value="${param.username}" required minlength="3" maxlength="50">
                                <div class="form-text">Tên đăng nhập phải có ít nhất 3 ký tự</div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope me-1"></i>Email <span class="text-danger">*</span>
                                </label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${param.email}" required>
                            </div>

                            <div class="mb-3">
                                <label for="fullName" class="form-label">
                                    <i class="fas fa-id-card me-1"></i>Họ và tên <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                       value="${param.fullName}" required minlength="2" maxlength="100">
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone me-1"></i>Số điện thoại <span class="text-danger">*</span>
                                </label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="${param.phone}" required pattern="[0-9]{10,11}">
                                <div class="form-text">Số điện thoại phải có 10-11 chữ số</div>
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">
                                    <i class="fas fa-map-marker-alt me-1"></i>Địa chỉ
                                </label>
                                <textarea class="form-control" id="address" name="address" 
                                          rows="3">${param.address}</textarea>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-1"></i>Mật khẩu <span class="text-danger">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="password" name="password" 
                                           required minlength="6">
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="form-text">Mật khẩu phải có ít nhất 6 ký tự</div>
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">
                                    <i class="fas fa-lock me-1"></i>Xác nhận mật khẩu <span class="text-danger">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" 
                                           name="confirmPassword" required minlength="6">
                                    <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">
                                    Tôi đồng ý với <a href="#" class="text-decoration-none">điều khoản sử dụng</a> 
                                    và <a href="#" class="text-decoration-none">chính sách bảo mật</a>
                                </label>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success btn-lg">
                                    <i class="fas fa-user-plus me-2"></i>Đăng ký
                                </button>
                            </div>
                        </form>

                        <div class="text-center mt-4">
                            <p class="mb-0">
                                Đã có tài khoản? 
                                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập ngay
                                </a>
                            </p>
                        </div>

                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/plants" class="text-decoration-none">
                                <i class="fas fa-arrow-left me-1"></i>Quay lại trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const confirmPassword = document.getElementById('confirmPassword');
            const icon = this.querySelector('i');
            
            if (confirmPassword.type === 'password') {
                confirmPassword.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                confirmPassword.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
                return false;
            }
            
            const phone = document.getElementById('phone').value;
            const phonePattern = /^[0-9]{10,11}$/;
            
            if (!phonePattern.test(phone)) {
                e.preventDefault();
                alert('Số điện thoại không hợp lệ!');
                return false;
            }
        });
    </script>
</body>
</html> 