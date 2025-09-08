package util;

import java.util.List;

public class PaginationUtil<T> {
    private List<T> items;
    private int currentPage;
    private int pageSize;
    private int totalItems;
    private int totalPages;
    private boolean hasNext;
    private boolean hasPrevious;
    private int startItem;
    private int endItem;
    
    public PaginationUtil(List<T> allItems, int page, int size) {
        this.items = allItems;
        this.totalItems = allItems.size();
        this.currentPage = Math.max(1, page); // Ensure page is at least 1
        this.pageSize = Math.max(1, size);    // Ensure size is at least 1
        
        // Calculate total pages
        this.totalPages = (int) Math.ceil((double) totalItems / pageSize);
        
        // Ensure current page doesn't exceed total pages
        this.currentPage = Math.min(currentPage, Math.max(1, totalPages));
        
        // Calculate pagination info
        this.hasPrevious = currentPage > 1;
        this.hasNext = currentPage < totalPages;
        
        // Calculate item range for current page
        this.startItem = (currentPage - 1) * pageSize;
        this.endItem = Math.min(startItem + pageSize, totalItems);
    }
    
    /**
     * Get items for current page
     */
    public List<T> getPageItems() {
        if (items.isEmpty() || startItem >= totalItems) {
            return List.of(); // Return empty list if no items or invalid range
        }
        return items.subList(startItem, endItem);
    }
    
    /**
     * Get page numbers to display in pagination UI
     */
    public int[] getPageNumbers() {
        int maxPagesToShow = 5;
        int startPage = Math.max(1, currentPage - maxPagesToShow / 2);
        int endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);
        
        // Adjust start page if we're near the end
        if (endPage - startPage + 1 < maxPagesToShow) {
            startPage = Math.max(1, endPage - maxPagesToShow + 1);
        }
        
        int[] pageNumbers = new int[endPage - startPage + 1];
        for (int i = 0; i < pageNumbers.length; i++) {
            pageNumbers[i] = startPage + i;
        }
        
        return pageNumbers;
    }
    
    /**
     * Generate pagination info text
     */
    public String getPaginationInfo() {
        if (totalItems == 0) {
            return "Không có dữ liệu";
        }
        
        int displayStart = startItem + 1;
        int displayEnd = endItem;
        
        return String.format("Hiển thị %d-%d trong tổng số %d kết quả", 
                           displayStart, displayEnd, totalItems);
    }
    
    // Getters
    public int getCurrentPage() { return currentPage; }
    public int getPageSize() { return pageSize; }
    public int getTotalItems() { return totalItems; }
    public int getTotalPages() { return totalPages; }
    public boolean isHasNext() { return hasNext; }
    public boolean isHasPrevious() { return hasPrevious; }
    public int getStartItem() { return startItem; }
    public int getEndItem() { return endItem; }
    
    public int getNextPage() { return hasNext ? currentPage + 1 : currentPage; }
    public int getPreviousPage() { return hasPrevious ? currentPage - 1 : currentPage; }
    
    // Helper methods for JSP
    public boolean isFirstPage() { return currentPage == 1; }
    public boolean isLastPage() { return currentPage == totalPages; }
    public boolean isEmpty() { return totalItems == 0; }
}

