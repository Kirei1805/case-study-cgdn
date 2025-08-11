<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Lỗi máy chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
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
        .error-details {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
            backdrop-filter: blur(10px);
            text-align: left;
        }
        .error-details h6 {
            margin-bottom: 10px;
            opacity: 0.9;
        }
        .error-details pre {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            margin: 0;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        .contact-info {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body>
    <!-- Floating Elements -->
    <div class="floating-elements">
        <div class="floating-element">
            <i class="fas fa-exclamation-triangle fa-3x"></i>
        </div>
        <div class="floating-element">
            <i class="fas fa-bug fa-2x"></i>
        </div>
        <div class="floating-element">
            <i class="fas fa-server fa-2x"></i>
        </div>
    </div>

    <div class="error-container">
        <div class="error-code">500</div>
        <div class="error-message">
            <i class="fas fa-exclamation-triangle me-2"></i>Lỗi máy chủ
        </div>
        <div class="error-description">
            Rất tiếc, đã xảy ra lỗi trong quá trình xử lý yêu cầu của bạn. 
            Chúng tôi đang khắc phục vấn đề này.
        </div>

        <!-- Action Buttons -->
        <div class="d-flex justify-content-center gap-3 flex-wrap mb-4">
            <a href="${pageContext.request.contextPath}/plants" class="btn btn-home">
                <i class="fas fa-home me-2"></i>Về trang chủ
            </a>
            <a href="javascript:location.reload()" class="btn btn-home">
                <i class="fas fa-redo me-2"></i>Thử lại
            </a>
            <a href="javascript:history.back()" class="btn btn-home">
                <i class="fas fa-arrow-left me-2"></i>Quay lại
            </a>
        </div>

        <!-- Error Details (only show in development) -->
        <c:if test="${not empty exception}">
            <div class="error-details">
                <h6><i class="fas fa-info-circle me-2"></i>Chi tiết lỗi:</h6>
                <pre>${exception}</pre>
            </div>
        </c:if>

        <!-- Contact Information -->
        <div class="contact-info">
            <h6 class="mb-3">
                <i class="fas fa-headset me-2"></i>Bạn cần hỗ trợ?
            </h6>
            <div class="row text-center">
                <div class="col-md-4">
                    <div class="mb-2">
                        <i class="fas fa-envelope fa-2x mb-2"></i>
                    </div>
                    <div>Email hỗ trợ</div>
                    <small>support@plantshop.com</small>
                </div>
                <div class="col-md-4">
                    <div class="mb-2">
                        <i class="fas fa-phone fa-2x mb-2"></i>
                    </div>
                    <div>Hotline</div>
                    <small>1900-1234</small>
                </div>
                <div class="col-md-4">
                    <div class="mb-2">
                        <i class="fas fa-clock fa-2x mb-2"></i>
                    </div>
                    <div>Thời gian làm việc</div>
                    <small>8:00 - 22:00</small>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="mt-4">
            <h6 class="mb-3" style="opacity: 0.8;">Bạn có thể thử:</h6>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/plants" class="text-white text-decoration-none" 
                   style="opacity: 0.7; transition: opacity 0.3s ease;" onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0.7'">
                    <i class="fas fa-leaf me-1"></i>Xem cây trồng
                </a>
                <a href="${pageContext.request.contextPath}/login" class="text-white text-decoration-none" 
                   style="opacity: 0.7; transition: opacity 0.3s ease;" onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0.7'">
                    <i class="fas fa-sign-in-alt me-1"></i>Đăng nhập
                </a>
                <a href="${pageContext.request.contextPath}/register" class="text-white text-decoration-none" 
                   style="opacity: 0.7; transition: opacity 0.3s ease;" onmouseover="this.style.opacity='1'" onmouseout="this.style.opacity='0.7'">
                    <i class="fas fa-user-plus me-1"></i>Đăng ký
                </a>
            </div>
        </div>

        <!-- Auto Refresh Timer -->
        <div class="mt-4" style="opacity: 0.7;">
            <small>
                <i class="fas fa-clock me-1"></i>
                Trang sẽ tự động tải lại sau <span id="countdown">30</span> giây
            </small>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto refresh countdown
        let countdown = 30;
        const countdownElement = document.getElementById('countdown');
        
        const timer = setInterval(function() {
            countdown--;
            countdownElement.textContent = countdown;
            
            if (countdown <= 0) {
                clearInterval(timer);
                location.reload();
            }
        }, 1000);
    </script>
</body>
</html> 