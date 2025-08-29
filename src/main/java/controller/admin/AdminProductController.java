package controller.admin;

import model.Plant;
import model.User;
import service.plant.PlantService;
import service.plant.PlantServiceImpl;
import service.category.CategoryService;
import service.category.CategoryServiceImpl;
import service.user.UserService;
import service.user.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/products")
public class AdminProductController extends HttpServlet {
    private PlantService plantService;
    private CategoryService categoryService;
    private UserService userService;

    @Override
    public void init() {
        plantService = new PlantServiceImpl();
        categoryService = new CategoryServiceImpl();
        userService = new UserServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Check quyền admin
        if (user == null || !userService.isAdmin(user)) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                // Hiển thị form thêm
                req.setAttribute("categories", categoryService.getAllCategories());
                req.getRequestDispatcher("/WEB-INF/view/admin/product-add.jsp").forward(req, resp);
                break;

            case "edit":
                // Hiển thị form sửa
                int editId = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("product", plantService.getPlantById(editId));
                req.setAttribute("categories", categoryService.getAllCategories());
                req.getRequestDispatcher("/WEB-INF/view/admin/product-edit.jsp").forward(req, resp);
                break;

            case "delete":
                // Xóa (hoặc soft delete)
                int deleteId = Integer.parseInt(req.getParameter("id"));
                plantService.deletePlant(deleteId);
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                break;
            case "search":
                String keyword = req.getParameter("keyword");
                req.setAttribute("products", plantService.searchPlantsByName(keyword));
                req.setAttribute("categories", categoryService.getAllCategories());
                req.getRequestDispatcher("/WEB-INF/view/admin/products.jsp").forward(req, resp);
                break;


            default: // list
                req.setAttribute("products", plantService.getAllPlants());
                req.setAttribute("categories", categoryService.getAllCategories());
                req.getRequestDispatcher("/WEB-INF/view/admin/products.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Plant p = extractPlantFromRequest(req);
            plantService.createPlant(p);

        } else if ("edit".equals(action)) {
            Plant p = extractPlantFromRequest(req);
            p.setId(Integer.parseInt(req.getParameter("id")));
            plantService.updatePlant(p);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    // Helper method để lấy dữ liệu từ form
    private Plant extractPlantFromRequest(HttpServletRequest req) {
        Plant p = new Plant();
        p.setName(req.getParameter("name"));
        p.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        p.setPrice(new BigDecimal(req.getParameter("price")));
        p.setStock(Integer.parseInt(req.getParameter("stock")));
        p.setImageUrl(req.getParameter("imageUrl"));
        p.setDescription(req.getParameter("description"));
        p.setActive(Boolean.parseBoolean(req.getParameter("isActive")));
        return p;
    }
}
