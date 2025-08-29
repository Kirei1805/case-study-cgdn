<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Đăng ký"/>
</jsp:include>

<div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
        <div class="card shadow">
            <div class="card-body p-5">
                <div class="text-center mb-4">
                    <i class="fas fa-user-plus fa-3x text-success mb-3"></i>
                    <h3 class="fw-bold">Đăng ký tài khoản</h3>
                    <p class="text-muted">Tham gia cùng chúng tôi để mua sắm cây cảnh chất lượng!</p>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="POST">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" id="fullName" name="fullName" 
                                           value="${fullName}" required minlength="2" maxlength="50"
                                           pattern="^[a-zA-ZÀ-ỹ\s]+$">
                                </div>
                                <div class="form-text">2-50 ký tự, chỉ chứa chữ cái và khoảng trắng</div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="username" class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-at"></i></span>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           value="${username}" required minlength="3" maxlength="20"
                                           pattern="^[a-zA-Z0-9_]{3,20}$">
                                </div>
                                <div class="form-text">3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới</div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${email}" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="password" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           required minlength="6" pattern="^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{6,}$">
                                </div>
                                <div class="form-text">Ít nhất 6 ký tự, bao gồm chữ cái và số</div>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                           required minlength="6">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                        <label class="form-check-label" for="agreeTerms">
                            Tôi đồng ý với <a href="#" class="text-decoration-none">Điều khoản sử dụng</a> và 
                            <a href="#" class="text-decoration-none">Chính sách bảo mật</a>
                        </label>
                    </div>

                    <div class="d-grid">
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="fas fa-user-plus me-2"></i>Đăng ký
                        </button>
                    </div>
                </form>

                <div class="text-center mt-4">
                    <p class="mb-2">Đã có tài khoản?</p>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary">
                        <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Enhanced validation script -->
<script>
// Form validation utilities
function showFieldError(field, message) {
    field.classList.add('is-invalid');
    field.classList.remove('is-valid');
    const feedback = field.parentElement.parentElement.querySelector('.invalid-feedback');
    if (feedback) feedback.textContent = message;
}

function showFieldSuccess(field) {
    field.classList.add('is-valid');
    field.classList.remove('is-invalid');
    const feedback = field.parentElement.parentElement.querySelector('.invalid-feedback');
    if (feedback) feedback.textContent = '';
}

function clearFieldValidation(field) {
    field.classList.remove('is-valid', 'is-invalid');
    const feedback = field.parentElement.parentElement.querySelector('.invalid-feedback');
    if (feedback) feedback.textContent = '';
}

// Real-time validation
document.getElementById('username').addEventListener('input', function() {
    const value = this.value.trim();
    if (value === '') {
        clearFieldValidation(this);
    } else if (!/^[a-zA-Z0-9_]{3,20}$/.test(value)) {
        showFieldError(this, 'Tên đăng nhập phải có 3-20 ký tự, chỉ chứa chữ cái, số và dấu gạch dưới');
    } else {
        showFieldSuccess(this);
    }
});

document.getElementById('fullName').addEventListener('input', function() {
    const value = this.value.trim();
    if (value === '') {
        clearFieldValidation(this);
    } else if (!/^[a-zA-ZÀ-ỹ\s]{2,50}$/.test(value)) {
        showFieldError(this, 'Họ tên phải có 2-50 ký tự và chỉ chứa chữ cái');
    } else {
        showFieldSuccess(this);
    }
});

document.getElementById('email').addEventListener('input', function() {
    const value = this.value.trim();
    if (value === '') {
        clearFieldValidation(this);
    } else if (!/^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/.test(value)) {
        showFieldError(this, 'Email không đúng định dạng');
    } else {
        showFieldSuccess(this);
    }
});

document.getElementById('password').addEventListener('input', function() {
    const value = this.value;
    const confirmPassword = document.getElementById('confirmPassword');
    
    if (value === '') {
        clearFieldValidation(this);
    } else if (!/^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{6,}$/.test(value)) {
        showFieldError(this, 'Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ cái và số');
    } else {
        showFieldSuccess(this);
    }
    
    // Re-validate confirm password
    if (confirmPassword.value) {
        if (value !== confirmPassword.value) {
            showFieldError(confirmPassword, 'Mật khẩu xác nhận không khớp');
        } else {
            showFieldSuccess(confirmPassword);
        }
    }
});

document.getElementById('confirmPassword').addEventListener('input', function() {
    const password = document.getElementById('password').value;
    const confirmPassword = this.value;
    
    if (confirmPassword === '') {
        clearFieldValidation(this);
    } else if (password !== confirmPassword) {
        showFieldError(this, 'Mật khẩu xác nhận không khớp');
    } else {
        showFieldSuccess(this);
    }
});

// Form submit validation
document.querySelector('form').addEventListener('submit', function(e) {
    let isValid = true;
    const fields = ['username', 'fullName', 'email', 'password', 'confirmPassword'];
    
    fields.forEach(fieldId => {
        const field = document.getElementById(fieldId);
        if (!field.checkValidity()) {
            isValid = false;
            field.classList.add('is-invalid');
        }
    });
    
    if (!isValid) {
        e.preventDefault();
        const firstInvalid = document.querySelector('.is-invalid');
        if (firstInvalid) firstInvalid.focus();
    }
});
</script>

<jsp:include page="../common/footer.jsp"/>
