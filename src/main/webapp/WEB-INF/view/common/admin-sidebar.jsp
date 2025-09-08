<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Admin Sidebar -->
<nav class="admin-sidebar">
    <div class="sidebar-header">
        <h4><i class="fas fa-leaf me-2"></i>Plant Shop Admin</h4>
    </div>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link ${param.activePage == 'dashboard' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt"></i>Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${param.activePage == 'products' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/admin/products">
                <i class="fas fa-seedling"></i>Quản lý sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${param.activePage == 'orders' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/admin/orders">
                <i class="fas fa-shopping-cart"></i>Quản lý đơn hàng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${param.activePage == 'reports' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/admin/reports">
                <i class="fas fa-chart-bar"></i>Báo cáo
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/">
                <i class="fas fa-home"></i>Về trang chủ
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i>Đăng xuất
            </a>
        </li>
    </ul>
</nav>


