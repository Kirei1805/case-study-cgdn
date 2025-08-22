package controller.admin;

import model.Plant;
import model.Order;
import model.User;
import service.AdminService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        String action = req.getParameter("action");

        if (action == null) {

            List<Plant> plants = adminService.getAllPlants();

            req.setAttribute("plants", plants);

            req.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp").forward(req, resp);

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Plant plant = adminService.getPlantById(id);
            req.setAttribute("plant", plant);
            req.getRequestDispatcher("/WEB-INF/view/admin/edit-plant.jsp").forward(req, resp);

        } else if (action.equals("add")) {
            req.getRequestDispatcher("/WEB-INF/view/admin/add-plant.jsp").forward(req, resp);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            adminService.deletePlant(id);
            resp.sendRedirect(req.getContextPath() + "/admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Plant plant = buildPlantFromRequest(req);
            adminService.addPlant(plant);
            resp.sendRedirect(req.getContextPath() + "/admin");

        } else if ("update".equals(action)) {
            Plant plant = buildPlantFromRequest(req);
            plant.setId(Integer.parseInt(req.getParameter("id")));
            adminService.updatePlant(plant);
            resp.sendRedirect(req.getContextPath() + "/admin");
        }
    }

    private Plant buildPlantFromRequest(HttpServletRequest req) {
        Plant plant = new Plant();
        plant.setName(req.getParameter("name"));
        plant.setPrice(new BigDecimal(req.getParameter("price")));
        plant.setImageUrl(req.getParameter("imageUrl"));
        plant.setDescription(req.getParameter("description"));
        plant.setStock(Integer.parseInt(req.getParameter("stock")));
        plant.setRatingAvg(Float.parseFloat(req.getParameter("ratingAvg")));
        plant.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        plant.setActive("on".equals(req.getParameter("isActive")));
        return plant;
    }
}
