<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Quên mật khẩu"/>
</jsp:include>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
        <div class="card shadow">
            <div class="card-body p-5">
                <div class="text-center mb-4">
                    <i class="fas fa-key fa-3x text-warning mb-3"></i>
                    <h3 class="fw-bold">Quên mật khẩu?</h3>
                    <p class="text-muted">Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu</p>
                </div>

                <!-- Success Message -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/forgot-password" method="POST" id="forgotPasswordForm">
                    <div class="mb-4">
                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control form-control-lg" id="email" name="email" 
                                   value="${email}" required placeholder="Nhập email của bạn">
                        </div>
                        <div class="invalid-feedback"></div>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-warning btn-lg" id="submitBtn">
                            <i class="fas fa-paper-plane me-2"></i><span id="btnText">Gửi hướng dẫn</span>
                        </button>
                    </div>
                </form>

                <div class="text-center">
                    <p class="mb-2">Nhớ lại mật khẩu?</p>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary">
                        <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                    </a>
                </div>

                <!-- Info Box -->
                <div class="mt-4 p-3 bg-light rounded">
                    <h6 class="text-muted mb-2"><i class="fas fa-info-circle me-2"></i>Lưu ý:</h6>
                    <ul class="small text-muted mb-0">
                        <li>Kiểm tra hộp thư spam nếu không thấy email</li>
                        <li>Link đặt lại mật khẩu có hiệu lực trong 15 phút</li>
                        <li>Liên hệ hỗ trợ nếu gặp vấn đề: 0909 123 456</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Validation Script -->
<script>
document.getElementById('email').addEventListener('input', function() {
    const email = this.value.trim();
    const emailRegex = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
    
    if (email === '') {
        this.classList.remove('is-valid', 'is-invalid');
    } else if (!emailRegex.test(email)) {
        this.classList.add('is-invalid');
        this.classList.remove('is-valid');
        this.parentElement.parentElement.querySelector('.invalid-feedback').textContent = 'Email không đúng định dạng';
    } else {
        this.classList.add('is-valid');
        this.classList.remove('is-invalid');
        this.parentElement.parentElement.querySelector('.invalid-feedback').textContent = '';
    }
});

document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
    const submitBtn = document.getElementById('submitBtn');
    const btnText = document.getElementById('btnText');
    
    // Disable button and show loading
    submitBtn.disabled = true;
    btnText.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang gửi...';
    
    // Re-enable after 3 seconds if still on page
    setTimeout(() => {
        submitBtn.disabled = false;
        btnText.innerHTML = 'Gửi hướng dẫn';
    }, 3000);
});
</script>

<jsp:include page="../common/footer.jsp"/>

