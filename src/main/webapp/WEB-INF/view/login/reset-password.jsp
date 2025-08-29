<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Đặt lại mật khẩu"/>
</jsp:include>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
        <div class="card shadow">
            <div class="card-body p-5">
                <div class="text-center mb-4">
                    <i class="fas fa-lock fa-3x text-success mb-3"></i>
                    <h3 class="fw-bold">Đặt lại mật khẩu</h3>
                    <p class="text-muted">Nhập mật khẩu mới cho tài khoản của bạn</p>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/reset-password" method="POST" id="resetPasswordForm">
                    <input type="hidden" name="token" value="${token}">
                    
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control form-control-lg" id="newPassword" name="newPassword" 
                                   required minlength="6" pattern="^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{6,}$"
                                   placeholder="Nhập mật khẩu mới">
                            <button type="button" class="btn btn-outline-secondary" id="togglePassword1">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="form-text">Ít nhất 6 ký tự, bao gồm chữ cái và số</div>
                        <div class="invalid-feedback"></div>
                    </div>

                    <div class="mb-4">
                        <label for="confirmPassword" class="form-label">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control form-control-lg" id="confirmPassword" name="confirmPassword" 
                                   required minlength="6" placeholder="Nhập lại mật khẩu mới">
                            <button type="button" class="btn btn-outline-secondary" id="togglePassword2">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                        <div class="invalid-feedback"></div>
                    </div>

                    <!-- Password Strength Indicator -->
                    <div class="mb-3">
                        <div class="progress" style="height: 5px;">
                            <div class="progress-bar" role="progressbar" id="passwordStrength" style="width: 0%"></div>
                        </div>
                        <small class="text-muted" id="passwordStrengthText">Độ mạnh mật khẩu</small>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-success btn-lg" id="submitBtn">
                            <i class="fas fa-check me-2"></i>Đặt lại mật khẩu
                        </button>
                    </div>
                </form>

                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại đăng nhập
                    </a>
                </div>

                <!-- Security Tips -->
                <div class="mt-4 p-3 bg-light rounded">
                    <h6 class="text-muted mb-2"><i class="fas fa-shield-alt me-2"></i>Mẹo bảo mật:</h6>
                    <ul class="small text-muted mb-0">
                        <li>Sử dụng mật khẩu mạnh với ít nhất 8 ký tự</li>
                        <li>Kết hợp chữ hoa, chữ thường, số và ký tự đặc biệt</li>
                        <li>Không sử dụng thông tin cá nhân dễ đoán</li>
                        <li>Không chia sẻ mật khẩu với ai khác</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Enhanced Validation Script -->
<script>
// Password visibility toggle
document.getElementById('togglePassword1').addEventListener('click', function() {
    const password = document.getElementById('newPassword');
    const icon = this.querySelector('i');
    
    if (password.type === 'password') {
        password.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        password.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
});

document.getElementById('togglePassword2').addEventListener('click', function() {
    const password = document.getElementById('confirmPassword');
    const icon = this.querySelector('i');
    
    if (password.type === 'password') {
        password.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
    } else {
        password.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
    }
});

// Password strength checker
function checkPasswordStrength(password) {
    let strength = 0;
    let text = '';
    let className = '';
    
    if (password.length >= 6) strength += 20;
    if (password.length >= 8) strength += 20;
    if (/[a-z]/.test(password)) strength += 20;
    if (/[A-Z]/.test(password)) strength += 20;
    if (/[0-9]/.test(password)) strength += 10;
    if (/[^A-Za-z0-9]/.test(password)) strength += 10;
    
    if (strength < 40) {
        text = 'Yếu';
        className = 'bg-danger';
    } else if (strength < 70) {
        text = 'Trung bình';
        className = 'bg-warning';
    } else {
        text = 'Mạnh';
        className = 'bg-success';
    }
    
    return { strength, text, className };
}

// Real-time validation
document.getElementById('newPassword').addEventListener('input', function() {
    const password = this.value;
    const strengthBar = document.getElementById('passwordStrength');
    const strengthText = document.getElementById('passwordStrengthText');
    const confirmPassword = document.getElementById('confirmPassword');
    
    if (password === '') {
        this.classList.remove('is-valid', 'is-invalid');
        strengthBar.style.width = '0%';
        strengthBar.className = 'progress-bar';
        strengthText.textContent = 'Độ mạnh mật khẩu';
    } else if (!/^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{6,}$/.test(password)) {
        this.classList.add('is-invalid');
        this.classList.remove('is-valid');
        this.parentElement.parentElement.querySelector('.invalid-feedback').textContent = 
            'Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ cái và số';
        
        // Still show strength indicator
        const { strength, text, className } = checkPasswordStrength(password);
        strengthBar.style.width = strength + '%';
        strengthBar.className = 'progress-bar ' + className;
        strengthText.textContent = text;
    } else {
        this.classList.add('is-valid');
        this.classList.remove('is-invalid');
        this.parentElement.parentElement.querySelector('.invalid-feedback').textContent = '';
        
        const { strength, text, className } = checkPasswordStrength(password);
        strengthBar.style.width = strength + '%';
        strengthBar.className = 'progress-bar ' + className;
        strengthText.textContent = text;
    }
    
    // Re-validate confirm password
    if (confirmPassword.value) {
        if (password !== confirmPassword.value) {
            confirmPassword.classList.add('is-invalid');
            confirmPassword.classList.remove('is-valid');
            confirmPassword.parentElement.parentElement.querySelector('.invalid-feedback').textContent = 
                'Mật khẩu xác nhận không khớp';
        } else {
            confirmPassword.classList.add('is-valid');
            confirmPassword.classList.remove('is-invalid');
            confirmPassword.parentElement.parentElement.querySelector('.invalid-feedback').textContent = '';
        }
    }
});

document.getElementById('confirmPassword').addEventListener('input', function() {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = this.value;
    
    if (confirmPassword === '') {
        this.classList.remove('is-valid', 'is-invalid');
    } else if (newPassword !== confirmPassword) {
        this.classList.add('is-invalid');
        this.classList.remove('is-valid');
        this.parentElement.parentElement.querySelector('.invalid-feedback').textContent = 'Mật khẩu xác nhận không khớp';
    } else {
        this.classList.add('is-valid');
        this.classList.remove('is-invalid');
        this.parentElement.parentElement.querySelector('.invalid-feedback').textContent = '';
    }
});

// Form submit validation
document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    let isValid = true;
    
    if (!newPassword.checkValidity()) {
        newPassword.classList.add('is-invalid');
        isValid = false;
    }
    
    if (!confirmPassword.checkValidity() || newPassword.value !== confirmPassword.value) {
        confirmPassword.classList.add('is-invalid');
        isValid = false;
    }
    
    if (!isValid) {
        e.preventDefault();
        const firstInvalid = document.querySelector('.is-invalid');
        if (firstInvalid) firstInvalid.focus();
    }
});
</script>

<jsp:include page="../common/footer.jsp"/>

