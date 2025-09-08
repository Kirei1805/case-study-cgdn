package controller.admin;

import model.Plant;
import model.Category;
import model.User;
import service.plant.PlantService;
import service.plant.PlantServiceImpl;
import service.category.CategoryService;
import service.category.CategoryServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;
import util.PaginationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductController extends HttpServlet {
    private PlantService plantService;
    private CategoryService categoryService;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        plantService = new PlantServiceImpl();
        categoryService = new CategoryServiceImpl();
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !userService.isAdmin(user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    showAddForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteProduct(req, resp);
                    break;
                case "toggle-status":
                    toggleProductStatus(req, resp);
                    break;
                default:
                    showProductList(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi trong quá trình xử lý: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !userService.isAdmin(user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addProduct(req, resp);
                    break;
                case "edit":
                    updateProduct(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/admin/products");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Lỗi trong quá trình xử lý: " + e.getMessage());
        }
    }

    private void showProductList(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // Get filter parameters
        String search = req.getParameter("search");
        String categoryParam = req.getParameter("category");
        String statusParam = req.getParameter("status");
        
        // Get pagination parameters
        String pageParam = req.getParameter("page");
        String sizeParam = req.getParameter("size");
        
        int page = 1;
        int size = 10; // Default page size for admin
        
        try {
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
            if (sizeParam != null && !sizeParam.trim().isEmpty()) {
                size = Integer.parseInt(sizeParam);
                size = Math.min(Math.max(size, 1), 100);
            }
        } catch (NumberFormatException e) {
            // Use defaults if invalid numbers
        }
        
        // Get all products for admin (both active and inactive)
        List<Plant> allProducts = plantService.getAllPlantsForAdmin();
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            allProducts = allProducts.stream()
                .filter(p -> p.getName().toLowerCase().contains(search.toLowerCase()))
                .collect(java.util.stream.Collectors.toList());
        }
        
        // Apply category filter
        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryParam);
                allProducts = allProducts.stream()
                    .filter(p -> p.getCategoryId() == categoryId)
                    .collect(java.util.stream.Collectors.toList());
            } catch (NumberFormatException e) {
                // Invalid category ID, ignore filter
            }
        }
        
        // Apply status filter
        if (statusParam != null && !statusParam.isEmpty()) {
            boolean isActive = "active".equals(statusParam);
            allProducts = allProducts.stream()
                .filter(p -> p.isActive() == isActive)
                .collect(java.util.stream.Collectors.toList());
        }
        
        // Create pagination
        PaginationUtil<Plant> pagination = new PaginationUtil<>(allProducts, page, size);
        List<Plant> products = pagination.getPageItems();
        
        // Build other params for pagination links
        StringBuilder otherParams = new StringBuilder();
        if (search != null && !search.trim().isEmpty()) {
            otherParams.append("search=").append(java.net.URLEncoder.encode(search, "UTF-8"));
        }
        if (categoryParam != null && !categoryParam.isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("category=").append(categoryParam);
        }
        if (statusParam != null && !statusParam.isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("status=").append(statusParam);
        }
        if (sizeParam != null && !sizeParam.trim().isEmpty()) {
            if (otherParams.length() > 0) otherParams.append("&");
            otherParams.append("size=").append(size);
        }
        
        // Get categories for filter dropdown
        List<Category> categories = categoryService.getAllCategories();
        
        // Set attributes
        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.setAttribute("pagination", pagination);
        req.setAttribute("pageUrl", req.getContextPath() + "/admin/products?");
        req.setAttribute("otherParams", otherParams.toString());
        req.setAttribute("currentSearch", search);
        req.setAttribute("currentCategory", categoryParam);
        req.setAttribute("currentStatus", statusParam);
        
        req.getRequestDispatcher("/WEB-INF/view/admin/products.jsp").forward(req, resp);
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Category> categories = categoryService.getAllCategories();
        req.setAttribute("categories", categories);
        req.setAttribute("mode", "add");
        req.getRequestDispatcher("/WEB-INF/view/admin/product-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=missing-id");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            Plant plant = plantService.getPlantById(id);
            
            if (plant == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products?error=not-found");
                return;
            }
            
            List<Category> categories = categoryService.getAllCategories();
            req.setAttribute("plant", plant);
            req.setAttribute("categories", categories);
            req.setAttribute("mode", "edit");
            req.getRequestDispatcher("/WEB-INF/view/admin/product-form.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=invalid-id");
        }
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        try {
            // Extract plant data from request
            Plant plant = extractPlantFromRequest(req);
            
            // Validate required fields
            if (plant.getName() == null || plant.getName().trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/products?action=add&error=missing-name");
                return;
            }
            
            // Add the plant
            boolean success = plantService.createPlant(plant);
            
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/products?success=added");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products?action=add&error=add-failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/products?action=add&error=system-error");
        }
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String idParam = req.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=missing-id");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            
            // Extract plant data from request
            Plant plant = extractPlantFromRequest(req);
            plant.setId(id);
            
            // Validate required fields
            if (plant.getName() == null || plant.getName().trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/products?action=edit&id=" + id + "&error=missing-name");
                return;
            }
            
            // Update the plant
            boolean success = plantService.updatePlant(plant);
            
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/products?success=updated");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products?action=edit&id=" + id + "&error=update-failed");
            }
            
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=invalid-id");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=system-error");
        }
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        
        String idParam = req.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=missing-id");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            boolean success = plantService.deletePlant(id);
            
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/admin/products?success=deleted");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products?error=delete-failed");
            }
            
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=invalid-id");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=system-error");
        }
    }

    private void toggleProductStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        
        String idParam = req.getParameter("id");
        
        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=missing-id");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            Plant plant = plantService.getPlantById(id);
            
            if (plant == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products?error=not-found");
                return;
            }
            
            // Toggle active status
            plant.setActive(!plant.isActive());
            boolean success = plantService.updatePlant(plant);
            
            if (success) {
                String status = plant.isActive() ? "activated" : "deactivated";
                resp.sendRedirect(req.getContextPath() + "/admin/products?success=" + status);
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/products?error=toggle-failed");
            }
            
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=invalid-id");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=system-error");
        }
    }

    private Plant extractPlantFromRequest(HttpServletRequest req) {
        Plant plant = new Plant();
        
        // Extract basic info
        plant.setName(req.getParameter("name"));
        plant.setDescription(req.getParameter("description"));
        plant.setImageUrl(req.getParameter("imageUrl"));
        
        // Extract price
        String priceParam = req.getParameter("price");
        if (priceParam != null && !priceParam.trim().isEmpty()) {
            try {
                plant.setPrice(new BigDecimal(priceParam));
            } catch (NumberFormatException e) {
                plant.setPrice(BigDecimal.ZERO);
            }
        }
        
        // Extract stock
        String stockParam = req.getParameter("stock");
        if (stockParam != null && !stockParam.trim().isEmpty()) {
            try {
                plant.setStock(Integer.parseInt(stockParam));
            } catch (NumberFormatException e) {
                plant.setStock(0);
            }
        }
        
        // Extract category
        String categoryParam = req.getParameter("categoryId");
        if (categoryParam != null && !categoryParam.trim().isEmpty()) {
            try {
                plant.setCategoryId(Integer.parseInt(categoryParam));
            } catch (NumberFormatException e) {
                plant.setCategoryId(1); // Default category
            }
        }
        
        // Extract active status
        String activeParam = req.getParameter("active");
        plant.setActive("true".equals(activeParam) || "on".equals(activeParam));
        
        return plant;
    }
}
