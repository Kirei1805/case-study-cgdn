package controller;

import model.Plant;
import model.Category;
import service.IPlantService;
import service.PlantService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/plants/*")
public class ManagementPlantController extends HttpServlet {
    private IPlantService plantService;
    
    @Override
    public void init() throws ServletException {
        plantService = new PlantService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra quyền admin
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null || 
            !"admin".equalsIgnoreCase((String) session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");
        
        if (pathInfo != null && pathInfo.startsWith("/edit/")) {
            // Hiển thị form chỉnh sửa
            String plantId = pathInfo.substring(6);
            try {
                int id = Integer.parseInt(plantId);
                Plant plant = plantService.getPlantById(id);
                if (plant != null) {
                    List<Category> categories = plantService.getAllCategories();
                    request.setAttribute("plant", plant);
                    request.setAttribute("categories", categories);
                    request.getRequestDispatcher("/WEB-INF/view/editPlant.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/plants");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/plants");
            }
        } else if ("add".equals(action)) {

            List<Category> categories = plantService.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/view/addPlant.jsp").forward(request, response);
        } else {
            List<Plant> plants = plantService.getAllPlants();
            request.setAttribute("plants", plants);
            request.getRequestDispatcher("/WEB-INF/view/managementPlant.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null || 
            !"admin".equalsIgnoreCase((String) session.getAttribute("userRole"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addPlant(request, response);
        } else if ("edit".equals(action)) {
            editPlant(request, response);
        } else if ("delete".equals(action)) {
            deletePlant(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/plants");
        }
    }
    
    private void addPlant(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String stockStr = request.getParameter("stock");
        String categoryIdStr = request.getParameter("categoryId");
        
        if (name == null || name.trim().isEmpty() || priceStr == null || 
            stockStr == null || categoryIdStr == null) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            List<Category> categories = plantService.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/view/addPlant.jsp").forward(request, response);
            return;
        }
        
        try {
            Plant plant = new Plant();
            plant.setName(name.trim());
            plant.setPrice(new BigDecimal(priceStr));
            plant.setImageUrl(imageUrl != null ? imageUrl.trim() : "");
            plant.setDescription(description != null ? description.trim() : "");
            plant.setStock(Integer.parseInt(stockStr));
            plant.setCategoryId(Integer.parseInt(categoryIdStr));
            plant.setActive(true);
            
            if (plantService.addPlant(plant)) {
                response.sendRedirect(request.getContextPath() + "/admin/plants?success=add");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi thêm cây trồng");
                List<Category> categories = plantService.getAllCategories();
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/view/addPlant.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            List<Category> categories = plantService.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/view/addPlant.jsp").forward(request, response);
        }
    }
    
    private void editPlant(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String stockStr = request.getParameter("stock");
        String categoryIdStr = request.getParameter("categoryId");
        
        if (idStr == null || name == null || name.trim().isEmpty() || priceStr == null || 
            stockStr == null || categoryIdStr == null) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc");
            response.sendRedirect(request.getContextPath() + "/admin/plants");
            return;
        }
        
        try {
            Plant plant = new Plant();
            plant.setId(Integer.parseInt(idStr));
            plant.setName(name.trim());
            plant.setPrice(new BigDecimal(priceStr));
            plant.setImageUrl(imageUrl != null ? imageUrl.trim() : "");
            plant.setDescription(description != null ? description.trim() : "");
            plant.setStock(Integer.parseInt(stockStr));
            plant.setCategoryId(Integer.parseInt(categoryIdStr));
            plant.setActive(true);
            
            if (plantService.updatePlant(plant)) {
                response.sendRedirect(request.getContextPath() + "/admin/plants?success=edit");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật cây trồng");
                response.sendRedirect(request.getContextPath() + "/admin/plants");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            response.sendRedirect(request.getContextPath() + "/admin/plants");
        }
    }
    
    private void deletePlant(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/plants");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            if (plantService.deletePlant(id)) {
                response.sendRedirect(request.getContextPath() + "/admin/plants?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/plants?error=delete");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/plants");
        }
    }
} 