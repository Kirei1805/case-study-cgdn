<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Pagination Component -->
<style>
/* Center only the pagination controls */
nav[aria-label="Pagination"] {
    display: flex;
    justify-content: center;
    width: 100%;
}

/* Ensure the list itself doesn't offset alignment */
.pagination {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding-left: 0;
    margin: 0;
}

/* Optional: make nav arrows consistent height with number buttons */
.pagination .page-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
</style>
<div class="pagination-container">
    <!-- Pagination Info -->
    <div class="pagination-info">
        ${pagination.paginationInfo}
    </div>
    
    <!-- Pagination Controls -->
    <c:if test="${pagination.totalPages > 1}">
        <nav aria-label="Pagination">
            <ul class="pagination">
                <!-- First Page -->
                <li class="page-item nav-button ${pagination.firstPage ? 'disabled' : ''}">
                    <a class="page-link" href="${pagination.firstPage ? '#' : pageUrl}page=1${not empty otherParams ? '&' : ''}${otherParams}" 
                       aria-label="First">
                        <i class="fas fa-angle-double-left"></i>
                    </a>
                </li>
                
                <!-- Previous Page -->
                <li class="page-item nav-button ${pagination.hasPrevious ? '' : 'disabled'}">
                    <a class="page-link" href="${pagination.hasPrevious ? pageUrl : '#'}page=${pagination.previousPage}${not empty otherParams ? '&' : ''}${otherParams}" 
                       aria-label="Previous">
                        <i class="fas fa-angle-left"></i>
                    </a>
                </li>
                
                <!-- Page Numbers -->
                <c:forEach var="pageNum" items="${pagination.pageNumbers}">
                    <c:choose>
                        <c:when test="${pageNum == pagination.currentPage}">
                            <li class="page-item active">
                                <span class="page-link">${pageNum}</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="${pageUrl}page=${pageNum}${not empty otherParams ? '&' : ''}${otherParams}">
                                    ${pageNum}
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <!-- Next Page -->
                <li class="page-item nav-button ${pagination.hasNext ? '' : 'disabled'}">
                    <a class="page-link" href="${pagination.hasNext ? pageUrl : '#'}page=${pagination.nextPage}${not empty otherParams ? '&' : ''}${otherParams}" 
                       aria-label="Next">
                        <i class="fas fa-angle-right"></i>
                    </a>
                </li>
                
                <!-- Last Page -->
                <li class="page-item nav-button ${pagination.lastPage ? 'disabled' : ''}">
                    <a class="page-link" href="${pagination.lastPage ? '#' : pageUrl}page=${pagination.totalPages}${not empty otherParams ? '&' : ''}${otherParams}" 
                       aria-label="Last">
                        <i class="fas fa-angle-double-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </c:if>
    
    <!-- Page Size Selector -->
    <div class="page-size-container">
        <label class="page-size-label" for="pageSizeSelect">Hiển thị:</label>
        <select class="page-size-select" id="pageSizeSelect" onchange="changePageSize(this.value)">
            <option value="10" ${pagination.pageSize == 10 ? 'selected' : ''}>10</option>
            <option value="20" ${pagination.pageSize == 20 ? 'selected' : ''}>20</option>
            <option value="50" ${pagination.pageSize == 50 ? 'selected' : ''}>50</option>
            <option value="100" ${pagination.pageSize == 100 ? 'selected' : ''}>100</option>
        </select>
        <span class="page-size-label">/ trang</span>
    </div>
</div>

<script>
function changePageSize(newSize) {
    const currentUrl = new URL(window.location);
    currentUrl.searchParams.set('size', newSize);
    currentUrl.searchParams.set('page', '1'); // Reset to first page
    window.location.href = currentUrl.toString();
}

// Add smooth transitions for pagination
document.addEventListener('DOMContentLoaded', function() {
    const paginationLinks = document.querySelectorAll('.pagination .page-link:not(.disabled .page-link)');
    
    paginationLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            // Add loading state
            const pagination = document.querySelector('.pagination-container');
            if (pagination) {
                pagination.classList.add('pagination-loading');
            }
        });
    });
});
</script>


